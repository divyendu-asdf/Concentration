//
//  ViewController.swift
//  Concentration
//
//  Created by Divyendu Sharma on 11/06/18.
//  Copyright © 2018 Divyendu Sharma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
   lazy var game = Concentration(numbersOfPairsOfCards: (cardButtons.count + 1)/2)
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "\(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    
    @IBAction func newGame(_ sender: UIButton) {
        
        flipCount = 0
        game.resetGame()
        updateViewFromModel()
        
    }
    
   
    @IBAction func touchCard(_ sender: UIButton) {
        
        
        if let cardNumber = cardButtons.index(of: sender), !game.cards[cardButtons.index(of: sender)!].isMatched,!game.cards[cardButtons.index(of: sender)!].isFaceUp {
            flipCount += 1
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen Card was not in card Buttons")
        }
        
        
    }
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for : card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.4993680977, blue: 0.1024409871, alpha: 1)
            }
        }
        
    }
    var emojiChoicesHaloween =  ["🧟‍♂️","👻","🎃","🎩","🕷","🐞","👽","☠️"]
    var emojiChoicesFruits = ["🍏","🍒","🍓","🍑","🍇","🍎","🍍","🥝"]
    var emojiChoicesFaces = ["😀","😅","🤩","😎","😡","🤠","😪","🤑"]
 
    var emojiArray = [["🧟‍♂️","👻","🎃","🎩","🕷","🐞","👽","☠️"],["🍏","🍒","🍓","🍑","🍇","🍎","🍍","🥝"],["😀","😅","🤩","😎","😡","🤠","😪","🤑"]]
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil ,emojiChoicesHaloween.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoicesHaloween.count)))
            emoji[card.identifier] = emojiChoicesHaloween.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
}

