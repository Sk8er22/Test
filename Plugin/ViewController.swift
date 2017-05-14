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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
            let videoURL = URL(string: "http://techslides.com/demos/sample-videos/small.mp4")
            
            let player = AVPlayer(url:videoURL!)
            
            let playerController = AVPlayerViewController()
            playerController.player = player
            playerController.delegate = self
            self.present(playerController, animated: true, completion: {player.play()} )
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

