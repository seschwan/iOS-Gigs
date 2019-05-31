//
//  GigDetailVC.swift
//  iOSGigs
//
//  Created by Seschwan on 5/30/19.
//  Copyright © 2019 Seschwan. All rights reserved.
//

import UIKit

class GigDetailVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var jobTitleTextField:    UITextField!
    @IBOutlet weak var datePicker:           UIDatePicker!
    @IBOutlet weak var descriptionTextField: UITextView!
    
    var gigController: GigController?
    var gig: Gig?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        
    }
    
    private func updateViews() {
        guard let gig = gig else {
            title = "New Gig"
            return
        }
        title = gig.title
        jobTitleTextField.text = gig.title
        datePicker.date = gig.dueDate
        descriptionTextField.text = gig.description
        
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        descriptionTextField.isEditable = false
    }
    
    // MARK: - Actions
    
    @IBAction func saveBtnPressed(_ sender: UIBarButtonItem) {
        view.endEditing(true)
        guard let gigTitle = jobTitleTextField.text, !gigTitle.isEmpty,
            let gigDescription = descriptionTextField.text, !gigDescription.isEmpty else { return }
        
        let gigDueDate = datePicker.date
        let gig = Gig(title: gigTitle, dueDate: gigDueDate, description: gigDescription)
        
        gigController?.createAGig(gig: gig, completion: { (error) in
            if let error = error {
                NSLog("Error saving new gig: \(error)")
                return
            }
        })
        DispatchQueue.main.async {
            self.gig = gig
            self.updateViews()
        }
        
        navigationController?.popViewController(animated: true)
    }
}
