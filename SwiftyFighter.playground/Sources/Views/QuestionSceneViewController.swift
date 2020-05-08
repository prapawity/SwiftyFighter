import Foundation
import UIKit

public class QuestionSceneViewController: UIViewController{
    private let loading: UIView = UIView()
    private var loadingTrailingCon: NSLayoutConstraint!
    private let questionView: UIView = UIView()
    
    override public func viewDidLoad(){
        super.viewDidLoad()
        viewSetup()
    }
    override public func viewDidAppear(_ animated: Bool) {
        
    }
    
    private func viewSetup(){
        view.backgroundColor = #colorLiteral(red: 0.07450980392, green: 0.1019607843, blue: 0.1764705882, alpha: 1)
        loadingSetup()
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
        
        self.view.addSubview(questionView)
        
        questionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            questionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            questionView.leadingAnchor.constraint(equalTo: )
        ])
    }
    
    private func timeCounter(){
        UIView.animate(withDuration: 5, delay: 1, options: .beginFromCurrentState, animations: {
            
            self.loadingTrailingCon.constant = CGFloat(0)
            self.view.layoutIfNeeded()
        }, completion: { _ in
        })
    }
}
