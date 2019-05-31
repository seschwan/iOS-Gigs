//
//  GigsTableViewController.swift
//  iOSGigs
//
//  Created by Seschwan on 5/30/19.
//  Copyright © 2019 Seschwan. All rights reserved.
//

import UIKit

class GigsTableVC: UIViewController {
    
    let gigController = GigController()
    
    @IBOutlet weak var gigTableView: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        gigTableView.dataSource = self
        gigTableView.delegate = self
        
        if gigController.bearer == nil {
            performSegue(withIdentifier: "ToSignUp", sender: self)
        } else {
            gigController.getAllGigs { (error) in
                if let error = error {
                    NSLog("Error getting gigs: \(error)")
                    return
                }
                
                DispatchQueue.main.async {
                    self.gigTableView.reloadData()
                }
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToSignUp" {
            guard let loginVC = segue.destination as? LoginVC else { return }
            
        
        } else if segue.identifier == "NewGig" {
            guard let gigDetailVC = segue.destination as? GigDetailVC else { return }
        
        } else if segue.identifier == "ViewGig" {
            guard let gigTableVC = segue.destination as? GigsTableVC else { return }
            if let indexPath = gigTableView.indexPathForSelectedRow {
                gigTableVC.
            }
        }
    }

}

extension GigsTableVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gigController.gigArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let gig = gigController.gigArray[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        cell.textLabel?.text = gig.title
        cell.detailTextLabel?.text = "Due: \(dateFormatter.string(from: gig.dueDate))"
        
        return cell
    
    
    }
    
    
    
}
