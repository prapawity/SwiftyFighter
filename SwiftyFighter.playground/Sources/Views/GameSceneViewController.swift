import Foundation
import UIKit

public protocol getAnswer {
    func getReturnAnswer(result: Bool)
}

public class GameSceneViewController: UIViewController, getAnswer{
    
    public var gameModel: PlayGameModel!
    
    private let bgView: UIView = UIView()
    private var playerLifeView: UIView!
    private var botLifeView: UIView!
    private let playerHeroImageView: UIImageView = UIImageView()
    private let botHeroImageView: UIImageView = UIImageView()
    private var lifeBarConstrain: [NSLayoutConstraint] = []
    private let playButton: UIButton = UIButton()
    private var actionInited: Bool = false
    private var userHeroConstraint: NSLayoutConstraint!
    private var botHeroConstraint: NSLayoutConstraint!
    private var isPlayerAttack: Bool = false
    
    override public func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.07450980392, green: 0.1019607843, blue: 0.1764705882, alpha: 1)
        
    }
    
    
    override public func viewDidAppear(_ animated: Bool) {
        
        if playerLifeView == nil{
            
            loadingIndicator()
            
        }
        
        lifeBarCheck()
        
    }
    
    private func loadingIndicator(){
        
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
        
        UIView.animate(withDuration: 2, delay: 0.5, options: .curveEaseOut, animations: {
            
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
        bgImageViewSetup()
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
    private func bgImageViewSetup(){
        
        let bgImageView: UIImageView = UIImageView(image: Backgrounds.firstPageBG)
        
        bgView.addSubview(bgImageView)
        
        bgImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            bgImageView.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 0),
            bgImageView.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: 0),
            bgImageView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 0),
            bgImageView.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: 0)
            
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
        
        let playerConstrain = playerLifeView.widthAnchor.constraint(equalToConstant: CGFloat(50 * self.gameModel.playerLife))
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
        let botConstrain = botLifeView.widthAnchor.constraint(equalToConstant: CGFloat(50 * self.gameModel.botLife))
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
        userHeroConstraint = playerHeroImageView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 50)
        
        NSLayoutConstraint.activate([
            userHeroConstraint,
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
        botHeroConstraint = botHeroImageView.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -50)
        NSLayoutConstraint.activate([
            botHeroConstraint,
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
        playButton.setTitle("Question \(gameModel.questionNumber)", for: .normal)
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
        vc.question = gameModel.question[gameModel.questionNumber-1]
        vc.delegate = self
        vc.questionNumber = gameModel.questionNumber
        self.present(vc, animated: false, completion: nil)
    }
    
    private func lifeBarCheck(){
        
        if playerLifeView != nil && botLifeView != nil && actionInited == true{
            if isPlayerAttack{
                userAttack(completion: {(Bool) -> Void in
                    self.lifeBarControl(completion: {(Bool) -> Void in
                        self.userHeroMove(go: false)
                        
                    })
                })
            }else{
                botAttack(completion: {(Bool) -> Void in
                    self.lifeBarControl(completion: {(Bool) -> Void in
                        self.botHeroMove(go: false)
                        
                    })
                })
            }
            actionInited = false
        }
        
    }
    
    private func lifeBarControl(completion: @escaping (Bool) -> Void){
        UIView.animate(withDuration: 0.5, delay: 2, options: .curveEaseOut, animations: {
            self.shakeScreen()
            self.lifeBarConstrain[0].constant = CGFloat(50 * self.gameModel.playerLife)
            self.lifeBarConstrain[1].constant = CGFloat(50 * self.gameModel.botLife)
            self.view.layoutIfNeeded()
            
        }, completion: { finished in
            self.botLifeView.layoutIfNeeded()
            self.playerLifeView.layoutIfNeeded()

            if self.gameModel.playerLife == 0{
                SoundManager.koSound()
                self.playerHeroImageView.stopAnimating()
                self.playerHeroImageView.animationImages = self.gameModel.playerHero == .TODO ? Heroes.todoDead : Heroes.leeDead
                self.playerHeroImageView.animationDuration = 2
                self.playerHeroImageView.startAnimating()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.8, execute: {
                    self.checkStatWin(1)
                })
            } else if self.gameModel.botLife == 0{
                SoundManager.koSound()
                self.botHeroImageView.stopAnimating()
                self.botHeroImageView.animationImages = self.gameModel.botHero == .TODO ? Heroes.todoDead : Heroes.leeDead
                self.botHeroImageView.animationDuration = 2
                self.botHeroImageView.startAnimating()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.8, execute: {
                    self.checkStatWin(0)
                })
            }
            self.playButton.setTitle("Question \(self.gameModel.questionNumber)", for: .normal)
            self.playButton.isEnabled = true
            completion(true)
        })
    }
    
    private func checkStatWin(_ whoWin: Int){
        let bgResult: UIView = UIView()
        let title: UILabel = UILabel()
        let message: UILabel = UILabel()
        let backButton: UIButton = UIButton()
        let uiStack: UIStackView = UIStackView()
        
        
        if whoWin == 0{
            title.text = "congratulation!"
            message.text = "You Win"
            bgResult.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
            
        } else{
            title.text = "Game Over"
            message.text = "You Lose"
            bgResult.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }
        
        backButton.setTitle("Back To Select Hero",for: .normal)
        backButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        backButton.layer.cornerRadius = 5
        
        uiStack.axis = .vertical
        uiStack.alignment = .center
        uiStack.distribution = .fillEqually
        uiStack.spacing = 5
        
        title.font = UIFont.boldSystemFont(ofSize: 50.0)
        message.font = UIFont.boldSystemFont(ofSize: 35.0)
        backButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        backButton.setTitleColor( .black, for: .normal)
        backButton.addTarget(self, action: #selector(backToSelectHeroView), for: .touchUpInside)
        title.textAlignment = .center
        message.textAlignment = .center
        
        
        uiStack.addArrangedSubview(title)
        uiStack.addArrangedSubview(message)
        uiStack.addArrangedSubview(backButton)
        bgResult.addSubview(uiStack)
        self.view.addSubview(bgResult)
        bgView.isHidden = true
        
        
        bgResult.layer.cornerRadius = 5
        bgResult.translatesAutoresizingMaskIntoConstraints = false
        uiStack.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bgResult.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            bgResult.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            bgResult.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            bgResult.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            uiStack.topAnchor.constraint(equalTo: bgResult.topAnchor, constant: 0),
            uiStack.heightAnchor.constraint(equalTo: bgResult.heightAnchor),
            uiStack.leadingAnchor.constraint(equalTo: bgResult.leadingAnchor, constant: 0),
            uiStack.trailingAnchor.constraint(equalTo: bgResult.trailingAnchor, constant: 0),
            backButton.widthAnchor.constraint(equalTo: uiStack.widthAnchor)
        ])
    }
    
    private func shakeScreen(){
        let midX = bgView.center.x
        let midY = bgView.center.y

        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.09
        animation.repeatCount = 4
        animation.beginTime = CACurrentMediaTime() + 1.5
        animation.autoreverses = true
        animation.fromValue = CGPoint(x: midX - 10, y: midY - 10)
        animation.toValue = CGPoint(x: midX + 10, y: midY + 10)
        bgView.layer.add(animation, forKey: "position")
        
    }
    
    private func userAttack(completion: @escaping (Bool) -> Void){
        UIView.animate(withDuration: 0.5, delay: 2, options: .curveEaseOut, animations: {
            
            self.userHeroMove(go: true)
            self.view.layoutIfNeeded()
            
        }, completion: { finished in
            SoundManager.punchSound()
            self.playerHeroImageView.stopAnimating()
            self.playerHeroImageView.animationImages = self.gameModel.playerHero == .TODO ? Heroes.todoAttack : Heroes.leeAttack
            self.playerHeroImageView.animationDuration = 1
            self.playerHeroImageView.startAnimating()
            completion(true)
        })
    }
    
    private func botAttack(completion: @escaping (Bool) -> Void){
        UIView.animate(withDuration: 0.5, delay: 2, options: .curveEaseOut, animations: {
            self.botHeroMove(go: true)
            self.view.layoutIfNeeded()
            
        }, completion: { finished in
            SoundManager.punchSound()
            self.botHeroImageView.stopAnimating()
            self.botHeroImageView.animationImages = self.gameModel.botHero == .TODO ? Heroes.todoAttack : Heroes.leeAttack
            self.botHeroImageView.animationDuration = 1
            self.botHeroImageView.startAnimating()
            completion(true)
        })
    }
    
    private func userHeroMove(go: Bool){
        if go{
            userHeroConstraint.constant = 400
        } else{
            playerHeroImageView.stopAnimating()
            playerHeroImageView.animationImages = gameModel.playerHero == .TODO ? Heroes.todoIdle : Heroes.leeIdle
            playerHeroImageView.animationDuration = 1.5
            playerHeroImageView.startAnimating()
            UIView.animate(withDuration: 0.5) {
                self.userHeroConstraint.constant = 50
                self.view.layoutIfNeeded()
            }
            
        }
    }
    
    private func botHeroMove(go: Bool){
        if go{
            botHeroConstraint.constant = -400
        } else{
            botHeroImageView.stopAnimating()
            botHeroImageView.animationImages = gameModel.botHero == .TODO ? Heroes.todoIdle : Heroes.leeIdle
            botHeroImageView.animationDuration = 1.75
            botHeroImageView.startAnimating()
            UIView.animate(withDuration: 0.5) {
                self.botHeroConstraint.constant = -50
                self.view.layoutIfNeeded()
            }
            
        }
    }
    
    @objc private func backToSelectHeroView(){
        self.dismiss(animated: false, completion: nil)
    }
    
    public func getReturnAnswer(result: Bool) {
        gameModel.questionNumber += 1
        if result {
            isPlayerAttack = true
            self.gameModel.botLife -= 1
        } else{
            self.gameModel.playerLife -= 1
            isPlayerAttack = false
        }
        actionInited = true
    }
}
