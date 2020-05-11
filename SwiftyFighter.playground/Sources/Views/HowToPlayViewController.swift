import Foundation
import UIKit

public class HowToPlayViewController: UIViewController{
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.07450980392, green: 0.1019607843, blue: 0.1764705882, alpha: 1)
        setupUI()
    }
    
    private func setupUI(){
        howToSetup()
        backButtonSetup()
    }
    
    private func howToSetup(){
        let howToImageView: UIImageView = UIImageView()
        howToImageView.image = UIImage(named: "HowToPlay/howToPlay.png")!

        howToImageView.translatesAutoresizingMaskIntoConstraints = false
        howToImageView.contentMode = .scaleAspectFit
        
        self.view.addSubview(howToImageView)
        NSLayoutConstraint.activate([
            howToImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            howToImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            howToImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            howToImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
    }
    
    private func backButtonSetup(){
        let button: UIButton = UIButton()
        button.setTitle("Back to Main", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel!.font = UIFont.boldSystemFont(ofSize: 35)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(backToMainView), for: .touchUpInside)
        self.view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            button.heightAnchor.constraint(equalToConstant: 60),
            button.widthAnchor.constraint(equalToConstant: 250)
        ])
        
    }
    
    @objc private func backToMainView(){
        self.dismiss(animated: false, completion: nil)
    }
}
