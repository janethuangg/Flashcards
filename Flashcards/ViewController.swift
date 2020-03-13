//
//  ViewController.swift
//  Flashcards
//
//  Created by Janet Huang on 2/21/20.
//  Copyright © 2020 Janet Huang. All rights reserved.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
    var opt1: String
    var opt2: String
    var opt3: String
}

class ViewController: UIViewController {

    @IBOutlet weak var answer: UILabel!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var opt1: UIButton!
    @IBOutlet weak var opt2: UIButton!
    @IBOutlet weak var opt3: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    
    var flashcards = [Flashcard]()
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        readFlashcardsFromDisk()
        
        if flashcards.count == 0{
              updateCard(newQuestion: "What's the capital of Brazil?", newOpt1: "Brasilia", newOpt2: "Rio de Janeiro", newOpt3: "Sao Paulo", newAnswer: "Brasilia")
        } else {
            updateLabels()
            updateNextPrevButtons()
        }
        
        format()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashcardsController = self
        
        if segue.identifier == "EditSegue"{
            creationController.initialQuestion = question.text
            creationController.initialAnswer = answer.text
            creationController.initialOpt1 = opt1.currentTitle
            creationController.initialOpt2 = opt2.currentTitle
            creationController.initialOpt3 = opt3.currentTitle
        }
    }

    @IBAction func didTapCard(_ sender: Any) {
        if question.isHidden == true {
            question.isHidden = false
        } else {
            question.isHidden = true
        }
    }
    
    func format(){
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
        opt1.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        opt1.setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: [])
        
        opt2.layer.borderWidth = 3.0
        opt2.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        opt2.layer.cornerRadius = 20.0
        opt2.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        opt2.setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: [])
        
        opt3.layer.borderWidth = 3.0
        opt3.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        opt3.layer.cornerRadius = 20.0
        opt3.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        opt3.setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: [])
        
        question.isHidden = false
    }
    
    func updateCard(newQuestion: String, newOpt1: String, newOpt2: String, newOpt3: String, newAnswer:String) {
        let flashcard = Flashcard(question: newQuestion, answer: newAnswer, opt1: newOpt1, opt2: newOpt2, opt3: newOpt3)
        
        question.text = flashcard.question
        answer.text = flashcard.answer
        opt1.setTitle(flashcard.opt1, for: .normal)
        opt2.setTitle(flashcard.opt2, for: .normal)
        opt3.setTitle(flashcard.opt3, for: .normal)
        
        format()
        
        flashcards.append(flashcard)
        print("added new flashcard")
        print("we now have \(flashcards.count) flashcards")
        currentIndex = flashcards.count-1
        print("our current index is \(currentIndex)")
        
        saveFlashcardsToDisk()
        updateNextPrevButtons()
        updateLabels()
    }
    
    func updateNextPrevButtons(){
        if currentIndex == flashcards.count-1{
            print("end")
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
        
        if currentIndex == 0{
            prevButton.isEnabled = false
        } else {
            prevButton.isEnabled = true
        }
    }
    
    @IBAction func didTapOpt1(_ sender: Any) {
        if answer.text == opt1.currentTitle{
            opt1.layer.backgroundColor = #colorLiteral(red: 0.2393075824, green: 0.6728859544, blue: 0.9679804444, alpha: 1)
            opt1.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: [])
            
            opt2.layer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            opt2.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            opt2.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: [])
            
            opt3.layer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            opt3.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            opt3.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: [])
            
            question.isHidden = true
        } else {
            opt1.layer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            opt1.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            opt1.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: [])
        }
    }
    
    @IBAction func didTapOpt2(_ sender: Any) {
        if answer.text == opt2.currentTitle{
            opt2.layer.backgroundColor = #colorLiteral(red: 0.2393075824, green: 0.6728859544, blue: 0.9679804444, alpha: 1)
            opt2.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: [])
            
            opt1.layer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            opt1.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            opt1.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: [])
            
            opt3.layer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            opt3.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            opt3.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: [])
            
            question.isHidden = true
        } else {
            opt2.layer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            opt2.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            opt2.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: [])
        }
    }
    
    @IBAction func didTapOpt3(_ sender: Any) {
        if answer.text == opt3.currentTitle{
            opt3.layer.backgroundColor = #colorLiteral(red: 0.2393075824, green: 0.6728859544, blue: 0.9679804444, alpha: 1)
            opt3.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: [])
            
            opt1.layer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            opt1.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            opt1.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: [])
            
            opt2.layer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            opt2.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            opt2.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: [])
            
            question.isHidden = true
        } else {
            opt3.layer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            opt3.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            opt3.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: [])
        }
    }
    
    @IBAction func didTapNext(_ sender: Any) {
        currentIndex = currentIndex + 1
        updateLabels()
        updateNextPrevButtons()
        format()
    }
    
    @IBAction func didTapPrev(_ sender: Any) {
        currentIndex = currentIndex - 1
        updateLabels()
        updateNextPrevButtons()
        format()
    }
    
    func updateLabels() {
        let currentFlashcard = flashcards[currentIndex]
        
        question.text = currentFlashcard.question
        answer.text = currentFlashcard.answer
        opt1.setTitle(currentFlashcard.opt1, for: .normal)
        opt2.setTitle(currentFlashcard.opt2, for: .normal)
        opt3.setTitle(currentFlashcard.opt3, for: .normal)
    }
    
    func saveFlashcardsToDisk(){
        let dictionaryArray = flashcards.map{ (card) -> [String: String] in return ["question" : card.question, "opt1": card.opt1, "opt2": card.opt2, "opt3": card.opt3, "answer": card.answer]
        }
        
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
    }
    
    func readFlashcardsFromDisk(){
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String:String]]{
            let savedCards = dictionaryArray.map{ dictionary -> Flashcard in return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!, opt1: dictionary["opt1"]!, opt2: dictionary["opt2"]!, opt3: dictionary["opt3"]!)
            }
            flashcards.append(contentsOf: savedCards)
        }
    }
}


