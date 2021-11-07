//
//  MapViewController.swift
//  mapApp
//
//  Created by i.mamadaev on 02.10.2021.
//

import UIKit
import SnapKit
import YandexMapsMobile

class MapViewController: UIViewController {

    let CAMERA_TARGET = YMKPoint(latitude: 59.952, longitude: 30.318)
    let ANIMATED_RECTANGLE_CENTER = YMKPoint(latitude: 59.956, longitude: 30.313)
    let TRIANGLE_CENTER = YMKPoint(latitude: 59.948, longitude: 30.313)
    let POLYLINE_CENTER = YMKPoint(latitude: 59.952, longitude: 30.318)
    let CIRCLE_CENTER = YMKPoint(latitude: 59.956, longitude: 30.323)
    let DRAGGABLE_PLACEMARK_CENTER = YMKPoint(latitude: 59.948, longitude: 30.323)
    let ANIMATED_PLACEMARK_CENTER = YMKPoint(latitude: 59.948, longitude: 30.318)
    let OBJECT_SIZE: Double = 0.0015
    
    private var animationIsActive = true
    private var circleMapObjectTapListener: YMKMapObjectTapListener!
    
    private let backButton = UIButton()

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
        
        createMapObjects()

        
        mapView.mapWindow.map.move(
                with: YMKCameraPosition.init(target: YMKPoint(latitude: 59.949941, longitude: 30.310250), zoom: 13, azimuth: 0, tilt: 0),
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
            $0.bottom.equalTo(view.snp.bottom).offset(-40)
            $0.size.height.equalTo(60)
        }
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
    
    @objc private func logoutPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    
    func createMapObjects() {
            let mapObjects = mapView.mapWindow.map.mapObjects
            let animatedPolygonPoints = [
                YMKPoint(
                    latitude: ANIMATED_RECTANGLE_CENTER.latitude - OBJECT_SIZE,
                    longitude: ANIMATED_RECTANGLE_CENTER.longitude - OBJECT_SIZE),
                YMKPoint(
                    latitude: ANIMATED_RECTANGLE_CENTER.latitude - OBJECT_SIZE,
                    longitude: ANIMATED_RECTANGLE_CENTER.longitude + OBJECT_SIZE),
                YMKPoint(
                    latitude: ANIMATED_RECTANGLE_CENTER.latitude + OBJECT_SIZE,
                    longitude: ANIMATED_RECTANGLE_CENTER.longitude + OBJECT_SIZE),
                YMKPoint(
                    latitude: ANIMATED_RECTANGLE_CENTER.latitude + OBJECT_SIZE,
                    longitude: ANIMATED_RECTANGLE_CENTER.longitude - OBJECT_SIZE)
            ]
            
            let animatedRectangle = mapObjects.addPolygon(
                with: YMKPolygon(outerRing: YMKLinearRing(points: animatedPolygonPoints), innerRings: []))
            animatedRectangle.fillColor = UIColor.clear
            animatedRectangle.strokeColor = UIColor.clear
            let animatedImage = YRTAnimatedImageProviderFactory.fromFile(
                Bundle.main.path(forResource: "Animations/animation", ofType: "png")) as! YRTAnimatedImageProvider
            animatedRectangle.setAnimatedImageWithAnimatedImage(
                animatedImage, patternWidth: 32)
            
            let trianglePoints = [
                YMKPoint(
                    latitude: TRIANGLE_CENTER.latitude + OBJECT_SIZE,
                    longitude: TRIANGLE_CENTER.longitude - OBJECT_SIZE),
                YMKPoint(
                    latitude: TRIANGLE_CENTER.latitude - OBJECT_SIZE,
                    longitude: TRIANGLE_CENTER.longitude - OBJECT_SIZE),
                YMKPoint(
                    latitude: TRIANGLE_CENTER.latitude,
                    longitude: TRIANGLE_CENTER.longitude + OBJECT_SIZE)
            ]
            
            let triangle = mapObjects.addPolygon(
                with: YMKPolygon(outerRing: YMKLinearRing(points: trianglePoints), innerRings: []))
            triangle.fillColor = UIColor.blue
            triangle.strokeColor = UIColor.black
            triangle.strokeWidth = 1
            triangle.zIndex = 100
            
            createTappableCircle();
            
            let polylinePoints = [
                YMKPoint(
                    latitude: POLYLINE_CENTER.latitude + OBJECT_SIZE,
                    longitude: POLYLINE_CENTER.longitude - OBJECT_SIZE),
                YMKPoint(
                    latitude: POLYLINE_CENTER.latitude - OBJECT_SIZE,
                    longitude: POLYLINE_CENTER.longitude - OBJECT_SIZE),
                YMKPoint(
                    latitude: POLYLINE_CENTER.latitude,
                    longitude: POLYLINE_CENTER.longitude + OBJECT_SIZE)
            ]
            let polyline = mapObjects.addPolyline(with: YMKPolyline(points: polylinePoints))
            polyline.strokeColor = UIColor.black
            polyline.zIndex = 100

            let coloredPolylinePoints = [
                YMKPoint(
                    latitude: 59.949941,
                    longitude: 30.310250),
                YMKPoint(
                    latitude: 59.950867,
                    longitude: 30.313382),
                YMKPoint(
                    latitude: 59.949596,
                    longitude: 30.315056),
                YMKPoint(
                    latitude: 59.951103,
                    longitude:  30.321622)
            ]

            let coloredPolyline = mapObjects.addColoredPolyline(with: YMKPolyline(points: coloredPolylinePoints))
            
            // lets define colors for each polyline segment
            coloredPolyline.setPaletteColorWithColorIndex(0, color: UIColor.yellow)
            coloredPolyline.setPaletteColorWithColorIndex(1, color: UIColor.green)
            coloredPolyline.setPaletteColorWithColorIndex(2, color: UIColor.purple)
            coloredPolyline.setColorsWithColors([0, 1, 2])

            // Maximum pgradient length in screen points.
            coloredPolyline.gradientLength = 250
            coloredPolyline.strokeWidth = 15
            coloredPolyline.zIndex = 100

            let placemark = mapObjects.addPlacemark(with: DRAGGABLE_PLACEMARK_CENTER)
            placemark.opacity = 0.5
            placemark.isDraggable = true
            placemark.setIconWith(UIImage(named:"Mark")!)

            createPlacemarkMapObjectWithViewProvider();
            createAnimatedPlacemark();
        }

