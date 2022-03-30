//
//  ViewController.swift
//  egg_timer
//
//  Created by Goh Yuhan on 2022/03/30.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    let eggTimer = ["Soft":300.0, "Medium":420.0, "Hard":720.0]
    
    var remainingSecond = 0.0
    var choosedHardness = ""
    var player: AVAudioPlayer!
    var timer = Timer()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timerBar: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        timerBar.progress = 0.0
        let hardness = sender.currentTitle!
        remainingSecond = eggTimer[hardness]!
        choosedHardness = hardness
        self.titleLabel.text = hardness
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc func timerAction(){
        if remainingSecond>0.0{
            let percent = Float(remainingSecond/eggTimer[choosedHardness]!)
            timerBar.progress = Float(1-percent)
            remainingSecond-=1.0
        }else{
            timer.invalidate()
            timerBar.progress = 1.0
            titleLabel.text = "Done!"
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()

        }
    }
    
   
}

