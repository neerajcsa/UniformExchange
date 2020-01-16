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
    var productListVC : ProductListVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //call service
        self.callServiceToGetProductList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "Product List"
        navigationController?.navigationBar.topItem?.title = ""
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "PRODUCT_FULL_VIEW_ID" {
            let destinationVC : ProductListDetailsViewController = segue.destination as! ProductListDetailsViewController
            destinationVC.gridProductDetails = sender as? GridProducts
        }
        
    }
    
    
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
    
    func callServiceToGetProductList() {
        //start animation
        self.manageProgressView(isHidden: true)
        
        //create request
        let productCategoryURL : URL? = URL(string : String(format: "%@%@", Application.appDelegate.strServerURL ?? "",Service.productList))
        let genericService = GenericService()
        genericService.getRequestForService(getURL: productCategoryURL!, httpMethod: "GET") { [weak self] (data, response, error) in
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            
            if error != nil {
                DispatchQueue.main.async {
                    //stop animation
                    self?.manageProgressView(isHidden: false)
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    //stop animation
                    self?.manageProgressView(isHidden: false)
                }
                return
            }
            
            if statusCode == 200 {
                let decoder = JSONDecoder()
                do {
                    self?.productListVC = try decoder.decode(ProductListVC.self, from: data)
                    if self?.productListVC?.success == "true" {
                        DispatchQueue.main.async {
                            //stop animation
                            self?.manageProgressView(isHidden: false)
                            //reload collection
                            self?.otlCollectionView?.reloadData()
                        }
                    } else {
                        DispatchQueue.main.async {
                            //stop animation
                            self?.manageProgressView(isHidden: false)
                        }
                    }
                } catch let error {
                    DispatchQueue.main.async {
                        //stop animation
                        self?.manageProgressView(isHidden: false)
                    }
                    print("failed to decode json \(error.localizedDescription)")
                }
                
            } else {
                DispatchQueue.main.async {
                    //stop animation
                    self?.manageProgressView(isHidden: false)
                }
            }
        }
    }

}

extension ProductDetailsViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size : CGSize = CGSize.zero
        
        size = CGSize(width: collectionView.frame.size.width/2, height: collectionView.frame.size.height/3)
        
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count : Int = 0
        count = productListVC?.products.count ?? 0
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell : HomeCollectionCell?
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PRODUCT_LIST_COLLECTION_CELL", for: indexPath) as? HomeCollectionCell
        //configure collection cell
        self.configureCollectionCell(cell: cell!, indexPath: indexPath)
        
        return cell!
    }
    
    func configureCollectionCell(cell : HomeCollectionCell, indexPath : IndexPath) {
        //get the download url
        let downloadString = self.productListVC?.products[indexPath.row].image ?? ""
        cell.otlImageView?.sd_setImage(with: URL(string: downloadString), placeholderImage: nil, options: .continueInBackground, context: nil)
        //product detail && product price
        let productName = self.productListVC?.products[indexPath.row].name ?? "-"
        let productPrice = self.productListVC?.products[indexPath.row].price ?? 0
        
        cell.otlLblProductName?.text = productName
        cell.otlLblProductPrice?.text = "₹ \(productPrice)/-"
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //get grid product
        let gridProduct : GridProducts? = self.productListVC?.products[indexPath.row]
        self.performSegue(withIdentifier: "PRODUCT_FULL_VIEW_ID", sender: gridProduct)
    }
    
}
