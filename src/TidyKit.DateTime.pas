unit TidyKit.DateTime;

{$mode objfpc}{$H+}{$J-}

interface

uses
  Classes, SysUtils, DateUtils;

type
  { TDateSpanKind represents different ways to measure time spans }
  TDateSpanKind = (dskPeriod,  // Calendar time (months, years - variable length)
                   dskDuration, // Physical time (fixed length in seconds)
                   dskInterval);// Specific start-end span
                   
  { TDateSpan represents a span of time that can be added to or subtracted from dates }
  TDateSpan = record
    Kind: TDateSpanKind;    // How to interpret this span
    Years: Integer;         // Number of years
    Months: Integer;        // Number of months
    Days: Integer;          // Number of days
    Hours: Integer;         // Number of hours
    Minutes: Integer;       // Number of minutes
    Seconds: Integer;       // Number of seconds
    Milliseconds: Integer;  // Number of milliseconds
  end;
  
  { TInterval represents a specific span of time with start and end points }
  TInterval = record
    StartDate: TDateTime;   // Start of interval
    EndDate: TDateTime;     // End of interval
  end;

  { TDateTimeKit provides a comprehensive set of date and time manipulation functions }
  TDateTimeKit = class
  public
    { Basic operations for getting and formatting date/time values }
    
    { GetNow
      Returns the current system date and time as a TDateTime value.
      This includes both the date and time portions.
      
      Returns:
        TDateTime - Current date and time from the system clock }
    class function GetNow: TDateTime; static;
    
    { GetToday
      Returns just the current date, with the time set to midnight (00:00:00).
      Useful when you only need the date portion.
      
      Returns:
        TDateTime - Current date with time set to 00:00:00 }
    class function GetToday: TDateTime; static;
    
    { GetDateTime
      Converts or validates a TDateTime value. This is useful for ensuring
      type safety or making explicit conversions.
      
      Parameters:
        AValue - The TDateTime value to convert/validate
        
      Returns:
        TDateTime - The same value, but guaranteed to be TDateTime type }
    class function GetDateTime(const AValue: TDateTime): TDateTime; static;
    
    { GetAsString
      Converts a TDateTime value to a formatted string representation.
      
      Parameters:
        AValue - The TDateTime value to format
        AFormat - Optional format string. If empty, uses system default format
                 Common format specifiers:
                 yyyy = 4-digit year (2024)
                 yy = 2-digit year (24)
                 mm = month (01-12)
                 dd = day (01-31)
                 hh = hour in 24h format (00-23)
                 nn = minutes (00-59)
                 ss = seconds (00-59)
                 zzz = milliseconds (000-999)
      
      Returns:
        string - The formatted date/time string }
    class function GetAsString(const AValue: TDateTime; const AFormat: string = ''): string; static;
    
    { FromString
      Converts a string representation of a date/time into a TDateTime value.
      
      Parameters:
        AValue - The string to parse (e.g., '2024-01-15' or '15/01/2024')
        AFormat - Optional format string matching the input format
                 If empty, tries to parse using system default format
      
      Returns:
        TDateTime - The parsed date/time value
        
      Raises:
        EConvertError - If the string cannot be parsed using the given format }
    class function FromString(const AValue: string; const AFormat: string = ''): TDateTime; static;
    
    { Date Component Getters
      These functions extract specific parts of a date/time value.
      All of them accept a TDateTime parameter and return an integer. }
    
    { GetYear
      Extracts the year from a date/time value.
      
      Parameters:
        AValue - The date/time to extract from
        
      Returns:
        Integer - The year (e.g., 2024) }
    class function GetYear(const AValue: TDateTime): Integer; static;
    
    { GetMonth
      Extracts the month from a date/time value.
      
      Parameters:
        AValue - The date/time to extract from
        
      Returns:
        Integer - The month (1-12, where 1=January) }
    class function GetMonth(const AValue: TDateTime): Integer; static;
    
    { GetDay
      Extracts the day of the month from a date/time value.
      
      Parameters:
        AValue - The date/time to extract from
        
      Returns:
        Integer - The day (1-31) }
    class function GetDay(const AValue: TDateTime): Integer; static;
    
    { GetDayOfWeek
      Returns which day of the week a date falls on.
      
      Parameters:
        AValue - The date/time to check
        
      Returns:
        Integer - Day of week (1=Sunday through 7=Saturday) }
    class function GetDayOfWeek(const AValue: TDateTime): Integer; static;
    
    { GetDayOfYear
      Calculates which day of the year a date falls on.
      
      Parameters:
        AValue - The date/time to check
        
      Returns:
        Integer - Day of year (1-366, accounting for leap years) }
    class function GetDayOfYear(const AValue: TDateTime): Integer; static;
    
    { GetHour
      Extracts the hour from a date/time value.
      
      Parameters:
        AValue - The date/time to extract from
        
      Returns:
        Integer - The hour in 24-hour format (0-23) }
    class function GetHour(const AValue: TDateTime): Integer; static;
    
    { GetMinute
      Extracts the minute from a date/time value.
      
      Parameters:
        AValue - The date/time to extract from
        
      Returns:
        Integer - The minute (0-59) }
    class function GetMinute(const AValue: TDateTime): Integer; static;
    
    { GetSecond
      Extracts the second from a date/time value.
      
      Parameters:
        AValue - The date/time to extract from
        
      Returns:
        Integer - The second (0-59) }
    class function GetSecond(const AValue: TDateTime): Integer; static;
    
    { GetMillisecond
      Extracts the millisecond from a date/time value.
      
      Parameters:
        AValue - The date/time to extract from
        
      Returns:
        Integer - The millisecond (0-999) }
    class function GetMillisecond(const AValue: TDateTime): Integer; static;
    
    { Date Component Setters
      These functions create a new TDateTime with one component changed.
      The original value is not modified. }
    
    { SetYear
      Creates a new date/time with the year changed.
      
      Parameters:
        AValue - Original date/time
        AYear - New year value (e.g., 2024)
        
      Returns:
        TDateTime - New date/time with updated year }
    class function SetYear(const AValue: TDateTime; const AYear: Integer): TDateTime; static;
    
    { SetMonth
      Creates a new date/time with the month changed.
      
      Parameters:
        AValue - Original date/time
        AMonth - New month value (1-12)
        
      Returns:
        TDateTime - New date/time with updated month }
    class function SetMonth(const AValue: TDateTime; const AMonth: Integer): TDateTime; static;
    
    { SetDay
      Creates a new date/time with the day changed.
      
      Parameters:
        AValue - Original date/time
        ADay - New day value (1-31)
        
      Returns:
        TDateTime - New date/time with updated day }
    class function SetDay(const AValue: TDateTime; const ADay: Integer): TDateTime; static;
    
    { SetHour
      Creates a new date/time with the hour changed.
      
      Parameters:
        AValue - Original date/time
        AHour - New hour value (0-23)
        
      Returns:
        TDateTime - New date/time with updated hour }
    class function SetHour(const AValue: TDateTime; const AHour: Integer): TDateTime; static;
    
    { SetMinute
      Creates a new date/time with the minute changed.
      
      Parameters:
        AValue - Original date/time
        AMinute - New minute value (0-59)
        
      Returns:
        TDateTime - New date/time with updated minute }
    class function SetMinute(const AValue: TDateTime; const AMinute: Integer): TDateTime; static;
    
    { SetSecond
      Creates a new date/time with the second changed.
      
      Parameters:
        AValue - Original date/time
        ASecond - New second value (0-59)
        
      Returns:
        TDateTime - New date/time with updated second }
    class function SetSecond(const AValue: TDateTime; const ASecond: Integer): TDateTime; static;
    
    { SetMilliSecond
      Creates a new date/time with the millisecond changed.
      
      Parameters:
        AValue - Original date/time
        AMilliSecond - New millisecond value (0-999)
        
      Returns:
        TDateTime - New date/time with updated millisecond }
    class function SetMilliSecond(const AValue: TDateTime; const AMilliSecond: Integer): TDateTime; static;
    
    { Date/Time Arithmetic
      These functions add or subtract time periods, returning a new TDateTime.
      Negative values can be used to subtract time. }
    
    { AddYears
      Adds (or subtracts) a number of years.
      
      Parameters:
        AValue - Original date/time
        AYears - Number of years to add (negative to subtract)
        
      Returns:
        TDateTime - New date/time with years added/subtracted }
    class function AddYears(const AValue: TDateTime; const AYears: Integer): TDateTime; static;
    
    { AddMonths
      Adds (or subtracts) a number of months.
      
      Parameters:
        AValue - Original date/time
        AMonths - Number of months to add (negative to subtract)
        
      Returns:
        TDateTime - New date/time with months added/subtracted }
    class function AddMonths(const AValue: TDateTime; const AMonths: Integer): TDateTime; static;
    
    { AddDays
      Adds (or subtracts) a number of days.
      
      Parameters:
        AValue - Original date/time
        ADays - Number of days to add (negative to subtract)
        
      Returns:
        TDateTime - New date/time with days added/subtracted }
    class function AddDays(const AValue: TDateTime; const ADays: Integer): TDateTime; static;
    
    { AddHours
      Adds (or subtracts) a number of hours.
      
      Parameters:
        AValue - Original date/time
        AHours - Number of hours to add (negative to subtract)
        
      Returns:
        TDateTime - New date/time with hours added/subtracted }
    class function AddHours(const AValue: TDateTime; const AHours: Integer): TDateTime; static;
    
    { AddMinutes
      Adds (or subtracts) a number of minutes.
      
      Parameters:
        AValue - Original date/time
        AMinutes - Number of minutes to add (negative to subtract)
        
      Returns:
        TDateTime - New date/time with minutes added/subtracted }
    class function AddMinutes(const AValue: TDateTime; const AMinutes: Integer): TDateTime; static;
    
    { AddSeconds
      Adds (or subtracts) a number of seconds.
      
      Parameters:
        AValue - Original date/time
        ASeconds - Number of seconds to add (negative to subtract)
        
      Returns:
        TDateTime - New date/time with seconds added/subtracted }
    class function AddSeconds(const AValue: TDateTime; const ASeconds: Integer): TDateTime; static;
    
    { Period Start/End Functions
      These functions return a new TDateTime set to the start or end
      of a specific time period (year, month, week, etc.) }
    
    { StartOfYear
      Sets the date to January 1st and time to 00:00:00.000
      
      Parameters:
        AValue - Original date/time
        
      Returns:
        TDateTime - First moment of the year }
    class function StartOfYear(const AValue: TDateTime): TDateTime; static;
    
    { StartOfMonth
      Sets the date to the 1st of the month and time to 00:00:00.000
      
      Parameters:
        AValue - Original date/time
        
      Returns:
        TDateTime - First moment of the month }
    class function StartOfMonth(const AValue: TDateTime): TDateTime; static;
    
    { StartOfWeek
      Sets the date to Sunday and time to 00:00:00.000
      
      Parameters:
        AValue - Original date/time
        
      Returns:
        TDateTime - First moment of the week }
    class function StartOfWeek(const AValue: TDateTime): TDateTime; static;
    
    { StartOfDay
      Sets the time to 00:00:00.000, keeping the date unchanged
      
      Parameters:
        AValue - Original date/time
        
      Returns:
        TDateTime - First moment of the day }
    class function StartOfDay(const AValue: TDateTime): TDateTime; static;
    
    { StartOfHour
      Sets minutes, seconds and milliseconds to 0, keeping date and hour
      
      Parameters:
        AValue - Original date/time
        
      Returns:
        TDateTime - First moment of the hour }
    class function StartOfHour(const AValue: TDateTime): TDateTime; static;
    
    { EndOfYear
      Sets the date to December 31st and time to 23:59:59.999
      
      Parameters:
        AValue - Original date/time
        
      Returns:
        TDateTime - Last moment of the year }
    class function EndOfYear(const AValue: TDateTime): TDateTime; static;
    
    { EndOfMonth
      Sets the date to the last day of the month and time to 23:59:59.999
      
      Parameters:
        AValue - Original date/time
        
      Returns:
        TDateTime - Last moment of the month }
    class function EndOfMonth(const AValue: TDateTime): TDateTime; static;
    
    { EndOfWeek
      Sets the date to Saturday and time to 23:59:59.999
      
      Parameters:
        AValue - Original date/time
        
      Returns:
        TDateTime - Last moment of the week }
    class function EndOfWeek(const AValue: TDateTime): TDateTime; static;
    
    { EndOfDay
      Sets the time to 23:59:59.999, keeping the date unchanged
      
      Parameters:
        AValue - Original date/time
        
      Returns:
        TDateTime - Last moment of the day }
    class function EndOfDay(const AValue: TDateTime): TDateTime; static;
    
    { EndOfHour
      Sets minutes to 59, seconds to 59, milliseconds to 999
      
      Parameters:
        AValue - Original date/time
        
      Returns:
        TDateTime - Last moment of the hour }
    class function EndOfHour(const AValue: TDateTime): TDateTime; static;
    
    { Date Comparison Functions
      These functions compare two dates in various ways }
    
    { IsBefore
      Checks if one date/time is before another.
      
      Parameters:
        AValue - First date/time to compare
        ADateTime - Second date/time to compare against
        
      Returns:
        Boolean - True if AValue is before ADateTime }
    class function IsBefore(const AValue, ADateTime: TDateTime): Boolean; static;
    
    { IsAfter
      Checks if one date/time is after another.
      
      Parameters:
        AValue - First date/time to compare
        ADateTime - Second date/time to compare against
        
      Returns:
        Boolean - True if AValue is after ADateTime }
    class function IsAfter(const AValue, ADateTime: TDateTime): Boolean; static;
    
    { IsSameDay
      Checks if two dates fall on the same calendar day.
      Time portions are ignored in the comparison.
      
      Parameters:
        AValue - First date/time to compare
        ADateTime - Second date/time to compare against
        
      Returns:
        Boolean - True if both dates are the same day }
    class function IsSameDay(const AValue, ADateTime: TDateTime): Boolean; static;
    
    { IsSameMonth
      Checks if two dates fall in the same month and year.
      
      Parameters:
        AValue - First date/time to compare
        ADateTime - Second date/time to compare against
        
      Returns:
        Boolean - True if both dates are in the same month }
    class function IsSameMonth(const AValue, ADateTime: TDateTime): Boolean; static;
    
    { IsSameYear
      Checks if two dates fall in the same year.
      
      Parameters:
        AValue - First date/time to compare
        ADateTime - Second date/time to compare against
        
      Returns:
        Boolean - True if both dates are in the same year }
    class function IsSameYear(const AValue, ADateTime: TDateTime): Boolean; static;
    
    { Business Day Functions
      These functions help with business day calculations,
      treating Monday-Friday as business days }
    
    { IsBusinessDay
      Checks if a date falls on a business day (Monday-Friday).
      Weekends (Saturday-Sunday) return False.
      
      Parameters:
        AValue - Date/time to check
        
      Returns:
        Boolean - True if date is a business day }
    class function IsBusinessDay(const AValue: TDateTime): Boolean; static;
    
    { NextBusinessDay
      Finds the next business day after the given date.
      If given a Friday, returns the following Monday.
      
      Parameters:
        AValue - Starting date/time
        
      Returns:
        TDateTime - Next business day }
    class function NextBusinessDay(const AValue: TDateTime): TDateTime; static;
    
    { PreviousBusinessDay
      Finds the previous business day before the given date.
      If given a Monday, returns the previous Friday.
      
      Parameters:
        AValue - Starting date/time
        
      Returns:
        TDateTime - Previous business day }
    class function PreviousBusinessDay(const AValue: TDateTime): TDateTime; static;
    
    { AddBusinessDays
      Adds (or subtracts) a number of business days.
      Skips weekends when counting days.
      
      Parameters:
        AValue - Starting date/time
        ADays - Number of business days to add (negative to subtract)
        
      Returns:
        TDateTime - New date after adding/subtracting business days }
    class function AddBusinessDays(const AValue: TDateTime; const ADays: Integer): TDateTime; static;
    
    { GetQuarter
      Returns the quarter (1-4) for the given date.
      
      Parameters:
        AValue - The date/time to check
        
      Returns:
        Integer - Quarter number (1-4) }
    class function GetQuarter(const AValue: TDateTime): Integer; static;
    
    { IsAM
      Checks if the time is in the AM (before noon).
      
      Parameters:
        AValue - The date/time to check
        
      Returns:
        Boolean - True if time is before noon }
    class function IsAM(const AValue: TDateTime): Boolean; static;
    
    { IsPM
      Checks if the time is in the PM (after noon).
      
      Parameters:
        AValue - The date/time to check
        
      Returns:
        Boolean - True if time is after noon }
    class function IsPM(const AValue: TDateTime): Boolean; static;
    
    { FloorDate
      Rounds down to the nearest unit.
      
      Parameters:
        AValue - The date/time to round
        AUnit - Unit to round to ('second', 'minute', 'hour', 'day', 'month', 'year')
        
      Returns:
        TDateTime - Rounded down date/time }
    class function FloorDate(const AValue: TDateTime; const AUnit: string): TDateTime; static;
    
    { CeilingDate
      Rounds up to the nearest unit.
      
      Parameters:
        AValue - The date/time to round
        AUnit - Unit to round to ('second', 'minute', 'hour', 'day', 'month', 'year')
        
      Returns:
        TDateTime - Rounded up date/time }
    class function CeilingDate(const AValue: TDateTime; const AUnit: string): TDateTime; static;
    
    { Time Span Creation Functions }
    
    { CreatePeriod
      Creates a calendar-based time span (handles months, leap years naturally).
      
      Parameters:
        AYears, AMonths, etc. - Components of the period
        
      Returns:
        TDateSpan - A period that can be added to dates }
    class function CreatePeriod(const AYears: Integer = 0; const AMonths: Integer = 0;
      const ADays: Integer = 0; const AHours: Integer = 0; const AMinutes: Integer = 0;
      const ASeconds: Integer = 0; const AMilliseconds: Integer = 0): TDateSpan; static;
      
    { CreateDuration
      Creates a fixed-length time span (in exact seconds).
      
      Parameters:
        AYears, AMonths, etc. - Components of the duration
        
      Returns:
        TDateSpan - A duration that can be added to dates }
    class function CreateDuration(const AYears: Integer = 0; const AMonths: Integer = 0;
      const ADays: Integer = 0; const AHours: Integer = 0; const AMinutes: Integer = 0;
      const ASeconds: Integer = 0; const AMilliseconds: Integer = 0): TDateSpan; static;
      
    { CreateInterval
      Creates a specific time interval between two dates.
      
      Parameters:
        AStart - Start date/time
        AEnd - End date/time
        
      Returns:
        TInterval - An interval representing the span }
    class function CreateInterval(const AStart, AEnd: TDateTime): TInterval; static;
    
    { Time Span Operations }
    
    { AddSpan
      Adds a time span to a date.
      
      Parameters:
        AValue - Original date/time
        ASpan - Time span to add
        
      Returns:
        TDateTime - New date with span added }
    class function AddSpan(const AValue: TDateTime; const ASpan: TDateSpan): TDateTime; static;
    
    { SubtractSpan
      Subtracts a time span from a date.
      
      Parameters:
        AValue - Original date/time
        ASpan - Time span to subtract
        
      Returns:
        TDateTime - New date with span subtracted }
    class function SubtractSpan(const AValue: TDateTime; const ASpan: TDateSpan): TDateTime; static;
    
    { SpanBetween
      Calculates the time span between two dates.
      
      Parameters:
        AStart - Start date/time
        AEnd - End date/time
        AKind - Kind of span to calculate (period/duration)
        
      Returns:
        TDateSpan - Time span between the dates }
    class function SpanBetween(const AStart, AEnd: TDateTime; 
      const AKind: TDateSpanKind = dskPeriod): TDateSpan; static;
      
    { Interval Operations }
    
    { IsWithinInterval
      Checks if a date falls within an interval.
      
      Parameters:
        AValue - Date to check
        AInterval - Interval to check against
        
      Returns:
        Boolean - True if date is within interval }
    class function IsWithinInterval(const AValue: TDateTime; 
      const AInterval: TInterval): Boolean; static;
      
    { IntervalsOverlap
      Checks if two intervals overlap.
      
      Parameters:
        AInterval1, AInterval2 - Intervals to check
        
      Returns:
        Boolean - True if intervals overlap }
    class function IntervalsOverlap(const AInterval1, AInterval2: TInterval): Boolean; static;
      
    { IntervalLength
      Gets the length of an interval as a span.
      
      Parameters:
        AInterval - Interval to measure
        AKind - Kind of span to return (period/duration)
        
      Returns:
        TDateSpan - Length of the interval }
    class function IntervalLength(const AInterval: TInterval; 
      const AKind: TDateSpanKind = dskPeriod): TDateSpan; static;
  end;

