//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Janet Huang on 3/11/20.
//  Copyright © 2020 Janet Huang. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var opt1TextField: UITextField!
    @IBOutlet weak var opt2TextField: UITextField!
    @IBOutlet weak var opt3TextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    var initialQuestion: String?
    var initialAnswer: String?
    var initialOpt1: String?
    var initialOpt2: String?
    var initialOpt3: String?
    
    var flashcardsController: ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionTextField.text = initialQuestion
        answerTextField.text = initialAnswer
        opt1TextField.text = initialOpt1
        opt2TextField.text = initialOpt2
        opt3TextField.text = initialOpt3
        // Do any additional setup after loading the view.
        
        opt1TextField.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        opt1TextField.layer.borderWidth = 3.0
        opt1TextField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        opt2TextField.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        opt2TextField.layer.borderWidth = 3.0
        opt2TextField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        opt3TextField.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        opt3TextField.layer.borderWidth = 3.0
        opt3TextField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        answerTextField.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        answerTextField.layer.borderWidth = 3.0
        answerTextField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        questionTextField.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        questionTextField.layer.borderWidth = 3.0
        questionTextField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        self.answerTextField.delegate = self
        self.questionTextField.delegate = self
        self.opt1TextField.delegate = self
        self.opt2TextField.delegate = self
        self.opt3TextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        let questionText = questionTextField.text
        let opt1Text = opt1TextField.text
        let opt2Text = opt2TextField.text
        let opt3Text = opt3TextField.text
        let answerText = answerTextField.text
        
        if (questionText == nil || answerText == nil || questionText!.isEmpty || answerText!.isEmpty){
            let alert = UIAlertController(title: "Missing text", message: "Fill out all fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            }))
            present(alert, animated: true)
        } else if (answerText != opt1Text && answerText != opt2Text && answerText != opt3Text){
            let alert = UIAlertController(title: "Invalid answer", message: "Make sure answer matches one of the options", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            }))
            present(alert, animated: true)
        } else {
            var isExisting = false
            
            if initialQuestion != nil {
                isExisting = true
            }
            flashcardsController.updateCard(newQuestion: questionText!, newOpt1: opt1Text!, newOpt2: opt2Text!, newOpt3: opt3Text!, newAnswer: answerText!, isExisting: isExisting)
            dismiss(animated: true)
        }
    }
}
