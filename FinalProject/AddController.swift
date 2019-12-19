//
//  AddController.swift
//  FinalProject
//
//  Created by Brendan Flood on 12/18/19.
//  Copyright © 2019 Brendan Flood. All rights reserved.
//

import UIKit

class AddController: UIViewController {

     @IBOutlet weak var titleField: UITextField!
        @IBOutlet weak var authorField: UITextField!
        @IBOutlet weak var yearField: UITextField!
        @IBOutlet weak var imageField: UITextField!
        @IBOutlet weak var submitButton: UIButton!
        @IBOutlet weak var endLabel: UILabel!
        
        
        
        @IBAction func buttonClicked(_ sender: UIButton){
            let service = MovieService()
            service.createMovie(book: Movie(title: titleField.text!, author: authorField.text!, year: yearField.text!, image: imageField.text!), completion: {})
            endLabel.isHidden = true
        }
        
        override func viewDidLoad() {
            submitButton.isEnabled = true
            endLabel.isHidden = true
            titleField.placeholder = "Book Title"
            titleField.delegate = self as? UITextFieldDelegate
            authorField.placeholder = "Book Author"
            authorField.delegate = self as? UITextFieldDelegate
            yearField.placeholder = "Release year"
            yearField.delegate = self as? UITextFieldDelegate
            imageField.placeholder = "Cover Image"
            imageField.delegate = self as? UITextFieldDelegate
        }
    }
