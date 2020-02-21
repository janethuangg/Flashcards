//
//  ViewController.swift
//  Flashcards
//
//  Created by Janet Huang on 2/21/20.
//  Copyright © 2020 Janet Huang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var answer: UILabel!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var opt1: UIButton!
    @IBOutlet weak var opt2: UIButton!
    @IBOutlet weak var opt3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        card.layer.cornerRadius = 20.0
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.2
        
        answer.layer.cornerRadius = 20.0
        question.layer.cornerRadius = 20.0
        answer.clipsToBounds = true
        question.clipsToBounds = true
        
        opt1.layer.borderWidth = 3.0
        opt1.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        opt1.layer.cornerRadius = 20.0
        opt2.layer.borderWidth = 3.0
        opt2.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        opt2.layer.cornerRadius = 20.0
        opt3.layer.borderWidth = 3.0
        opt3.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        opt3.layer.cornerRadius = 20.0
    }

    @IBAction func didTapCard(_ sender: Any) {
        if question.isHidden == true {
            question.isHidden = false
        } else {
            question.isHidden = true
        }
    }
    
    @IBAction func didTapOpt1(_ sender: Any) {
        opt1.layer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        opt1.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        opt1.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: [])
    }
    
    @IBAction func didTapOpt2(_ sender: Any) {
        opt1.layer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        opt1.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        opt1.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: [])
        
        opt2.layer.backgroundColor = #colorLiteral(red: 0.2393075824, green: 0.6728859544, blue: 0.9679804444, alpha: 1)
        opt2.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: [])
        
        opt3.layer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        opt3.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        opt3.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: [])
        
        question.isHidden = true
    }
    
    @IBAction func didTapOpt3(_ sender: Any) {
        opt3.layer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        opt3.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        opt3.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: [])
    }
}

