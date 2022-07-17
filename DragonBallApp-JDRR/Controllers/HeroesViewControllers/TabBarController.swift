//
//  TabBarController.swift
//  DragonBallApp-JDRR
//
//  Created by Julio Rodriguez Reategui on 11/07/22.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Heroes"
        
        //create instances of view controllers
        let heroesTableView = HeroesTableViewController()
        let heroresCollectionView = CollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        
        //set titles
        heroesTableView.title = "TableView"
        heroresCollectionView.title = "CollectionView"

        //Assign viewcontrollers to tab bar
        self.setViewControllers([heroesTableView, heroresCollectionView], animated: false)
        self.tabBar.backgroundColor = .secondarySystemBackground
        
        guard let items = self.tabBar.items else {return}
        items[0].image = UIImage(systemName: "tablecells")
        items[1].image = UIImage(systemName: "square.grid.2x2")
    }


}