implementation

{ TDateTimeKit }

class function TDateTimeKit.GetNow: TDateTime;
begin
  // Returns the current system date and time using SysUtils.Now
  Result := SysUtils.Now;
end;

class function TDateTimeKit.GetToday: TDateTime;
begin
  // Returns just the date part of the current system time
  // Time portion is set to 00:00:00 by truncating
  Result := Trunc(SysUtils.Now);
end;

class function TDateTimeKit.GetDateTime(const AValue: TDateTime): TDateTime;
begin
  // Simple pass-through function for type safety and consistency
  Result := AValue;
end;

class function TDateTimeKit.GetAsString(const AValue: TDateTime; const AFormat: string): string;
begin
  // Convert DateTime to string using either default or custom format
  if AFormat = '' then
    Result := DateTimeToStr(AValue)  // Use system default format
  else
    Result := FormatDateTime(AFormat, AValue);  // Use specified format
end;

class function TDateTimeKit.FromString(const AValue: string; const AFormat: string): TDateTime;
var
  FormatSettings: TFormatSettings;
begin
  // Get system default format settings
  FormatSettings := DefaultFormatSettings;
  
  // Parse string to DateTime using either default or custom format
  if AFormat = '' then
    Result := StrToDateTime(AValue, FormatSettings)
  else
  begin
    // Use provided format for parsing
    FormatSettings.ShortDateFormat := AFormat;
    Result := StrToDateTime(AValue, FormatSettings);
  end;
