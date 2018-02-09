//
//  Card.swift
//  Texas Hold em
//
//  Created by STEVE DURAN on 9/20/17.
//  Copyright © 2017 STEVE DURAN. All rights reserved.
//

import Foundation
import SpriteKit

class Card:SKSpriteNode{
    private var suit: String = ""
    private var number: Int = 0
    
    init(suit: String,number: Int){
        self.suit = suit
        self.number = number
        
        //picks up the image from the folder 
        let cardPicture = SKTexture(imageNamed: suit + String(number))
        super.init(texture: cardPicture, color: SKColor.clear, size: CGSize(width: 30, height: 45))
        //cardPicture.size() uses card 
    }
    
    
    
    func getValue()->Int{
        return number
    }
    
    func getSuit()->String{
        return suit
    }
    
    //always needed when working with sprite due to movement on the screen in some sort of way
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
