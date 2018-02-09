//
//  Deck.swift
//  Texas Hold em
//
//  Created by STEVE DURAN on 9/20/17.
//  Copyright © 2017 STEVE DURAN. All rights reserved.
//

import Foundation

class Deck {
    private var deck = [Card]()
    private var deckCounter = -1
    
    init(){
        createDeck()
    }
    
    func createDeck(){
        let suits = ["c","s","h","d"]
        for suitOfCard in suits{
            for cardValue in 1...13{
                let tempCard = Card(suit: suitOfCard ,number: cardValue )
                deck.append(tempCard)
            }
        }
    }
    
    //keeps track of cards in the deck
    func getCard()->Card{
        deckCounter += 1
        return deck[deckCounter]
    }
    
    //shuffle the deck
    func shuffle(){
        //deck.shuffle()
    }
    
    
    func resetDeck(){
        deckCounter = -1
       // shuffle()
    }
    
}
