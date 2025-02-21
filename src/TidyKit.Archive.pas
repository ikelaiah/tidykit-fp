unit TidyKit.Archive;

{$mode objfpc}{$H+}{$J-}

interface

uses
  Classes, SysUtils, zipper, libtar, TidyKit.FS, TidyKit.Core, StrUtils;

type
  { TArchiveKit
    -----------
    A toolkit for file compression and archiving operations.
    Provides methods for working with ZIP and TAR archives.
    All methods are static (class functions) for ease of use. }
  TArchiveKit = class
  private
    class function MatchPattern(const FileName, Pattern: string): Boolean; static;
  public
    { Compresses files into a ZIP archive.
      
      Parameters:
        APath - The source path containing files to compress.
        ADestPath - The destination path for the ZIP file.
        Recursive - Whether to include subdirectories.
        Pattern - File pattern to match (e.g. '*' for all files). }
    class procedure CompressToZip(const APath, ADestPath: string; const Recursive: Boolean = False; const Pattern: string = '*'); static;
    
    { Decompresses files from a ZIP archive.
      
      Parameters:
        AZipPath - The path to the ZIP file.
        ADestPath - The destination path to extract files to.
        Pattern - File pattern to match (e.g. '*' for all files). }
    class procedure DecompressFromZip(const AZipPath, ADestPath: string; const Pattern: string = '*'); static;
    
    { Compresses files into a TAR archive.
      
      Parameters:
        APath - The source path containing files to compress.
        ADestPath - The destination path for the TAR file.
        Recursive - Whether to include subdirectories.
        Pattern - File pattern to match (e.g. '*' for all files). }
    class procedure CompressToTar(const APath, ADestPath: string; const Recursive: Boolean = False; const Pattern: string = '*'); static;
    
    { Decompresses files from a TAR archive.
      
      Parameters:
        ATarPath - The path to the TAR file.
        ADestPath - The destination path to extract files to.
        Pattern - File pattern to match (e.g. '*' for all files). }
    class procedure DecompressFromTar(const ATarPath, ADestPath: string; const Pattern: string = '*'); static;
  end;

implementation

{ TArchiveKit }

class function TArchiveKit.MatchPattern(const FileName, Pattern: string): Boolean;
begin
  Result := False;
  if Pattern = '*' then
    Exit(True);
    
  // Simple wildcard matching for now
  if (Pattern[1] = '*') and (Pattern[Length(Pattern)] = '*') then
    Result := Pos(Copy(Pattern, 2, Length(Pattern)-2), FileName) > 0
  else if Pattern[1] = '*' then
    Result := AnsiEndsText(Copy(Pattern, 2, MaxInt), FileName)
  else if Pattern[Length(Pattern)] = '*' then
    Result := AnsiStartsText(Copy(Pattern, 1, Length(Pattern)-1), FileName)
  else
    Result := AnsiSameText(Pattern, FileName);
end;

class procedure TArchiveKit.CompressToZip(const APath, ADestPath: string; const Recursive: Boolean = False; const Pattern: string = '*');
var
  Zipper: TZipper;
  Files: TFilePathArray;
  Dirs: TStringArray;
  I: Integer;
  BaseDir: string;
  RelativePath: string;
begin
  if DEBUG_MODE then
    WriteLn('CompressToZip: Starting compression of ', APath, ' to ', ADestPath);
    
  BaseDir := IncludeTrailingPathDelimiter(ExpandFileName(APath));
  
  if DEBUG_MODE then
    WriteLn('CompressToZip: Base directory is ', BaseDir);
  
  // Get files first
  Files := TFileKit.ListFiles(APath, Pattern, Recursive);
  
  if DEBUG_MODE then
    WriteLn('CompressToZip: Found ', Length(Files), ' files to compress');
  
  Zipper := TZipper.Create;
  try
    Zipper.FileName := ADestPath;
    
    // Add each file with its relative path
    for I := 0 to High(Files) do
    begin
      RelativePath := ExtractRelativePath(BaseDir, Files[I]);
      if DEBUG_MODE then
        WriteLn('CompressToZip: Adding file ', RelativePath);
        
      // Store only the relative path in the ZIP
      Zipper.Entries.AddFileEntry(Files[I], RelativePath);
    end;
    
    if DEBUG_MODE then
      WriteLn('CompressToZip: Creating ZIP file');
      
    Zipper.ZipAllFiles;  // This will create the ZIP file
    
    if DEBUG_MODE then
      WriteLn('CompressToZip: ZIP file created successfully');
  finally
    Zipper.Free;  // This will close all resources
    if DEBUG_MODE then
      WriteLn('CompressToZip: Resources freed');
  end;
end;

class procedure TArchiveKit.DecompressFromZip(const AZipPath, ADestPath: string; const Pattern: string = '*');
var
  UnZipper: TUnZipper;
  DestDir: string;
