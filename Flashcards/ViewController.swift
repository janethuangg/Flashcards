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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapCard(_ sender: Any) {
        if question.isHidden == true {
            question.isHidden = false
        } else {
            question.isHidden = true
        }
    }
}

