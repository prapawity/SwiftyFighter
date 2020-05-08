//: A UIKit based Playground for presenting user interface
import PlaygroundSupport
import UIKit

// Present the view controller in the Live View window
//var myView = LaunchScreenViewController()
//var myView = FirstPageGameViewController()
//var myView = MainpageViewController()
//var myView = SelectHeroViewController()
//var myView = GameSceneViewController()
//myView.setGameModel()
var myView = QuestionSceneViewController()
myView.preferredContentSize = CGSize(width: 736, height: 414)
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(myView)
// Credit
// Backgrounds by ansimuz.itch.io
// Character by Yawackhary: Art of Fighting
