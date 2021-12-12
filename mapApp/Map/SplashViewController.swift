//
//  SplashViewController.swift
//  RootControllerNavigation
//
//  Created by Stanislav Ostrovskiy on 12/5/17.
//  Copyright © 2017 Stanislav Ostrovskiy. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    private let titleLabel = UILabel()
    private let iconImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .yellow

        view.addSubview(iconImageView)
        view.addSubview(titleLabel)
        view.addSubview(activityIndicator)
        
        activityIndicator.frame = view.bounds
        activityIndicator.backgroundColor = .clear
        
        setupUI()
        makeServiceCall()
    }
    
    private func makeServiceCall() {
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(500)) {
            self.activityIndicator.stopAnimating()
            if UserDefaults.standard.bool(forKey: "LOGGED_IN") {
                AppDelegate.shared.rootViewController.switchToMainScreen()
            } else {
                AppDelegate.shared.rootViewController.showLoginScreen()
            }
        }
    }
    
    private func setupUI() {
        // Icon
        iconImageView.image = UIImage(named: "map.png")
        iconImageView.snp.makeConstraints {
            $0.top.equalTo(view.snp.topMargin).offset(100)
            $0.centerX.equalToSuperview()
            $0.size.height.equalTo(256)
            $0.size.width.equalTo(256)
        }
        
        // Title
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(iconImageView.snp.bottom).offset(60)
            $0.centerX.equalToSuperview()
        }
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Thin", size: 30)
        titleLabel.text = "Подскажем куда сходить"
        titleLabel.textColor = .black
    }
        
}
