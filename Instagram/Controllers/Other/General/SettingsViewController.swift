//
//  SettingsViewController.swift
//  Instagram
//
//  Created by Danica Vladić on 15/09/2020.
//  Copyright © 2020 Danica Vladić. All rights reserved.
//

import UIKit
import SafariServices

struct SettingCellModel {
    let title: String
    let handler: (() -> Void)
}

final class SettingsViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var data = [[SettingCellModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        tableView.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
    
    private func configureModels() {
        
        data.append([
        SettingCellModel (
            title: "Edit profile"
        ) { [weak self] in
            self?.didTapEditProfile()
            },
        SettingCellModel (
            title: "Invite friends"
        ) { [weak self] in
            self?.didTapInivteFriends()
            },
        SettingCellModel (
            title: "Save original posts"
        ) { [weak self] in
            self?.didTapSaveOriginalPosts()
            },
        ])
        
        data.append([
        SettingCellModel (
            title: "Terms of service"
        ) { [weak self] in
            self?.openURL(type: .terms)
            }
        ])
        
        data.append([
        SettingCellModel (
            title: "Privacy policy"
        ) { [weak self] in
            self?.openURL(type: .privacy)
            }
        ])
        
        data.append([
        SettingCellModel (
            title: "Help / Feedback"
        ) { [weak self] in
            self?.openURL(type: .help)
            }
        ])
        
        data.append([
        SettingCellModel (
            title: "Log Out"
        ) { [weak self] in
            self?.didTapLogOut()
            }
        ])
    }
    
    private func didTapEditProfile() {
        let vc = EditProfileViewController()
        vc.title = "Edit profile"
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)
    }
    
    private func didTapInivteFriends() {
        
    }
    
    private func didTapSaveOriginalPosts() {
        
    }
    
    enum SettingsURLType {
        case terms, privacy, help
    }
    
    private func openURL(type: SettingsURLType) {
        let urlString: String
        switch type {
        case .terms: urlString = "https://help.instagram.com/581066165581870?%3F__hstc=20629287.2f3f33a24b44870ec4a577029c49e44b.1585353600091.1585353600092.1585353600093.1&__hssc=192971698.1.1585872000174&__hsfp=3071927421&_ga=2.67531538.2090819656.1556546632-504387059.1544696302"
        case .privacy: urlString = "https://www.facebook.com/help/instagram/196883487377501"
        case .help: urlString = "https://help.instagram.com"
        }
        guard let url = URL(string: urlString) else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
        
        
    }
   
    
    
    private func didTapLogOut() {
        let actionSheet = UIAlertController(title: "Log out", message: "Are you sure you want to log out?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Log out", style: .destructive, handler: { _ in
            AuthManager.shared.logOut(completion: { success in
                DispatchQueue.main.async {
                    if success {
                        let vc = LoginViewController()
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true){
                            self.navigationController?.popToRootViewController(animated: false)
                            self.tabBarController?.selectedIndex = 0
                        }
                    } else {
                        //error
                        fatalError("Could not sign out user.")
                    }
                }
            })
        }))
        
        present(actionSheet, animated: true)
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = data[indexPath.section][indexPath.row]
        model.handler()
    }
}
