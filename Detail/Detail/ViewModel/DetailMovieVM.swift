//
//  DetailMovieVM.swift
//  Detail
//
//  Created by Phincon on 22/09/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import NetworkServices

class DetailMovieVM {
    private let disposeBag = DisposeBag()
    private let detailMovieList = BehaviorRelay<DetailGameModel?>(value: nil)
    private let error = BehaviorRelay<ErrorMessage?>(value: nil)
    
    private let detailUseCase: DetailGameUseCase
    
    init(detailUseCase: DetailGameUseCase) {
        self.detailUseCase = detailUseCase
    }
    
    var listGames: Driver<DetailGameModel?> {
        return detailMovieList.asDriver()
    }
    
    var errorMessage: Driver<ErrorMessage?>{
        return error.asDriver()
    }
    
    func showDetail(withId id: Int){
        detailUseCase.getListGame(withId: id)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {
                detailGames in
                self.detailMovieList.accept(detailGames)
            }, onError: {
                error in
                
                switch error {
                case ApiError.conflict:
                    self.error.accept(.conflict)
                case ApiError.forbidden:
                    self.error.accept(.forbidden)
                case ApiError.notFound:
                    self.error.accept(.notFound)
                case ApiError.internalServerError:
                    self.error.accept(.internalServerError)
                default:
                    self.error.accept(.unknownError)
                }
            }).disposed(by: disposeBag)
    }
}
