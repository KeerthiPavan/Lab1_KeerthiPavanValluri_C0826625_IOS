//
//  ViewController.swift
//  Lab1_KeerthiPavanValluri_C0826625_IOS
//
//  Created by Keerthi Pavan Valluri on 2022-01-17.
//

import UIKit

class ViewController: UIViewController {
    
    var player = 1
    var player1Score: Int = 0
    var player2Score: Int = 0
    var state = [0,0,0,0,0,0,0,0,0]
    var position = 0
    let winComb = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    var gameActive: Bool = true
    var no1Wons: Bool = true
    
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var player1ScoreLabel: UILabel!
    @IBOutlet weak var player2ScoreLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipedUp))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
        
        gameLabel.text = "Game Ongoing"
        becomeFirstResponder()
        
    }
    
    override var canBecomeFirstResponder: Bool{
        return true
    }
    
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            print("shaked")
            let button = view.viewWithTag(position) as! UIButton
            button.setImage(nil, for: .normal)
            state[position-1] = 0
            button.isEnabled = true
            player-=1
        }
    }
    
    @IBAction func tapBtn(_ sender: UIButton) {
        
        position = sender.tag
        
        if (state[sender.tag-1] == 0 && gameActive == true){
            
            state[sender.tag-1] = player
            if (player == 1){
                //sender.setTitle("X", for: .normal)
                sender.setImage(UIImage(named: "cross"), for: .normal)
                print("Button Pressed")
                player = 2
            }
            else{
                
                //sender.setTitle("O", for: .normal)
                sender.setImage(UIImage(named: "circle"), for: .normal)
                sender.isHidden = false
                player = 1
            }
            
        }
        
        
        
        for i in winComb{
            if state[i[0]] != 0 && state[i[0]] == state[i[1]] && state[i[1]] == state[i[2]] {
                gameActive = false
                if state[i[0]] == 1{
                    gameLabel.text = "Player X won"
                    player1Score += 1
                    player1ScoreLabel.text = String(player1Score)
                    no1Wons = false
                    for i in 1...9{
                        let button = view.viewWithTag(i) as! UIButton
                        button.isEnabled = false
                        //button.setTitle(" ", for: .normal)
                    }
                }
                else {
                    gameLabel.text = "Player O won"
                    player2Score += 1
                    player2ScoreLabel.text = String(player2Score)
                    no1Wons = false
                    for i in 1...9{
                        let button = view.viewWithTag(i) as! UIButton
                        button.isEnabled = false
                        //button.setTitle(" ", for: .normal)
                    }
                }
            }
            
        }
        
        if(no1Wons){
            gameActive = false
            for i in state{
                if i == 0{
                    gameActive = true
                    no1Wons = true
                    break
                }
            }
            if gameActive == false{
                gameLabel.text = "Game Ended - Players are Even"
                for i in 1...9{
                    let button = view.viewWithTag(i) as! UIButton
                    button.isEnabled = false
                    //button.setTitle(" ", for: .normal)
                }
                
            }
        }
        
        
        
        
    }
    
    @objc func swipedUp(_ sender: UISwipeGestureRecognizer) {
        print("gesture Recog")
        no1Wons = true
        state = [0,0,0,0,0,0,0,0,0]
        gameActive = true
        player = 1
        gameLabel.text = "New Game"
//        player1ScoreLabel.text = "0"
//        player1ScoreLabel.text = "0"
        for i in 1...9{
            let button = view.viewWithTag(i) as! UIButton
            button.setImage(nil, for: .normal)
            button.isEnabled = true
            //button.setTitle(" ", for: .normal)
        }
    }
    
}

