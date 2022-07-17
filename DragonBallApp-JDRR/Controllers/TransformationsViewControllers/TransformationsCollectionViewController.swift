//
//  TransformationsCollectionViewController.swift
//  DragonBallApp-JDRR
//
//  Created by Julio Rodriguez Reategui on 13/07/22.
//

import UIKit

private let reuseIdentifier = "Cell"

class TransformationsCollectionViewController: UICollectionViewController {
    
    var hero: Hero? //puede que no
    var transformations: [Transformation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        
        collectionView?.register(UINib(nibName: "TransformationsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)

        //Getting token
        guard let token = LocalDataModel.getToken() else { return }
        
        // Network call herores -> Cambiar a transformaciones
        let networkModel = NetworkModel(token: token)
        
        networkModel.getTransformations(id:hero?.id ?? "D13A40E5-4418-4223-9CE6-D2F9A28EBE94") { [weak self] transformations, _ in
            guard let self = self else { return }
            self.transformations = transformations
            
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
       
        return transformations.count // -> Cambiar a transformaciones
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
        
        (cell as? TransformationsCollectionViewCell)?.set(model: transformations[indexPath.row]) //cambiar modelo a transformaciones
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextVC = TransformationDetailViewController()
        nextVC.set(model: transformations[indexPath.row])
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
}


extension TransformationsCollectionViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.frame.width/2) - 6
        
        return CGSize(width: width, height: 140.0)
    }
}