        private class CircleMapObjectTapListener: NSObject, YMKMapObjectTapListener {
            private weak var controller: UIViewController?

            init(controller: UIViewController) {
                self.controller = controller
            }

            func onMapObjectTap(with mapObject: YMKMapObject, point: YMKPoint) -> Bool {
                if let circle = mapObject as? YMKCircleMapObject {
                    let randomRadius: Float = 100.0 + 50.0 * Float.random(in: 0..<10);
                    let curGeometry = circle.geometry;
                    circle.geometry = YMKCircle(center: curGeometry.center, radius: randomRadius);

                    if let userData = circle.userData as? CircleMapObjectUserData {
                        let message = "Circle with id \(userData.id) and description '\(userData.description)' tapped";
                        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert);
                        alert.view.backgroundColor = UIColor.darkGray;
                        alert.view.alpha = 0.8;
                        alert.view.layer.cornerRadius = 15;

                        controller?.present(alert, animated: true);
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                            alert.dismiss(animated: true);
                        }
                    }
                }
                return true;
            }
        }

        private class CircleMapObjectUserData {
            let id: Int32;
            let description: String;
            init(id: Int32, description: String) {
                self.id = id;
                self.description = description;
            }
        }

        func createTappableCircle() {
            let mapObjects = mapView.mapWindow.map.mapObjects;
            let circle = mapObjects.addCircle(
                with: YMKCircle(center: CIRCLE_CENTER, radius: 100),
                stroke: UIColor.green,
                strokeWidth: 2,
                fill: UIColor.red)
            circle.zIndex = 100
            circle.userData = CircleMapObjectUserData(id: 42, description: "Tappable circle");

            // Client code must retain strong reference to the listener.
            circleMapObjectTapListener = CircleMapObjectTapListener(controller: self);
            circle.addTapListener(with: circleMapObjectTapListener);
        }

        func createPlacemarkMapObjectWithViewProvider() {
            let textView =
                UITextView(frame: CGRect(x: 0, y: 0, width: 200, height: 30));
            let colors = [UIColor.red, UIColor.green, UIColor.black];

            textView.isOpaque = false;
            textView.backgroundColor = UIColor.clear.withAlphaComponent(0.0);
            textView.text = "Hello, World!";
            textView.textColor = UIColor.red;

            let viewProvider = YRTViewProvider(uiView: textView);

            let mapObjects = mapView.mapWindow.map.mapObjects;
            let viewPlacemark = mapObjects.addPlacemark(
                with: YMKPoint(latitude: 59.946263, longitude: 30.315181),
                view: viewProvider!);

            let delayToShowInitialText = 5.0;  // seconds
            let delayToShowRandomText = 0.5; // seconds
            // Show initial text `delayToShowInitialText` seconds and then
            // randomly change text in textView every `delayToShowRandomText` seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + delayToShowInitialText) {

                func doMainLoop() {
                    if !self.animationIsActive {
                        return
                    }

                    let randomInt = Int(arc4random_uniform(1000));
                    textView.text = "Some text " + String(randomInt);
                    textView.textColor = colors[randomInt % colors.count];
                    viewProvider?.snapshot();
                    viewPlacemark.setViewWithView(viewProvider!);

                    DispatchQueue.main.asyncAfter(deadline: .now() + delayToShowRandomText) {
                        doMainLoop()
                    }
                }

                doMainLoop();
            }
        }
        
        func createAnimatedPlacemark() {
            let animatedImageProvider = YRTAnimatedImageProviderFactory.fromFile(
                Bundle.main.path(forResource: "Animations/animation", ofType: "png")) as! YRTAnimatedImageProvider
            let mapObjects = mapView.mapWindow.map.mapObjects;
            let animatedPlacemark = mapObjects.addPlacemark(with: ANIMATED_PLACEMARK_CENTER, animatedImage: animatedImageProvider, style: YMKIconStyle())
            animatedPlacemark.useAnimation().play()
        }
}

