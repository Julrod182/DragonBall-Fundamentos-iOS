//
//  CollectionViewCell.swift
//  DragonBallApp-JDRR
//
//  Created by Julio Rodriguez Reategui on 13/07/22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroName: UILabel!
    
    func set(model: Hero) {
        heroName.text = model.name
        heroImage.setImage(url: model.photo!)
    }

}
