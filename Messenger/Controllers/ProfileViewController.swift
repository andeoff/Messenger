//
//  ProfileViewController.swift
//  Messenger
//
//  Created by Andrey on 2/9/23.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    private let cellIdentifier = "cellIdentifier"
    
    @IBOutlet var tableView: UITableView!
    
    let data = ["Log Out"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        setDelegates()
        
    }
    
    private func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    

}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            content.text = data[indexPath.row]
            content.textProperties.alignment = .center
            content.textProperties.color = .red
            cell.contentConfiguration = content
            return cell
        } else {
            // Fallback on earlier versions
            cell.textLabel?.text = data[indexPath.row]
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = .red
            return cell
        }
        
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let actionSheet = UIAlertController(title: "Выход",
                                      message: "Вы действительно хотите выйти?",
                                      preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Log Out",
                                      style: .destructive,
                                      handler: { [weak self] _ in
            
            guard let strongSelf = self else { return }
            do {
                try FirebaseAuth.Auth.auth().signOut()
                let vc = LoginViewController()
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                strongSelf.present(nav, animated: true)
            
            } catch  {
                print("Filed log out")
            }
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                              
        present(actionSheet, animated: true)
    }
}
