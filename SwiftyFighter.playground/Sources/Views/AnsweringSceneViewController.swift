import Foundation
import UIKit
public class AnsweringSceneViewController: UIViewController{
    
    private let loading: UIView = UIView()
    private var loadingTrailingCon: NSLayoutConstraint!
    private var result: Bool = false
    public var delegate: sendResultBack!
    private var isResultOpen: Bool = false
    public var question: String!
    public var answerList: [AnswerModel]!
    override public func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.07450980392, green: 0.1019607843, blue: 0.1764705882, alpha: 1)
        
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        setupUI()
    }
    
    private func setupUI(){
        loadingSetup()
        questionAnswerViewSetup()
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
    
    private func timeCounter(){
        
        UIView.animate(withDuration: 10, delay: 1, options: .beginFromCurrentState, animations: {
            SoundManager.timerSound()
            self.loadingTrailingCon.constant = CGFloat(0)
            self.view.layoutIfNeeded()
        }, completion: { _ in
            if self.isResultOpen == false{
                self.showResult()
            }
        })
    }
    
    private func questionAnswerViewSetup(){
        let answerStack: UIStackView = UIStackView()
        let compositeStack: UIStackView = UIStackView()
        let questionTitle: UILabel = UILabel()
        var color: [UIColor] = [
        UIColor(red: 0.01, green: 0.33, blue: 0.64, alpha: 1.00),
        UIColor(red: 1.00, green: 0.35, blue: 0.37, alpha: 1.00),
        UIColor(red: 0.99, green: 0.67, blue: 0.06, alpha: 1.00),
        UIColor(red: 0.57, green: 0.59, blue: 0.68, alpha: 1.00)
        ]
        
        answerList.forEach{ answer in
            let button: UIButton = UIButton()
            button.setTitle(answer.message, for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            button.setTitleColor(.black, for: .normal)
            button.tag = answer.isCorrect == true ? 1 : 0
            button.addTarget(self, action: #selector(answerActionButton), for: .touchUpInside)
            button.backgroundColor = color[0]
            button.titleLabel?.numberOfLines = 0
            color.remove(at: 0)
            answerStack.addArrangedSubview(button)
        }
        
        questionTitle.text = question
        questionTitle.textColor = .white
        questionTitle.numberOfLines = 0
        questionTitle.textAlignment = .center
        questionTitle.sizeToFit()
        questionTitle.font = UIFont.boldSystemFont(ofSize: 18)
        questionTitle.sizeToFit()

        compositeStack.addArrangedSubview(questionTitle)
        compositeStack.addArrangedSubview(answerStack)
        

        compositeStack.axis = .vertical
        compositeStack.distribution = .fillProportionally
        compositeStack.spacing = 0
        compositeStack.alignment = .fill
        
        answerStack.axis = .horizontal
        answerStack.distribution = .fillEqually
        answerStack.spacing = 0
        
        compositeStack.addArrangedSubview(questionTitle)
        compositeStack.addArrangedSubview(answerStack)
        
        self.view.addSubview(compositeStack)
        compositeStack.translatesAutoresizingMaskIntoConstraints = false
        questionTitle.translatesAutoresizingMaskIntoConstraints = false
        answerStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            compositeStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            compositeStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            compositeStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            compositeStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            
            questionTitle.leadingAnchor.constraint(equalTo: compositeStack.leadingAnchor, constant: 10),
            questionTitle.trailingAnchor.constraint(equalTo: compositeStack.trailingAnchor, constant: -10),
            
            answerStack.leadingAnchor.constraint(equalTo: compositeStack.leadingAnchor, constant: 0),
            answerStack.trailingAnchor.constraint(equalTo: compositeStack.trailingAnchor, constant: 0)
            ])
        self.view.layoutIfNeeded()
    }
    
    @objc private func answerActionButton(sender: UIButton){
        result = sender.tag == 0 ? false : true
        showResult()
    }
    
    private func showResult(){
        let uiview: UIView = UIView()
        let labelText: UILabel = UILabel()
        let uiStack: UIStackView = UIStackView()
        
        uiStack.axis = .vertical
        uiStack.alignment = .center
        uiStack.distribution = .fillEqually
        uiStack.spacing = 5
        
        
        
        isResultOpen = true
        
        labelText.text = result == false ? "Incorrect" : "Correct"
        labelText.font = UIFont.boldSystemFont(ofSize: 100)
        labelText.textAlignment = .center
        
        
        uiview.alpha = 0
        uiview.backgroundColor = result == false ? UIColor(red: 0.92, green: 0.59, blue: 0.58, alpha: 1.00) : UIColor(red: 0.76, green: 0.88, blue: 0.77, alpha: 1.00)
        uiStack.addArrangedSubview(labelText)
        if !result{
            let correctLabel: UILabel = UILabel()
            correctLabel.font = UIFont.boldSystemFont(ofSize: 50)
            correctLabel.textAlignment = .center
            correctLabel.numberOfLines = 0
            for i in answerList{
                if i.isCorrect == true{
                    correctLabel.text = "Answer: \(i.message!)"
                    
                    uiStack.addArrangedSubview(correctLabel)
                    break
                }
            }
        }
        
        uiview.addSubview(uiStack)
        self.view.addSubview(uiview)
        SoundManager.stopSound()
        
        uiview.translatesAutoresizingMaskIntoConstraints = false
        uiStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            uiview.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            uiview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            uiview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            uiview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            uiStack.topAnchor.constraint(equalTo: uiview.topAnchor, constant: 0),
            uiStack.bottomAnchor.constraint(equalTo: uiview.bottomAnchor, constant: 0),
            uiStack.leadingAnchor.constraint(equalTo: uiview.leadingAnchor, constant: 0),
            uiStack.trailingAnchor.constraint(equalTo: uiview.trailingAnchor, constant: 0),
        ])
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 1, delay: 0.001, options: .beginFromCurrentState, animations: {
            uiview.alpha = 10
            self.view.layoutIfNeeded()
        }, completion: { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.delegate.returnResult(answerCorrect: self.result)
                self.dismiss(animated: false, completion: nil)
            })
            
        })
        
    }

}
