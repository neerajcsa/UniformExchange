//
//  ContainerViewController.swift
//  Uniform Exchange
//
//  Created by Neeraj Pandey on 02/12/19.
//  Copyright © 2019 Neeraj Pandey. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    // MARK: - Properties
    
    var menuController: MenuViewController!
    var centerController: UIViewController!
    var isExpanded = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureHomeController()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    override var prefersStatusBarHidden: Bool {
        return isExpanded
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Handlers
    
    func configureHomeController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeController : HomeViewController = storyboard.instantiateViewController(withIdentifier: "HOME_ID") as! HomeViewController
        homeController.delegate = self
        Application.appDelegate.navController = UINavigationController(rootViewController: homeController)
        centerController = Application.appDelegate.navController
        view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent: self)
    }
    
    func configureMenuController() {
        if menuController == nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            menuController = storyboard.instantiateViewController(withIdentifier: "MENU_VIEW_ID") as? MenuViewController
            menuController.delegate = self
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)
        }
    }
    
    func animatePanel(shouldExpand: Bool, menuOption: MenuOption?) {
        
        if shouldExpand {
            // show menu
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = self.centerController.view.frame.width - 80
            }, completion: nil)
            
        } else {
            // hide menu
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = 0
            }) { (_) in
                guard let menuOption = menuOption else { return }
                self.didSelectMenuOption(menuOption: menuOption)
            }
        }
        
        animateStatusBar()
    }
    
    func didSelectMenuOption(menuOption: MenuOption) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller : UIViewController?
        switch menuOption {
            case .Home:
                break
            case .ShopByCategory:
                controller = storyboard.instantiateViewController(withIdentifier: "SHOP_BY_CATEGORY_ID")
                Application.appDelegate.navController?.pushViewController(controller!, animated: true)
            case .YourOrder:
                controller = storyboard.instantiateViewController(withIdentifier: "ORDER_ID")
                Application.appDelegate.navController?.pushViewController(controller!, animated: true)
            case .YourAccounts:
                controller = storyboard.instantiateViewController(withIdentifier: "ACCOUNT_ID")
                Application.appDelegate.navController?.pushViewController(controller!, animated: true)
            case .ReferAFriend:
                controller = storyboard.instantiateViewController(withIdentifier: "REFER_FRIEND_ID")
                Application.appDelegate.navController?.pushViewController(controller!, animated: true)
            case .Settings:
                controller = storyboard.instantiateViewController(withIdentifier: "SETTINGS_ID")
                Application.appDelegate.navController?.pushViewController(controller!, animated: true)
            case .CustomerSupport:
                controller = storyboard.instantiateViewController(withIdentifier: "CUSTOMER_SUPPORT_ID")
                Application.appDelegate.navController?.pushViewController(controller!, animated: true)
        }
    }
    
    func animateStatusBar() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.setNeedsStatusBarAppearanceUpdate()
        }, completion: nil)
    }

}

extension ContainerViewController: HomeControllerDelegate {
    func handleMenuToggle(forMenuOption menuOption: MenuOption?) {
        if !isExpanded {
            configureMenuController()
        }
        
        isExpanded = !isExpanded
        animatePanel(shouldExpand: isExpanded, menuOption: menuOption)
    }
}
