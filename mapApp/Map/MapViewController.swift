//
//  MapViewController.swift
//  mapApp
//
//  Created by i.mamadaev on 02.10.2021.
//

import UIKit
import SnapKit
import YandexMapsMobile

class MapNavigationViewController: UINavigationController { }

class MapViewController: UIViewController, YMKClusterListener, YMKClusterTapListener, YMKMapObjectTapListener {
    
    // YMK Properies
    private let mapView = YMKMapView()
    private var imageProvider = UIImage(named: "SearchResult")!
    private let moscow = YMKPoint(latitude: 55.756, longitude: 37.618)
    private let CLUSTER_CENTERS: [YMKPoint] = [
        YMKPoint(latitude: 55.756, longitude: 37.618)
    ]
    private let PLACEMARKS_NUMBER = 1000
    private let FONT_SIZE: CGFloat = 15
    private let MARGIN_SIZE: CGFloat = 3
    private let STROKE_SIZE: CGFloat = 3
    private var circleMapObjectTapListener: YMKMapObjectTapListener!
    
    // ZOOM
    private var zoomLvl: Float = 5

    // Private
    private let menuButton = UIImageView()
    private let userIconButton = UIImageView()
    private let newLocsButton = UIImageView()
    private let sampleButton = UIImageView()
    
    private let addButton = UIImageView()
    private let zoomInButton = UIImageView()
    private let zoomOutButton = UIImageView()
    private let locButton = UIImageView()

    private var animationIsActive = true
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMap()
        setupUI()
        setupConstraints()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        view.backgroundColor = .black
        backgroundView.backgroundColor = .black
        
        
        view.addSubview(backgroundView)
        backgroundView.addSubview(testLabel)
        backgroundView.addSubview(mapView)
        
