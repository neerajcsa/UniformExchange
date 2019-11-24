//
//  HomeViewController.swift
//  Uniform Exchange
//
//  Created by Neeraj Pandey on 19/10/19.
//  Copyright © 2019 Neeraj Pandey. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

extension HomeViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell : HomeCollectionCell?
        
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HOME_COLLECTION_CELL", for: indexPath) as? HomeCollectionCell
        
        return cell!
    }
    
    
}
