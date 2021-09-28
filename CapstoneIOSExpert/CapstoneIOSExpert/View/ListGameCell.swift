//
//  ListGameCell.swift
//  CapstoneIOSExpert
//
//  Created by Phincon on 22/09/21.
//

import UIKit
import Cosmos
import Kingfisher
import SkeletonView
import Core
import Common

class ListGameCell: UICollectionViewCell {

    @IBOutlet weak var listTitleGameLbl: UILabel!
    @IBOutlet weak var listGameImg: UIImageView!
    @IBOutlet weak var listGameBackgroundView: UIView!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var saveToFavouriteBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configure()
    }
    
    func configure(){
        [listGameImg, listTitleGameLbl, ratingLbl, ratingView].forEach {
            $0?.showGradientSkeleton()
        }
        
        listGameBackgroundView.layer.cornerRadius = 10
        listGameBackgroundView.clipsToBounds = true
    }
    
    func showListGame(with content: ListGame){
        hideAnimation()
        listTitleGameLbl.text = content.name
        ratingLbl.text = "\(content.rating.truncate(places: 1))"
        ratingView.rating = content.rating
        ratingView.settings.updateOnTouch = false
        ratingView.settings.fillMode = .precise
        listGameImg.kf.setImage(with: URL(string: content.imageList ?? ""))
        if content.favourite == false {
            saveToFavouriteBtn.setImage(#imageLiteral(resourceName: "icons8-love-48"), for: .normal)
        } else {
            saveToFavouriteBtn.setImage(#imageLiteral(resourceName: "icons8-love-50"), for: .normal)
        }
    }
    
    func hideAnimation(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            [self.listGameImg, self.listTitleGameLbl, self.ratingLbl, self.ratingView].forEach {
                $0?.hideSkeleton()
            }
        }
    }

}
