//
//  HomeViewController.swift
//  iCount
//
//  Created by Ionut Ciovica on 28/10/2021.
//

import UIKit
import AVFoundation
import CLTypingLabel

class HomeViewController: UIViewController {

    @IBOutlet var infoLabel: UILabel!
    
    @IBOutlet var imagePlayer: UIImageView!
    
    @IBOutlet var trackTitle: UILabel!
    
    var player: AVAudioPlayer?
    var count = 0
    
    lazy var gradient: CAGradientLayer = {
         let gradient = CAGradientLayer()
         gradient.type = .axial
         gradient.colors = [
             UIColor.colorHunt.cgColor,
             UIColor.purple.cgColor,
             UIColor.cyan.cgColor
         ]
         gradient.locations = [0, 0.25, 1]
         
         return gradient
     }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gradient.frame = view.bounds
        gradient.zPosition = -10
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 0, y: 0)
        view.layer.addSublayer(gradient)
        
        
        infoLabel.text = "The app is designed to offer an all in one organizer for your daily basis activities (e.g., Calculator, Reminder, Split a bill, Bitcoin currency converter, Euro currency converter, and more).\n\nEnjoy!"
        
        infoLabel.adjustsFontSizeToFitWidth = true
        trackTitle.adjustsFontSizeToFitWidth = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)
    }
    
    @IBAction func playPauseRegognizer(_ sender: UITapGestureRecognizer) {
        
        let url = Bundle.main.url(forResource: "iCountTrack", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        
        if count % 2 == 0 {
            imagePlayer.image = UIImage(systemName: "pause.fill")
            player?.play()
        } else {
            imagePlayer.image = UIImage(systemName: "play.fill")
            player?.pause()
        }
        
        count += 1
    }
}
