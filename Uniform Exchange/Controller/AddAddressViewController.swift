//
//  AddAddressViewController.swift
//  Uniform Exchange
//
//  Created by Neeraj Pandey on 15/12/19.
//  Copyright © 2019 Neeraj Pandey. All rights reserved.
//

import UIKit

class AddAddressViewController: UIViewController {

    //MARK:- Properties
    
    var isEditAddress : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "Add Address"
        navigationController?.navigationBar.topItem?.title = ""
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
