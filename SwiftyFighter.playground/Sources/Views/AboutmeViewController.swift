import Foundation
import UIKit

public class AboutmeViewController: UIViewController{
    let button: UIButton = UIButton()
    let profile: UIImageView = UIImageView()
    override public func viewDidLoad(){
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        backButtonSetup()
        setDetail()
    }
    
    private func setDetail(){
        
        profile.image = UIImage(named: "Aboutme/profile.png")!
        profile.layer.cornerRadius = 5
        profile.translatesAutoresizingMaskIntoConstraints = false
        profile.contentMode = .scaleAspectFit
        profile.layer.masksToBounds = true
        
        self.view.addSubview(profile)
        NSLayoutConstraint.activate([
            profile.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            profile.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -10),
            profile.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            profile.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
    
    private func backButtonSetup(){
        
        button.setTitle("Back to Main", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel!.font = UIFont.boldSystemFont(ofSize: 35)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
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
