//
//  ProfileViewCell.swift
//  Lagree
//
//  Created by Arsen Leontijevic on 9/26/19.
//  Copyright © 2019 Arsen Leontijevic. All rights reserved.
//

import UIKit

class ProfileViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate  {

    //First cell
    @IBOutlet weak var welcomeName: UILabel!
    @IBOutlet weak var balance: UILabel!
    @IBAction func yourJourney(_ sender: Any) {
    }
    @IBOutlet weak var firstCellImage: UIImageView!
    
    //Second cell
    @IBOutlet weak var sessionImage: UIImageView!
    @IBOutlet weak var sessionName: UILabel!
    @IBOutlet weak var sessionDate: UILabel!
    @IBOutlet weak var studioName: UILabel!
    @IBOutlet weak var instructor: UILabel!
    
    //Third cell
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var favoriteCounts: UILabel!
    
    var source:[Favorite] = []
    
    
    @IBOutlet weak var favoritesView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if(welcomeName != nil)
        {
            welcomeName.text = "Hi,  \(User.getLoggedUser().first_name)"
            
        }
        // Initialization code
        if self.collectionView != nil {
            
            

            favoritesView.viewBorderBottom()
            
            //Get favorites from API
            let dm = DataManager()
            dm.getFavorites{ (json) in
                for (_, item) in json {
                    let favorite = Favorite(json: item)
                    self.source.append(favorite)
                }
                self.collectionView.reloadData()
            }
            self.collectionView.dataSource = self
            self.collectionView.delegate = self
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return source.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let favorite = source[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteCell", for: indexPath) as! FavoriteViewCell
        cell.favoriteName.text = favorite.name
        cell.favoriteImage.setRounded()
        cell.favoriteImage.downloadedFrom(link: favorite.imageUrl!, contentMode: .scaleAspectFill)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: IndexPath) {
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
