//
//  GameScene.swift
//  texHoldem
//
//  Created by STEVE DURAN on 9/20/17.
//  Copyright © 2017 STEVE DURAN. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreGraphics

class GameScene: SKScene {
    
    //creating spride nodes
    let moneyHolder = SKSpriteNode(color: .clear, size: CGSize(width: 100, height:80))
    let dealButton = SKSpriteNode(imageNamed: "dealButton")
    let hitButton = SKSpriteNode(imageNamed: "hitButton")
    let checkButton = SKSpriteNode(imageNamed: "checkButton")
    let currency10 = Money(moneyNum: .ten)
    let currency25 = Money(moneyNum: .twentyFive)
    let currency50 = Money(moneyNum: .fifty)
    let pot = Pot()
    var potAmount : Int = 0
    var gamblerHand = [Card]()
    var dealerHand = [Card]()
    let potLabel = SKLabelNode(text: "Place your Bet")
    let gamblerBankLabel = SKLabelNode(text: "Your Bank: $600")
    let gamblerCardLabel = SKLabelNode(text: "Your Cards")
    var flushCount = [0,0,0,0]
    var cardCount = [Card]() //array of sprites cards
    var cardsInPlayPositionX = 230 //cards in play x position
    var gamblerCardInPlayPositonX = 230 // gamblers cards in play x position
    var gamblerLabelPostionX = 274 //gamblers label position x(width)
    var gamblerBankLabelPositionX = 350
    let deck = Deck() //creates new deck
    var handPlacement = winningHand.highCard
    var dealerPlacement = winningHand.pair
    
    
    
    
    
    
    //initiazlied dealer and gambler
    let gambler = PlayerControl(hand: Hand(),playersMoney: playersMoney())
    let dealer  = Player(hand: Hand()) //dealer does not need money
    
    
    override func didMove(to view: SKView){
        pokerTable()
        displayMoney()
        displayAction()
    }
    
    // setting up poker table
    func pokerTable(){
        // we will be placing the image on the screen
        let table = SKSpriteNode(imageNamed: "pokerTable")
        
        //addChild adds to the scene
        addChild(table)
        table.position = CGPoint(x:size.width/2 ,y:size.height/2)
        
        //controls order which nodes get drawn on the view. Lowest first
        table.zPosition = -1
        addChild(moneyHolder)
        moneyHolder.anchorPoint = CGPoint(x:0,y:0)
        moneyHolder.position = CGPoint(x: size.width/2 - 50, y: size.height/2 + 50)
        
        //placing pot label to table and changing feat
        potLabel.fontColor = UIColor.white
        potLabel.fontName = "AvenirNext-Bold"
        potLabel.fontSize = 14
        addChild(potLabel)
        potLabel.position = CGPoint(x:size.width/2, y: 200)
        
        //placing gamblers card label
        gamblerCardLabel.fontSize = 8
        gamblerCardLabel.fontName = "AvenirNext-Bold"
        addChild(gamblerCardLabel)
        gamblerCardLabel.position = CGPoint(x: gamblerLabelPostionX, y: 105)
        gamblerCardLabel.isHidden = true
        
        //placing gamblerBankLabel
        gamblerBankLabel.fontSize = 8
        gamblerBankLabel.fontName = "AvenirNext-Bold"
        addChild(gamblerBankLabel)
        gamblerBankLabel.position = CGPoint(x: gamblerBankLabelPositionX, y: 105)
        
        deck.createDeck()
    }
    
    //creating sprite nodes for the money
    func displayMoney(){
        addChild(currency10)
        currency10.position = CGPoint(x: 260, y: 25)
        
        addChild(currency25)
        currency25.position = CGPoint(x: 320, y: 25)
        
        addChild(currency50)
        currency50.position = CGPoint(x: 380, y: 25 )
    }
    
    //creating sprite node for the deal, hit check buttons
    func displayAction(){
        dealButton.name = "dealButton"
        addChild(dealButton)
        dealButton.position = CGPoint(x:260, y: 300)
        
        checkButton.name = "checkBtn"
        addChild(checkButton)
        checkButton.position = CGPoint(x:320, y: 300)
        checkButton.isHidden = true
        
        hitButton.name = "hitBtn"
        addChild(hitButton)
        hitButton.position = CGPoint(x:380, y:300 )
        hitButton.isHidden = true
        
    }
    
