import Foundation

public enum HeroType{
    case TODO
    case LEE
}

public class PlayGameModel{
    public var playerLife: Int = 5
    public var botLife: Int = 5
    public var questionNumber: Int = 1
    public var playerHero: HeroType!
    public let botHero: HeroType = Bool.random() == true ? .TODO : .LEE

}
