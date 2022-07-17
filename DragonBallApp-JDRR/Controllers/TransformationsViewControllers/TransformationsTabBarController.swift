//
//  TransformationsTabBarController.swift
//  DragonBallApp-JDRR
//
//  Created by Julio Rodriguez Reategui on 13/07/22.
//

import UIKit

class TransformationsTabBarController: UITabBarController {
    
    var selectedHero: Hero?
    
    init(hero: Hero){
        selectedHero = hero
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder){
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Transformaciones"
        
        //create instances of view controllers
        
        let transformationsTableView = TransformationsTableViewController()
        transformationsTableView.hero = selectedHero
        let transformationsCollectionView = TransformationsCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        
        
        //set titles
        transformationsTableView.title = "TableView"
        transformationsCollectionView.title = "CollectionView"

        //Assign viewcontrollers to tab bar
        self.setViewControllers([transformationsTableView, transformationsCollectionView], animated: false)
        self.tabBar.backgroundColor = .secondarySystemBackground
        
        guard let items = self.tabBar.items else {return}
        items[0].image = UIImage(systemName: "tablecells")
        items[1].image = UIImage(systemName: "square.grid.2x2")
    }

}
