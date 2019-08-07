//
//  Logger.swift
//  20190807-YaseenAlDallash-NYCSchools
//
//  Created by Yaseen Al Dallash on 8/7/19.
//  Copyright © 2019 Yaseen AlDallash. All rights reserved.
//

import Foundation
import os

enum LoggEventType: String {
    case error = "[‼️]"
    case information = "[ℹ️]"
    case debug = "[💬]"
    case verbose = "[🔬]"
    case warning = "[⚠️]"
    case severe = "[🔥]"
}

/// Hanldes logging information for the App during debugging sessions only
class Logger {
    // 1. The date formatter
    static var dateFormat = "yyyy-MM-dd hh:mm:ssSSS"
    
    static var loggingAvailable: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    static func getDate(_ date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
    private class func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last ?? "Can't load the source file name"
    }
    
    
    class func log( _ object: Any,
                    eventType: LoggEventType,
                    filename: String = #file,
                    line: Int = #line,
                    column: Int = #column,
                    funcName: String = #function) {
        guard loggingAvailable else { return }
        print("\(getDate(Date())) \(eventType.rawValue)[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)")
    }
    
    class func logServiceInfo(serviceName: String, url: URL, params: [String: Any] = [:]) {
        guard loggingAvailable else { return }
        Logger.log(serviceName, eventType: .information)
        Logger.log(url, eventType: .information)
        Logger.log(params, eventType: .information)
    }
}
