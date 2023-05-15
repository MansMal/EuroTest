//
//  ViewController.swift
//  EuroTest
//
//  Created by Malek Mansour on 15/05/2023.
//

import UIKit

final class ListViewController: UIViewController {
        
    let viewmodel: ListViewModel = ListViewModel()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails",
            let destination = segue.destination as? DetailsViewController {
            
        }
    }
}
