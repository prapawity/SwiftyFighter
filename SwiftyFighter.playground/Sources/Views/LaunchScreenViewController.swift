import Foundation
import UIKit

public class LaunchScreenViewController: UIViewController{
    private var imageView: UIImageView = UIImageView(image: Logo.scctLogo)
    lazy private var counter: Double = 0.0
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        view.backgroundColor = #colorLiteral(red: 0.07450980392, green: 0.1019607843, blue: 0.1764705882, alpha: 1)
        imageViewSetup()
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            self.counter += 5
            switch self.counter {
            case 0...100:
                self.imageView.alpha += 0.05
            case 101...199:
                break
            case 200...300:
                self.imageView.alpha -= 0.05
            case 301...310:
                timer.invalidate()
                let vc = FirstPageGameViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false, completion: nil)
            default:
                timer.invalidate()
                break
            }
        }
    }
    
    private func imageViewSetup(){
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0
        self.view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 120),
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -120)
        ])
    }
    
}
