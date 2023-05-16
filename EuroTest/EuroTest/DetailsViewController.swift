//
//  DetailsViewController.swift
//  EuroTest
//
//  Created by Malek Mansour on 15/05/2023.
//

import UIKit

final class DetailsViewController: UIViewController {

    var story: Story?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
}
