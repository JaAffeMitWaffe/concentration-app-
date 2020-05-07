//
//  ViewController.swift
//  Fun
//
//  Created by user170945 on 5/2/20.
//  Copyright © 2020 user170945. All rights reserved.
//
import iCarousel
import UIKit
import Lottie

struct CustomData {
    var title: String
    var image: UIImage
    var url: String
}
class ViewController: UIViewController, iCarouselDataSource {
    
      // MARK: Nach oben ziehen
    enum CardState {
            case expanded
            case collapsed
        }
        
        var cardViewController:CardViewController!
        var visualEffectView:UIVisualEffectView!
        
        let cardHeight:CGFloat = 600
        let cardHandleAreaHeight:CGFloat = 65
        
        var cardVisible = false
        var nextState:CardState {
            return cardVisible ? .collapsed : .expanded
        }
        
        var runningAnimations = [UIViewPropertyAnimator]()
        var animationProgressWhenInterrupted:CGFloat = 0
        
      //  override func viewDidLoad() {
       //     super.viewDidLoad()
            //    setupCard()
        
       // }
    
        // MARK: Karte erstellen
    func setupCard() {
            visualEffectView = UIVisualEffectView()
            visualEffectView.frame = self.view.frame
            self.view.addSubview(visualEffectView)
            
            cardViewController = CardViewController(nibName:"CardViewController", bundle:nil)
            self.addChild(cardViewController)
            self.view.addSubview(cardViewController.view)
            
            cardViewController.view.frame = CGRect(x: 0, y: self.view.frame.height - cardHandleAreaHeight, width: self.view.bounds.width, height: cardHeight)
            
            cardViewController.view.clipsToBounds = true
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleCardTap(recognzier:)))
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handleCardPan(recognizer:)))
            
            cardViewController.handleArea.addGestureRecognizer(tapGestureRecognizer)
            cardViewController.handleArea.addGestureRecognizer(panGestureRecognizer)
            
            
        }

    // MARK: Animationen
        @objc
        func handleCardTap(recognzier:UITapGestureRecognizer) {
            switch recognzier.state {
            case .ended:
                animateTransitionIfNeeded(state: nextState, duration: 0.9)
            default:
                break
            }
        }
        
        @objc
        func handleCardPan (recognizer:UIPanGestureRecognizer) {
            switch recognizer.state {
            case .began:
                startInteractiveTransition(state: nextState, duration: 0.9)
            case .changed:
                let translation = recognizer.translation(in: self.cardViewController.handleArea)
                var fractionComplete = translation.y / cardHeight
                fractionComplete = cardVisible ? fractionComplete : -fractionComplete
                updateInteractiveTransition(fractionCompleted: fractionComplete)
            case .ended:
                continueInteractiveTransition()
            default:
                break
            }
            
        }
        
        func animateTransitionIfNeeded (state:CardState, duration:TimeInterval) {
            if runningAnimations.isEmpty {
                let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                    switch state {
                    case .expanded:
                        self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHeight
                    case .collapsed:
                        self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHandleAreaHeight
                    }
                }
                
                frameAnimator.addCompletion { _ in
                    self.cardVisible = !self.cardVisible
                    self.runningAnimations.removeAll()
                }
                
                frameAnimator.startAnimation()
                runningAnimations.append(frameAnimator)
                
                
                let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
                    switch state {
                    case .expanded:
                        self.cardViewController.view.layer.cornerRadius = 12
                    case .collapsed:
                        self.cardViewController.view.layer.cornerRadius = 0
                    }
                }
                
                cornerRadiusAnimator.startAnimation()
                runningAnimations.append(cornerRadiusAnimator)
                
                let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                    switch state {
                    case .expanded:
                        self.visualEffectView.effect = UIBlurEffect(style: .dark)
                    case .collapsed:
                        self.visualEffectView.effect = nil
                    }
                }
                
                blurAnimator.startAnimation()
                runningAnimations.append(blurAnimator)
                
            }
        }
    
    // MARK: Kartenstatus
        func startInteractiveTransition(state:CardState, duration:TimeInterval) {
            if runningAnimations.isEmpty {
                animateTransitionIfNeeded(state: state, duration: duration)
            }
            for animator in runningAnimations {
                animator.pauseAnimation()
                animationProgressWhenInterrupted = animator.fractionComplete
            }
        }
        
        func updateInteractiveTransition(fractionCompleted:CGFloat) {
            for animator in runningAnimations {
                animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
            }
        }
        
        func continueInteractiveTransition (){
            for animator in runningAnimations {
                animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
            }
        }

    // MARK: Karusellansicht
    var i = 0
    var Arr: [Int] = []
    var data = [
        UIImage(named: "mo9"),
                
        //UIImage(named: "mo5"),
    ]
    let myCarousel: iCarousel = {
        let view = iCarousel()
        view.type = .rotary
        return view
        
    }()
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(myCarousel)
        myCarousel.dataSource = self
        
              // Do
        myCarousel.frame = CGRect(x: 0, y: 50, width: view.frame.size.width, height: 300)
        setupCard()
        self.visualEffectView.isUserInteractionEnabled = false
        // Do any additional setup after loading the view.
    }
    func numberOfItems(in carousel: iCarousel) -> Int {
        return data.count    }
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width/2, height: 300))
        let imageview = UIImageView(frame: view.bounds)
        view.addSubview(imageview)
        imageview.contentMode = .scaleAspectFill
        imageview.image = data[index]
        view.backgroundColor = .red
        return view
    }
    
    // MARK: Photo hinzufuegen
    @IBAction func Addphoto(_ sender: UIButton) {
        let bild = randomSeq(min: 1, max: 10)
        
        Arr.append(bild())
        print(Arr)
        
        //data.append(UIImage(named: "mo5"))
        let bildname = "mo" + String(Arr[i])
        print(bildname)
        data.insert(UIImage(named: bildname), at: 0)
        //data.append(UIImage(named: bildname))
        // neuladen der Bilder
        myCarousel.reloadData()
        print(data)
        print("ready")
        i += 1
        print(i)
    }
     func randomSeq(min: Int, max: Int) -> () -> Int{
           var numbers: [Int] = []
           return{
               if numbers.isEmpty{
                   numbers = Array(min...max)
               }
               let index = Int(arc4random_uniform(UInt32(numbers.count)))
               return numbers.remove(at: index)
               
           }
           
       }}