end;

class function TDateTimeKit.GetYear(const AValue: TDateTime): Integer;
var
  Y, M, D: Word;
begin
  // Extract date components and return just the year
  DecodeDate(AValue, Y, M, D);
  Result := Y;
end;

class function TDateTimeKit.GetMonth(const AValue: TDateTime): Integer;
var
  Y, M, D: Word;
begin
  // Extract date components and return just the month
  DecodeDate(AValue, Y, M, D);
  Result := M;
end;

class function TDateTimeKit.GetDay(const AValue: TDateTime): Integer;
var
  Y, M, D: Word;
begin
  // Extract date components and return just the day
  DecodeDate(AValue, Y, M, D);
  Result := D;
end;

class function TDateTimeKit.GetDayOfWeek(const AValue: TDateTime): Integer;
begin
  // Returns day of week where 1=Sunday, 2=Monday, ..., 7=Saturday
  Result := SysUtils.DayOfWeek(AValue);
end;

class function TDateTimeKit.GetDayOfYear(const AValue: TDateTime): Integer;
begin
  // Returns day of year (1-366)
  Result := DateUtils.DayOfTheYear(AValue);
end;

class function TDateTimeKit.GetHour(const AValue: TDateTime): Integer;
var
  H, M, S, MS: Word;
begin
  // Extract time components and return just the hour
  DecodeTime(AValue, H, M, S, MS);
  Result := H;
