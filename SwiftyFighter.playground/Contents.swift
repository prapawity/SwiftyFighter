//: A UIKit based Playground for presenting user interface
import PlaygroundSupport
import UIKit

class Game{
    
    private static let myView = LaunchScreenViewController()
    
    // Present the view controller in the Live View window
    public static func start(){
        
        myView.preferredContentSize = CGSize(width: 736, height: 414)
        PlaygroundPage.current.needsIndefiniteExecution = true
        PlaygroundPage.current.setLiveView(myView)
        
    }
    
}

// to start Game
Game.start() // if screen is black, please click again

// Credit
// Backgrounds by ansimuz.itch.io
// Character by Yawackhary: Art of Fighting
// Intro Song for Swifty Fighter By Supakit Theanthunyakit
