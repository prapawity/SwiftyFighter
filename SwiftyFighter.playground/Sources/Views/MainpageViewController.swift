import UIKit

public class MainpageViewController: UIViewController{
    
    private let logoImageView: UIImageView = UIImageView()
    private let stackButtonView: UIStackView = UIStackView()
    private var timerList: [Timer] = []
    
    override public func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.07450980392, green: 0.1019607843, blue: 0.1764705882, alpha: 1)
        setupUI()
        
    }
    
    private func setupUI(){
        
        bgImageViewSetup()
        logoImageViewSetup()
        stackButtonSetup()
        
        UIView.animate(withDuration: 2, delay: 0, options: .curveEaseOut, animations: {

            self.logoImageView.alpha = 1
            self.stackButtonView.alpha = 1

        }, completion: nil)
        
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
    
    private func logoImageViewSetup(){
        
        logoImageView.animationImages = Logo.sfLogo
        logoImageView.animationDuration = 1
        logoImageView.startAnimating()
        logoImageView.alpha = 0
        logoImageView.contentMode = .scaleAspectFit
        
        self.view.addSubview(logoImageView)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            logoImageView.heightAnchor.constraint(equalToConstant: 260),
            
        ])
        
    }
    
    private func stackButtonSetup(){
        
        stackButtonView.alpha = 0
        stackButtonView.alignment = .center
        stackButtonView.axis = .horizontal
        stackButtonView.contentMode = .scaleAspectFit
        stackButtonView.distribution = .fillProportionally
        stackButtonView.spacing = 40
        
        buttonSetup().forEach{ (button) in stackButtonView.addArrangedSubview(button)}
        
        self.view.addSubview(stackButtonView)
        
        stackButtonView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            stackButtonView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            stackButtonView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            stackButtonView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 40),
            stackButtonView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            
        ])
        
    }
    
    private func buttonSetup() -> [UIButton]{
        
        let play: UIButton = UIButton()
        let howto: UIButton = UIButton()
        let aboutme: UIButton = UIButton()
        var state: Int = 0
        
        let time = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            
            play.setImage(TitleAndButton.playButton[state == 0 ? 1:0], for: .normal)
            howto.setImage(TitleAndButton.howToButton[state == 1 ? 1:0], for: .normal)
            aboutme.setImage(TitleAndButton.aboutMeButton[state == 2 ? 1:0], for: .normal)
            state = state == 2 ? 0 : state + 1
            
        }
        timerList.append(time)
        
        play.addTarget(self,action: #selector(toSelectHero), for: .touchUpInside)
        aboutme.addTarget(self, action: #selector(toAboutmeView), for: .touchUpInside)
        howto.addTarget(self, action: #selector(toHowToView), for: .touchUpInside)
        
        return [play, howto, aboutme]
    }
    
    @objc private func toSelectHero(){
        
        let vc = SelectHeroViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
        
    }
    
    @objc private func toAboutmeView(){
        
        let vc = AboutmeViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
        
    }
    
    @objc private func toHowToView(){
        
        let vc = HowToPlayViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
        
    }
}