end;

class function TDateTimeKit.GetMinute(const AValue: TDateTime): Integer;
var
  H, M, S, MS: Word;
begin
  // Extract time components and return just the minute
  DecodeTime(AValue, H, M, S, MS);
  Result := M;
end;

class function TDateTimeKit.GetSecond(const AValue: TDateTime): Integer;
var
  H, M, S, MS: Word;
begin
  // Extract time components and return just the second
  DecodeTime(AValue, H, M, S, MS);
  Result := S;
end;

class function TDateTimeKit.GetMillisecond(const AValue: TDateTime): Integer;
var
  H, M, S, MS: Word;
begin
  // Extract time components and return just the millisecond
  DecodeTime(AValue, H, M, S, MS);
  Result := MS;
end;

class function TDateTimeKit.SetYear(const AValue: TDateTime; const AYear: Integer): TDateTime;
var
  Y, M, D: Word;
  NewD: Word;
begin
  // Extract current date components
  DecodeDate(AValue, Y, M, D);
  
  // Handle Feb 29 corner case
  if (M = 2) and (D = 29) and (not IsLeapYear(AYear)) then
    NewD := 28
  else
    NewD := D;
    
  // Create new date with updated year, preserving time portion
  Result := EncodeDate(AYear, M, NewD) + Frac(AValue);
