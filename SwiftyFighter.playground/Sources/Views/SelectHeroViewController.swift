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
            selectHeroTextImagaView.heightAnchor .constraint(equalToConstant: 50),
            selectHeroTextImagaView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 150),
            selectHeroTextImagaView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -150)
            
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
            heroImageView.heightAnchor.constraint(equalToConstant: 200),
            heroImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            heroImageView.widthAnchor.constraint(equalToConstant: 200)
            
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
        
        todoButton.addTarget(self, action: #selector(setStateHeroCounter), for: .touchUpInside)
        leeButton.addTarget(self, action: #selector(setStateHeroCounter), for: .touchUpInside)
        
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
        NSLayoutConstraint.activate([
            
            heroButtonStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            heroButtonStackView.widthAnchor.constraint(equalToConstant: 250),
            heroButtonStackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 130),
            heroButtonStackView.heightAnchor.constraint(equalToConstant: 150),
            
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
        startButton.addTarget(self, action: #selector(toStartGame), for: .touchUpInside)
        
        actionButtonStackView.addArrangedSubview(backButton)
        actionButtonStackView.addArrangedSubview(startButton)
        
        self.view.addSubview(actionButtonStackView)
        
        actionButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            actionButtonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            actionButtonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            actionButtonStackView.heightAnchor.constraint(equalToConstant: 50),
            actionButtonStackView.widthAnchor.constraint(equalToConstant: 280)
            
        ])
        
    }
    
    
    @objc private func setStateHero(sender: UIButton){
        
        stateHero = sender.tag
        
        if stateHero == 0{
            
            clickButtonChangeState(button: todoButton)
            heroNameImageView.image = Heroes.todoNameImage
            
        } else{
            
            clickButtonChangeState(button: leeButton)
            heroNameImageView.image = Heroes.leeNameImage
            
        }
        
        heroImageView.stopAnimating()
        heroImageView.animationImages = stateHero == 0 ? Heroes.todoIdle : Heroes.leeIdle
        heroImageView.animationDuration = 2.5
        heroImageView.startAnimating()
        
    }
    
    private func clickButtonChangeState(button: UIButton){
        
        todoButton.isEnabled = true
        leeButton.isEnabled = true
        todoButton.layer.borderWidth = 0
        leeButton.layer.borderWidth = 0
        
        button.isEnabled = false
        button.layer.borderWidth = 5
        
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
    
    @objc private func toStartGame(){
        
        SoundManager.stopSound()
        
        let vc = GameSceneViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.gameModel = PlayGameModel()
        vc.gameModel.playerHero = stateHero == 0 ? .TODO : .LEE
        self.present(vc, animated: false, completion: nil)
        
        
    }
    
    @objc private func backToHomePage(){
        
        self.dismiss(animated: false, completion: nil)
        
    }
    
    @objc private func setStateHeroCounter(sender: UIButton){
        
        stateHero = sender.tag
        
    }
    
}