begin
  if DEBUG_MODE then
    WriteLn('DecompressFromZip: Starting decompression of ', AZipPath, ' to ', ADestPath);
    
  // Ensure absolute, normalized path with trailing delimiter
  DestDir := IncludeTrailingPathDelimiter(ExpandFileName(ADestPath));
  
  if DEBUG_MODE then
    WriteLn('DecompressFromZip: Destination directory is ', DestDir);
    
  if not ForceDirectories(DestDir) then
  begin
    if DEBUG_MODE then
      WriteLn('DecompressFromZip: Failed to create destination directory');
    raise ETidyKitException.CreateFmt('Failed to create directory: %s', [DestDir]);
  end;
  
  if not FileExists(AZipPath) then
  begin
    if DEBUG_MODE then
      WriteLn('DecompressFromZip: ZIP file not found');
    raise ETidyKitException.CreateFmt('ZIP file not found: %s', [AZipPath]);
  end;
  
  UnZipper := TUnZipper.Create;
  try
    UnZipper.FileName := AZipPath;
    UnZipper.OutputPath := ExcludeTrailingPathDelimiter(DestDir);  // UnZipper adds its own delimiter
    
    if DEBUG_MODE then
      WriteLn('DecompressFromZip: Examining ZIP file');
      
    UnZipper.Examine;  // Read the ZIP directory
    
    if DEBUG_MODE then
    begin
      WriteLn('DecompressFromZip: Found ', UnZipper.Entries.Count, ' entries');
      WriteLn('DecompressFromZip: Output path is ', UnZipper.OutputPath);
    end;
      
    UnZipper.UnZipAllFiles;  // Extract all files
    
    if DEBUG_MODE then
      WriteLn('DecompressFromZip: Files extracted successfully');
  finally
    UnZipper.Free;  // This will close all resources
    if DEBUG_MODE then
      WriteLn('DecompressFromZip: Resources freed');
  end;
end;

class procedure TArchiveKit.CompressToTar(const APath, ADestPath: string; const Recursive: Boolean = False; const Pattern: string = '*');
var
  TarWriter: TTarWriter;
  Files: TFilePathArray;
  Dirs: TStringArray;
  I: Integer;
  BaseDir: string;
  FileStream: TFileStream;
  TarFileName: string;
  RelativePath: string;
  ModTime: TDateTime;
begin
  if DEBUG_MODE then
    WriteLn('CompressToTar: Starting compression of ', APath, ' to ', ADestPath);
    
  BaseDir := IncludeTrailingPathDelimiter(ExpandFileName(APath));
  TarFileName := ExpandFileName(ADestPath);  // Get full path of TAR file
  
  if DEBUG_MODE then
    WriteLn('CompressToTar: Base directory is ', BaseDir);
  
  // Delete existing file if it exists
  if FileExists(TarFileName) then
  begin
    if DEBUG_MODE then
      WriteLn('CompressToTar: Deleting existing TAR file');
    DeleteFile(TarFileName);
  end;
  
  // Get directories first (if recursive)
  if Recursive then
  begin
    Dirs := TFileKit.ListDirectories(APath, '*', True);
    if DEBUG_MODE then
      WriteLn('CompressToTar: Found ', Length(Dirs), ' directories');
  end;
  
  // Get files
  Files := TFileKit.ListFiles(APath, Pattern, Recursive);
  
  // Filter out the TAR file itself from the list
  for I := High(Files) downto 0 do
  begin
    if SameFileName(Files[I], TarFileName) then
    begin
      if DEBUG_MODE then
        WriteLn('CompressToTar: Excluding TAR file from archive');
      Delete(Files, I, 1);
    end;
  end;
  
  if DEBUG_MODE then
    WriteLn('CompressToTar: Found ', Length(Files), ' files to compress');
  
  // Create output file with exclusive access
  FileStream := TFileStream.Create(TarFileName, fmCreate or fmShareExclusive);
  try
    if DEBUG_MODE then
      WriteLn('CompressToTar: Creating TAR writer');
      
    TarWriter := TTarWriter.Create(FileStream);
    try
      // Add directories first (if recursive)
      if Recursive then
      begin
        for I := 0 to High(Dirs) do
        begin
          // TAR format requires trailing path delimiter for directories
          RelativePath := IncludeTrailingPathDelimiter(ExtractRelativePath(BaseDir, Dirs[I]));
          ModTime := TFileKit.GetLastWriteTime(Dirs[I]);
          if DEBUG_MODE then
            WriteLn('CompressToTar: Adding directory ', RelativePath);
          TarWriter.AddDir(RelativePath, ModTime);
        end;
      end;
      
      // Add each file with its relative path
      for I := 0 to High(Files) do
      begin
        RelativePath := ExtractRelativePath(BaseDir, Files[I]);
        if DEBUG_MODE then
          WriteLn('CompressToTar: Adding file ', RelativePath);
          
        // Store only the relative path in the TAR
        TarWriter.AddFile(Files[I], RelativePath);
      end;
      
      if DEBUG_MODE then
        WriteLn('CompressToTar: Writing TAR footer');
        
      TarWriter.Finalize;  // Write TAR footer
      
      if DEBUG_MODE then
        begin
          WriteLn('CompressToTar: TAR file created successfully');
          WriteLn('CompressToTar: Final file size is ', FileStream.Size, ' bytes');
        end;
    finally
      TarWriter.Free;
      if DEBUG_MODE then
        WriteLn('CompressToTar: TAR writer freed');
    end;
  finally
    FileStream.Free;
    if DEBUG_MODE then
      WriteLn('CompressToTar: File stream freed');
  end;
