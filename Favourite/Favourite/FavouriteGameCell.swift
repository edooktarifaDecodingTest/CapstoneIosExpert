//
//  FavouriteGameCell.swift
//  Favourite
//
//  Created by Phincon on 22/09/21.
//

import UIKit
import Kingfisher
import Cosmos
import Core

protocol FavouriteGameSelected {
    func didSelectAt(_ tag: Int)
}

class FavouriteGameCell: UITableViewCell {

    @IBOutlet weak var favouriteGamesTitleLbl: UILabel!
    @IBOutlet weak var favouriteGamesReleaseLbl: UILabel!
    @IBOutlet weak var favouriteGamesImg: UIImageView!
    @IBOutlet weak var favouriteRatingView: CosmosView!
    @IBOutlet weak var favouriteTrashBtn: UIButton!
    
    var delegate: FavouriteGameSelected?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        favouriteGamesImg.layer.cornerRadius = 35
        self.selectionStyle = UITableViewCell.SelectionStyle.none
    }
    
    func showListGame(with content: ListGame){
        favouriteGamesTitleLbl.text = content.name
        favouriteRatingView.rating = content.rating
        favouriteRatingView.settings.updateOnTouch = false
        favouriteRatingView.settings.fillMode = .precise
        favouriteGamesReleaseLbl.text = content.released
        favouriteGamesImg.kf.setImage(with: URL(string: content.imageList ?? ""))
    }
    
    @IBAction func trashButtonAction(_ sender: UIButton){
        delegate?.didSelectAt(sender.tag)
    }
}
