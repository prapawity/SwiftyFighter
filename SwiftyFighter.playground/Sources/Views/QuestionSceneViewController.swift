import Foundation
import UIKit

public protocol sendResultBack {
    func returnResult(answerCorrect: Bool)
}

public class QuestionSceneViewController: UIViewController, sendResultBack{
    
    public var questionNumber: Int!
    private let loading: UIView = UIView()
    private var loadingTrailingCon: NSLayoutConstraint!
    private let questionView: UIView = UIView()
    public var question: QuestionModel!
    private var isOpened: Bool = false
    public var delegate: getAnswer!
    
    override public func viewDidLoad(){

        super.viewDidLoad()

    }
    
    override public func viewDidAppear(_ animated: Bool) {
        if !isOpened{
            viewSetup()
        } else{
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    

    
    private func viewSetup(){
        isOpened = true
        view.backgroundColor = #colorLiteral(red: 0.07450980392, green: 0.1019607843, blue: 0.1764705882, alpha: 1)
        loadingSetup()
        questionViewSetup()
        timeCounter()
    }
    
    private func loadingSetup(){
        self.view.addSubview(loading)
        loading.backgroundColor = .white
        loading.translatesAutoresizingMaskIntoConstraints = false
        loadingTrailingCon = loading.trailingAnchor.constraint(equalTo: loading.leadingAnchor, constant: 736)
        loadingTrailingCon.isActive = true
        
        NSLayoutConstraint.activate([
            loading.topAnchor.constraint(equalTo: loading.bottomAnchor, constant: -15),
            loading.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            loading.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
        ])
        self.view.layoutIfNeeded()
        
    }
    
    private func questionViewSetup(){
        let questionNumberLabel: UILabel = UILabel()
        let message: UILabel = UILabel()
        
        questionNumberLabel.text = "Question: \(questionNumber!)"
        questionNumberLabel.font = UIFont.boldSystemFont(ofSize: 40)
        questionNumberLabel.textColor = .white
        
        message.text = question.message
        message.textColor = .white
        message.numberOfLines = 0
        message.textAlignment = .center
        message.sizeToFit()
        message.font = UIFont.boldSystemFont(ofSize: 22)
        
        questionView.addSubview(questionNumberLabel)
        questionView.addSubview(message)
        
        self.view.addSubview(questionView)
        
        questionView.translatesAutoresizingMaskIntoConstraints = false
        questionNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        message.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            questionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            questionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            questionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            
            questionNumberLabel.centerXAnchor.constraint(equalTo: questionView.centerXAnchor),
            questionNumberLabel.topAnchor.constraint(equalTo: questionView.topAnchor, constant: 10),
            
            message.topAnchor.constraint(equalTo: questionNumberLabel.bottomAnchor, constant: 0),
            message.leadingAnchor.constraint(equalTo: questionView.leadingAnchor, constant: 20),
            message.trailingAnchor.constraint(equalTo: questionView.trailingAnchor, constant: -20),
            message.bottomAnchor.constraint(equalTo: questionView.bottomAnchor, constant:-5)
        ])
        self.view.layoutIfNeeded()
    }
    
    private func timeCounter(){
        UIView.animate(withDuration: 5, delay: 1, options: .beginFromCurrentState, animations: {
            
            self.loadingTrailingCon.constant = CGFloat(0)
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.toAnswerView()
        })
    }
    
    private func toAnswerView(){
        let vc = AnsweringSceneViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.answerList = question.answerList
        vc.question = question.message
        vc.delegate = self
        self.present(vc, animated: false, completion: nil)
    }
    
    public func returnResult(answerCorrect: Bool) {
        delegate.getReturnAnswer(result: answerCorrect)
    }
}

