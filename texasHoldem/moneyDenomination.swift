//
//  moneyDenomination.swift
//  Texas Hold em
//
//  Created by STEVE DURAN on 9/20/17.
//  Copyright © 2017 STEVE DURAN. All rights reserved.
//


import Foundation

enum moneyDen: Int {
    case ten = 10
    case twentyFive = 25
    case fifty = 50
}

enum winningHand: Int {
    case royalFlush = 1
    case straightFlush = 2
    case FourOfKind = 3
    case fullHouse = 4
    case flush = 5
    case straight = 6
    case threeOfKind = 7
    case twoPair = 8
    case pair = 9
    case highCard = 10
    
}
