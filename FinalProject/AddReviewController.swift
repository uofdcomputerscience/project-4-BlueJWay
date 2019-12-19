//
//  AddReviewController.swift
//  FinalProject
//
//  Created by Brendan Flood on 12/18/19.
//  Copyright © 2019 Brendan Flood. All rights reserved.
//

import UIKit

class AddReviewController: ViewController {
        @IBOutlet weak var titleField: UITextField!
        @IBOutlet weak var reviewerField: UITextField!
        @IBOutlet weak var bodyField: UITextField!
    @IBOutlet weak var ratingField: UITextField!
        @IBOutlet weak var submitButton: UIButton!
        
        
        
        @IBAction func buttonClicked(_ sender: UIButton){
            let service = ReviewService()
            service.createReview(review: Review(reviewer: reviewerField.text!, title: titleField.text!, body: bodyField.text!), completion: {})
        }
        
        override func viewDidLoad() {
            submitButton.isEnabled = true
            
            titleField.placeholder = "Movie Title"
            titleField.delegate = self as? UITextFieldDelegate
            reviewerField.placeholder = "Review Author"
            reviewerField.delegate = self as? UITextFieldDelegate
            
            
            bodyField.placeholder = "Type your review"
            bodyField.delegate = self as? UITextFieldDelegate
        }
        
        
        
        
    }
