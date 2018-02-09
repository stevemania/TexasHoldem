//
//  GameViewController.swift
//  texHoldem
//
//  Created by STEVE DURAN on 9/25/17.
//  Copyright © 2017 STEVE DURAN. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pokerTableImg = GameScene(size:CGSize(width: 640, height: 322))
        let skView = self.view as! SKView
        
        //turnsof
        skView.showsFPS = false
        skView.showsNodeCount = false
        skView.ignoresSiblingOrder = false
        pokerTableImg.scaleMode = .aspectFill
        skView.presentScene(pokerTableImg)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
