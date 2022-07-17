//
//  FirstViewController.swift
//  DragonBallApp-JDRR
//
//  Created by Julio Rodriguez Reategui on 7/07/22.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let token = LocalDataModel.getToken(){
            print(token)
            let nextVC = TabBarController()
            navigationController?.setViewControllers([nextVC], animated: true)
        }
    }
    
    //Se linkea el botón del primer ViewController al segundo

    @IBAction func onButtonTap(_ sender: Any) {
        
        let model = NetworkModel()
        let user = userTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        loginButton.isEnabled = false
        activityIndicator.startAnimating()
        
        guard !user.isEmpty, !password.isEmpty else{
            loginButton.isEnabled = true
            activityIndicator.stopAnimating()
            return
        }
        
        model.login(user: user, password: password) { [weak self] token, _ in
            
            // Executing at main threat
            DispatchQueue.main.async {
                self?.loginButton.isEnabled = true
                self?.activityIndicator.stopAnimating()
                
                guard let token = token, !token.isEmpty else {
                    return
                }
                
                LocalDataModel.save(token: token)
                
//                let nextVC = TabBarController()
//                self?.navigationController?.setViewControllers([nextVC], animated: true)
            }
            
        }
    }
}
