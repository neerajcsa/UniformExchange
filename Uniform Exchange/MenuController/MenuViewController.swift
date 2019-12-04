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
    var delegate: HomeControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.otlTableView?.rowHeight = 44.0
        self.view.backgroundColor = UIColor(named: "menu_background")
        self.otlTableView?.backgroundColor = UIColor(named: "menu_background")
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
        delegate?.handleMenuToggle(forMenuOption: menuOption)
    }
    
}
