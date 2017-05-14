//
//  ViewController.swift
//  Plugin
//
//  Created by PEDRO ARMANDO MANFREDI on 12/5/17.
//  Copyright © 2017 Test. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController, AVPlayerViewControllerDelegate {
    
    var player: AVPlayer!
    var playerController: AVPlayerViewController!
    
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
        if keyPath == "rate" {
            print("rate")
        }
        
    
    }
    
    func playerDidFinishPlaying(note: NSNotification) {
        print("Video Finished")
    }

}

