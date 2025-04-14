//
//  DLog.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 3/13/25.
//

enum DLog {
    enum LogType: String {
        case info = "ℹ️"
        case response = "✅"
        case error = "🚨"
        case warning = "⚠️"
    }
    
    static func log(
        _ type: LogType,
        subject: String,
        content: Any...,
        file: String = #fileID,
        function: String = #function,
        line: UInt = #line
    ) {
        #if DEBUG
        let formattedContent = content.map({"\($0)"}).joined(separator: "\n")
        print(
        """
        [\(file)] \(function): \(line)
        ---------------------------------------------------
        [\(type.rawValue) \(subject)]
        \(formattedContent)
        ---------------------------------------------------
        """
        )
        #endif
    }
}
