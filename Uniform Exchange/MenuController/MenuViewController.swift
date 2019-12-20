//
//  MenuViewController.swift
//  Uniform Exchange
//
//  Created by Neeraj Pandey on 29/11/19.
//  Copyright © 2019 Neeraj Pandey. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    //MARK:- Properties Declaration
    
    @IBOutlet weak var otlTableView : UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.otlTableView?.rowHeight = 60.0
        self.otlTableView?.tableFooterView = UIView()
        
        //configure navigation bar
        self.configureNavigationBar()
    }
    
    func configureNavigationBar() {
        //set title
        navigationItem.title = "More"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //configure navigation bar
        self.configureNavigationBar()
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

extension MenuViewController : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return ""
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : MenuTableCell?
        cell = tableView.dequeueReusableCell(withIdentifier: "MENU_CELL", for: indexPath) as? MenuTableCell
        
        let menuOption = MenuOption(rawValue: indexPath.row)
        cell?.otlMenuName?.text = menuOption?.description
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuOption = MenuOption(rawValue: indexPath.row)
        didSelectMenuOption(menuOption: menuOption!)
    }
    
    func didSelectMenuOption(menuOption: MenuOption) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller : UIViewController?
        switch menuOption {
        case .ReferAFriend:
            controller = storyboard.instantiateViewController(withIdentifier: "REFER_FRIEND_ID")
            self.navigationController?.pushViewController(controller!, animated: true)
        case .Settings:
            controller = storyboard.instantiateViewController(withIdentifier: "SETTINGS_ID")
            self.navigationController?.pushViewController(controller!, animated: true)
        case .CustomerSupport:
            controller = storyboard.instantiateViewController(withIdentifier: "CUSTOMER_SUPPORT_ID")
            self.navigationController?.pushViewController(controller!, animated: true)
        case .MyOrders:
            break
        case .MyAddresses:
            break
        case .ReturnPolicy:
            break
        case .ShippingPolicy:
            break
        }
    }
    
}
