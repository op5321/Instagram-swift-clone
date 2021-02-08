//
//  ViewController.swift
//  Instagram
//
//  Created by 박요셉 on 2021/02/03.
//
import FirebaseAuth
import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleNoAuthenticated()
        
    }
    
    private func handleNoAuthenticated() {
        if Auth.auth().currentUser == nil{
            //show log in
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
        }
    }
    
}

