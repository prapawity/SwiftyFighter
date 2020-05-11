import Foundation
import AVFoundation
public struct SoundManager{
    private static var avManager: AVAudioPlayer?
    
    public static func punchSound(){
        let path = Bundle.main.path(forResource: "Sounds/punch.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        do {
            avManager = try AVAudioPlayer(contentsOf: url)
            avManager?.volume = 1.0;
            avManager?.play()
        } catch {
            // couldn't load file :(
        }
    }
    
    public static func timerSound(){
        let path = Bundle.main.path(forResource: "Sounds/timer.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        do {
            avManager = try AVAudioPlayer(contentsOf: url)
            avManager?.volume = 0.8;
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
            avManager?.volume = 1;
            avManager?.play()
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
            avManager?.play()
            avManager?.setVolume(0.8, fadeDuration: 3)
        } catch {
            // couldn't load file :(
        }
    }
    
    public static func stopSound(){
        avManager?.setVolume(0, fadeDuration: 2)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8, execute: {
//
//        })
        
    }
    
    
}
