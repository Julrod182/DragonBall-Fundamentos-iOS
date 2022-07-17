//
//  TransformationDetailViewController.swift
//  DragonBallApp-JDRR
//
//  Created by Julio Rodriguez Reategui on 16/07/22.
//

import UIKit

class TransformationDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    private var transformation: Transformation?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let transformation = transformation else {
            return
        }
        
        self.title = transformation.name
        
        self.imageView.setImage(url: transformation.photo)
        self.nameLabel.text = transformation.name
        self.descriptionTextView.text = transformation.description
    }
    
    func set(model: Transformation){
        transformation = model
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
