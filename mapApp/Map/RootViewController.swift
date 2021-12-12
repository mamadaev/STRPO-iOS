//
//  RootViewController.swift
//  mapApp
//
//  Created by i.mamadaev on 08.10.2021.
//

import UIKit

class RootViewController: UIViewController {
    private var current: UIViewController

    public var deeplink: DeeplinkType? {
        didSet {
            handleDeeplink()
        }
    }
    
    init() {
        current = SplashViewController()
        super.init(nibName:  nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(current)
        current.view.frame = view.bounds
        view.addSubview(current.view)
        current.didMove(toParent: self)
    }
    
    func showLoginScreen() {
        
        let new = UINavigationController(rootViewController: EntryViewController())
        
        addChild(new)
        new.view.frame = view.bounds
        view.addSubview(new.view)
        new.didMove(toParent: self)
        
        current.willMove(toParent: nil)
        current.view.removeFromSuperview()
        current.removeFromParent()
        
        current = new
    }
    
    func switchToLogout() {
        let loginViewController = EntryViewController()
        let logoutScreen = UINavigationController(rootViewController: loginViewController)
        animateDismissTransition(to: logoutScreen)
    }
    
    func switchToSettings() {
        let settingsVC = SettingsViewController()
        let settingsScreen = UINavigationController(rootViewController: settingsVC)
        animateDismissTransition(to: settingsScreen)
    }
    
    func switchToLogin() {
        let vc = LoginViewController()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func switchToMainScreen() {
        let mainViewController = MapViewController()
        let mainScreen = MapNavigationViewController(rootViewController: mainViewController)
        
        animateFadeTransition(to: mainScreen) { [weak self] in
            self?.handleDeeplink()
        }
    }
    
    private func animateFadeTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
        current.willMove(toParent: nil)
        addChild(new)
        transition(from: current, to: new, duration: 0.3, options: [.transitionCrossDissolve, .curveEaseOut], animations: {
            
        }) { completed in
            self.current.removeFromParent()
            new.didMove(toParent: self)
            self.current = new
            completion?()
        }
    }
    
    private func animateDismissTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
        
        let initialFrame = CGRect(x: -view.bounds.width, y: 0, width: view.bounds.width, height: view.bounds.height)
        current.willMove(toParent: nil)
        addChild(new)
        new.view.frame = initialFrame
        
        transition(from: current, to: new, duration: 0.3, options: [], animations: {
            new.view.frame = self.view.bounds
        }) { completed in
            self.current.removeFromParent()
            new.didMove(toParent: self)
            self.current = new
            completion?()
        }
    }
    
    private func handleDeeplink() {
        if let mainNavigationController = current as? MapNavigationViewController, let deeplink = deeplink {
            switch deeplink {
            case .activity:
                mainNavigationController.popToRootViewController(animated: false)
                (mainNavigationController.topViewController as? MapViewController)?.showActivityScreen()
            default:
                // handle any other types of Deeplinks here
                break
            }
            
            // reset the deeplink back no nil, so it will not be triggered more than once
            self.deeplink = nil
        }
    }
    
}
