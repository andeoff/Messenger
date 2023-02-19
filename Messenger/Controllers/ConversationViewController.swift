//
//  ConversationViewController.swift
//  Messenger
//
//  Created by Andrey on 2/9/23.
//

import UIKit
import FirebaseAuth

class ConversationViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        validateAuth()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
//        do {
//            try FirebaseAuth.Auth.auth().signOut()
//        } catch  {
//            print("couldn't sign out")
//        }

    }
    
    private func validateAuth() {
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
        }
    }
}

