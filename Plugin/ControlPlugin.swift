//
//  ControlPugin.swift
//  Plugin
//
//  Created by PEDRO ARMANDO MANFREDI on 15/5/17.
//  Copyright © 2017 Test. All rights reserved.
//

import Foundation
import AVKit
import AVFoundation
import Alamofire
import SwiftyJSON

public class ControlPlugin: UIViewController, AVPlayerViewControllerDelegate {
    
    var play = false
    var counterSeconds = 0.0
    var counterPauses = 0
    var counterPlays = 0
    var timer = Timer()
    
    
    //add observers to player: rate and playerDidFinishPlaying
    public func addObserver(player: AVPlayer){
    
        player.addObserver(self, forKeyPath: "rate", options: .new, context: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(self.playerDidFinishPlaying(note:)),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)

        //!!!!!2ndTASK REQUEST:Video starts.
        self.request()
    }
    

    func playerDidFinishPlaying(note: NSNotification) {
        
        self.request() //!!!!2nd TASK REQUEST: The video finishes.

        
        //-1 bc at the end rate change to 0 adding +1 in counter
        counterPauses -= 1
        
        self.end()
    }
    
    //dealloc rate
    func deallocObservers(player: AVPlayer) {
        player.removeObserver(self, forKeyPath: "rate")
        
        
    }
    
    
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self,   selector: (#selector(ControlPlugin.updateTimer)), userInfo: nil, repeats: true)
    }
    
    
    func updateTimer() {
        counterSeconds += 0.1     //This will increment the counterSeconds.
    }
    
    
    func timeString(time:TimeInterval) -> String { // usefull to convert counterSecond to h:m:s format
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    
    
    
    
    
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if (keyPath == "rate" && play == true) {
            
            //REQUEST: The user resumes the content.
            self.request()
            play = !play
            counterPlays += 1
            timer.invalidate() //pausetimer
            
        }
        else if (keyPath == "rate" && play == false){
            
            //The user pauses the content.
            counterPauses += 1
            play = !play
            runTimer() // start timer
            
            
        }
        
        
    }
    
    public func end()->String {
        
        timer.invalidate() // stop timer
        let time = timeString(time: counterSeconds)
        let msg =  "PAUSE: \(counterPauses) times\nPLAY: \(counterPlays) times\nPAUSED TIME:\(time) )"
        return msg
       
        
    }
    
    func request (){ //request function asks to openweather api in real time the wheater description.
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
