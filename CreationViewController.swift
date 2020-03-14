//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Janet Huang on 3/11/20.
//  Copyright © 2020 Janet Huang. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {

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
