//
//  TransformationsCollectionViewCell.swift
//  DragonBallApp-JDRR
//
//  Created by Julio Rodriguez Reategui on 13/07/22.
//

import UIKit

class TransformationsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var transformationImage: UIImageView!
    @IBOutlet weak var transformationName: UILabel!
    
    func set(model: Transformation) { //Se cambió Hero por Transformation
        transformationName.text = model.name
        transformationImage.setImage(url: model.photo)
    }
    

}
