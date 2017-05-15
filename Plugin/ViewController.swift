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
    var counterPlays = 0
    var timer = Timer()
    var isTimerRunning = false
    var finalMessage: String = ""
    let urlRequest = URL(string: "https://www.google.com")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.request()
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
            
            timer.invalidate()
            
        }
        else if (keyPath == "rate" && play == false){
            counterPauses += 1
            play = !play
            
            
            if isTimerRunning == false {
                runTimer()
            }
            
        }
        
        
    }
    
    func playerDidFinishPlaying(note: NSNotification) {
        print("Video Finished")
        counterPauses -= 1
        dismiss(animated: true, completion: nil)
    }
    
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    
    func updateTimer() {
        counterSeconds += 0.1     //This will decrement(count down)the seconds.
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
        finalMessage =  "PAUSE: \(counterPauses) times\nPLAY: \(counterPlays) times\nPAUSED TIME: \(timeString(time: counterSeconds))"
        playerController?.dismiss(animated: true, completion: nil)
        let alertController = UIAlertController(title: "FINISHED", message:"\(finalMessage)",preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
        print("\(finalMessage)")
        
    }
    
    
    func request (){
        let parameters = ["q": "Barcelona", "APPID": "a51c02180847521c7f27d3ee317ec388"]
        //?q=London,uk&appid=b1b15e88fa797225412429c1c50c122a1
        Alamofire.request("http://api.openweathermap.org/data/2.5/forecast", parameters: parameters) .responseJSON { response in
            //  print(response.request)  // original URL request
            //  print(response.response) // HTTP URL response
            //  print(response.data)     // server data
            //  print(response.result)   // result of response serialization
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("PRUEBA DE REQUEST\nEL TIEMPO EN BARCELONA ES: \(json["list"][0]["weather"][0]["description"])")
            case .failure(let error):
                print(error)
            }
        }}
}

