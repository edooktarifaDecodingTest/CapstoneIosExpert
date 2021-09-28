//
//  DetailViewController.swift
//  Detail
//
//  Created by Phincon on 21/09/21.
//

import UIKit
import Cosmos
import SkeletonView
import RxSwift
import Kingfisher
import Common

public class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailImg:UIImageView!
    @IBOutlet weak var detailTitle:UILabel!
    @IBOutlet weak var ratingLbl:UILabel!
    @IBOutlet weak var dateReleaseLbl:UILabel!
    @IBOutlet weak var ratingCountLbl:UILabel!
    @IBOutlet weak var achievementsCountLbl:UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var backgroundGamesView: UIView!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var noDataView: UIView!
    
    public var id : Int?
    private var detailVm: DetailMovieVM!
    var disposeBag = DisposeBag()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        detailVm = DetailGameInjection.shared.container.resolve(DetailMovieVM.self)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupSkeletonView()
        fetchData()
        
        let backButton = UIBarButtonItem()
        backButton.title = "DetailTitle".localized(identifier: "asd.Detail")
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    func fetchData(){
        detailVm.showDetail(withId: id ?? 0)
        noDataView.isHidden = true
        detailVm.listGames.drive(onNext: {
            [unowned self] gameDetail in
            
            self.hideAnimation()
            if let gameDetail = gameDetail{
                
                self.detailImg.kf.setImage(with: URL(string: gameDetail.backgroundImage ?? ""))
                self.ratingView.settings.updateOnTouch = false
                self.ratingView.settings.fillMode = .precise
                self.ratingLbl.text = "\(gameDetail.rating ?? 0.0)"
                self.backgroundGamesView.roundCorners(corners: [.topLeft, .topRight], radius: 30)
                self.detailTextView.text = gameDetail.descriptionRaw
                self.title = gameDetail.name
                self.detailTitle.text = gameDetail.name
                self.dateReleaseLbl.text = gameDetail.released
                self.ratingCountLbl.text = "\(gameDetail.ratingsCount ?? 0)"
                self.achievementsCountLbl.text = "\(gameDetail.achievementsCount ?? 0)"
                noDataView.isHidden = true
            }
            
        }).disposed(by: disposeBag)
        
        detailVm.errorMessage.drive(onNext: {
            [unowned self] (message) in
            if let message = message {
                //                self.showAlert(title: "Error", message: message.rawValue)
                noDataView.isHidden = false
            }
        }).disposed(by: disposeBag)
    }
    
    
    func setupSkeletonView(){
        [detailImg, ratingLbl, ratingView, detailTextView, dateReleaseLbl, ratingCountLbl, achievementsCountLbl, detailTitle].forEach {
            $0?.showGradientSkeleton()
        }
    }
    
    func hideAnimation(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            [self.detailImg, self.ratingView, self.ratingLbl, self.detailTextView, self.dateReleaseLbl, self.ratingCountLbl, self.achievementsCountLbl, self.detailTitle].forEach {
                $0?.hideSkeleton()
            }
        }
    }
    
}
