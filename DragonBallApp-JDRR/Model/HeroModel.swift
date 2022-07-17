//
//  HeroModel.swift
//  DragonBallApp-JDRR
//
//  Created by Julio Rodriguez Reategui on 12/07/22.
//

import UIKit

struct Hero: Decodable {
    let id: String
    let name: String?
    let description: String?
    let photo: URL?
    let favorite: Bool?
}

struct Transformation: Decodable{
    let name: String
    let id: String
    let hero: Hero
    let description: String
    let photo: URL
}
