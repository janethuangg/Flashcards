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
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    var flashcards = [Flashcard]()
    var currentIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        readFlashcardsFromDisk()
        
        card.layer.cornerRadius = 20.0
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.2
        
        answer.layer.cornerRadius = 20.0
        question.layer.cornerRadius = 20.0
        answer.clipsToBounds = true
        question.clipsToBounds = true
        
        updateNextPrevButtons()
        
        if flashcards.count == 0{
            opt1.isHidden = true
            opt2.isHidden = true
            opt3.isHidden = true
            answer.isHidden = true
            question.isHidden = false
            deleteButton.isHidden = true
            editButton.isHidden = true
            question.text = "create card below"
        } else {
            currentIndex = 0
            format()
            updateLabels()
            updateNextPrevButtons()
        }
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
        if flashcards.count != 0 {
            if question.isHidden == true {
                question.isHidden = false
            } else {
                question.isHidden = true
            }
        }
    }
    
    func format(){
        opt1.isHidden = false
        opt1.layer.borderWidth = 3.0
        opt1.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        opt1.layer.cornerRadius = 20.0
        opt1.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        opt1.setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: [])
        
        opt2.isHidden = false
        opt2.layer.borderWidth = 3.0
        opt2.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        opt2.layer.cornerRadius = 20.0
        opt2.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        opt2.setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: [])
        
        opt3.isHidden = false
        opt3.layer.borderWidth = 3.0
        opt3.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        opt3.layer.cornerRadius = 20.0
        opt3.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        opt3.setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: [])
        
        question.isHidden = false
        answer.isHidden = false
        deleteButton.isHidden = false
        editButton.isHidden = false
    }
    
    func updateCard(newQuestion: String, newOpt1: String, newOpt2: String, newOpt3: String, newAnswer:String, isExisting: Bool) {
        let flashcard = Flashcard(question: newQuestion, answer: newAnswer, opt1: newOpt1, opt2: newOpt2, opt3: newOpt3)
        
        question.text = flashcard.question
        answer.text = flashcard.answer
        opt1.setTitle(flashcard.opt1, for: .normal)
        opt2.setTitle(flashcard.opt2, for: .normal)
        opt3.setTitle(flashcard.opt3, for: .normal)
        
        format()
        
        if isExisting {
            flashcards[currentIndex] = flashcard
        } else {
            flashcards.append(flashcard)
            print("added new flashcard")
            print("we now have \(flashcards.count) flashcards")
            currentIndex = flashcards.count-1
            print("our current index is \(currentIndex)")
        }
        saveFlashcardsToDisk()
        updateNextPrevButtons()
        updateLabels()
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
    
    @IBAction func didTapDelete(_ sender: Any) {
        let alert = UIAlertController(title: "Delete flashcard", message: "Are you sure you want to delete this card?", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: {action in self.deleteCurrentCard()})
        
        alert.addAction(deleteAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    
    
    func deleteCurrentCard(){
        flashcards.remove(at: currentIndex)
        
        if currentIndex > flashcards.count - 1{
            currentIndex = flashcards.count - 1
        }
        
        updateLabels()
        updateNextPrevButtons()
        saveFlashcardsToDisk()
    }
    
    
    func updateLabels() {
        if currentIndex == -1 {
            card.layer.cornerRadius = 20.0
            card.layer.shadowRadius = 15.0
            card.layer.shadowOpacity = 0.2
            
            answer.layer.cornerRadius = 20.0
            question.layer.cornerRadius = 20.0
            answer.clipsToBounds = true
            question.clipsToBounds = true
            
            opt1.isHidden = true
            opt2.isHidden = true
            opt3.isHidden = true
            answer.isHidden = true
            question.isHidden = false
            deleteButton.isHidden = true
            editButton.isHidden = true
            question.text = "create card below"
        } else {
            let currentFlashcard = flashcards[currentIndex]
            question.text = currentFlashcard.question
            answer.text = currentFlashcard.answer
            opt1.setTitle(currentFlashcard.opt1, for: .normal)
            opt2.setTitle(currentFlashcard.opt2, for: .normal)
            opt3.setTitle(currentFlashcard.opt3, for: .normal)
        }
    }
    
    func updateNextPrevButtons(){
        if currentIndex == -1 {
            print("working")
            prevButton.isEnabled = false
            nextButton.isEnabled = false
        } else {
            if currentIndex == flashcards.count-1{
                nextButton.isEnabled = false
            } else {
                nextButton.isEnabled = true
            }
            
            if currentIndex == 0 {
                prevButton.isEnabled = false
            } else {
                prevButton.isEnabled = true
            }
        }        
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


