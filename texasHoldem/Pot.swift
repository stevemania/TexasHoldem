//
//  Pot.swift
//  Texas Hold em
//
//  Created by STEVE DURAN on 9/20/17.
//  Copyright © 2017 STEVE DURAN. All rights reserved.
//

import Foundation

class Pot {
    private var pot = 0
    
    func addMoney(addToPot: Int){
        pot += addToPot
    }
    
    func getMoney()->Int{
        return pot
    }
    func resetPot(){
        pot = 0
    }
}
