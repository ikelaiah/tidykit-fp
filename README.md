# 📦 Archived

This library is now archived. The functionality will be available as smaller, focused modules (better maintainability and usability) under my GitHub profile: 

👉 @ikelaiah

Thanks for using `tidykit-fp`!

---

# 🔧 TidyKit: Robust Tools for Free Pascal Development!

[![FPC](https://img.shields.io/badge/Free%20Pascal-3.2.2-blue.svg)](https://www.freepascal.org/)
[![Lazarus](https://img.shields.io/badge/Lazarus-3.6+-blue.svg)](https://www.lazarus-ide.org/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE.md)
[![Documentation](https://img.shields.io/badge/Docs-Available-brightgreen.svg)](docs/)
[![Tests](https://img.shields.io/badge/Tests-Passing-brightgreen.svg)](tests/)
[![Status](https://img.shields.io/badge/Status-Development-yellow.svg)]()
[![Version](https://img.shields.io/badge/Version-0.1.8-blueviolet.svg)]()

**TidyKit streamlines your Pascal development experience.**

> [!WARNING]
> ⚠️ This library is under active development and is not yet ready for production use. APIs may change without notice.

## ✨ Say Goodbye to Boilerplate

Tired of writing the same code over and over? TidyKit helps you focus on your application logic instead of reinventing the wheel.

```pascal
// JSON has never been easier
var
  Json: TJSONValue;
begin
  Json := TJSON.Parse('{"name":"Pascal","age":50}');
  WriteLn('Name: ', Json['name'].AsString);

  // Easy file operations
  var
    Files: TStringArray;
    FileName: string;
  begin
    Files := TFileKit.ListFiles('./data', '*.csv', True); // Recursively find all CSVs
    for FileName in Files do
      TFileKit.CopyFile(FileName, './backup/' + TFileKit.GetFileName(FileName));
  end;
  
  // Easy-to-use collections with interface-based memory management
  var
    NameList: IList<string>;
  begin
    NameList := CreateList<string>;  // no need to worry about freeing!
    NameList.Add('Alice');
    NameList.Add('Bob');
    NameList.Sort;
  end;
end;
```

## 🌟 Why TidyKit?

- **Everything You Need**: One library with everything from JSON to file handling to collections
- **Modern Pascal**: Clean, consistent APIs with FPC 3.2.2 compatibility
- **Rock-Solid Reliability**: Extensive test suite ensures things just work
- **No Dependency Nightmares**: Works on Windows and Linux with minimal external requirements
- **Smart Memory Management**: Forget manual Destroy calls with interface-based reference counting
- **Ready-to-Use Collections**: Lists, dictionaries, sets, and more with generic type safety

## 📑 Table of Contents 

- [🔧 TidyKit: Make Pascal Development Fun Again!](#-tidykit-make-pascal-development-fun-again)
  - [✨ Say Goodbye to Boilerplate](#-say-goodbye-to-boilerplate)
  - [🌟 Why TidyKit?](#-why-tidykit)
  - [📑 Table of Contents](#-table-of-contents)
  - [🏗️ Architectural Patterns](#️-architectural-patterns)
  - [✨ Features](#-features)
  - [💻 Installation (Lazarus IDE)](#-installation-lazarus-ide)
  - [💻 Installation (General)](#-installation-general)
  - [📝 Library Usage](#-library-usage)
  - [🚀 Quick Start](#-quick-start)
    - [📝 String Operations](#-string-operations)
    - [📂 File System Operations](#-file-system-operations)
    - [📅 DateTime Operations](#-datetime-operations)
    - [🔄 JSON Operations](#-json-operations)
    - [📝 Logging Operations](#-logging-operations)
    - [🌐 HTTP Request Operations](#-http-request-operations)
    - [🔐 Crypto Operations](#-crypto-operations)
    - [📦 Archive Operations](#-archive-operations)
    - [📚 Collections Operations](#-collections-operations)
  - [📖 System Requirements](#-system-requirements)
    - [Tested Environments](#tested-environments)
    - [Dependencies](#dependencies)
    - [Build Requirements](#build-requirements)
  - [📚 Documentation](#-documentation)
  - [📊 Real-World Examples](#-real-world-examples)
  - [💬 Community \& Support](#-community--support)
  - [⚠️ Known Limitations](#️-known-limitations)
  - [✅ Testing](#-testing)
  - [🤝 Contributing](#-contributing)
  - [⚖️ License](#️-license)
  - [🙏 Acknowledgments](#-acknowledgments)
  - [🗺️ Roadmap](#️-roadmap)
    - [Planned for v0.2.0 (Q3 2025) - Simplify API](#planned-for-v020-q3-2025---simplify-api)
    - [Planned for v0.3.0 (Q4 2025) - Examples \& Refinements](#planned-for-v030-q4-2025---examples--refinements)
    - [Future Goals](#future-goals)

## 💪 How TidyKit Makes Your Life Easier

We've designed TidyKit with one goal in mind: **making your development experience smoother**. Here's how we've organized things:

### 🧰 Three Simple Approaches

**1. Just Call It** - For simple operations like file handling or string manipulation:
```pascal
// No objects to create, just call and go!
TFileKit.WriteTextFile('log.txt', 'Hello World');
NewStr := TStringKit.ToUpperCase('make me shout');
```

**2. Smart Objects** - For complex operations like JSON handling, with automatic cleanup:
```pascal
// No manual memory management needed!
var JsonObj := TJSON.Parse(JsonText);
JsonObj['config']['enabled'] := True;
// When JsonObj goes out of scope, memory is automatically freed
```

**3. Simple Records** - For operations that need state without complexity:
```pascal
// Easy to use with method chaining
var Request := TRequest.Create('https://api.example.com')
  .AddHeader('Content-Type', 'application/json')
  .SetTimeout(5000);
var Response := Request.Get;
```

> [!NOTE]
> In our next version, we're streamlining things even further to make the API even more consistent and intuitive.

## ✨ What's Inside TidyKit?

TidyKit is packed with tools that make common programming tasks simple. Here's a taste of what you can do:

### 📝 Text & Strings
Transform, validate, and manipulate text with ease
```pascal
// Convert case styles seamlessly
var
  snake, kebab: string;
begin
  snake := TStringKit.ToSnakeCase('HelloWorld');
  kebab := TStringKit.ToKebabCase('HelloWorld');

  // Validate email addresses
  if TStringKit.IsValidEmail(email) then ...
end;
```

### 📂 Files & Directories
Work with files without the headaches
```pascal
// Find and filter files
var
  PascalFiles: TStringArray;
  Dir, FileName: string;
begin
  PascalFiles := TFileKit.ListFiles('.', '*.pas', True, fsDateDesc);

  // Easy path operations
  Dir := TFileKit.GetDirectory(Path);
  FileName := TFileKit.GetFileName(Path);
end;
```

### 📦 Archives & Compression
Create and extract ZIP/TAR archives
```pascal
// Extract ZIP files
TArchiveKit.ExtractZipFile('archive.zip', 'output_dir');

// Create TAR archives
TArchiveKit.CreateTarFile('src_dir', 'output.tar', '*.txt');
```

### 🔐 Security & Crypto
Modern encryption and hashing
```pascal
// Modern SHA3 hashing
var
  hash, encrypted: string;
begin
  hash := TCrypto.SHA3.ComputeHash(Data);

  // Simple AES-256 encryption
  encrypted := TCrypto.AES.Encrypt(plaintext, password);
end;
```

### 🌐 HTTP & Networking
Simplified web requests without the complexity
```pascal
// GET request with just one line
var
  Response: TResponse;
begin
  Response := TRequest.Create(url).Get();
  
  // POST JSON data easily
  Response := TRequest.Create(url)
    .SetJSON(jsonObj).Post();
end;
```

### 🔁 JSON Handling
Parse, create and modify JSON with ease
```pascal
// Parse existing JSON
var
  config, user: TJSONValue;
begin
  config := TJSON.Parse(jsonText);

  // Build JSON programmatically
  user := TJSON.Obj
    .Add('name', 'Alice')
    .Add('age', 30);
end;
```

### 📝 Powerful Logging
Flexible logging with multiple outputs
```pascal
// Quick console logging (correct usage)
TLogger.CreateConsoleLogger();
Logger.Info('Starting up...');

// Structured file logging (correct usage)
TLogger.CreateFileLogger('app.log');
Logger.LogStructured(llInfo, 'UserLogin', [NameValuePair('user', username)]);
```

### 📚 Type-Safe Collections
Modern generic collections with memory management
```pascal
// Create a dictionary with string keys
var
  Dict: IDictionary<string, Integer>;
begin
  Dict := CreateDictionary<string, Integer>(@FNV1aHash, @TidyKitStringEquals);

  // Add and retrieve values
  Dict.Add('Alice', 30);
  WriteLn(Dict['Alice']); // Displays: 30
end;
```

### 📅 DateTime Handling
Powerful date and time operations
```pascal
// Date calculations made simple
var
  Today, Tomorrow, NextWeek: TDateTime;
  FormattedDate: string;
begin
  Today := TDateTimeKit.Today;
  Tomorrow := TDateTimeKit.AddDays(Today, 1);
  NextWeek := TDateTimeKit.AddWeeks(Today, 1);
  
  // Format dates easily
  FormattedDate := TDateTimeKit.Format(Today, 'yyyy-mm-dd');
end;
```

### 💡 Command-Line Parsing
Parse command-line arguments with ease
```pascal
// Define and parse arguments
var
  Args: TParseArgs;
begin
  Args := TParseArgs.Create
    .Add('v|verbose', 'Enable verbose output')
    .Add('f|file=', 'Input file path')
    .Parse;
end;
```

### 📚 Documentation
Extensive documentation for all features
```pascal
// Documentation for all units
// See our detailed docs for more information
```


### All Features at a Glance

- 📝 **String Operations**: Case conversion, validation, pattern matching, Unicode support
- 📂 **File System**: File manipulation, path operations, searching and filtering
- 📦 **Archive**: ZIP/TAR compression with pattern-based filtering
- 🔐 **Cryptography**: SHA3, SHA2, AES-256 encryption, secure hashing
- 🌐 **Network**: HTTP client with request/response handling
- 🔁 **JSON**: Memory-managed JSON with full Unicode support
- 📝 **Logging**: Multi-destination logging with structured data support
  - 🛠️ **Command Line Parsing**: Easy-to-use argument parser with support for various data types
    - `TidyKit.ParseArgs` - For parsing command-line arguments with support for:
      - String, integer, float, and boolean options
      - Required and optional parameters
      - Automatic help generation
      - Callback support for custom argument handling
      - Array parameters for handling multiple values
  - 📚 **Collections**: Type-safe lists, dictionaries, sets, and queues
    - **When to use each collection:**
      - `TidyKit.Collections.List` - For sequential access and general-purpose ordered collections
      - `TidyKit.Collections.Dictionary` - For key-value storage with O(1) average time complexity (uses separate chaining for collision resolution)
      - `TidyKit.Collections.Deque` - For double-ended queues and efficient operations at both ends
      - `TidyKit.Collections.HashSet` - For unique unordered collections with fast lookups
    - **Documentation**: See our detailed docs for [Dictionary](./docs/TidyKit.Collections.Dictionary.md) and [HashSet](./docs/TidyKit.Collections.HashSet.md)
    - All collections support automatic memory management via interfaces (no manual Destroy calls needed)
    - Note: `for..in..do` enumeration is not supported; use indexed access or `ToArray` for traversal

## 💻 Installation (Lazarus IDE)

1. Clone the repository:

```bash
git clone https://github.com/ikelaiah/tidykit-fp
```

2. Open / start a new project in Lazarus IDE

3. Go to `Package` → `Open Package File (.lpk)...`

4. Navigate to the TidyKit packages in the `packages/lazarus/` folder and select `TidyKit.lpk`

5. In the package window that opens, click `Compile`

6. Click `Use → Add to Project` to install the package

The TidyKit package is now ready to use in your Lazarus project.

## 💻 Installation (General)

1. Clone the repository:

```bash
git clone https://github.com/ikelaiah/tidykit-fp
```

2. Add the source directory to your project's search path.


## 📝 Library Usage

```pascal
uses
  // String manipulation unit
  TidyKit.Strings,           // String operations

  // File system operations
  TidyKit.FS,                // File system operations

  // Date Time manipulation unit
  TidyKit.DateTime,          // Date Time operations

  // JSON functionality
  TidyKit.JSON,              // All JSON functionality

  // Logging functionality
  TidyKit.Logger,            // Easy to use logging system

  // Network units
  TidyKit.Request,           // HTTP client with simple and advanced features

  // Cryptography units
  TidyKit.Crypto,            // Base crypto operations
  TidyKit.Crypto.SHA2,       // SHA2 implementation
  TidyKit.Crypto.SHA3,       // SHA3 implementation
  TidyKit.Crypto.AES256,     // AES-256 implementation

  // Archive operations
  TidyKit.Archive,           // Archive operations

  // Command-line argument parsing
  TidyKit.ParseArgs,         // Simple argument parser

  // Collections
  TidyKit.Collections.List,  // Generic List implementation
  TidyKit.Collections.Deque, // Generic Deque implementation
  TidyKit.Collections.HashSet; // Generic HashSet implementation
```

## 🚀 Quick Start

### 📝 String Operations

```pascal
var
  Text: string;
begin
  // Email validation
  if TStringKit.MatchesPattern('user@example.com', '^[\w\.-]+@[\w\.-]+\.\w+$') then
    WriteLn('Valid email');
    
  // Format phone number
  Text := TStringKit.PadLeft('5551234', 10, '0');  // Returns '0005551234'
  
  // Clean user input
  Text := TStringKit.CollapseWhitespace('  Hello    World  ');  // Returns 'Hello World'
  
  // Format product code
  Text := TStringKit.PadCenter('A123', 8, '-');  // Returns '--A123---'
end;
```

### 📂 File System Operations

```pascal
var
  Files: TFilePathArray;
  Attrs: TFileAttributes;
  Content: string;
begin
  // Basic file operations
  TFileKit.WriteFile('example.txt', 'Hello World');
  Content := TFileKit.ReadFile('example.txt');
  
  // Directory operations
  TFileKit.CreateDirectory('new_folder');
  TFileKit.EnsureDirectory('path/to/folder');
  
  // List files with pattern matching
  Files := TFileKit.ListFiles('src', '*.pas', True, fsName);
  
  // Get file attributes
  Attrs := TFileKit.GetAttributes('example.txt');
  WriteLn(Format('Read-only: %s', [BoolToStr(Attrs.ReadOnly, True)]));
  
  // File manipulation
  TFileKit.CopyFile('source.txt', 'dest.txt');
  TFileKit.MoveFile('old.txt', 'new.txt');
  TFileKit.DeleteFile('temp.txt');
  
  // Path operations
  WriteLn(TFileKit.GetFileName('path/to/file.txt')); // Returns 'file.txt'
  WriteLn(TFileKit.GetExtension('script.pas')); // Returns '.pas'
  WriteLn(TFileKit.ChangeExtension('test.txt', '.bak')); // Returns 'test.bak'
end;
```

### 📅 DateTime Operations

```pascal
var
  CurrentTime: TDateTime;
  NextWorkday: TDateTime;
  TZInfo: TTimeZoneInfo;
  OriginalTZ: string;
  DSTTransitionDate: TDateTime;
begin
  // Get next business day for delivery date
  CurrentTime := TDateTimeKit.GetNow;
  NextWorkday := TDateTimeKit.NextBusinessDay(CurrentTime);
  
  // Format for display
  WriteLn(TDateTimeKit.GetAsString(NextWorkday, 'yyyy-mm-dd'));
  
  // Check if within business hours (9 AM - 5 PM)
  if TDateTimeKit.IsWithinInterval(CurrentTime, 
     TDateTimeKit.CreateInterval(
       TDateTimeKit.StartOfDay(CurrentTime) + EncodeTime(9, 0, 0, 0),
       TDateTimeKit.StartOfDay(CurrentTime) + EncodeTime(17, 0, 0, 0)
     )) then
    WriteLn('Within business hours');
    
  // Cross-platform timezone handling
  TZInfo := TDateTimeKit.GetTimeZone(CurrentTime);
  WriteLn('Current timezone: ', TZInfo.Name);
  WriteLn('Offset from UTC: ', TZInfo.Offset, ' minutes');
  WriteLn('DST active: ', BoolToStr(TZInfo.IsDST, True));
  
  // Convert between timezones
  WriteLn('UTC time: ', TDateTimeKit.GetAsString(
    TDateTimeKit.WithTimeZone(CurrentTime, 'UTC'), 
    'yyyy-mm-dd hh:nn:ss'));
    
  // Cross-platform environment variables for testing
  OriginalTZ := GetEnvVar('TZ');
  try
    // Change timezone for testing
    SetEnvVar('TZ', 'America/New_York');
    
    // Create a datetime value near the US DST transition 
    // (2:00 AM on second Sunday in March 2024)
    DSTTransitionDate := EncodeDateTime(2024, 3, 10, 2, 0, 0, 0);
    
    // Check if this time is in DST using GetTimeZone
    TZInfo := TDateTimeKit.GetTimeZone(DSTTransitionDate);
    WriteLn('DST active: ', BoolToStr(TZInfo.IsDST, True));
    WriteLn('Timezone offset: ', TZInfo.Offset, ' minutes');
  finally
    // Restore original timezone
    SetEnvVar('TZ', OriginalTZ);
  end;
end;
```

### 🔄 JSON Operations

```pascal
var
  Person: IJSONObject;
  Address: IJSONObject;
  Hobbies: IJSONArray;
  JSON: string;
  Value: IJSONValue;
begin
  // Create a person object
  Person := TJSON.Obj;
  Person.Add('name', 'John Smith');
  Person.Add('age', 30);
  Person.Add('isActive', True);
  
  // Create and add an address object
  Address := TJSON.Obj;
  Address.Add('street', '123 Main St');
  Address.Add('city', 'Springfield');
  Address.Add('zipCode', '12345');
  Person.Add('address', Address);
  
  // Create and add a hobbies array
  Hobbies := TJSON.Arr;
  Hobbies.Add('reading');
  Hobbies.Add('cycling');
  Hobbies.Add('swimming');
  Person.Add('hobbies', Hobbies);
  
  // Convert to JSON string with pretty printing
  JSON := Person.ToString(True);
  WriteLn(JSON);
  
  // Parse JSON string
  JSON := '{"name":"Jane Doe","age":25,"skills":["Pascal","Python"]}';
  Value := TJSON.Parse(JSON);
  Person := Value.AsObject;
  
  // Access values
  WriteLn('Name: ', Person['name'].AsString);
  WriteLn('Age: ', Person['age'].AsInteger);
  WriteLn('First Skill: ', Person['skills'].AsArray[0].AsString);
  
  // Error handling
  try
    Value := TJSON.Parse('{invalid json}');
  except
    on E: EJSONException do
      WriteLn('Error: ', E.Message);
  end;
end;
```

### 📝 Logging Operations

```pascal
// Simple one-line setup for console and file logging
TLogger.CreateConsoleAndFileLogger('application.log', llInfo);

// Log messages with different levels
Logger.Debug('Processing started'); // Only shown if minimum level is Debug
Logger.Info('User %s logged in', ['JohnDoe']);
Logger.Warning('Disk space is low: %d%% remaining', [5]);
Logger.Error('Failed to save file: %s', ['Access denied']);
Logger.Fatal('Application crashed: %s', ['Segmentation fault']);

// Create category-based loggers for better organization
var
  UILogger, DBLogger: ILogContext;
begin
  UILogger := Logger.CreateContext('UI');
  DBLogger := Logger.CreateContext('DB');
  
  UILogger.Info('Window created');
  DBLogger.Warning('Slow query detected: %s', ['SELECT * FROM large_table']);
end;

// Time operations and log their duration
var
  Timer: ITimedOperation;
begin
  Timer := Logger.TimedBlock('Data processing');
  // ... perform long operation ...
  // Timer automatically logs completion with duration when it goes out of scope
end;

// IMPORTANT: Always close log files when shutting down
try
  // Your application logic with logging...
finally
  Logger.CloseLogFiles;  // Ensures all data is written to disk
end;
```

### 🌐 HTTP Request Operations

```pascal
var
  Response: TResponse;
  UserData: IJSONObject;
  ApiResponse: IJSONObject;
  Result: TRequestResult;
begin
  // Simple GET request with JSON response
  Response := Http.Get('https://api.example.com/data');
  if Response.StatusCode = 200 then
  begin
    ApiResponse := Response.JSON.AsObject;
    WriteLn('User ID: ', ApiResponse['id'].AsInteger);
    WriteLn('Username: ', ApiResponse['username'].AsString);
  end;
    
  // POST with JSON data
  UserData := TJSON.Obj;
  UserData.Add('name', 'John Smith');
  UserData.Add('email', 'john@example.com');
  UserData.Add('age', 30);
  
  Response := Http.PostJSON('https://api.example.com/users',
    UserData.ToString);
    
  if Response.StatusCode = 201 then
    WriteLn('User created with ID: ', Response.JSON.AsObject['id'].AsString);
    
  // Error handling with TryGet pattern
  Result := Http.TryGet('https://api.example.com/users');
  if Result.Success then
    WriteLn('Found ', Result.Response.JSON.AsObject['count'].AsInteger, ' users')
  else
    WriteLn('Error: ', Result.Error);
    
  // Download file with custom headers
  Response := Http.Get('https://example.com/large-file.zip');
  TFileKit.WriteFile('download.zip', Response.Text);
end;
```

### 🔐 Crypto Operations

```pascal
var
  Hash: string;
  Encrypted: string;
begin
  // Hash password for storage
  Hash := TCryptoKit.SHA512Hash('user_password');
  
  // Secure configuration data
  Encrypted := TCryptoKit.BlowfishCrypt(
    '{"api_key": "secret123"}',
    'encryption_key',
    bmEncrypt
  );
  
  // Verify file integrity
  Hash := TCryptoKit.SHA256Hash(TFileKit.ReadFile('important.dat'));
end;
```

### 📦 Archive Operations

```pascal
var
  SourceDir, DestDir: string;
begin
  // Create ZIP archive
  SourceDir := 'path/to/source';
  TArchiveKit.CompressToZip(SourceDir, 'archive.zip', True);  // Recursive
  
  // Extract specific files
  DestDir := 'path/to/extract';
  TArchiveKit.DecompressFromZip('archive.zip', DestDir, '*.txt');  // Only .txt files
  
  // Create TAR archive with specific files
  TArchiveKit.CompressToTar(SourceDir, 'backup.tar', True, '*.pas');  // Only .pas files
  
  // Extract entire TAR archive
  TArchiveKit.DecompressFromTar('backup.tar', DestDir);
end;
```

### 📚 Collections Operations

```pascal
uses
  TidyKit.Collections.List, TidyKit.Collections.Deque, 
  TidyKit.Collections.HashSet, TidyKit.Collections.HashFunction, 
  TidyKit.Collections.EqualityFunction;

var
  // Example for TList<T>
  MyIntList: IList<Integer>;
  I: Integer;

  // Example for TDeque<T>
  MyStringDeque: IDeque<string>;

  // Example for THashSet<T>
  MyHashSet: IHashSet<string>;
begin
  // --- TList<T> Example ---
  MyIntList := CreateList<Integer>; // Using helper for interface-based management
  MyIntList.Add(10);
  MyIntList.Add(20);
  MyIntList.Insert(1, 15); // List is now: 10, 15, 20

  Write('List items: ');
  for I := 0 to MyIntList.Count - 1 do
    Write(MyIntList[I], ' ');
  WriteLn; // Output: 10 15 20

  // --- TDeque<T> Example ---
  MyStringDeque := CreateDeque<string>; // Using helper for interface-based management
  MyStringDeque.PushBack('apples');
  MyStringDeque.PushFront('bananas'); // Deque is now: 'bananas', 'apples'
  MyStringDeque.PushBack('cherries'); // Deque is now: 'bananas', 'apples', 'cherries'

  Write('Deque items (popping from front): ');
  while MyStringDeque.Count > 0 do
    Write(MyStringDeque.PopFront, ' ');
  WriteLn; // Output: bananas apples cherries

  // --- THashSet<T> Example with specialized hash functions ---
  MyHashSet := CreateHashSet<string>(@XXHash32, @TidyKitStringEquals);
  MyHashSet.Add('apple');
  MyHashSet.Add('banana');
  MyHashSet.Add('cherry');
  MyHashSet.Add('apple'); // Duplicate, won't be added

  Write('HashSet items: ');
  for I := 0 to MyHashSet.ToArray.Count - 1 do
    Write(MyHashSet.ToArray[I], ' ');
  WriteLn; // Output: apple banana cherry

  // No explicit Free needed as these are interface variables
  // and will be automatically managed.
end;
```

## 📖 System Requirements

### Tested Environments

| Module                          | Windows 11 | Ubuntu 24.04.2 |
|---------------------------------|------------|----------------|
| TidyKit.Strings                 | ✅         | ✅             |
| TidyKit.FS                      | ✅         | ✅             |
| TidyKit.DateTime                | ✅         | ✅             |
| TidyKit.JSON                    | ✅         | ✅             |
| TidyKit.JSON.Factory            | ✅         | ✅             |
| TidyKit.JSON.Parser             | ✅         | ✅             |
| TidyKit.JSON.Scanner            | ✅         | ✅             |
| TidyKit.JSON.Types              | ✅         | ✅             |
| TidyKit.JSON.Writer             | ✅         | ✅             |
| TidyKit.Logger                  | ✅         | ✅             |
| TidyKit.Request                 | ✅         | ✅             |
| TidyKit.Crypto                  | ✅         | ✅             |
| TidyKit.Crypto.AES256           | ✅         | ✅             |
| TidyKit.Crypto.SHA2             | ✅         | ✅             |
| TidyKit.Crypto.SHA3             | ✅         | ✅             |
| TidyKit.Archive                 | ✅         | ✅             |
| TidyKit.Collections             | ✅         | ✅             |
| TidyKit.Collections.Deque       | ✅         | ✅             |
| TidyKit.Collections.Dictionary  | ✅         | ✅             |
| TidyKit.Collections.EqualityFunction | ✅  | ✅             |
| TidyKit.Collections.HashFunction| ✅         | ✅             |
| TidyKit.Collections.HashSet     | ✅         | ✅             |
| TidyKit.Collections.List        | ✅         | ✅             |
| TidyKit.ParseArgs               | ✅         | ✅             |

### Dependencies

- Windows
  - No external dependencies required
- Linux
  - Ubuntu/Debian: `sudo apt-get install libssl-dev` (needed for HTTPS in `TidyKit.Request`)
  - Fedora/RHEL: `sudo dnf install openssl-devel` (needed for HTTPS in `TidyKit.Request`)
- Uses only standard Free Pascal RTL units

### Build Requirements

- Free Pascal Compiler (FPC) 3.2.2+
- Lazarus 3.6+
- Basic development tools (git, terminal, etc)

## 📚 Documentation

For detailed documentation, see:

- 📋 [Cheat Sheet](docs/cheat-sheet.md)
- ❓ [FAQ](docs/FAQ.md) - Common questions about design decisions and patterns
- 📝 [Strings](docs/TidyKit.Strings.md)
- 📂 [File System](docs/TidyKit.FS.md)
- 📅 [DateTime](docs/TidyKit.DateTime.md)
- 🔄 [JSON](docs/TidyKit.JSON.md)
- 📝 [Logger](docs/TidyKit.Logger.md)
- 🌐 [Network](docs/TidyKit.Request.md)
- 🔐 [Crypto](docs/TidyKit.Crypto.md)
- 📦 [Archive](docs/TidyKit.Archive.md)
- 📚 Collections:
  - [List Collection (TList<T>)](docs/TidyKit.Collections.List.md)
  - [Deque Collection (TDeque<T>)](docs/TidyKit.Collections.Deque.md)
  - [HashSet Collection (THashSet<T>)](docs/TidyKit.Collections.HashSet.md)
  - [Hash Functions](docs/TidyKit.Collections.HashFunction.md)
  - [Equality Functions](docs/TidyKit.Collections.EqualityFunction.md)

## 📊 Real-World Examples

TidyKit can be used to build a wide variety of applications quickly:

| Example Project | Description | Source Code |
|-----------------|-------------|-------------|
| File System Utility | Batch operations on files with pattern matching | [View Example](examples/FileKitExample/) |
| Simple File Explorer | Navigate directories, view files, and perform file operations with an interactive console UI | [View Example](examples/SimpleFileExplorer/) |
| File Analyzer | Analyze text files, count word frequencies, and gather directory statistics | [View Example](examples/FileAnalyzer/) |
| File Backup | Backup files and folders, supports simulate run | [View Example](examples/FileBackup/) |
| Simple Data Logger | Record sensor readings with timestamp and export as CSV | [View Example](examples/LoggerExample/) |
| Configuration Manager | Load, parse, and validate JSON configuration files | [View Example](examples/ConfigKitExample/) |
| Secure Password Storage | Hash and verify passwords with SHA-256 | [View Example](examples/CryptoKitExample/) |
| Date Calculator | Business day calculator with timezone handling | [View Example](examples/DateTimeExample/) |

## 💬 Community & Support

- **Questions?** [Open a discussion](https://github.com/ikelaiah/tidykit-fp/discussions)
- **Found a bug?** [Report an issue](https://github.com/ikelaiah/tidykit-fp/issues)

## ⚠️ Known Limitations

- **Platform Support**: Currently only tested on Windows 11 and Ubuntu 24.04. MacOS and FreeBSD are not officially supported.
- **Threading**: Batch logging mode is not thread-safe. Use in single-threaded contexts or implement your own synchronization.
- **HTTP SSL**: HTTPS requests require OpenSSL libraries on Linux systems (see Dependencies section).
- **Timezone Support**: Limited timezone support on Unix-like systems.
- **Language Features**: Designed for FPC 3.2.2, so no use of inline var declarations or anonymous functions.
- **Library Integration**: Currently no integration with package managers.

## ✅ Testing

1. Open the `TestRunner.lpi` using Lazarus IDE
2. Compile the project
3. Run the Test Runner:

```bash
$ cd tests
$ ./TestRunner.exe -a --format=plain
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

1. Fork the Project
2. Create your Feature Branch (git checkout -b feature/AmazingFeature)
3. Commit your Changes (git commit -m 'Add some AmazingFeature')
4. Push to the Branch (git push origin feature/AmazingFeature)
5. Open a Pull Request

## ⚖️ License

This project is licensed under the MIT License - see the [LICENSE](LICENSE.md) file for details.

## 🙏 Acknowledgments

- FPC Team for Free Pascal
- Contributors and maintainers

## 🗺️ Roadmap

TidyKit is under active development. Here's what's planned:

### Planned for v0.2.0 (Q3 2025) - Simplify API

- Provide a simpler API.

### Planned for v0.3.0 (Q4 2025) - Examples & Refinements

- Add **more real-world examples** and tutorials demonstrating common use cases.
- Performance optimizations based on profiling.
- Expand unit test coverage, especially for edge cases identified during API simplification.

### Future Goals

- Command line argument parser module.
- Thread-safe collections and data structures module.
- Concurrency module.
- Integration with package managers.

---

*Feedback and suggestions are welcome! See the [issues](https://github.com/ikelaiah/tidykit-fp/issues) page to contribute ideas or track progress.*
