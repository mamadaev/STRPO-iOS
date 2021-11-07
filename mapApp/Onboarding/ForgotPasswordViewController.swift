//
//  ForgotPasswordViewController.swift
//  mapApp
//
//  Created by i.mamadaev on 07.11.2021.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "А не надо было забывать,\n на серваке нет сброса пароля)"
        label.numberOfLines = 0
        label.sizeToFit()
        label.textAlignment = .center
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        titleLabel.isUserInteractionEnabled = true
        titleLabel.addGestureRecognizer(labelTap)
        
        
        // Do any additional setup after loading the view.
    }
    

    @objc private func labelTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
