//
//  DetailsViewController.swift
//  EuroTest
//
//  Created by Malek Mansour on 15/05/2023.
//

import UIKit

final class DetailsViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var sportTitle: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descTextView: UITextView!
    var story: Story?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        sportTitle.text = story?.sport.name
        if let story = self.story, let url = URL(string: story.image) {
            Task(priority: .high) {
                image.image = try await ImageLoader().fetch(url)
            }
            titleLabel.text = story.title
            authorLabel.text = story.author
            descTextView.attributedText = story.teaser.convertHtmlToNSAttributedString
        }
    }
    
    @IBAction func popBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
