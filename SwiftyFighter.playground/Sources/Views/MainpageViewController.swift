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
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            self.fadeIn()
            if self.logoImageView.alpha >= 1 {
                timer.invalidate()
            }
        }
    }
    
    private func fadeIn(){
        let alpha = CGFloat(0.3)
        logoImageView.alpha += alpha
        stackButtonView.alpha += alpha
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
            logoImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30),
            logoImageView.bottomAnchor.constraint(equalTo: logoImageView.topAnchor, constant: 250)
        ])
    }
    
    private func stackButtonSetup(){
        stackButtonView.axis = .horizontal
        stackButtonView.alignment = .center
        stackButtonView.distribution = .fillProportionally
        stackButtonView.spacing = 40
        stackButtonView.alpha = 0
        
        for button in buttonSetup(){
            stackButtonView.addArrangedSubview(button)
        }
        
        self.view.addSubview(stackButtonView)
        stackButtonView.translatesAutoresizingMaskIntoConstraints = false
        stackButtonView.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            stackButtonView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -80),
            stackButtonView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 80),
            stackButtonView.topAnchor.constraint(equalTo: self.logoImageView.bottomAnchor, constant: 35),
            stackButtonView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40),
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
        
        return [play, howto, aboutme]
    }
    
    @objc private func toSelectHero(){
        let vc = SelectHeroViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
}
