//
//  CardViewController.swift
//  CardViewAnimation
//
//  Created by Brian Advent on 26.10.18.
//  Copyright © 2018 Brian Advent. All rights reserved.
//

import UIKit
import Lottie

class CardViewController: UIViewController {

    @IBOutlet weak var handleArea: UIView!
    
    @IBOutlet weak var myWebView: UIWebView!
    let animat = AnimationView()

       override func viewDidLoad() {
           super.viewDidLoad()
           //startanimation()
           staran()
        videostart()
           // Do any additional setup after loading the view.
       }
    func videostart(){
        let url = URL(string: "https://www.youtube.com/watch?v=_-kYLnc5dWU")
        myWebView.loadRequest(URLRequest(url: url!))
    }
    
    func staran(){
        animat.animation = Animation.named("dev")
        animat.frame = CGRect(x: 85, y: 70, width: 200, height: 200)
        animat.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        animat.contentMode = .scaleAspectFit
        animat.loopMode = .autoReverse
        
        animat.play()
        view.addSubview(animat)
    }}
