//
//  PickerViewController.swift
//  Uniform Exchange
//
//  Created by Neeraj Pandey on 04/12/19.
//  Copyright © 2019 Neeraj Pandey. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController {

    //MARK: - Property Declaration
    
    @IBOutlet weak var otlPickerView : UIPickerView?
    @IBOutlet weak var otlDatePickerView : UIDatePicker?
    @IBOutlet weak var navigationBar : UINavigationBar?
    @IBOutlet weak var otlBtnDone : UIBarButtonItem?
    @IBOutlet weak var otlBtnCancel : UIBarButtonItem?
    
    weak var delegate : AnyObject?
    var searchController : UISearchController?
    var selectedPickerIndex : Int = 0
    var pickerValue : Any? = {}
    var btnObject : UIButton?
    var isSearchVisible : Bool = false
    var isDatePicker : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Set corner radius of view
        self.view.layer.cornerRadius = 10.0
        self.view.layer.masksToBounds = true
        
        if self.isSearchVisible {
            self.initializeSearchController()
        }
        
        if isDatePicker {
            self.otlDatePickerView?.isHidden = false
        } else {
            self.otlPickerView?.isHidden = false
            //Set data source and delegate
            self.otlPickerView?.delegate = self.delegate as? UIPickerViewDelegate
            self.otlPickerView?.dataSource = self.delegate as? UIPickerViewDataSource
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.isDatePicker {
            //check for picker value
            guard self.pickerValue != nil else {
                return
            }
            let date : Date = Application.appDelegate.formatStringToDate(date: self.pickerValue as! String, format: "dd-MM-yyyy")!
            //set date
            self.otlDatePickerView?.setDate(date, animated: true)
        } else {
            //Reload picker component
            self.otlPickerView?.reloadAllComponents()
            //Select picker
            if self.selectedPickerIndex != -1 {
                self.otlPickerView?.selectRow(self.selectedPickerIndex, inComponent: 0, animated: true)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: - IBAction method
    
    @IBAction func onBtnClickCancel(sender : UIBarButtonItem) {
        //Call delegate method
        
        
        //Dismiss view controller
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onBtnClickSave(sender : UIBarButtonItem) {
        if self.isDatePicker {
            self.pickerValue = self.otlDatePickerView?.date
        } else {
            self.pickerValue = self.otlPickerView?.selectedRow(inComponent: 0)
        }
        
        //Call delegate method
        
        //Dismiss view controller
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - UISearchController
    
    func initializeSearchController() {
        searchController = UISearchController.init(searchResultsController: nil)
        searchController?.searchResultsUpdater = self.delegate as? UISearchResultsUpdating
        searchController?.searchBar.sizeToFit()
        searchController?.searchBar.delegate = self.delegate as? UISearchBarDelegate
        searchController?.searchBar.searchBarStyle = UISearchBar.Style.minimal
        if #available(iOS 13.0, *) {
            searchController?.obscuresBackgroundDuringPresentation = false
        } else {
            //nothing here
            searchController?.dimsBackgroundDuringPresentation = false
        }
        searchController?.hidesNavigationBarDuringPresentation = false
        searchController?.definesPresentationContext = true
        searchController?.searchBar.placeholder = "Search"
        
        //Add search controller to table view
        self.navigationBar?.topItem?.titleView = searchController?.searchBar
        //search bar tint color
        self.searchController?.searchBar.tintColor = _SEARCH_CONTROLLER_SEARCH_BAR_TINT_COLOR
        (UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self])).tintColor = _SEARCH_CONTROLLER_SEARCH_BAR_TINT_COLOR
        
        //Get the text field
        let searchTextField : UITextField = searchController?.searchBar.value(forKey: "searchField") as! UITextField
        searchTextField.textColor = _SEARCH_CONTROLLER_SEARCH_BAR_TINT_COLOR
    }

}
