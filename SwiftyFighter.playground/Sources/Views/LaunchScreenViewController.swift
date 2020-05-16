import UIKit

public class LaunchScreenViewController: UIViewController{

    private var imageView: UIImageView = UIImageView(image: Logo.scctLogo)

    override public func viewDidLoad() {

        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.07450980392, green: 0.1019607843, blue: 0.1764705882, alpha: 1)

    }

    override public func viewDidAppear(_ animated: Bool){
        setupUI()
        SoundManager.introSound()
    }
    
    private func setupUI(){

        var counter: Int = 0

        imageViewSetup()

        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { timer in

            switch counter {

            case 0:
                self.fadeImage(state: true,completion: { (fadeReturn) -> Void in
                    counter += fadeReturn
                })

            case 1:
                self.fadeImage(state: false,completion:{ (fadeReturn) -> Void in
                    counter += fadeReturn
                })

            default:
                timer.invalidate()
                let vc = FirstPageGameViewController()

                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false, completion: nil)

            }

        }

    }
    
    private func fadeImage(state: Bool, completion: @escaping (Int) -> Void){
        
        UIView.animate(withDuration: 1.5, delay: 0.5, options: .curveEaseOut, animations: {

            self.imageView.alpha = state == true ? 1 : 0

        }, completion: { finished in

            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                completion(1)
            })

        })

    }

    private func imageViewSetup(){

        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0

        self.view.addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([

            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 500),

        ])

    }

}
