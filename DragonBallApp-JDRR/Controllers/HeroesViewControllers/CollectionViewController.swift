//
//  CollectionViewController.swift
//  DragonBallApp-JDRR
//
//  Created by Julio Rodriguez Reategui on 11/07/22.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {
    
    var heroes: [Hero] = [] // Initializing a set of heroes
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        
        collectionView?.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)

        //Getting token
        guard let token = LocalDataModel.getToken() else { return }
        
        // Network call herores
        let networkModel = NetworkModel(token: token)
        networkModel.getHeroes { [weak self] heroes, _ in
            guard let self = self else { return }
            self.heroes = heroes
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return heroes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
        
        (cell as? CollectionViewCell)?.set(model: heroes[indexPath.row])
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextVC = DetailViewController()
        nextVC.set(model: heroes[indexPath.row])
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.frame.width/2) - 6
        
        return CGSize(width: width, height: 140.0)
    }
}