        // Bottom menu
        let menuView = UIView()
        menuView.backgroundColor = UIColor.black.withAlphaComponent(0.25)
        view.addSubview(menuView)
        menuView.layer.cornerRadius = 20
        menuView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.size.height.equalTo(90)
        }
        
        // Menu Button
        view.addSubview(menuButton)
        menuButton.image = UIImage(named: "list")
        menuButton.contentMode = .center
        menuButton.snp.makeConstraints {
            $0.centerY.equalTo(menuView)
            $0.left.equalToSuperview().offset(48)
            $0.size.width.equalTo(32)
            $0.size.height.equalTo(32)
        }
        let menuButtonGesture = UITapGestureRecognizer(target: self, action: #selector(menuButtonPressed))
        menuButton.isUserInteractionEnabled = true
        menuButton.addGestureRecognizer(menuButtonGesture)
        
        // Flag Button
        view.addSubview(userIconButton)
        userIconButton.image = UIImage(named: "profile-user")
        userIconButton.contentMode = .center
        userIconButton.snp.makeConstraints {
            $0.centerY.equalTo(menuView)
            $0.left.equalTo(menuButton.snp.right).offset(32)
            $0.size.width.equalTo(32)
            $0.size.height.equalTo(32)
        }
        let flagButtonGesture = UITapGestureRecognizer(target: self, action: #selector(userIconButtonPressed))
        userIconButton.isUserInteractionEnabled = true
        userIconButton.addGestureRecognizer(flagButtonGesture)
        
        // Update locations
        view.addSubview(newLocsButton)
        newLocsButton.image = UIImage(named: "flags")
        newLocsButton.contentMode = .center
        newLocsButton.snp.makeConstraints {
            $0.centerY.equalTo(menuView)
            $0.right.equalToSuperview().offset(-48)
            $0.size.width.equalTo(32)
            $0.size.height.equalTo(32)
        }
        let newLocsButtonGesture = UITapGestureRecognizer(target: self, action: #selector(newLocsButtonPressed))
        newLocsButton.isUserInteractionEnabled = true
        newLocsButton.addGestureRecognizer(newLocsButtonGesture)
        
        // Sample Button
        view.addSubview(sampleButton)
        sampleButton.image = UIImage(named: "bubble-chat")
        sampleButton.contentMode = .center
        sampleButton.snp.makeConstraints {
            $0.centerY.equalTo(menuView)
            $0.right.equalTo(newLocsButton.snp.left).offset(-32)
            $0.size.width.equalTo(32)
            $0.size.height.equalTo(32)
        }
        let sampleButtonGesture = UITapGestureRecognizer(target: self, action: #selector(sampleButtonPressed))
        sampleButton.isUserInteractionEnabled = true
        sampleButton.addGestureRecognizer(sampleButtonGesture)
        
        // Add Button
        view.addSubview(addButton)
//        addButton.backgroundColor = UIColor.black.withAlphaComponent(0.25)
//        addButton.layer.cornerRadius = 45
        addButton.image = UIImage(named: "plus_w_64")
        addButton.contentMode = .center
        addButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-5)
            $0.centerX.equalToSuperview()
            $0.size.width.equalTo(90)
            $0.size.height.equalTo(90)
        }
        let addButtonGesture = UITapGestureRecognizer(target: self, action: #selector(addButtonPressed))
        addButton.isUserInteractionEnabled = true
        addButton.addGestureRecognizer(addButtonGesture)
        
        // zoom In Button
        view.addSubview(zoomInButton)
        zoomInButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)
        zoomInButton.layer.cornerRadius = 24
        zoomInButton.image = UIImage(named: "zoom-in")
        zoomInButton.contentMode = .center
        zoomInButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(300)
            $0.right.equalToSuperview().offset(-16)
            $0.size.width.equalTo(48)
            $0.size.height.equalTo(48)
        }
        let zoomInButtonGesture = UITapGestureRecognizer(target: self, action: #selector(zoomInButtonPressed))
        zoomInButton.isUserInteractionEnabled = true
        zoomInButton.addGestureRecognizer(zoomInButtonGesture)
        
        // zoom out Button
        view.addSubview(zoomOutButton)
        zoomOutButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)
        zoomOutButton.layer.cornerRadius = 24
        zoomOutButton.image = UIImage(named: "zoom-out")
        zoomOutButton.contentMode = .center
        zoomOutButton.snp.makeConstraints {
            $0.top.equalTo(zoomInButton.snp.bottom).offset(10)
            $0.right.equalToSuperview().offset(-16)
            $0.size.width.equalTo(48)
            $0.size.height.equalTo(48)
        }
        let zoomOutButtonGesture = UITapGestureRecognizer(target: self, action: #selector(zoomOutButtonPressed))
        zoomOutButton.isUserInteractionEnabled = true
        zoomOutButton.addGestureRecognizer(zoomOutButtonGesture)
        
        // user location button
        view.addSubview(locButton)
        locButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)
        locButton.layer.cornerRadius = 24
        locButton.image = UIImage(named: "navigation_w")
        locButton.contentMode = .center
        locButton.snp.makeConstraints {
            $0.top.equalTo(zoomOutButton.snp.bottom).offset(64)
            $0.right.equalToSuperview().offset(-16)
            $0.size.width.equalTo(48)
            $0.size.height.equalTo(48)
        }
        let locButtonGesture = UITapGestureRecognizer(target: self, action: #selector(locButtonPressed))
        locButton.isUserInteractionEnabled = true
        locButton.addGestureRecognizer(locButtonGesture)
    }
    
    private func setupConstraints() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        testLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        mapView.layer.cornerRadius = 5
        mapView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
//            equalTo(menuButton.snp.bottom).offset(10)
//            $0.left.right.equalTo(self.backgroundView.safeAreaLayoutGuide)
//            $0.height.equalTo(650.0)
        }
    }
    
    // MARK: - Map setup
    
    private func setupMap() {
        let cameraPosition = YMKCameraPosition(
            target: CLUSTER_CENTERS[0], zoom: zoomLvl, azimuth: 0, tilt: 0)
        mapView.mapWindow.map.move(with: cameraPosition)
    }
    
    // MARK: - YMK Protocols conformation
    
    func onClusterAdded(with cluster: YMKCluster) {
        // We setup cluster appearance and tap handler in this method
        cluster.appearance.setIconWith(clusterImage(cluster.size))
        cluster.addClusterTapListener(with: self)
    }

    func onClusterTap(with cluster: YMKCluster) -> Bool {
        var format = ""
        if cluster.size > 5 {
            format = "В этой точке %u локаций"
        } else {
            format = "В этой точке %u локации"
        }
        
        let alert = UIAlertController(
            title: "",
            message: String(format: format, cluster.size),
            preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(title: "Ок", style: .default, handler: nil))

        present(alert, animated: true, completion: nil)

        // We return true to notify map that the tap was handled and shouldn't be
        // propagated further.
        return true
    }
    
    // MARK: - Map logic
    
    func clusterImage(_ clusterSize: UInt) -> UIImage {
        let scale = UIScreen.main.scale
        let text = (clusterSize as NSNumber).stringValue
        let font = UIFont.systemFont(ofSize: FONT_SIZE * scale)
        let size = text.size(withAttributes: [NSAttributedString.Key.font: font])
        let textRadius = sqrt(size.height * size.height + size.width * size.width) / 2
        let internalRadius = textRadius + MARGIN_SIZE * scale
        let externalRadius = internalRadius + STROKE_SIZE * scale
        let iconSize = CGSize(width: externalRadius * 2, height: externalRadius * 2)

        UIGraphicsBeginImageContext(iconSize)
        let ctx = UIGraphicsGetCurrentContext()!

        ctx.setFillColor(UIColor.green.cgColor)
        ctx.fillEllipse(in: CGRect(
            origin: .zero,
            size: CGSize(width: 2 * externalRadius, height: 2 * externalRadius)));

        ctx.setFillColor(UIColor.white.cgColor)
        ctx.fillEllipse(in: CGRect(
            origin: CGPoint(x: externalRadius - internalRadius, y: externalRadius - internalRadius),
            size: CGSize(width: 2 * internalRadius, height: 2 * internalRadius)));

        (text as NSString).draw(
            in: CGRect(
                origin: CGPoint(x: externalRadius - size.width / 2, y: externalRadius - size.height / 2),
                size: size),
            withAttributes: [
                NSAttributedString.Key.font: font,
                NSAttributedString.Key.foregroundColor: UIColor.black])
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        return image
    }

    func randomDouble() -> Double {
        return Double(arc4random()) / Double(UINT32_MAX)
    }

    func createPoints() -> [YMKPoint]{
        var points = [YMKPoint]()
        for _ in 0..<PLACEMARKS_NUMBER {
            let clusterCenter = CLUSTER_CENTERS.randomElement()!
            let latitude = clusterCenter.latitude + randomDouble()  - 0.5
            let longitude = clusterCenter.longitude + randomDouble()  - 0.5

            points.append(YMKPoint(latitude: latitude, longitude: longitude))
        }

        return points
    }
    
    // MARK: - Map tap protocol conformation
    
    func onMapObjectTap(with mapObject: YMKMapObject, point: YMKPoint) -> Bool {
        
        print(point.latitude, point.longitude)
        return true
    }
    
    
    // MARK: - Navigation
    
    @objc func showActivityScreen(animated: Bool = true) {
        let activityViewController = ActivityViewController()
        navigationController?.pushViewController(activityViewController, animated: animated)
    }
    
    @objc func menuButtonPressed() {
        print("menu")
//        AppDelegate.shared.rootViewController.switchToSettings()
        
        let vc = SettingsViewController()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func addButtonPressed() {
        print("add")
        if !UserDefaults.standard.bool(forKey: "LOGGED_IN") {
            let alert = UIAlertController(title: "", message: "Доступно только авторизованным пользователям", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)

            // change to desired number of seconds (in this case 5 seconds)
            let when = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: when){
                // your code with delay
                alert.dismiss(animated: true, completion: nil)
                self.dismiss(animated: true, completion: nil)
            }
        } else {
            let vc = AddLocationViewController()
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @objc func zoomInButtonPressed() {
        print("zoomInButtonPressed")
        if self.zoomLvl <= 20 {
            self.zoomLvl += 1
            
            mapView.mapWindow.zoomFocusPoint = .none
            let point = YMKPoint(latitude: 55.75266014718742, longitude: 37.63247677612304)

            print(zoomLvl)
            mapView.mapWindow.map.move(with:
                YMKCameraPosition(target: point, zoom: zoomLvl, azimuth: 0, tilt: 0))
        }
        
    }
    
    @objc func zoomOutButtonPressed() {
        print("zoomOutButtonPressed")
        
        if self.zoomLvl >= 3 {
            self.zoomLvl -= 1
            let point = YMKPoint(latitude: 55.75266014718742, longitude: 37.63247677612304)

            mapView.mapWindow.map.move(with:
                YMKCameraPosition(target: point, zoom: zoomLvl, azimuth: 0, tilt: 0))
        }
    }
    
    @objc func locButtonPressed() {
        print("locButtonPressed")
        
        let mapObjects = mapView.mapWindow.map.mapObjects
        let point = YMKPoint(latitude: 55.75266014718742, longitude: 37.63247677612304)
        let placemark = mapObjects.addPlacemark(with: point)
        placemark.setIconWith(UIImage(named: "user_arrow")!)
        
        mapView.mapWindow.map.move(with:
            YMKCameraPosition(target: point, zoom: 14, azimuth: 0, tilt: 0))
        self.zoomLvl = 14
    }
    
    @objc func userIconButtonPressed() {
        print("userIconButtonPressed")
    }
    
    @objc func newLocsButtonPressed() {
        print("newLocsButtonGesture")
        
        let mapObjects = mapView.mapWindow.map.mapObjects
        mapObjects.clear()
        
        
        // Note that application must retain strong references to both
        // cluster listener and cluster tap listener
        let collection = mapView.mapWindow.map.mapObjects.addClusterizedPlacemarkCollection(with: self)

//        let points = createPoints()
        
        let points = getRealObjects()
        
        collection.addPlacemarks(with: points, image: self.imageProvider, style: YMKIconStyle())
        collection.addTapListener(with: self)
        
        let point = YMKPoint(latitude: 55.75266014718742, longitude: 37.63247677612304)
        let placemark = mapObjects.addPlacemark(with: point)
        placemark.setIconWith(UIImage(named: "user_arrow")!)
        // Placemarks won't be displayed until this method is called. It must be also called
        // to force clusters update after collection change
        collection.clusterPlacemarks(withClusterRadius: 60, minZoom: 15)
    }
    
    @objc func sampleButtonPressed() {
        print("sampleButtonPressed")
        
        let mapObjects = mapView.mapWindow.map.mapObjects
        mapObjects.clear()
        
        
        // Note that application must retain strong references to both
        // cluster listener and cluster tap listener
        let collection = mapView.mapWindow.map.mapObjects.addClusterizedPlacemarkCollection(with: self)

        let points = createPoints()
            
        collection.addPlacemarks(with: points, image: self.imageProvider, style: YMKIconStyle())
        collection.addTapListener(with: self)
        
        let point = YMKPoint(latitude: 55.75266014718742, longitude: 37.63247677612304)
        let placemark = mapObjects.addPlacemark(with: point)
        placemark.setIconWith(UIImage(named: "user_arrow")!)
        // Placemarks won't be displayed until this method is called. It must be also called
        // to force clusters update after collection change
        collection.clusterPlacemarks(withClusterRadius: 60, minZoom: 15)
    }
    
    
    private func getRealObjects() -> [YMKPoint] {
        let sem = DispatchSemaphore.init(value: 0)

        var points: [YMKPoint] = []
        guard let url = URL(string: "http://134.0.117.63:8081/get_places") else { return [] }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters = ["x1_lat": 10.0, "x1_long": 10.0, "x2_lat": 150.200, "x2_long": 160.20, "category_id": "test category", "secret": "secret"] as [String : Any]
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            return []
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            let strResponse = String(decoding: data, as: UTF8.self)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String:Any]]
                let values = json as? [[String: Any]] ?? []
                print(values)
                for value in values {
                    points.append(YMKPoint(latitude: value["lat"] as! Double, longitude: value["long"] as! Double))
                }
            } catch {
                print(error)
            }
            
            defer { sem.signal() }
        }.resume()
        
        sem.wait()

        return points
    }
}

