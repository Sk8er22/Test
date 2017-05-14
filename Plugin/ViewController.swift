//
//  ViewController.swift
//  Plugin
//
//  Created by PEDRO ARMANDO MANFREDI on 12/5/17.
//  Copyright © 2017 Test. All rights reserved.
//

import UIKit
import Foundation
import AVKit
import AVFoundation

class ViewController: UIViewController, AVPlayerViewControllerDelegate {
    
    var player: AVPlayer!
    var playerController: AVPlayerViewController!
    var play = false
    var counterSeconds = 0.0
    var counterPauses = 0
    var counterPlays = 0
    var timer = Timer()
    var isTimerRunning = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
            let videoURL = URL(string: "http://techslides.com/demos/sample-videos/small.mp4")
            
            player = AVPlayer(url:videoURL!)
        

            let playerController = AVPlayerViewController()
            playerController.player = player
            playerController.delegate = self
            self.present(playerController, animated: true, completion: {
                self.player.play()
                self.player.addObserver(self, forKeyPath: "rate", options: .new, context: nil)
                NotificationCenter.default.addObserver(self, selector:#selector(ViewController.playerDidFinishPlaying(note:)),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player.currentItem)

            } )

        
              // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    func deallocObservers(player: AVPlayer) {
        player.removeObserver(self, forKeyPath: "rate")
 
        
    }
    
    //observer for av play
    override  func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "rate" && play == true) {
            play = !play
            counterPlays += 1
            print("PLAYING || PAUSE: \(counterPauses) times   ||   PLAY: \(counterPlays) times  || PAUSED TIME: \(timeString(time: counterSeconds)) ")
            timer.invalidate()

        }
        else if (keyPath == "rate" && play == false){
            counterPauses += 1
            play = !play
            print("PAUSE: \(counterPauses) times   ||   PLAY: \(counterPlays) times  || PAUSED TIME: \(timeString(time: counterSeconds)) ")

            if isTimerRunning == false {
                runTimer()
            }
            
        }
        
    
    }
    
    func playerDidFinishPlaying(note: NSNotification) {
        print("Video Finished")
    }

    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    func updateTimer() {
        counterSeconds += 0.1     //This will decrement(count down)the seconds.
        print("\(counterSeconds)")
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
    override func viewDidAppear(_ animated: Bool) {
        
        player.pause()
        timer.invalidate()
    }
}