    func bet(betAmount: moneyDen ){
        
        if(betAmount.rawValue > gambler.playersMoney.getPlayerMoney()){
            print("You do not have enough money");
            return
        }else{
            pot.addMoney(addToPot: betAmount.rawValue * 2)
            let tempMoney = Money(moneyNum: betAmount)
            tempMoney.anchorPoint = CGPoint(x:0, y:0)
            moneyHolder.addChild(tempMoney)
            tempMoney.position = CGPoint(x:CGFloat(arc4random_uniform(UInt32(moneyHolder.size.width - tempMoney.size.width))), y: CGFloat(arc4random_uniform(UInt32(moneyHolder.size.height - tempMoney.size.height))))
            
        }
    }
    
    //method is called when screen is touched.Multitouch is  false therefore single tap
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        
        //used to transfer program control out of a scope if one or more conditions arent met
        guard let mouseClick = touches.first else {
            return
        }
        
        // retrieves location clicked and loads node
        let screenClickLocation = mouseClick.location(in: self)
        let spriteClicked = self.atPoint(screenClickLocation)
        
        
        //checking if one of the chips was clicked
        if spriteClicked.name == "chip" {
            let chip = spriteClicked as! Money //downcasting
            bet(betAmount: chip.getValue())
        }
        
        if(spriteClicked.name == "dealButton"){
            deal()
        }
        if(spriteClicked.name == "hitBtn"){
            deal()
        }
        if(spriteClicked.name == "chkBtn"){
            gambler.setCheck(check: true)
            print(gambler.isChecking())
            deal()
        }
    }
    
    func deal(){
        
        dealButton.isHidden = true;
        checkButton.isHidden = false
        hitButton.isHidden = false
        gamblerCardLabel.isHidden = false
        
        //retrieving pot amount to update
        potAmount = pot.getMoney()
        var potTempString = "Pot: "
        potTempString += String(potAmount)
        potLabel.text = potTempString
        
        // deal the cards out to players and table. First Round
        if (cardCount.isEmpty == true){
            for count in 0...6 {
                if(count < 2){
                    let tempCard = deck.getCard()
                    dealerHand.append(tempCard)
                    
                }else if count == 2 || count < 4{
                    let tempCard = deck.getCard()
                    gamblerHand.append(tempCard)
                    gamblerCardInPlayPositonX = gamblerCardInPlayPositonX + 30
                    tempCard.position = CGPoint(x: gamblerCardInPlayPositonX, y: 80)
                    addChild(tempCard)
                }else{
                    let tempCard = deck.getCard()
                    cardCount.append(tempCard)
                    cardsInPlayPositionX = cardsInPlayPositionX + 30
                    tempCard.position = CGPoint(x: cardsInPlayPositionX, y: 168)
                    addChild(tempCard)
                }
                
            }
            
        }else if cardCount.count < 5 && gambler.isChecking() != true{ //playing is betting but not yeilding
            let tempCard = deck.getCard()
            cardCount.append(tempCard)
            cardsInPlayPositionX = cardsInPlayPositionX + 30 //incrementing sprite x coordinate. (width)
            tempCard.position = CGPoint(x: cardsInPlayPositionX, y: 168)
            addChild(tempCard)
        }
        else if cardCount.count < 5 && gambler.isChecking() == true{ //yielding
            let tempCard = deck.getCard()
            cardCount.append(tempCard)
            cardsInPlayPositionX = cardsInPlayPositionX + 30 //incrementing sprite x coordinate. (width)
            tempCard.position = CGPoint(x: cardsInPlayPositionX, y: 168)
            addChild(tempCard)
        }
        
        //comparing dealers hand with gamblers hand
        if cardCount.count == 5{
            comparingHands()
            
            if self.handPlacement.rawValue < self.dealerPlacement.rawValue {
                switch(handPlacement){
                case .flush:
                    print("You have a flush")
                    gambler.playersMoney.addPlayerMoney(addAmount: pot.getMoney()) //adding money to Bank
                    sleep(10)
                case .FourOfKind:
                    print("You have a 4kind")
                    gambler.playersMoney.addPlayerMoney(addAmount: pot.getMoney())
                    sleep(10)
                case .fullHouse:
                    print("You have a fullHouse")
                    gambler.playersMoney.addPlayerMoney(addAmount: pot.getMoney())
                    sleep(10)
                case .highCard:
                    print("You have a highCard")
                    gambler.playersMoney.addPlayerMoney(addAmount: pot.getMoney())
                    sleep(10)
                case .pair:
                    print("You have a pair")
                    gambler.playersMoney.addPlayerMoney(addAmount: pot.getMoney())
                    sleep(10)
                case .royalFlush:
                    print("You have a royalFlush")
                    gambler.playersMoney.addPlayerMoney(addAmount: pot.getMoney())
                    sleep(10)
                case .straight:
                    print("You have a straight")
                    gambler.playersMoney.addPlayerMoney(addAmount: pot.getMoney())
                    sleep(10)
                case .straightFlush:
                    print("You have a starightFlush")
                    gambler.playersMoney.addPlayerMoney(addAmount: pot.getMoney())
                    sleep(10)
                case .threeOfKind:
                    print("You have a 3kind")
                    gambler.playersMoney.addPlayerMoney(addAmount: pot.getMoney())
                    sleep(10)
                case .twoPair:
                    print("You have a 2pair")
                    gambler.playersMoney.addPlayerMoney(addAmount: pot.getMoney())
                    sleep(10)
                }
            }else{
                switch(dealerPlacement){
                case .flush:
                    print("Dealer Won with flush")
                case .FourOfKind:
                    print("Dealer Won with 4kind")
                case .fullHouse:
                    print("Dealer Won with fullHouse")
                case .highCard:
                    print("Dealer Won with highCard")
                case .pair:
                    print("Dealer Won with pair")
                case .royalFlush:
                    print("Dealer Won with royalFlush")
                case .straight:
                    print("Dealer Won with straight")
                case .straightFlush:
                    print("Dealer Won with starightFlush")
                case .threeOfKind:
                    print("Dealer Won with 3kind")
                case .twoPair:
                    print("Dealer Won with 2pair")
                }
            }
        }
    }
    
    //start a new game
    func resetGame(){
        deck.resetDeck()
        potLabel.text = "Place your bet"
        dealButton.isHidden = false
        hitButton.isHidden = true
        checkButton.isHidden = true
        gamblerCardLabel.isHidden = true
        currency10.isHidden = true
        currency25.isHidden = true
        currency50.isHidden = true
        resetMoneyContainer()
        
        //deleting all hands
        gamblerHand.removeAll()
        dealerHand.removeAll()
        cardCount.removeAll()
    }
    
    //removing money from the container box
    func resetMoneyContainer (){
        moneyHolder.removeAllChildren()
    }
    func comparingHands(){
        //var tempNum = 0
        var tempDeckDealer = [Card]()
        var tempDeckGambler = [Card]()
        tempDeckDealer  = cardCount
        tempDeckGambler = cardCount
        
        tempDeckDealer += dealerHand
        tempDeckGambler += gamblerHand
        
        //========================================
        //checking for flush
        for index in 0..<7{
            if (tempDeckGambler[index].getSuit() == "c"){
                flushCount[0] += 1
                //   print("Club \(index+1)) \(flushCount[0]) the card is \(tempDeckGambler[index].getSuit()) \(tempDeckGambler[index].getValue()) ")
            }else if(tempDeckGambler[index].getSuit() == "h"){
                flushCount[1] += 1
            }else if(tempDeckGambler[index].getSuit() == "s"){
                flushCount[2] += 1
            }else if(tempDeckGambler[index].getSuit() == "d"){
                flushCount[3] += 1
            }
        }
        
        for index in 0..<4{
            if (flushCount[index] >= 5){
                handPlacement = .flush
                return
            }
        }
        //===========================================
        
        
    }
    
}

