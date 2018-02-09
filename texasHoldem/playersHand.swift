//
//  playersHand.swift
//  Texas Hold em
//
//  Created by STEVE DURAN on 9/20/17.
//  Copyright © 2017 STEVE DURAN. All rights reserved.
//

import Foundation


class Hand {
    //array of card objects
    private var hand = [Card]()
    
    //adds a new card
    func addCard(tempCard: Card){
        hand.append(tempCard)
    }
    
    
    //resets the hand
    func resetHand(){
        //deletes the player hand
        hand.removeAll()
    }
    
}
