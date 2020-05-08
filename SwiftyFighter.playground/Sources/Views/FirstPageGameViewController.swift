import Foundation
import UIKit


public class FirstPageGameViewController: UIViewController{
    private let bgImageView: UIImageView = UIImageView(image: Backgrounds.firstPageBG)
    private let logoImageView: UIImageView = UIImageView()
    private let pressToStartImageView: UIImageView = UIImageView(image: TitleAndButton.pressToStartTitle)
    private var timer: Timer!
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.07450980392, green: 0.1019607843, blue: 0.1764705882, alpha: 1)
        setupUI()
    }

    private func setupUI(){
        bgImageViewSetup()
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (Timer) in
            self.bgImageView.alpha += 0.03
            if(self.bgImageView.alpha >= 1){
                self.logoImageViewSetup()
                self.pressToStartImageViewSetup()
                self.invisibleButtonSetup()
                Timer.invalidate()
            }
        }
    }
    
    private func bgImageViewSetup(){
        bgImageView.alpha = 0
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
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.animationImages = Logo.sfLogo
        logoImageView.animationDuration = 2.5
        logoImageView.startAnimating()
        self.view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
        logoImageView.bottomAnchor.constraint(equalTo: view.topAnchor,constant: 300),
        ])
    }
    
    private func pressToStartImageViewSetup(){
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { (Timer) in
            self.pressToStartImageView.alpha = self.pressToStartImageView.alpha == 0 ? 1:0
        }
        self.view.addSubview(pressToStartImageView)
        pressToStartImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pressToStartImageView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 35),
            pressToStartImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant:-40),
            pressToStartImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 210),
            pressToStartImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -210)
        ])
    }
    
    private func invisibleButtonSetup(){
        let invisibleButton: UIButton = UIButton()
        invisibleButton.addTarget(self, action: #selector(pressToStartAction), for: .touchUpInside)
        self.view.addSubview(invisibleButton)
        invisibleButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        invisibleButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
        invisibleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
        invisibleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
        invisibleButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: 0),
        invisibleButton.heightAnchor.constraint(equalToConstant: 0)
        ])
    }
    
    private func fadeScene(){
        let alpha = CGFloat(0.3)
        logoImageView.alpha -= alpha
        pressToStartImageView.alpha -= alpha
    }
    
    @objc private func pressToStartAction(){
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
            self.fadeScene()
            if(self.logoImageView.alpha <= -0.2){
                timer.invalidate()
                self.timer.invalidate()
                let vc = MainpageViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false, completion: nil)
            }
        }
    }
    
}
