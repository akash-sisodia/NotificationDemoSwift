//
//  SViewController.swift
//  NotificationCategoryDemo
//
//  Created by Akash Singh Sisodia on 6/29/17.


import UIKit
import AVKit
import AVFoundation

class SViewController: UIViewController {
    @IBOutlet weak var btn: UIButton!
    
    
     
    override func viewDidLoad() {
        super.viewDidLoad()
 
        
        
        
        
        let videoURL = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
        let player = AVPlayer(url: videoURL!)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer)
        player.play()
        
        
        
        
        
        
        
        
        
        
        btn.addTarget(self,
                         action: #selector(drag(control:event:)),
                         for: UIControlEvents.touchDragInside)
        btn.addTarget(self,
                         action: #selector(drag(control:event:)),
                         for: [UIControlEvents.touchDragExit,
                               UIControlEvents.touchDragOutside])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    func drag(control: UIControl, event: UIEvent) {
        if let center = event.allTouches?.first?.location(in: self.view) {
            control.center = center
        }
    }


}

 
