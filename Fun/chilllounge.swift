//
//  chilllounge.swift
//  Fun
//
//  Created by user170945 on 5/3/20.
//  Copyright © 2020 user170945. All rights reserved.
//

import UIKit
import Lottie

class chilllounge: UIViewController {
    //@IBOutlet weak var animate: AnimationView!
    let animat = AnimationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        //startanimation()
        staran()
        // Do any additional setup after loading the view.
    }
    
    
    
// MARK: starte Animation
    func staran(){
        animat.animation = Animation.named("wait")
        animat.frame = CGRect(x: 85, y: 150, width: 200, height: 200)
        animat.backgroundColor = .white
        animat.contentMode = .scaleAspectFit
        animat.loopMode = .loop
        animat.play()
        view.addSubview(animat)
    }
    // MARK: Timer
      override var preferredStatusBarStyle: UIStatusBarStyle {return.lightContent}
      var counter = 0
      @IBOutlet weak var lbl: UILabel!
      @IBOutlet weak var lable: UILabel!
      @IBOutlet weak var playPauseButton: UIButton!
      
      var isTimerOn = false
      
      var duration = 0
      
      
      
      var timer = Timer()
      @IBAction func slider(_ sender: UISlider) {
          lbl.text = String(Int(sender.value))
          
         
      }
      
    // MARK: Notification
      func Notification(){
          let contnet = UNMutableNotificationContent()
          contnet.title = "You are ready for work"
          contnet.body = "👩🏼‍🎨 create"
          contnet.sound = UNNotificationSound.default
          
          let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
          
          let request = UNNotificationRequest(identifier: "testIdentifier", content: contnet, trigger: trigger)
          UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)        // Do any
      }
      
    
    // MARK: noch mehr Timer
      @IBAction func didTapStartOrPause(_ sender: UIButton){
          isTimerOn.toggle()
          //showPlayButton(!isTimerOn)
          
          toggleTimer(on: isTimerOn)
      }
      
      func vgl(_ shouldShowPlayButton: Bool) -> Int{
          var lblint: Int? = Int(lbl.text!)
          let lableint: Int? = Int(lable.text!)
          
          let convert = lblint! - lableint!
          print("\(convert)")
          
          return convert
      }
      
      
      func toggleTimer(on: Bool){
          if on {
              timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {[weak self] (_) in
                  guard let strongSelf = self else{return}
                  
                  strongSelf.duration += 1
                  
                  strongSelf.lable.text = String(strongSelf.duration)
                  
                  
                  if strongSelf.vgl(true) == 0{
                      strongSelf.didTapReset()
                      strongSelf.Notification()
                      print("finish")
                  }
                  
              })
              
          } else {
              timer.invalidate()
          }
          
          
      }
      
      
     // func showPlayButton(_ shouldShowPlayButton: Bool){
          
          //let imageName = shouldShowPlayButton ? "playIcon" : "pausIcon"
          
            //playPauseButton.setImage(UIImage(named: imageName), for: .normal)
          //playPauseButton.backgroundColor = shouldShowPlayButton ? .green : .yellow
          
      //}
      
      @IBAction func didTapReset() {
          timer.invalidate()
          
          duration = 0
          
          lable.text = "0"
          //showPlayButton(true)
          
          
          
      }
      
      
}
