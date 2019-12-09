//
//  ShopByCategoryViewController.swift
//  Uniform Exchange
//
//  Created by Neeraj Pandey on 02/12/19.
//  Copyright © 2019 Neeraj Pandey. All rights reserved.
//

import UIKit

class ShopByCategoryViewController: UIViewController,UISearchResultsUpdating,UISearchBarDelegate {
    
    //MARK:- Property Declaration
    @IBOutlet weak var otlCollectionView : UICollectionView?
    @IBOutlet weak var otlProgressView : UIActivityIndicatorView?
    var productCategoryVC : ProductCategoryVC?
    
    var searchController : UISearchController = {
        var searchController = UISearchController.init(searchResultsController: nil)
        searchController.searchBar.sizeToFit()
        searchController.searchBar.searchBarStyle = UISearchBar.Style.minimal
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.definesPresentationContext = true
        searchController.searchBar.placeholder = "Search"
        return searchController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        
        //call service
        self.callServiceToGetProductCategory()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "Shop By Category"
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
    
    func callServiceToGetProductCategory() {
        //start animation
        self.manageProgressView(isHidden: true)
        
        //create request
        let productCategoryURL : URL? = URL(string : String(format: "%@%@", Application.appDelegate.strServerURL ?? "",Service.categoryList))
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

    //MARK: - UISearchController
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
}

extension ShopByCategoryViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 100, height: 158)
//    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "COLLECTION_HEADER_ID", for: indexPath)
        sectionHeader.addSubview(searchController.searchBar)
        
        return sectionHeader
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productCategoryVC?.category.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell : ProductCategoryCollectionCell?
        
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CATEGORY_CELL_ID", for: indexPath) as? ProductCategoryCollectionCell
        //configure collection cell
        self.configureCollectionCell(cell: cell!, indexPath: indexPath)
        return cell!
    }
    
    func configureCollectionCell(cell : ProductCategoryCollectionCell, indexPath : IndexPath) {
        //get the download url
        let category : ProductCategoryVC.Category? = self.productCategoryVC?.category[indexPath.row]
        //let downloadString = category?.image ?? ""
        //cell.otlImageView?.sd_setImage(with: URL(string: downloadString), placeholderImage: nil, options: .continueInBackground, context: nil)
        cell.otlLblName?.text = category?.name ?? "-"
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "PRODUCT_DETAILS_ID", sender: self)
    }
    
}