end;

class function TDateTimeKit.SetMonth(const AValue: TDateTime; const AMonth: Integer): TDateTime;
var
  Y, M, D: Word;
  LastDay: Word;
  NewD: Word;
  TempDate: TDateTime;
begin
  // Extract current date components
  DecodeDate(AValue, Y, M, D);
  
  // Create a temporary date with the target month
  TempDate := EncodeDate(Y, AMonth, 1);
  
  // Get last day of target month using RTL function
  LastDay := DaysInMonth(TempDate);
  
  // Adjust day if it exceeds the last day of target month
  if D > LastDay then
    NewD := LastDay
  else
    NewD := D;
    
  // Create new date with updated month, preserving time portion
  Result := EncodeDate(Y, AMonth, NewD) + Frac(AValue);
end;

class function TDateTimeKit.SetDay(const AValue: TDateTime; const ADay: Integer): TDateTime;
var
  Y, M, D: Word;
begin
  // Extract current date components
  DecodeDate(AValue, Y, M, D);
  // Create new date with updated day, preserving time portion
  Result := EncodeDate(Y, M, ADay) + Frac(AValue);
end;

class function TDateTimeKit.SetHour(const AValue: TDateTime; const AHour: Integer): TDateTime;
var
  H, M, S, MS: Word;
begin
  // Extract current time components
  DecodeTime(AValue, H, M, S, MS);
  // Create new time with updated hour, preserving date portion
  Result := Trunc(AValue) + EncodeTime(AHour, M, S, MS);
end;

class function TDateTimeKit.SetMinute(const AValue: TDateTime; const AMinute: Integer): TDateTime;
var
  H, M, S, MS: Word;
begin
  // Extract current time components
  DecodeTime(AValue, H, M, S, MS);
  // Create new time with updated minute, preserving date portion
  Result := Trunc(AValue) + EncodeTime(H, AMinute, S, MS);
end;

class function TDateTimeKit.SetSecond(const AValue: TDateTime; const ASecond: Integer): TDateTime;
var
  H, M, S, MS: Word;
begin
  // Extract current time components
  DecodeTime(AValue, H, M, S, MS);
  // Create new time with updated second, preserving date portion
  Result := Trunc(AValue) + EncodeTime(H, M, ASecond, MS);
end;

class function TDateTimeKit.SetMilliSecond(const AValue: TDateTime; const AMilliSecond: Integer): TDateTime;
var
  H, M, S, MS: Word;
begin
  // Extract current time components
  DecodeTime(AValue, H, M, S, MS);
  // Create new time with updated millisecond, preserving date portion
  Result := Trunc(AValue) + EncodeTime(H, M, S, AMilliSecond);
end;

