//
//  HomeViewController.swift
//  Uniform Exchange
//
//  Created by Neeraj Pandey on 19/10/19.
//  Copyright © 2019 Neeraj Pandey. All rights reserved.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController {

    //MARK:- Property Declaration
    @IBOutlet weak var otlCollectionView : UICollectionView?
    @IBOutlet weak var otlCollectionBannerView : UICollectionView?
    @IBOutlet weak var otlProgressView : UIActivityIndicatorView?
    @IBOutlet weak var otlPageControl : UIPageControl?

    var bannerTimer : Timer?
    var homeVC : HomeVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //allow selection
        self.otlCollectionBannerView?.allowsSelection = true
        //call service
        self.callServiceToGetDashboardDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //configure navigation bar
        configureNavigationBar()
        if bannerTimer == nil {
            //create timer
            bannerTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(runBannerTimer), userInfo: nil, repeats: true)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        bannerTimer?.invalidate()
        bannerTimer = nil
        super.viewDidDisappear(animated)
    }
    
    //MARK: - Handlers
    
    @objc func runBannerTimer() {
        //get the current collection view item
        let indexPaths = self.otlCollectionBannerView?.indexPathsForVisibleItems
        let row = (indexPaths?.first?.row ?? 0) + 1
        let indexPath = IndexPath(item: row % ((self.otlPageControl?.numberOfPages ?? 1)), section: 0)
        self.otlCollectionBannerView?.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        self.otlCollectionBannerView?.reloadData()
    }
        
    func configureNavigationBar() {
//        navigationController?.navigationBar.barTintColor = .darkGray
//        navigationController?.navigationBar.barStyle = .black
        
        navigationItem.title = "UNIFORM EXCHANGE"
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK:- Page Control
    
    func configurePageControl(totalPage : Int) {
        self.otlPageControl?.numberOfPages = totalPage
        self.otlPageControl?.currentPage = 0//first page
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
    
    func callServiceToGetDashboardDetails() {
        //start animation
        self.manageProgressView(isHidden: true)
        
        //create request
        let dashBoardURL : URL? = URL(string : String(format: "%@%@", Application.appDelegate.strServerURL ?? "",Service.dashboard))
        let genericService = GenericService()
        genericService.getRequestForService(getURL: dashBoardURL!, httpMethod: "GET") { [weak self] (data, response, error) in
            
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
                    self?.homeVC = try decoder.decode(HomeVC.self, from: data)
                    if self?.homeVC?.success == "true" {
                        DispatchQueue.main.async {
                            //stop animation
                            self?.manageProgressView(isHidden: false)
                            //reload collection
                            self?.otlCollectionView?.reloadData()
                            //reload banner collection
                            self?.otlCollectionBannerView?.reloadData()
                            //page control
                            self?.configurePageControl(totalPage: self?.homeVC?.sliderimages.first?.count ?? 0)
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

extension HomeViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        self.otlPageControl?.currentPage = Int(pageIndex)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size : CGSize = CGSize.zero
        
        switch collectionView.tag {
        case 1:
            size = CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
        case 2:
            size = CGSize(width: collectionView.frame.size.width/2, height: collectionView.frame.size.height/3)
        default:
            size = CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
        }
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count : Int = 0
        switch collectionView.tag {
        case 1:
            count = homeVC?.sliderimages.first?.count ?? 0
        case 2:
            count = homeVC?.gridproducts.count ?? 0
        default:
            break
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell : UICollectionViewCell?
        switch collectionView.tag {
        case 1:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "COLLECTION_BANNER_ID", for: indexPath) as? HomeCollectionBannerCell
            //configure collection cell
            self.configureCollectionBannerCell(cell: cell as! HomeCollectionBannerCell, indexPath: indexPath)
        case 2:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HOME_COLLECTION_CELL", for: indexPath) as? HomeCollectionCell
            //configure collection cell
            self.configureCollectionCell(cell: cell as! HomeCollectionCell, indexPath: indexPath)
        default:
            break
        }
        
        return cell!
    }
    
    func configureCollectionBannerCell(cell : HomeCollectionBannerCell, indexPath : IndexPath) {
        //get the download url
        let downloadString = self.homeVC?.sliderimages.first?[indexPath.row] ?? ""
        cell.otlImageView?.sd_setImage(with: URL(string: downloadString), placeholderImage: nil, options: .continueInBackground, context: nil)
    }
    
    func configureCollectionCell(cell : HomeCollectionCell, indexPath : IndexPath) {
        //get the download url
        let downloadString = self.homeVC?.gridproducts[indexPath.row].image ?? ""
        cell.otlImageView?.sd_setImage(with: URL(string: downloadString), placeholderImage: nil, options: .continueInBackground, context: nil)
        //product detail && product price
        let productName = self.homeVC?.gridproducts[indexPath.row].name ?? "-"
        let productPrice = self.homeVC?.gridproducts[indexPath.row].price ?? 0
        
        cell.otlLblProductName?.text = productName
        cell.otlLblProductPrice?.text = "₹ \(productPrice)/-"
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.tag {
        case 1:
            break
        case 2:
            //get the download url
            let gridProduct = self.homeVC?.gridproducts[indexPath.row]

            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller : ProductListDetailsViewController = storyboard.instantiateViewController(withIdentifier: "PRODUCT_FULL_VIEW_ID") as! ProductListDetailsViewController
            controller.gridProductDetails = gridProduct
            
            self.navigationController?.pushViewController(controller, animated: true)
        default:
            break
        }
    }
    
}
