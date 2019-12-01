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
    @IBOutlet weak var otlProgressView : UIActivityIndicatorView?
    
    var homeVC : HomeVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //call service
        self.callServiceToGetDashboardDetails()
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
    
    func callServiceToGetDashboardDetails() {
        //start animation
        self.manageProgressView(isHidden: true)
        
        //create request
        let dashBoardURL : URL? = URL(string : String(format: "%@%@", Application.appDelegate.strServerURL ?? "",Service.dashboard))
        let genericService = GenericService()
        genericService.getRequestForService(getURL: dashBoardURL!, httpMethod: "GET") { [weak self] (data, response, error) in
            
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
                    self?.homeVC = try decoder.decode(HomeVC.self, from: data)
                    if self?.homeVC?.success == "true" {
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

extension HomeViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeVC?.sliderimages.first?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell : HomeCollectionCell?
        
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HOME_COLLECTION_CELL", for: indexPath) as? HomeCollectionCell
        //configure collection cell
        self.configureCollectionCell(cell: cell!, indexPath: indexPath)

        return cell!
    }
    
    func configureCollectionCell(cell : HomeCollectionCell, indexPath : IndexPath) {
        //get the download url
        let downloadString = self.homeVC?.sliderimages.first?[indexPath.row] ?? ""
        cell.otlImageView?.sd_setImage(with: URL(string: downloadString), placeholderImage: nil, options: .continueInBackground, context: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
