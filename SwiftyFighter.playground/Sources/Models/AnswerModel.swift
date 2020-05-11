import Foundation

public struct AnswerModel{
    var message: String!
    var isCorrect: Bool!
    
    init(_ message: String, _ isCorrect: Bool) {
        self.message = message
        self.isCorrect = isCorrect
    }
}
