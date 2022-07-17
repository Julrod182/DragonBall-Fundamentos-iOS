//
//  HeroesTableViewController.swift
//  DragonBallApp-JDRR
//
//  Created by Julio Rodriguez Reategui on 12/07/22.
//

import UIKit

class HeroesTableViewController: UITableViewController {
        
    var heroes: [Hero] = [] // Initializing a set of heroes
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Registrar la celda custom
        tableView?.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "reuseIdentifier")
        
        //Getting token
        guard let token = LocalDataModel.getToken() else { return }
        
        // Network call herores
        let networkModel = NetworkModel(token: token)
        networkModel.getHeroes { [weak self] heroes, _ in
            guard let self = self else { return }
            self.heroes = heroes
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }

    //Configuración de la celda para que devuelva el heroe según el index path
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        //Llamado a la función del TableViewCell que setea los heroes
        cell.set(model: heroes[indexPath.row])

        return cell
    }
    
    //Go to DetailView according to selected cell in TableViewController
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let nextVC = DetailViewController()
        //nextVC.hero = heroes[indexPath.row]
        nextVC.set(model: heroes[indexPath.row])
        
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
// MARK: - Table view data source

extension HeroesTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return heroes.count
    }
}