class function TDateTimeKit.AddYears(const AValue: TDateTime; const AYears: Integer): TDateTime;
begin
  // Add/subtract years using DateUtils function
  Result := IncYear(AValue, AYears);
end;

class function TDateTimeKit.AddMonths(const AValue: TDateTime; const AMonths: Integer): TDateTime;
begin
  // Add/subtract months using DateUtils function
  Result := IncMonth(AValue, AMonths);
end;

class function TDateTimeKit.AddDays(const AValue: TDateTime; const ADays: Integer): TDateTime;
begin
  // Add/subtract days using DateUtils function
  Result := IncDay(AValue, ADays);
end;

class function TDateTimeKit.AddHours(const AValue: TDateTime; const AHours: Integer): TDateTime;
begin
  // Add/subtract hours using DateUtils function
  Result := IncHour(AValue, AHours);
end;

class function TDateTimeKit.AddMinutes(const AValue: TDateTime; const AMinutes: Integer): TDateTime;
begin
  // Add/subtract minutes using DateUtils function
  Result := IncMinute(AValue, AMinutes);
end;

class function TDateTimeKit.AddSeconds(const AValue: TDateTime; const ASeconds: Integer): TDateTime;
begin
  // Add/subtract seconds using DateUtils function
  Result := IncSecond(AValue, ASeconds);
end;

class function TDateTimeKit.StartOfYear(const AValue: TDateTime): TDateTime;
begin
  // Set date to January 1st of the current year at 00:00:00.000
  Result := StartOfTheYear(AValue);
end;

class function TDateTimeKit.StartOfMonth(const AValue: TDateTime): TDateTime;
begin
  // Set date to the 1st of the current month at 00:00:00.000
  Result := StartOfTheMonth(AValue);
end;

class function TDateTimeKit.StartOfWeek(const AValue: TDateTime): TDateTime;
begin
  // Set date to Sunday of the current week at 00:00:00.000
  Result := StartOfTheWeek(AValue);
end;

class function TDateTimeKit.StartOfDay(const AValue: TDateTime): TDateTime;
begin
  // Set time to 00:00:00.000, preserving the date
  Result := DateOf(AValue);
end;

class function TDateTimeKit.StartOfHour(const AValue: TDateTime): TDateTime;
var
  H, M, S, MS: Word;
begin
  // Extract hour and set minutes, seconds, milliseconds to zero
  DecodeTime(AValue, H, M, S, MS);
  Result := Trunc(AValue) + EncodeTime(H, 0, 0, 0);
end;

class function TDateTimeKit.EndOfYear(const AValue: TDateTime): TDateTime;
begin
  // Set date to December 31st of the current year at 23:59:59.999
  Result := EndOfTheYear(AValue);
end;

class function TDateTimeKit.EndOfMonth(const AValue: TDateTime): TDateTime;
begin
  // Set date to the last day of the current month at 23:59:59.999
  Result := EndOfTheMonth(AValue);
end;

class function TDateTimeKit.EndOfWeek(const AValue: TDateTime): TDateTime;
begin
  // Set date to Saturday of the current week at 23:59:59.999
  Result := EndOfTheWeek(AValue);
end;

class function TDateTimeKit.EndOfDay(const AValue: TDateTime): TDateTime;
begin
  // Set time to 23:59:59.999, preserving the date
  Result := EndOfTheDay(AValue);
end;

class function TDateTimeKit.EndOfHour(const AValue: TDateTime): TDateTime;
var
  H, M, S, MS: Word;
begin
  // Extract hour and set minutes, seconds, milliseconds to their maximum values
  DecodeTime(AValue, H, M, S, MS);
  Result := Trunc(AValue) + EncodeTime(H, 59, 59, 999);
end;

class function TDateTimeKit.IsBefore(const AValue, ADateTime: TDateTime): Boolean;
begin
  // Compare dates using SysUtils function, returns true if AValue < ADateTime
  Result := CompareDateTime(AValue, ADateTime) < 0;
end;

class function TDateTimeKit.IsAfter(const AValue, ADateTime: TDateTime): Boolean;
begin
  // Compare dates using SysUtils function, returns true if AValue > ADateTime
  Result := CompareDateTime(AValue, ADateTime) > 0;
end;

class function TDateTimeKit.IsSameDay(const AValue, ADateTime: TDateTime): Boolean;
begin
  // Compare dates ignoring time portion
  Result := SameDate(AValue, ADateTime);
end;

class function TDateTimeKit.IsSameMonth(const AValue, ADateTime: TDateTime): Boolean;
var
  Y1, M1, D1, Y2, M2, D2: Word;
begin
  // Extract date components from both dates
  DecodeDate(AValue, Y1, M1, D1);
  DecodeDate(ADateTime, Y2, M2, D2);
  // Compare year and month
  Result := (Y1 = Y2) and (M1 = M2);
end;

class function TDateTimeKit.IsSameYear(const AValue, ADateTime: TDateTime): Boolean;
var
  Y1, M1, D1, Y2, M2, D2: Word;
begin
  // Extract date components from both dates
  DecodeDate(AValue, Y1, M1, D1);
  DecodeDate(ADateTime, Y2, M2, D2);
  // Compare year only
  Result := Y1 = Y2;
end;

class function TDateTimeKit.IsBusinessDay(const AValue: TDateTime): Boolean;
var
  DayOfWeek: Integer;
begin
  // Get day of week (1=Sunday, 2=Monday, ..., 7=Saturday)
  DayOfWeek := GetDayOfWeek(AValue);
  // Check if it's Monday through Friday (2-6)
  Result := (DayOfWeek > 1) and (DayOfWeek < 7);
end;

