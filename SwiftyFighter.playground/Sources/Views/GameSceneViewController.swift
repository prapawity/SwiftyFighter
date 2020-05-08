import Foundation
import UIKit

public class GameSceneViewController: UIViewController{
    private let bgImageView: UIImageView = UIImageView(image: Backgrounds.firstPageBG)
    private let bgView: UIView = UIView()
    private var playerLifeView: UIView!
    private var botLifeView: UIView!
    private let playerHeroImageView: UIImageView = UIImageView()
    private let botHeroImageView: UIImageView = UIImageView()
    private var gameModel: PlayGameModel!
    private var lifeBarConstrain: [NSLayoutConstraint] = []
    private let playButton: UIButton = UIButton()
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.07450980392, green: 0.1019607843, blue: 0.1764705882, alpha: 1)
        fakeLoading()
    }
    
    
    override public func viewDidAppear(_ animated: Bool) {
        lifeBarCheck()
    }
    
    public func setGameModel(){
        gameModel = PlayGameModel()
        gameModel.playerHero = .TODO
    }
    
    private func fakeLoading(){
        let loading: UIView = UIView()
        loading.backgroundColor = .white
        
        view.addSubview(loading)
        loading.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loading.bottomAnchor.constraint(equalTo: loading.topAnchor, constant: 15),
            loading.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            loading.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            loading.trailingAnchor.constraint(equalTo: loading.leadingAnchor, constant: 0)
            
        ])
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 3, delay: 0.5, options: .curveEaseOut, animations: {
            NSLayoutConstraint.activate([
                loading.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)
            ])
            self.view.layoutIfNeeded()
            
        }, completion: { finished in
            loading.removeFromSuperview()
            self.setupUI()
        })

        
    }
    
    
    
    private func setupUI(){
        bgViewSetup()
        bgSetup()
        statusBarSetup()
        playerHeroSetup()
        botHeroSetup()
        
        playButtonActionSetup()
    }
    
    private func bgViewSetup(){
        view.addSubview(bgView)
        bgView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            bgView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            bgView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            bgView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
    }
    private func bgSetup(){
        bgView.addSubview(bgImageView)
        
        bgImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bgImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            bgImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            bgImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            bgImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
    }
    
    private func statusBarSetup(){
        let statusStackView: UIStackView = UIStackView()
        let vsLabel: UILabel = UILabel()
        let playerStack: UIStackView = UIStackView()
        let botStack: UIStackView = UIStackView()
        
        statusStackView.axis = .horizontal
        statusStackView.alignment = .center
        statusStackView.distribution = .fill
        statusStackView.spacing = 5
        
        vsLabel.text = "VS"
        vsLabel.font = UIFont.boldSystemFont(ofSize: 48.0)
        vsLabel.textColor = .white
        vsLabel.translatesAutoresizingMaskIntoConstraints = false
        bgView.addSubview(statusStackView)
        statusStackView.addArrangedSubview(playerBarSetup(stackView: playerStack))
        statusStackView.addArrangedSubview(vsLabel)
        statusStackView.addArrangedSubview(botBarSetup(stackView: botStack))
        statusStackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            statusStackView.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 20),
            statusStackView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 20),
            statusStackView.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -20),
            playerStack.bottomAnchor.constraint(equalTo: statusStackView.bottomAnchor, constant: 0),
            vsLabel.centerXAnchor.constraint(equalTo: statusStackView.centerXAnchor)
        ])
        
        
    }
    
    private func playerBarSetup(stackView: UIStackView)  -> UIStackView {
        
        let nameLabel: UILabel = UILabel()
        let uiview: UIView = UIView()
        playerLifeView = UIView()
        
        nameLabel.text = "YOU"
        nameLabel.font = nameLabel.font.withSize(30)
        nameLabel.textColor = .white
        
        uiview.addSubview(playerLifeView)
        uiview.backgroundColor = .red
        
        playerLifeView.backgroundColor = .green
        
        uiview.translatesAutoresizingMaskIntoConstraints = false
        playerLifeView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(uiview)
        stackView.addArrangedSubview(nameLabel)
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 5
        
        let playerConstrain = playerLifeView.widthAnchor.constraint(equalToConstant: 250)
        playerConstrain.isActive = true
        lifeBarConstrain.append(playerConstrain)
        
        NSLayoutConstraint.activate([
            uiview.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 0),
            uiview.bottomAnchor.constraint(equalTo: uiview.bottomAnchor, constant: 15),
            uiview.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 0),
            uiview.trailingAnchor.constraint(equalTo: uiview.leadingAnchor, constant: 250),
            playerLifeView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 0),
            playerLifeView.bottomAnchor.constraint(equalTo: uiview.bottomAnchor, constant: 0),
            playerLifeView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 0),
        ])
        
        return stackView
    }
    
    private func botBarSetup(stackView: UIStackView)  -> UIStackView{
        let nameLabel: UILabel = UILabel()
        let uiview: UIView = UIView()
        botLifeView = UIView()
        
        nameLabel.text = "COMPUTER"
        nameLabel.font = nameLabel.font.withSize(30)
        nameLabel.textColor = .white
        
        stackView.axis = .vertical
        stackView.alignment = .trailing
        stackView.distribution = .fill
        stackView.spacing = 5
        
        uiview.addSubview(botLifeView)
        stackView.addArrangedSubview(uiview)
        stackView.addArrangedSubview(nameLabel)
        
        botLifeView.translatesAutoresizingMaskIntoConstraints = false
        botLifeView.backgroundColor = .green
        uiview.translatesAutoresizingMaskIntoConstraints = false
        uiview.backgroundColor = .red
        
        
        NSLayoutConstraint.activate([
            
            uiview.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 0),
            uiview.bottomAnchor.constraint(equalTo: uiview.topAnchor, constant: 15),
            uiview.leadingAnchor.constraint(equalTo: uiview.trailingAnchor, constant: -250),
            uiview.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 0),

            botLifeView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 0),
            botLifeView.bottomAnchor.constraint(equalTo: uiview.bottomAnchor, constant: 0),
            botLifeView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 0),
        ])
        let botConstrain = botLifeView.widthAnchor.constraint(equalToConstant: 250)
        botConstrain.isActive = true
        lifeBarConstrain.append(botConstrain)
        return stackView
    }
    
    private func playerHeroSetup(){
        
        playerHeroImageView.animationImages = gameModel.playerHero == .TODO ? Heroes.todoIdle : Heroes.leeIdle
        playerHeroImageView.animationDuration = 1.5
        playerHeroImageView.startAnimating()
        
        bgView.addSubview(playerHeroImageView)
        playerHeroImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playerHeroImageView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 50),
            playerHeroImageView.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -50),
            playerHeroImageView.widthAnchor.constraint(equalToConstant: 150),
            playerHeroImageView.heightAnchor.constraint(equalToConstant: 175)
        ])
    }
    
    private func botHeroSetup(){
        botHeroImageView.animationImages = gameModel.botHero == .TODO ? Heroes.todoIdle : Heroes.leeIdle
        botHeroImageView.animationDuration = 2
        botHeroImageView.startAnimating()
        botHeroImageView.transform = CGAffineTransform(scaleX: -1, y: 1)
        bgView.addSubview(botHeroImageView)
        botHeroImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            botHeroImageView.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -50),
            botHeroImageView.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -50),
            botHeroImageView.widthAnchor.constraint(equalToConstant: 150),
            botHeroImageView.heightAnchor.constraint(equalToConstant: 175)
        ])
    }
    
    private func playButtonActionSetup(){
        
        playButton.layer.cornerRadius = 5
        playButton.layer.borderWidth = 2
        playButton.layer.borderColor = UIColor.white.cgColor
        playButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        playButton.setTitleColor( .white, for: .normal)
        playButton.setTitle("Question 1", for: .normal)
        playButton.addTarget(self, action: #selector(toQuestionScene), for: .touchUpInside)
        playButton.backgroundColor = #colorLiteral(red: 0.07450980392, green: 0.1019607843, blue: 0.1764705882, alpha: 1)
        
        bgView.addSubview(playButton)
        
        playButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playButton.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -10),
            playButton.centerXAnchor.constraint(equalTo: bgView.centerXAnchor),
            playButton.heightAnchor.constraint(equalToConstant: 75),
            playButton.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    @objc private func toQuestionScene(sender: UIButton){
        sender.isEnabled = false
        let vc = QuestionSceneViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
    
    private func lifeBarCheck(){
        print("test")
        if playerLifeView != nil && botLifeView != nil {
            print("asas")
            UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseOut, animations: {
                
                self.lifeBarConstrain[0].constant = CGFloat(50 * self.gameModel.playerLife)
                self.lifeBarConstrain[1].constant = CGFloat(50 * self.gameModel.botLife)
                self.view.layoutIfNeeded()
                
            }, completion: { finished in
                
                self.botLifeView.layoutIfNeeded()
                self.playerLifeView.layoutIfNeeded()
                self.gameModel.playerLife -= 1
                self.gameModel.botLife -= 1
                self.playButton.isEnabled = true
            })
        }
    }
}
