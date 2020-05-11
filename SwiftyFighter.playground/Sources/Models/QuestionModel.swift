import Foundation

public struct QuestionModel{
    public let questionID: Int!
    public let message: String!
    public let answerList: [AnswerModel]!
    
    init(questionID: Int, message: String, answerList: [AnswerModel]) {
        self.questionID = questionID
        self.message = message
        self.answerList = answerList
    }
}

public class QuestionBank{
    private static let question: [QuestionModel] = [
        QuestionModel(questionID: 1, message: "Which keyword can use to announce constants (cannot change value) in Swift? ", answerList: [
            
            AnswerModel("var", false),
            AnswerModel("let", true),
            AnswerModel("static", false),
            AnswerModel("constant", false)
        
        ]),
        QuestionModel(questionID: 2, message: "Which keyword can to announce variables (can be changes value) in Swift?", answerList: [
            
            AnswerModel("static", false),
            AnswerModel("var", true),
            AnswerModel("let", false),
            AnswerModel("new", false)
            
        ]),
        QuestionModel(questionID: 3, message: "Which data types can use to announce value True or False in Swift?", answerList: [
            
            AnswerModel("let", false),
            AnswerModel("var", false),
            AnswerModel("Check", false),
            AnswerModel("Boolean", true),
            
        ]),
        QuestionModel(questionID: 4, message: "What is the data type of a value 3.14159 in Swift?", answerList: [
            
            AnswerModel("Boolean", false),
            AnswerModel("String", false),
            AnswerModel("Double or Float", true),
            AnswerModel("Integer", false),
            
        ]),
        QuestionModel(questionID: 5, message: "What is the data type of a value \"3.14159\" in Swift?", answerList: [
            
            AnswerModel("Boolean", false),
            AnswerModel("String", true),
            AnswerModel("Double or Float", false),
            AnswerModel("Integer", false),
            
        ]),
        QuestionModel(questionID: 6, message: "Which keyword do you use to handle the absence of a value?", answerList: [
            
            AnswerModel("nil", false),
            AnswerModel("Optional", true),
            AnswerModel("null", false),
            AnswerModel("Checker", false),
            
        ]),
        QuestionModel(questionID: 7, message: "Which collection type stores values of the same type in an ordered list?", answerList: [
            
            AnswerModel("Array", true),
            AnswerModel("let", false),
            AnswerModel("Set", false),
            AnswerModel("Dictionaries", false),
            
        ]),
        QuestionModel(questionID: 8, message: "Which collection type stores associations between keys of the same type and values of the same type in a collection with no defined ordering?", answerList: [
            
            AnswerModel("Array", false),
            AnswerModel("let", false),
            AnswerModel("Set", false),
            AnswerModel("Dictionaries", true),
            
        ]),
        QuestionModel(questionID: 9, message: "which control flow can use to iterate over a sequence, such as items in an array, ranges of numbers, or characters in a string?", answerList: [
            
            AnswerModel("For-Loop", true),
            AnswerModel("While-Loop", false),
            AnswerModel("Repeat-While", false),
            AnswerModel("Array", false),
            
        ]),
        QuestionModel(questionID: 10, message: "What kinds of loop start by evaluating a condition. If the condition is true, a set of statements is repeated until the condition becomes false?", answerList: [
            
            AnswerModel("For-Loop", false),
            AnswerModel("While-Loop", true),
            AnswerModel("If-else", false),
            AnswerModel("Map Function", false),
            
        ]),
         QuestionModel(questionID: 11, message: "which choice can use to iterate sequence statement or task everytime when call it?", answerList: [
            
            AnswerModel("For-Loop", false),
            AnswerModel("While-Loop", false),
            AnswerModel("Function", true),
            AnswerModel("Class", false),
         ]),
         QuestionModel(questionID: 12, message: "which choice can use to calling function to do task in class?", answerList: [
            AnswerModel("functionName()", true),
            AnswerModel(".functionName", false),
            AnswerModel(".functionName()", false),
            AnswerModel("functionName", false),
         ]),
         QuestionModel(questionID: 13, message: "which choice can use to creat new Object of NewClass", answerList: [
            AnswerModel("let object: NewClass = NewClass()", true),
            AnswerModel("var object: NewClass = NewClass", false),
            AnswerModel("let object: NewClass = NewClass", false),
            AnswerModel("object = NewClass", false),
         ]),
         QuestionModel(questionID: 14, message: "Which statement considers a value and compares it against several possible matching patterns?", answerList: [
            AnswerModel("If- else", false),
            AnswerModel("Switch", true),
            AnswerModel("For-Loop", false),
            AnswerModel("nil", false),
         ]),
         
        
        
        
        
        
        
    
    
    ]
    
    public static func getQuestion() -> [QuestionModel]{
        var returnQuestion: [QuestionModel] = []
        
        while returnQuestion.count != 10 {
            let questionIndex = question.randomElement()!
            var isReturn: Bool = false
            for i in returnQuestion{
                if i.questionID == questionIndex.questionID {
                    isReturn = true
                    break
                }
            }
            if isReturn == false{
                returnQuestion.append(questionIndex)
            }
        }
        return returnQuestion
    }
}
 