class function TDateTimeKit.NextBusinessDay(const AValue: TDateTime): TDateTime;
begin
  Result := AValue;
  // Keep adding days until we find a business day
  repeat
    Result := AddDays(Result, 1);
  until IsBusinessDay(Result);
end;

class function TDateTimeKit.PreviousBusinessDay(const AValue: TDateTime): TDateTime;
begin
  Result := AValue;
  // Keep subtracting days until we find a business day
  repeat
    Result := AddDays(Result, -1);
  until IsBusinessDay(Result);
end;

class function TDateTimeKit.AddBusinessDays(const AValue: TDateTime; const ADays: Integer): TDateTime;
var
  Step, RemainingDays: Integer;
begin
  Result := AValue;
  if ADays = 0 then
    Exit;
    
  // Determine direction (1 for forward, -1 for backward)
  Step := ADays div Abs(ADays);
  // Get absolute number of days to add/subtract
  RemainingDays := Abs(ADays);
  
  // Keep adding/subtracting days until we've found enough business days
  while RemainingDays > 0 do
  begin
    Result := AddDays(Result, Step);
    if IsBusinessDay(Result) then
      Dec(RemainingDays);
  end;
end;

class function TDateTimeKit.GetQuarter(const AValue: TDateTime): Integer;
begin
  Result := ((GetMonth(AValue) - 1) div 3) + 1;
end;

class function TDateTimeKit.IsAM(const AValue: TDateTime): Boolean;
begin
  Result := GetHour(AValue) < 12;
end;

class function TDateTimeKit.IsPM(const AValue: TDateTime): Boolean;
begin
  Result := GetHour(AValue) >= 12;
end;

class function TDateTimeKit.FloorDate(const AValue: TDateTime; const AUnit: string): TDateTime;
var
  Y, M, D: Word;
  H, N, S, MS: Word;
begin
  DecodeDate(AValue, Y, M, D);
  DecodeTime(AValue, H, N, S, MS);
  
  case LowerCase(AUnit) of
    'year': Result := EncodeDate(Y, 1, 1);
    'month': Result := EncodeDate(Y, M, 1);
    'day': Result := Trunc(AValue);
    'hour': Result := Trunc(AValue) + EncodeTime(H, 0, 0, 0);
    'minute': Result := Trunc(AValue) + EncodeTime(H, N, 0, 0);
    'second': Result := Trunc(AValue) + EncodeTime(H, N, S, 0);
    else
      Result := AValue;  // Unknown unit, return as is
  end;
end;

class function TDateTimeKit.CeilingDate(const AValue: TDateTime; const AUnit: string): TDateTime;
var
  Y, M, D: Word;
  H, N, S, MS: Word;
  LastDay: Word;
begin
  DecodeDate(AValue, Y, M, D);
  DecodeTime(AValue, H, N, S, MS);
  
  case LowerCase(AUnit) of
    'year': 
      if (M = 1) and (D = 1) and (H = 0) and (N = 0) and (S = 0) and (MS = 0) then
        Result := AValue
      else
        Result := EncodeDate(Y + 1, 1, 1);
        
    'month':
      if (D = 1) and (H = 0) and (N = 0) and (S = 0) and (MS = 0) then
        Result := AValue
      else
        if M = 12 then
          Result := EncodeDate(Y + 1, 1, 1)
        else
          Result := EncodeDate(Y, M + 1, 1);
          
    'day':
      if (H = 0) and (N = 0) and (S = 0) and (MS = 0) then
        Result := AValue
      else
        Result := Trunc(AValue) + 1;
        
    'hour':
      if (N = 0) and (S = 0) and (MS = 0) then
        Result := AValue
      else
        Result := Trunc(AValue) + EncodeTime(H + 1, 0, 0, 0);
        
    'minute':
      if (S = 0) and (MS = 0) then
        Result := AValue
      else
        Result := Trunc(AValue) + EncodeTime(H, N + 1, 0, 0);
        
    'second':
      if MS = 0 then
        Result := AValue
      else
        Result := Trunc(AValue) + EncodeTime(H, N, S + 1, 0);
    else
      Result := AValue;  // Unknown unit, return as is
  end;
end;

class function TDateTimeKit.CreatePeriod(const AYears, AMonths, ADays, AHours,
  AMinutes, ASeconds, AMilliseconds: Integer): TDateSpan;
begin
  Result.Kind := dskPeriod;
  Result.Years := AYears;
  Result.Months := AMonths;
  Result.Days := ADays;
  Result.Hours := AHours;
  Result.Minutes := AMinutes;
  Result.Seconds := ASeconds;
  Result.Milliseconds := AMilliseconds;
end;

class function TDateTimeKit.CreateDuration(const AYears, AMonths, ADays, AHours,
  AMinutes, ASeconds, AMilliseconds: Integer): TDateSpan;
begin
  Result.Kind := dskDuration;
  // Convert everything to a consistent unit (milliseconds)
  Result.Years := 0;
  Result.Months := 0;
  Result.Days := 0;
  Result.Hours := 0;
  Result.Minutes := 0;
  Result.Seconds := ASeconds + 
                   AMinutes * 60 + 
                   AHours * 3600 + 
                   ADays * 86400 +
                   AMonths * 2592000 +  // Approximate - 30 days
                   AYears * 31536000;   // Approximate - 365 days
  Result.Milliseconds := AMilliseconds;
end;

class function TDateTimeKit.CreateInterval(const AStart, AEnd: TDateTime): TInterval;
begin
  Result.StartDate := AStart;
  Result.EndDate := AEnd;
end;

