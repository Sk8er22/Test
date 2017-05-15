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
import Alamofire
import SwiftyJSON
import AVFoundation


class ViewController: UIViewController, AVPlayerViewControllerDelegate {
    
    var player: AVPlayer!
    var playerController: AVPlayerViewController!
    var play = false
    var counterSeconds = 0.0
    var counterPauses = 0
    var counterPlays = -1
    var timer = Timer()
    var controlPlugin = ControlPlugin()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //test video link & player init
        let videoURL = URL(string: "http://techslides.com/demos/sample-videos/small.mp4")
        player = AVPlayer(url:videoURL!)
        let playerController = AVPlayerViewController()
        playerController.player = player
        playerController.delegate = self
        
        //present playerController
        self.present(playerController, animated: true, completion: {
            
            
            
            //autoplay at the start
            self.player.play()
            
            //add oberserver for rate... 0 pause/1 normal play
            self.controlPlugin.addObserver(player: self.player)
            
        } )
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(_ animated: Bool) { //when end the video and get close
        player.pause() //important if the user click DONE
        
        let finalmessage = controlPlugin.end()
        
        //create ALERT
        let alertController = UIAlertController(title: "FINISHED", message:"\(finalmessage)",preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
        print("\(finalmessage)")
    }
    
    
    
}

