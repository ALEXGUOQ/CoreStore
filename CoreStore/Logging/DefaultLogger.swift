//
//  DefaultLogger.swift
//  CoreStore
//
//  Copyright (c) 2015 John Rommel Estropia
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import Foundation


// MARK: - DefaultLogger

/**
The `DefaultLogger` is a basic implementation of the `CoreStoreLogger` protocol.

- The `log(...)` method calls `println(...)` to print the level, source file name, line number, function name, and the log message.
- The `handleError(...)` method calls `println(...)` to print the source file name, line number, function name, and the error message.
- The `assert(...)` method calls `assert(...)` on the arguments.
*/
public final class DefaultLogger: CoreStoreLogger {
   
    public func log(#level: LogLevel, message: String, fileName: StaticString, lineNumber: Int, functionName: StaticString) {
        
        #if DEBUG
            let levelString: String
            switch level {
            case .Trace: levelString = "Trace"
            case .Notice: levelString = "Notice"
            case .Warning: levelString = "Warning"
            case .Fatal: levelString = "Fatal"
            }
            Swift.println("[CoreStore:\(levelString)] \(fileName.stringValue.lastPathComponent):\(lineNumber) \(functionName)\n  ↪︎ \(message)\n")
        #endif
    }
    
    public func handleError(#error: NSError, message: String, fileName: StaticString, lineNumber: Int, functionName: StaticString) {
        
        #if DEBUG
            Swift.println("[CoreStore:Error] \(fileName.stringValue.lastPathComponent):\(lineNumber) \(functionName)\n  ↪︎ \(message): \(error)\n")
        #endif
    }
    
    public func assert(@autoclosure condition: () -> Bool, message: String, fileName: StaticString, lineNumber: Int, functionName: StaticString) {
        
        #if DEBUG
            Swift.assert(condition, message, file: fileName, line: numericCast(lineNumber))
        #endif
    }
}