class function TDateTimeKit.AddSpan(const AValue: TDateTime; const ASpan: TDateSpan): TDateTime;
begin
  case ASpan.Kind of
    dskPeriod:
      begin
        // Use RTL functions for date arithmetic
        Result := AValue;
        if ASpan.Years <> 0 then
          Result := IncYear(Result, ASpan.Years);
        if ASpan.Months <> 0 then
          Result := IncMonth(Result, ASpan.Months);
        if ASpan.Days <> 0 then
          Result := IncDay(Result, ASpan.Days);
        if (ASpan.Hours <> 0) or (ASpan.Minutes <> 0) or 
           (ASpan.Seconds <> 0) or (ASpan.Milliseconds <> 0) then
          Result := Result + EncodeTime(ASpan.Hours, ASpan.Minutes,
                                      ASpan.Seconds, ASpan.Milliseconds);
      end;
      
    dskDuration:
      begin
        // Add exact number of seconds
        Result := AValue + 
                 (ASpan.Seconds / SecsPerDay) +
                 (ASpan.Milliseconds / (SecsPerDay * 1000));
      end;
      
    else
      Result := AValue; // Unknown kind
  end;
end;

class function TDateTimeKit.SubtractSpan(const AValue: TDateTime; const ASpan: TDateSpan): TDateTime;
var
  NegativeSpan: TDateSpan;
begin
  // Create negative version of span
  NegativeSpan := ASpan;
  NegativeSpan.Years := -ASpan.Years;
  NegativeSpan.Months := -ASpan.Months;
  NegativeSpan.Days := -ASpan.Days;
  NegativeSpan.Hours := -ASpan.Hours;
  NegativeSpan.Minutes := -ASpan.Minutes;
  NegativeSpan.Seconds := -ASpan.Seconds;
  NegativeSpan.Milliseconds := -ASpan.Milliseconds;
  
  Result := AddSpan(AValue, NegativeSpan);
end;

class function TDateTimeKit.SpanBetween(const AStart, AEnd: TDateTime;
  const AKind: TDateSpanKind): TDateSpan;
var
  Y1, M1, D1, Y2, M2, D2: Word;
  H1, N1, S1, MS1, H2, N2, S2, MS2: Word;
  TempDate: TDateTime;
begin
  case AKind of
    dskPeriod:
      begin
        // Extract components from both dates
        DecodeDate(AStart, Y1, M1, D1);
        DecodeTime(AStart, H1, N1, S1, MS1);
        DecodeDate(AEnd, Y2, M2, D2);
        DecodeTime(AEnd, H2, N2, S2, MS2);
        
        // Try exact year first
        TempDate := IncYear(AStart, Y2 - Y1);
        if CompareDateTime(TempDate, AEnd) = 0 then
        begin
          Result := CreatePeriod(Y2 - Y1);
          Exit;
        end;
        
        // Try exact month
        TempDate := IncMonth(AStart, (Y2 - Y1) * 12 + (M2 - M1));
        if CompareDateTime(TempDate, AEnd) = 0 then
        begin
          Result := CreatePeriod(Y2 - Y1, M2 - M1);
          Exit;
        end;
        
        // Calculate full period
        Result.Kind := dskPeriod;
        Result.Years := Y2 - Y1;
        Result.Months := M2 - M1;
        Result.Days := D2 - D1;
        Result.Hours := H2 - H1;
        Result.Minutes := N2 - N1;
        Result.Seconds := S2 - S1;
        Result.Milliseconds := MS2 - MS1;
        
        // Normalize using RTL functions
        if Result.Milliseconds < 0 then begin
          Dec(Result.Seconds);
          Inc(Result.Milliseconds, 1000);
        end;
        if Result.Seconds < 0 then begin
          Dec(Result.Minutes);
          Inc(Result.Seconds, 60);
        end;
        if Result.Minutes < 0 then begin
          Dec(Result.Hours);
          Inc(Result.Minutes, 60);
        end;
        if Result.Hours < 0 then begin
          Dec(Result.Days);
          Inc(Result.Hours, 24);
        end;
        if Result.Days < 0 then begin
          Dec(Result.Months);
          TempDate := EncodeDate(Y1, M1, 1);
          Inc(Result.Days, DaysInMonth(TempDate));
        end;
        if Result.Months < 0 then begin
          Dec(Result.Years);
          Inc(Result.Months, 12);
        end;
      end;
      
    dskDuration:
      begin
        // For durations, use direct subtraction and convert to seconds
        Result.Kind := dskDuration;
        Result.Years := 0;
        Result.Months := 0;
        Result.Days := 0;
        Result.Hours := 0;
        Result.Minutes := 0;
        Result.Seconds := Round((AEnd - AStart) * SecsPerDay);
        Result.Milliseconds := Round(Frac(AEnd - AStart) * SecsPerDay * 1000) mod 1000;
      end;
      
    else
      FillChar(Result, SizeOf(Result), 0);
  end;
end;

class function TDateTimeKit.IsWithinInterval(const AValue: TDateTime;
  const AInterval: TInterval): Boolean;
begin
  Result := (AValue >= AInterval.StartDate) and (AValue <= AInterval.EndDate);
end;

class function TDateTimeKit.IntervalsOverlap(const AInterval1,
  AInterval2: TInterval): Boolean;
begin
  Result := (AInterval1.StartDate <= AInterval2.EndDate) and
            (AInterval1.EndDate >= AInterval2.StartDate);
end;

class function TDateTimeKit.IntervalLength(const AInterval: TInterval;
  const AKind: TDateSpanKind): TDateSpan;
begin
  Result := SpanBetween(AInterval.StartDate, AInterval.EndDate, AKind);
end;

end. 