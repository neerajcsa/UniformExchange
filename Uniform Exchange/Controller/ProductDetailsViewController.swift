//
//  ProductDetailsViewController.swift
//  Uniform Exchange
//
//  Created by Neeraj Pandey on 06/12/19.
//  Copyright © 2019 Neeraj Pandey. All rights reserved.
//

import UIKit

class ProductDetailsViewController: UIViewController {

    //MARK:- Property Declaration
    @IBOutlet weak var otlCollectionView : UICollectionView?
    @IBOutlet weak var otlProgressView : UIActivityIndicatorView?
    var productCategoryVC : ProductCategoryVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //call service
        self.callServiceToGetProductDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "Product Details"
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
    
    //MARK:- Manage Progress View
    
    func manageProgressView(isHidden : Bool) {
        if isHidden {
             //start animation
            self.otlProgressView?.startAnimating()
        } else {
            //stop animation
            self.otlProgressView?.stopAnimating()
        }
        self.view.isUserInteractionEnabled = !isHidden
    }
    
    //MARK:- Service Request
    
    func callServiceToGetProductDetails() {
        //start animation
        self.manageProgressView(isHidden: true)
        
        //create request
        let productCategoryURL : URL? = URL(string : String(format: "%@%@", Application.appDelegate.strServerURL ?? "",Service.productList))
        let genericService = GenericService()
        genericService.getRequestForService(getURL: productCategoryURL!, httpMethod: "GET") { [weak self] (data, response, error) in
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            
            if error != nil {
                return
            }
            
            guard let data = data else {
                return
            }
            
            if statusCode == 200 {
                let decoder = JSONDecoder()
                do {
                    self?.productCategoryVC = try decoder.decode(ProductCategoryVC.self, from: data)
                    if self?.productCategoryVC?.success == "true" {
                        DispatchQueue.main.async {
                            //stop animation
                            self?.manageProgressView(isHidden: false)
                            //reload collection
                            self?.otlCollectionView?.reloadData()
                        }
                    } else {
                        
                    }
                } catch let error {
                    print("failed to decode json \(error.localizedDescription)")
                }
                
            } else {
                
            }
        }
    }

}
