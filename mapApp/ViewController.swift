//
//  ViewController.swift
//  mapApp
//
//  Created by i.mamadaev on 02.10.2021.
//

import UIKit
import SnapKit
import YandexMapsMobile

class ViewController: UIViewController {

    /// Private properties
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemBackground
        
        return view
    }()
    
    private lazy var testLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello no storyboard world"
        label.sizeToFit()
        return label
    }()
    
    private let mapView = YMKMapView()

    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        .lightContent
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        
        mapView.mapWindow.map.move(
                with: YMKCameraPosition.init(target: YMKPoint(latitude: 55.751574, longitude: 37.573856), zoom: 15, azimuth: 0, tilt: 0),
                animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 5),
                cameraCallback: nil)
        
        
//        let style = "[" +
//                    "        {" +
//                    "            \"types\": \"point\"," +
//                    "            \"tags\": {" +
//                    "                \"all\": [" +
//                    "                    \"poi\"" +
//                    "                ]" +
//                    "            }," +
//                    "            \"stylers\": {" +
//                    "                \"color\": \"000000\"" +
//                    "            }" +
//                    "        }" +
//                    "    ]";
        
//        mapView.mapWindow.map.setMapStyleWithStyle(style)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
//        addGradient()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.systemBackground
        
        view.addSubview(backgroundView)
        backgroundView.addSubview(testLabel)
        backgroundView.addSubview(mapView)
    }
    
    private func setupConstraints() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        testLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        mapView.snp.makeConstraints {
            $0.top.left.right.equalTo(self.backgroundView.safeAreaLayoutGuide)
            $0.height.equalTo(350.0)
        }
        
    }
    
    private func addGradient(){
        let gradient: CAGradientLayer = CAGradientLayer()

        // Решил убрать зависимость на цвет темы устройства UIColor.systemBackground.cgColor, так как:
        // сложно поддерживать две темы + в этом нет необходиомости
        gradient.colors = [UIColor.black.cgColor, UIColor.mainAppColor.withAlphaComponent(0.85).cgColor, UIColor.mainAppColor.withAlphaComponent(0.95).cgColor, UIColor.mainAppColor.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = view.frame

        self.backgroundView.layer.insertSublayer(gradient, at: 0)
        self.backgroundView.layer.layoutSublayers()
    }
}

extension UIColor {
    static let mainAppColor = UIColor(red: 139.0/255.0, green: 251.0/255.0, blue: 232.0/255.0, alpha: 1.0)
}
