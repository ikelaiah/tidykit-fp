# TidyKit.Request Documentation

A lightweight, memory-safe HTTP client for Free Pascal that uses advanced records for automatic cleanup. This module provides a fluent interface for making HTTP requests with built-in memory management and seamless JSON integration through TidyKit.JSON.

## Table of Contents

- [TidyKit.Request Documentation](#tidykitrequest-documentation)
  - [Table of Contents](#table-of-contents)
  - [Features](#features)
  - [System Requirements](#system-requirements)
  - [Design Philosophy](#design-philosophy)
    - [Fluent Interface Pattern](#fluent-interface-pattern)
  - [Memory Safety](#memory-safety)
  - [Basic Usage](#basic-usage)
    - [Simple GET Request](#simple-get-request)
    - [Working with JSON](#working-with-json)
    - [Using the Fluent Interface](#using-the-fluent-interface)
  - [Error Handling](#error-handling)
    - [Using Try-Pattern](#using-try-pattern)
    - [SSL/TLS Errors](#ssltls-errors)
  - [API Reference](#api-reference)
    - [TResponse Record](#tresponse-record)
    - [THttpRequest Record](#thttprequest-record)
    - [Global HTTP Functions](#global-http-functions)
  - [Advanced Usage Examples](#advanced-usage-examples)
    - [Complex Request with Multiple Headers and Parameters](#complex-request-with-multiple-headers-and-parameters)
    - [Authenticated Request with Error Handling](#authenticated-request-with-error-handling)
    - [Form Data Submission](#form-data-submission)
  - [Testing and Development](#testing-and-development)
  - [Best Practices](#best-practices)


## Features

- Zero-setup memory management using advanced records
- Fluent interface for expressive request building
- Support for common HTTP methods (GET, POST, PUT, DELETE, PATCH)
- Seamless JSON integration with TidyKit.JSON
- Query parameters and custom headers
- Basic authentication
- Timeout configuration
- Error handling with result pattern
- Cross-platform support for Windows and Linux
- Automatic test environment detection and HTTP fallback

## System Requirements

For basic HTTP functionality, no special requirements are needed. For HTTPS (SSL/TLS) support:

- Windows: OpenSSL libraries are included with the application and no additional setup is required
- Linux:
  - Ubuntu/Debian: `sudo apt-get install libssl-dev`
  - Fedora/RHEL: `sudo dnf install openssl-devel`

The module will detect missing OpenSSL libraries and provide helpful error messages with installation instructions.

## Design Philosophy

### Fluent Interface Pattern
This module implements a fluent interface pattern, which is a specific form of the builder pattern that emphasizes:

1. **Method Chaining**: Each method returns the request itself, allowing for a chain of method calls:
```pascal
var
  Request: THttpRequest;  // Automatically initialized when declared
  UserData: IJSONObject;
  Response: TResponse;
begin
  UserData := TJSON.Obj;
  UserData.Add('name', 'John');
  UserData.Add('email', 'john@example.com');

  Response := Request
    .Post                                // Chain HTTP method
    .URL('https://api.example.com')      // Chain URL
    .AddHeader('X-API-Key', 'your-key')  // Chain headers
    .WithJSON(UserData.ToString)         // Chain JSON body
    .Send;                               // Execute
end;
```

2. **Readable, SQL-like Syntax**: The API reads almost like English:
```pascal
var
  Request: THttpRequest;  // Automatically initialized when declared
  Response: TResponse;
begin
  Response := Request
    .Get
    .URL('https://api.example.com/secure')
    .BasicAuth('username', 'password')
    .WithTimeout(5000)
    .Send;
end;
```

3. **Context Preservation**: Each method call preserves and adds to the context, with the final state resolved only when `Send` is called.

4. **Self-Documenting Code**: The fluent interface makes the intent clear and reduces the need for additional documentation.

## Memory Safety

This module uses Free Pascal's advanced records feature to provide automatic memory management:

- No manual initialization or cleanup needed
- Objects are automatically initialized when declared
- Memory is automatically freed when variables go out of scope
- Safe to use in try-except blocks - cleanup still happens if an exception occurs
- JSON responses are managed through interface references

## Basic Usage

### Simple GET Request
```pascal
var
  Response: TResponse;
  Data: IJSONObject;
begin
  Response := Http.Get('https://api.example.com/data');
  if Response.StatusCode = 200 then
  begin
    Data := Response.JSON.AsObject;
    WriteLn('ID: ', Data['id'].AsInteger);
    WriteLn('Name: ', Data['name'].AsString);
  end;
end;
```

### Working with JSON
```pascal
var
  Response: TResponse;
  UserData: IJSONObject;
begin
  // Create JSON request data
  UserData := TJSON.Obj;
  UserData.Add('name', 'John Smith');
  UserData.Add('age', 30);
  UserData.Add('email', 'john@example.com');

  // Send JSON request
  Response := Http.PostJSON('https://api.example.com/users',
    UserData.ToString);

  // Handle JSON response
  if Response.StatusCode = 201 then
  begin
    WriteLn('User created with ID: ', Response.JSON.AsObject['id'].AsString);
    WriteLn('Created at: ', Response.JSON.AsObject['created_at'].AsString);
  end;
end;
```

### Using the Fluent Interface
```pascal
var
  Request: THttpRequest;  // Automatically initialized when declared
  Response: TResponse;
  UserData, ResponseData: IJSONObject;
begin
  // Create request JSON
  UserData := TJSON.Obj;
  UserData.Add('name', 'John');
  UserData.Add('email', 'john@example.com');

  Response := Request
    .Post                                // Chain HTTP method
    .URL('https://api.example.com')      // Chain URL
    .AddHeader('X-API-Key', 'your-key')  // Chain headers
    .WithJSON(UserData.ToString)         // Chain JSON body
    .Send;                               // Execute

  if Response.StatusCode = 200 then
  begin
    ResponseData := Response.JSON.AsObject;
    WriteLn('Success: ', ResponseData['success'].AsBoolean);
    WriteLn('Message: ', ResponseData['message'].AsString);
  end;
end;
```

## Error Handling

The TidyKit.Request module uses a dedicated exception class, `ERequestError`, for handling HTTP-related errors. This allows you to specifically catch HTTP request errors while letting other types of exceptions propagate as normal.

```pascal
try
  Response := Http.Get('https://api.example.com/data');
  // Use the response...
except
  on E: ERequestError do
    // Handle HTTP-specific errors (timeouts, connection problems, etc.)
    WriteLn('HTTP Error: ', E.Message);
  on E: Exception do
    // Handle other types of errors
    WriteLn('General Error: ', E.Message);
end;
```

### Using Try-Pattern
For a more functional approach, you can use the built-in Try-pattern methods that handle exceptions for you:

```pascal
var
  Result: TRequestResult;
begin
  Result := Http.TryGet('https://api.example.com/data');
  if Result.Success then
  begin
    WriteLn('Status: ', Result.Response.JSON.AsObject['status'].AsString);
    WriteLn('Data: ', Result.Response.JSON.AsObject['data'].AsString);
  end
  else
    WriteLn('Error: ', Result.Error);
end;
```

### SSL/TLS Errors

When making HTTPS requests, you may encounter SSL-related errors if the OpenSSL libraries are not properly installed, especially on Linux systems. The module will provide helpful error messages:

```
OpenSSL initialization failed: Could not initialize OpenSSL library
You need to install the OpenSSL development libraries:
On Ubuntu/Debian: sudo apt-get install libssl-dev
On Fedora/RHEL: sudo dnf install openssl-devel
```

The TryGet and TryPost methods handle these errors gracefully, allowing your application to continue functioning even if HTTPS is not available:

```pascal
var
  Result: TRequestResult;
begin
  Result := Http.TryGet('https://api.example.com/secure');
  if Result.Success then
    // Process successful response
  else if Pos('OpenSSL', Result.Error) > 0 then
    WriteLn('HTTPS not available. Please install OpenSSL libraries.')
  else
    WriteLn('Error: ', Result.Error);
end;
```

## API Reference

### TResponse Record
```pascal
TResponse = record
  StatusCode: Integer;
  property Text: string;              // Response body as text
  property JSON: IJSONValue;          // Response parsed as JSON
  
  // Memory management (called automatically)
  class operator Initialize(var Response: TResponse);  // Called when variable is created
  class operator Finalize(var Response: TResponse);    // Called when variable goes out of scope
end;
```

### THttpRequest Record
```pascal
THttpRequest = record
  // HTTP Methods (each returns Self for chaining)
  function Get: THttpRequest;
  function Post: THttpRequest;
  function Put: THttpRequest;
  function Delete: THttpRequest;
  function Patch: THttpRequest;
  
  // Request Configuration (each returns Self for chaining)
  function URL(const AUrl: string): THttpRequest;
  function AddHeader(const Name, Value: string): THttpRequest;
  function AddParam(const Name, Value: string): THttpRequest;
  function WithTimeout(const Milliseconds: Integer): THttpRequest;
  function BasicAuth(const Username, Password: string): THttpRequest;
  function WithJSON(const JsonStr: string): THttpRequest;
  function WithData(const Data: string): THttpRequest;
  
  // Execute the request
  function Send: TResponse;
  
  // Memory management (called automatically)
  class operator Initialize(var Request: THttpRequest);
  class operator Finalize(var Request: THttpRequest);
end;
```

### Global HTTP Functions
```pascal
THttp = record
  // Simple one-line request methods
  class function Get(const URL: string): TResponse;
  class function Post(const URL: string; const Data: string = ''): TResponse;
  class function Put(const URL: string; const Data: string = ''): TResponse;
  class function Delete(const URL: string): TResponse;
  class function PostJSON(const URL: string; const JSON: string): TResponse;
  
  // Error handling variants
  class function TryGet(const URL: string): TRequestResult;
  class function TryPost(const URL: string; const Data: string = ''): TRequestResult;
end;
```

The global `Http` constant of type `THttp` provides convenient one-liner methods for simple requests. For more complex requests, declare a `THttpRequest` variable and use the fluent interface.

## Advanced Usage Examples

### Complex Request with Multiple Headers and Parameters
```pascal
var
  Request: THttpRequest;
  Response: TResponse;
  UserData: IJSONObject;
  CreatedUser: IJSONObject;
begin
  // Create request data
  UserData := TJSON.Obj;
  UserData.Add('name', 'John');
  UserData.Add('email', 'john@example.com');

  Response := Request
    .Post
    .URL('https://api.example.com/users')
    .AddHeader('X-API-Key', 'your-key')
    .AddHeader('Accept', 'application/json')
    .AddParam('version', '2.0')
    .AddParam('format', 'detailed')
    .WithJSON(UserData.ToString)
    .WithTimeout(5000)
    .Send;

  if Response.StatusCode = 201 then
  begin
    CreatedUser := Response.JSON.AsObject;
    WriteLn('User created with ID: ', CreatedUser['id'].AsString);
    WriteLn('Created at: ', CreatedUser['created_at'].AsString);
  end;
end;
```

### Authenticated Request with Error Handling
```pascal
var
  Result: TRequestResult;
  Response: TResponse;
  SecureData: IJSONObject;
begin
  // Using the Try-pattern for better error handling
  Result := Http.TryGet('https://api.example.com/secure');
  
  if Result.Success then
  begin
    // Access the successful response
    Response := Result.Response;
    if Response.StatusCode = 200 then
    begin
      SecureData := Response.JSON.AsObject;
      WriteLn('Access granted to: ', SecureData['resource'].AsString);
    end;
  end
  else
    WriteLn('Failed to access secure resource: ', Result.Error);
end;
```

### Form Data Submission
```pascal
var
  Request: THttpRequest;
  Response: TResponse;
begin
  Response := Request
    .Post
    .URL('https://api.example.com/submit')
    .AddHeader('Content-Type', 'application/x-www-form-urlencoded')
    .WithData('name=John&age=30&email=john@example.com')
    .Send;

  if Response.StatusCode = 200 then
    WriteLn('Form submitted successfully');
end;
```

## Testing and Development

The TidyKit.Request module includes special features for testing environments:

- Automatic detection of test runs based on command-line parameters
- Fallback to HTTP when testing with httpbin.org URLs if SSL is not available
- Detailed error messages for SSL initialization failures

This ensures your tests can run successfully even on systems without OpenSSL installed, while still providing appropriate security warnings for production code.

## Best Practices

1. Let the automatic memory management work for you - don't try to manually manage memory
2. Always check StatusCode before accessing response data
3. Use TryGet/TryPost for better error handling, especially for HTTPS requests
4. Set appropriate timeouts for your use case
5. Take advantage of the fluent interface for complex requests
6. Let the code read like natural language descriptions
7. For production applications requiring HTTPS, make sure to install the appropriate OpenSSL libraries
8. In testing environments, be aware of the automatic HTTP fallback for HTTPS URLs 