import Foundation
import AVFoundation
public struct SoundManager{
    
    private static var avManager: AVAudioPlayer?
    public static var isMute: Bool = false
    public static var isPlay: Bool = true
    
    public static func punchSound(){
        let path = Bundle.main.path(forResource: "Sounds/punch.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        do {
            avManager = try AVAudioPlayer(contentsOf: url)
            avManager?.volume = isMute ? 0 : 1.0;
            avManager?.play()
        } catch {
            print("Error, could not load file")
        }
    }
    
    public static func timerSound(){
        let path = Bundle.main.path(forResource: "Sounds/timer.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        do {
            avManager = try AVAudioPlayer(contentsOf: url)
            avManager?.volume = isMute ? 0 : 0.8;
            avManager?.play()
        } catch {
            // couldn't load file :(
        }
    }
    
    public static func koSound(){
        let path = Bundle.main.path(forResource: "Sounds/koSound.m4a", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        do {
            avManager = try AVAudioPlayer(contentsOf: url)
            avManager?.volume = isMute ? 0 : 1;
            avManager?.play()
            isPlay = false
        } catch {
            // couldn't load file :(
        }
    }
    
    public static func introSound(){
        let path = Bundle.main.path(forResource: "Sounds/swifty_figther_theme_demo1.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        do {
            avManager = try AVAudioPlayer(contentsOf: url)
            avManager?.volume = 0;
            avManager?.numberOfLoops = -1
            avManager?.play()
            avManager?.setVolume(isMute ? 0 : 0.8, fadeDuration: 3)
            isPlay = true
        } catch {
            // couldn't load file :(
        }
    }
    
    public static func muteSound(){
        isMute ? avManager?.setVolume(0, fadeDuration: 1.5) : avManager?.setVolume(0.8, fadeDuration: 3)
    }
    
    public static func stopSound(){
        avManager?.setVolume(0, fadeDuration: 2)
        isPlay = false
        
    }
    
    
}
