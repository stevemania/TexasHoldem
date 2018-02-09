//
//  playersMoney.swift
//  Texas Hold em
//
//  Created by STEVE DURAN on 9/20/17.
//  Copyright © 2017 STEVE DURAN. All rights reserved.
//

import Foundation
import Foundation

class playersMoney {
    var balance = 600
    
    init(){
        
    }

//resets balance
func resetBalance(){
    balance = 600
}

//add funds to players bank
func addPlayerMoney(addAmount: Int){
    balance += addAmount
}

//subtract from players bank
func subPlayerMoney (subAmount: Int){
    balance -= subAmount
    if (balance < 10){
        resetBalance()
    }
}

//gets back the players money
func getPlayerMoney()->Int{
    return balance
}

}
