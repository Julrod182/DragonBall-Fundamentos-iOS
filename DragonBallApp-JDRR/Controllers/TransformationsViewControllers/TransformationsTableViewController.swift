//
//  TransformationsTableViewController.swift
//  DragonBallApp-JDRR
//
//  Created by Julio Rodriguez Reategui on 13/07/22.
//

import UIKit

class TransformationsTableViewController: UITableViewController {
    
    var transformations: [Transformation] = []
    var hero: Hero?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Registramos la celda custom
        tableView?.register(UINib(nibName: "TransformationsTableViewCell", bundle: nil), forCellReuseIdentifier: "reuseIdentifier")
        //Getting token
        guard let token = LocalDataModel.getToken() else { return }

        //Network call herores - > Este llamado se tiene que cambiar por getTransformations cuando esté implementado
        let networkModel = NetworkModel(token: token)

        //"D13A40E5-4418-4223-9CE6-D2F9A28EBE94"
        
        networkModel.getTransformations (id: hero?.id ?? "D13A40E5-4418-4223-9CE6-D2F9A28EBE94") { [weak self] transformations, _ in
            guard let self = self else { return }
            self.transformations = transformations

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    //Configuración de la celda para que devuelva el heroe según el index path
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? TransformationsTableViewCell else {
            return UITableViewCell()
        }
        
        //Llamado a la función del TransformationsTableViewCell que setea los heroes y que hay que cambiar para que setee a las transformaciones
        
        cell.set(model: transformations[indexPath.row])
        

        return cell
    }
    
    //Go to DetailView according to selected cell in TableViewController
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let nextVC = TransformationDetailViewController() //Hacer un detail view de las transformaciones o modificar el DetailViewController actual. Por ahora está con DetailViewController de los heroes
        nextVC.set(model: transformations[indexPath.row])
        
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
}

// MARK: - Table view data source

extension TransformationsTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return transformations.count //modificar a transformations.count cuando tenga el array de transformaciones
    }
    
    
}
