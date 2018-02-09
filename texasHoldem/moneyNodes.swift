//
//  moneyNodes.swift
//  Texas Hold em
//
//  Created by STEVE DURAN on 9/20/17.
//  Copyright © 2017 STEVE DURAN. All rights reserved.
//

import Foundation
import SpriteKit

class Money:SKSpriteNode{
    
    //initializing with 10 dollars with enumeration
    private var moneyNum = moneyDen.ten
    
    init(moneyNum: moneyDen){
        var moneyPicture:SKTexture
        self.moneyNum = moneyNum
        
        //switches money image shown on the screen. Example of enum
        switch moneyNum{
        case .ten:
            moneyPicture = SKTexture(imageNamed: "money10")
        case .twentyFive:
            moneyPicture = SKTexture(imageNamed: "money25")
        case .fifty:
            moneyPicture = SKTexture(imageNamed: "money50")
        }
        
        // edits the image
        super.init(texture: moneyPicture, color: SKColor.clear, size: moneyPicture.size())
        self.name = "chip"
        
    }
    
    
    //ask about this
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //returns
    func getValue()->moneyDen{
        return moneyNum
    }
}
