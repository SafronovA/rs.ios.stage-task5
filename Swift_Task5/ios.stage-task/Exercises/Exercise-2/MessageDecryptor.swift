import UIKit

//class MessageDecryptor: NSObject {
//    func decryptMessage(_ message: String) -> String {
//        let encodedMessage = message.starts(with: "[") ? "\("1")\(message)" : message
//        var stack = [(String, Int)]()
//        var result = ""
//        var count = 0
//        for char in encodedMessage {
//            switch char {
//            case _ where char.isNumber:
//                count = Int(String(char))! + count * 10
//            case "[":
//                stack.append((result, count))
//                result = ""
//                count = 0
//            case "]":
//                let (prevStr, count) = stack.removeLast()
//                result = prevStr + String(repeating: result, count: count)
//            default:
//                result += String(char)
//            }
//        }
//        return result
//    }
//}

// MARK: Regex in Swift exapmple!!! (thanks zm1ca)
extension String {
    subscript(_ range: NSRange) -> String {
        let start = self.index(self.startIndex, offsetBy: range.lowerBound)
        let end = self.index(self.startIndex, offsetBy: range.upperBound)
        let subString = self[start..<end]
        return String(subString)
    }
}

class MessageDecryptor: NSObject {
    
    func decryptMessage(_ message: String) -> String {
        var msg = message
        let regex: NSRegularExpression = try! NSRegularExpression(pattern: "(\\d{0,3})\\[(\\w+)\\]")
        
        while let match: NSTextCheckingResult = regex.firstMatch(in: msg, options: [], range: NSRange(location: 0, length: msg.utf16.count)) {
            let numberOfRepetitions = Int(msg[match.range(at: 1)]) ?? 1
            let stringToRepeat      = msg[match.range(at: 2)]
            
            msg.replaceSubrange(Range(match.range, in: msg)!, with: String(repeating: stringToRepeat, count: numberOfRepetitions))
        }
        return msg
    }
}
