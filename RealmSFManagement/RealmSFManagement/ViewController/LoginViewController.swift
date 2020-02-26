//
//  LoginViewController.swift
//  RealmSFManagement
//
//  Created by chakrni5 on 25/02/2020.
//  Copyright © 2020 Niloy. All rights reserved.
//

import UIKit

import RealmSwift

class LoginViewController: UIViewController {
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signIn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signIn.addTarget(self, action: #selector(logInUser), for: .touchUpInside)
        // Do any additional setup after loading the view.
        
    }

    @objc private func logInUser() {
        
            logIn(username: userName.text!, password: password.text!, register: false)
    
    }
    
    // Log in with the username and password, optionally registering a user.
    func logIn(username: String, password: String, register: Bool) {
        print("Log in as user: \(username) with register: \(register)");
        
        for u in SyncUser.all {
            u.value.logOut()
        }
        let creds = SyncCredentials.usernamePassword(username: username, password: password, register: register);
        SyncUser.logIn(with: creds, server: Constants.AUTH_URL, onCompletion: { [weak self](user, err) in
            
            if let error = err {
                // Auth error: user already exists? Try logging in as that user.
                print("Login failed: \(error)");
                //self!.errorLabel.text = "Login failed: \(error.localizedDescription)"
                return;
            }
            
            print("Login succeeded!");
            if let routeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RouteController") as? RouteViewController,  let userId = user?.identity{
                routeViewController.userId = userId
                self?.navigationController?.pushViewController(routeViewController, animated: true)
            }
        });
    }
}
