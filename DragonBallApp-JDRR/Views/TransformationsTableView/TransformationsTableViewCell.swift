//
//  TransformationsTableViewCell.swift
//  DragonBallApp-JDRR
//
//  Created by Julio Rodriguez Reategui on 13/07/22.
//

import UIKit

class TransformationsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var transformationImage: UIImageView!
    @IBOutlet weak var transformationName: UILabel!
    @IBOutlet weak var transformationDescription: UILabel!
    
    
    //Crear modelo de Transformaciones a usar en esta función que en este momento está usando el modelo Hero
    func set(model: Transformation) {
        self.transformationName.text = model.name
        self.transformationDescription.text = model.description
        self.transformationImage.setImage(url: model.photo)
    }
}
