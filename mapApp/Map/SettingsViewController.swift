//
//  SettingsViewController.swift
//  mapApp
//
//  Created by i.mamadaev on 14.11.2021.
//

import UIKit
import SnapKit

class SettingsViewController: UIViewController {

    private let backButton = UIButton()
    private let editButton = UIButton()
    private let closeButton = UIImageView()
    private let userIconView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        
        let logoutButton = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.setLeftBarButton(logoutButton, animated: true)
        
        
        // Button
        view.addSubview(backButton)
        backButton.backgroundColor = .white
        backButton.setTitleColor(.white, for: .selected)
        backButton.layer.cornerRadius = 30
        backButton.backgroundColor = UIColor(red: 185/255, green: 190/255, blue: 197/255, alpha: 1)
        backButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        backButton.setTitle("Выйти", for: .normal)
        backButton.addTarget(self, action: #selector(logoutPressed), for: .touchUpInside)
        
        backButton.sizeToFit()
        backButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.right.equalToSuperview().offset(-64)
            $0.left.equalToSuperview().offset(64)
            $0.bottom.equalTo(view.snp.bottom).offset(-100)
            $0.size.height.equalTo(60)
        }
        
        // Button
        view.addSubview(editButton)
        editButton.backgroundColor = .white
        editButton.setTitleColor(.white, for: .selected)
        editButton.layer.cornerRadius = 30
        editButton.backgroundColor = UIColor(red: 185/255, green: 190/255, blue: 197/255, alpha: 1)
        editButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        editButton.setTitle("Редактировать", for: .normal)
        
        editButton.sizeToFit()
        editButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.right.equalToSuperview().offset(-64)
            $0.left.equalToSuperview().offset(64)
            $0.bottom.equalTo(view.snp.bottom).offset(-180)
            $0.size.height.equalTo(60)
        }
        
        // Close button
        view.addSubview(closeButton)
        closeButton.image = UIImage(named: "xmark_b.png")
        closeButton.contentMode = .center
        closeButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(52)
            $0.left.equalToSuperview().offset(22)
            $0.size.width.equalTo(32)
            $0.size.height.equalTo(32)
        }
        let gesture = UITapGestureRecognizer(target: self, action: #selector(closeButtonPressed))
        closeButton.isUserInteractionEnabled = true
        closeButton.addGestureRecognizer(gesture)
        
        // Flag Button
        view.addSubview(userIconView)
        userIconView.image = UIImage(named: "profile")
        userIconView.contentMode = .center
        userIconView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(100)
            $0.size.width.equalTo(256)
            $0.size.height.equalTo(256)
        }
        
        // Title
        let nameLabel = UILabel()
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(userIconView.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }
        nameLabel.font = UIFont(name: "AppleSDGothicNeo-Thin", size: 24)
        nameLabel.text = "Имя: Иван"
        nameLabel.textColor = .black
        
        // Surname
        let surnameLabel = UILabel()
        view.addSubview(surnameLabel)
        surnameLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        surnameLabel.font = UIFont(name: "AppleSDGothicNeo-Thin", size: 24)
        surnameLabel.text = "Фамилия: Петров"
        surnameLabel.textColor = .black
    }
    

    // MARK: - Navigation
    
    @objc private func logoutPressed() {
        self.dismiss(animated: true, completion: nil)
        
        UserDefaults.standard.set(false, forKey: "LOGGED_IN")
        AppDelegate.shared.rootViewController.switchToLogout()
    }
    
    @objc private func backButtonPressed() {
        AppDelegate.shared.rootViewController.switchToMainScreen()
    }

    @objc func closeButtonPressed() {
        self.modalPresentationStyle = .fullScreen
        self.dismiss(animated: true, completion: nil)
    }
}
