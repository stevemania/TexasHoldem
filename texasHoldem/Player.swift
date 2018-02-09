//
//  Player.swift
//  Texas Hold em
//
//  Created by STEVE DURAN on 9/20/17.
//  Copyright © 2017 STEVE DURAN. All rights reserved.
//

import Foundation

class PlayerControl: Player {
    var playersMoney: playersMoney
    private var playerBets = false
    private var playerCheck = false
    
    
    init(hand: Hand, playersMoney: playersMoney){
        self.playersMoney = playersMoney
        super.init(hand:hand)
    }
    
    func setCheck(check: Bool){
        self.playerCheck = check
    }
    
    func isChecking()->Bool{
        return playerCheck
    }
    
    func setBet(bet: Bool){
        self.playerBets = bet
    }
    
    func isBetting()->Bool {
        return playerBets
    }
    
}
