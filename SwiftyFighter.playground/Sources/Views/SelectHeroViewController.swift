import Foundation
import UIKit
public class SelectHeroViewController: UIViewController{
    
    private let heroImageView: UIImageView = UIImageView()
    private var stateHero: Int = 0
    private let todoButton: UIButton = UIButton()
    private let leeButton: UIButton = UIButton()
    private let heroNameImageView: UIImageView = UIImageView(image: Heroes.todoNameImage)
    private let heroButtonStackView: UIStackView = UIStackView()
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        bgImageViewSetup()
        selectHeroTextSetup()
        heroImageViewSetup()
        heroDraftSetup()
        setPlayBackButtonSetup()
        setNameHeroSetup()
    }
    
    private func bgImageViewSetup(){
        let bgImageView: UIImageView = UIImageView(image: Backgrounds.firstPageBG)
        self.view.addSubview(bgImageView)
        self.view.sendSubviewToBack(bgImageView)
        bgImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        bgImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
        bgImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
        bgImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
        bgImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: 0),
        ])
    }
    
    private func selectHeroTextSetup(){
        let selectHeroTextImagaView: UIImageView = UIImageView(image: TitleAndButton.selectHeroButton)
        self.view.addSubview(selectHeroTextImagaView)
        selectHeroTextImagaView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            selectHeroTextImagaView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            selectHeroTextImagaView.bottomAnchor.constraint(equalTo:selectHeroTextImagaView.topAnchor, constant: 50),
            selectHeroTextImagaView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 150),
            selectHeroTextImagaView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -150),
        ])
    }
    
    private func heroImageViewSetup(){
        
        heroImageView.contentMode = .scaleAspectFit
        heroImageView.animationImages = stateHero == 0 ? Heroes.todoIdle : Heroes.leeIdle
        heroImageView.animationDuration = 2.5
        heroImageView.startAnimating()
        
        self.view.addSubview(heroImageView)
        heroImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heroImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
            heroImageView.topAnchor.constraint(equalTo: heroImageView.bottomAnchor, constant: -200),
            heroImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            heroImageView.trailingAnchor.constraint(equalTo: heroImageView.leadingAnchor, constant: 200)
        ])
    }
    
    private func heroDraftSetup(){
        
        todoButton.addTarget(self, action: #selector(setStateHero), for: .touchUpInside)
        leeButton.addTarget(self, action: #selector(setStateHero), for: .touchUpInside)
        
        heroButtonStackView.axis = .horizontal
        heroButtonStackView.alignment = .center
        heroButtonStackView.distribution = .fillEqually
        heroButtonStackView.spacing = 10
        
        todoButton.setImage(Heroes.todoFace, for: .normal)
        leeButton.setImage(Heroes.leeFace, for: .normal)
        
        todoButton.tag = 0
        leeButton.tag = 1
        
        
        todoButton.layer.cornerRadius = 5
        todoButton.layer.borderWidth = 5
        todoButton.layer.borderColor = UIColor.white.cgColor
        
        leeButton.layer.cornerRadius = 5
        leeButton.layer.borderColor = UIColor.white.cgColor
        
        todoButton.isEnabled = false
        
        
        heroButtonStackView.addArrangedSubview(todoButton)
        heroButtonStackView.addArrangedSubview(leeButton)
        self.view.addSubview(heroButtonStackView)
        heroButtonStackView.translatesAutoresizingMaskIntoConstraints = false
//        heroButtonStackView.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            heroButtonStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            heroButtonStackView.leadingAnchor.constraint(equalTo: heroButtonStackView.trailingAnchor, constant: -250),
            heroButtonStackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 130),
            heroButtonStackView.bottomAnchor.constraint(equalTo: heroButtonStackView.topAnchor, constant: 150),
        ])
    }
    
    private func setPlayBackButtonSetup(){
        let startButton: UIButton = UIButton()
        let backButton: UIButton = UIButton()
        let actionButtonStackView: UIStackView = UIStackView()
        
        actionButtonStackView.axis = .horizontal
        actionButtonStackView.alignment = .center
        actionButtonStackView.distribution = .fillEqually
        actionButtonStackView.spacing = 30
        
        
        startButton.setImage(TitleAndButton.startButton, for: .normal)
        backButton.setImage(TitleAndButton.backButton, for: .normal)
        
        backButton.addTarget(self, action: #selector(backToHomePage), for: .touchUpInside)
        
        actionButtonStackView.addArrangedSubview(backButton)
        actionButtonStackView.addArrangedSubview(startButton)
        self.view.addSubview(actionButtonStackView)
        actionButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            actionButtonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            actionButtonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            actionButtonStackView.topAnchor.constraint(equalTo: actionButtonStackView.bottomAnchor, constant: -50),
            actionButtonStackView.leadingAnchor.constraint(equalTo: actionButtonStackView.trailingAnchor, constant: -280)
        ])
    }
    
    
    @objc private func setStateHero(sender: UIButton){
        stateHero = sender.tag
        print(stateHero)
        if stateHero == 0{
            todoButton.layer.borderWidth = 5
            leeButton.layer.borderWidth = 0
            todoButton.isEnabled = false
            leeButton.isEnabled = true
            heroNameImageView.image = Heroes.todoNameImage
        } else{
            todoButton.layer.borderWidth = 0
            leeButton.layer.borderWidth = 5
            todoButton.isEnabled = true
            leeButton.isEnabled = false
            heroNameImageView.image = Heroes.leeNameImage
        }
        heroImageView.stopAnimating()
        heroImageView.animationImages = stateHero == 0 ? Heroes.todoIdle : Heroes.leeIdle
        heroImageView.animationDuration = 2.5
        heroImageView.startAnimating()
    }
    
    private func setNameHeroSetup(){
        self.view.addSubview(heroNameImageView)
        
        heroNameImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heroNameImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            heroNameImageView.bottomAnchor.constraint(equalTo: heroNameImageView.topAnchor, constant: 100),
            heroNameImageView.leadingAnchor.constraint(equalTo: heroImageView.trailingAnchor, constant: 50),
            heroNameImageView.trailingAnchor.constraint(equalTo: heroButtonStackView.leadingAnchor, constant: -50)
        ])
        
    }
    
    @objc private func backToHomePage(){
        self.dismiss(animated: false, completion: nil)
    }
    
}