end;

class procedure TArchiveKit.DecompressFromTar(const ATarPath, ADestPath: string; const Pattern: string = '*');
var
  TarArchive: TTarArchive;
  DirRec: TTarDirRec;
  OutputFile: string;
  DestDir: string;
  EntryCount: Integer;
  DirToCreate: string;
begin
  DirRec := Default(TTarDirRec);  // Initialize DirRec using Default
  
  if DEBUG_MODE then
    WriteLn('DecompressFromTar: Starting decompression of ', ATarPath, ' to ', ADestPath);
    
  // Ensure absolute, normalized path with trailing delimiter
  DestDir := IncludeTrailingPathDelimiter(ExpandFileName(ADestPath));
  
  if DEBUG_MODE then
    WriteLn('DecompressFromTar: Destination directory is ', DestDir);
    
  if not ForceDirectories(DestDir) then
  begin
    if DEBUG_MODE then
      WriteLn('DecompressFromTar: Failed to create destination directory');
    raise ETidyKitException.CreateFmt('Failed to create directory: %s', [DestDir]);
  end;
  
  if not FileExists(ATarPath) then
  begin
    if DEBUG_MODE then
      WriteLn('DecompressFromTar: TAR file not found');
    raise ETidyKitException.CreateFmt('TAR file not found: %s', [ATarPath]);
  end;
  
  // Create TAR archive directly with filename
  TarArchive := TTarArchive.Create(ATarPath);
  try
    if DEBUG_MODE then
      WriteLn('DecompressFromTar: Reading TAR entries');
      
    // Reset the archive to start reading from the beginning
    TarArchive.Reset;
      
    EntryCount := 0;
    while TarArchive.FindNext(DirRec) do
    begin
      Inc(EntryCount);

      if DEBUG_MODE then
      begin
        WriteLn('DecompressFromTar: Size = ', DirRec.Size, ' bytes');
        WriteLn('DecompressFromTar: Found entry #', EntryCount);
        WriteLn('DecompressFromTar: Name = ', DirRec.Name);
        WriteLn('DecompressFromTar: Type = ', Integer(DirRec.FileType));
      end;
        
      // Handle directory entries
      if DirRec.FileType = ftDirectory then
      begin
        // For directory entries, use the full path
        DirToCreate := DestDir + ExcludeTrailingPathDelimiter(DirRec.Name);
        
        if DEBUG_MODE then
          WriteLn('DecompressFromTar: Creating directory ', DirToCreate);
          
        if not ForceDirectories(DirToCreate) then
        begin
          if DEBUG_MODE then
            WriteLn('DecompressFromTar: Failed to create directory');
          raise ETidyKitException.CreateFmt('Failed to create directory: %s', [DirToCreate]);
        end;
        
        Continue;  // Skip to next entry
      end;
      
      // Handle file entries
      if DirRec.FileType = ftNormal then
      begin
        OutputFile := DestDir + DirRec.Name;
        
        if DEBUG_MODE then
          WriteLn('DecompressFromTar: Processing file ', DirRec.Name);
          
        if MatchPattern(DirRec.Name, Pattern) then
        begin
          if DEBUG_MODE then
            WriteLn('DecompressFromTar: Extracting file ', OutputFile);
            
          // Create parent directory for file
          DirToCreate := ExtractFilePath(OutputFile);
          if not ForceDirectories(DirToCreate) then
          begin
            if DEBUG_MODE then
              WriteLn('DecompressFromTar: Failed to create directory for file');
            raise ETidyKitException.CreateFmt('Failed to create directory: %s', [DirToCreate]);
          end;
            
          try
            TarArchive.ReadFile(OutputFile);
            if DEBUG_MODE then
              WriteLn('DecompressFromTar: File extracted successfully');
          except
            on E: Exception do
            begin
              if DEBUG_MODE then
                WriteLn('DecompressFromTar: Failed to extract file - ', E.Message);
              raise ETidyKitException.CreateFmt('Failed to extract file %s: %s', [DirRec.Name, E.Message]);
            end;
          end;
        end
        else if DEBUG_MODE then
          WriteLn('DecompressFromTar: Skipping file ', DirRec.Name, ' (does not match pattern)');
      end;
    end;
    
    if DEBUG_MODE then
    begin
      WriteLn('DecompressFromTar: Found ', EntryCount, ' entries in total');
      WriteLn('DecompressFromTar: All files extracted successfully');
    end;
  finally
    TarArchive.Free;
    if DEBUG_MODE then
      WriteLn('DecompressFromTar: TAR archive reader freed');
  end;
end;

end. 
