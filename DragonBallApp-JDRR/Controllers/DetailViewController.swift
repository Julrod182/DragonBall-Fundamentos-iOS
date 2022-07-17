//
//  DetailViewController.swift
//  DragonBallApp-JDRR
//
//  Created by Julio Rodriguez Reategui on 12/07/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var transormationsButton: UIButton!
    
    var hero: Hero?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let hero = hero else {
            return
        }
        
        self.title = hero.name
        
        self.imageView.setImage(url: hero.photo!)
        self.nameLabel.text = hero.name
        self.descriptionTextView.text = hero.description
    }
    
    func set(model: Hero) {
        hero = model
    }
    
    @IBAction func transformationsButtonTap(_ sender: Any) {
        
        guard let hero = hero else {
            return
        }
        
        let nextVC = TransformationsTabBarController(hero: hero)
        navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
}
