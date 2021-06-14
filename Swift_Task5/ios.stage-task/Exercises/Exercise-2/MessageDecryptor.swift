import UIKit

class MessageDecryptor: NSObject {

    func decryptMessage(_ message: String) -> String {
        let encodedMessage = message.starts(with: "[") ? "\("1")\(message)" : message
        var stack = [(String, Int)]()
        var result = ""
        var count = 0
        for char in encodedMessage {
            switch char {
            case _ where char.isNumber:
                count = Int(String(char))! + count * 10
            case "[":
                stack.append((result, count))
                result = ""
                count = 0
            case "]":
                let (prevStr, count) = stack.removeLast()
                result = prevStr + String(repeating: result, count: count)
            default:
                result += String(char)
            }
        }
        return result
    }
}
