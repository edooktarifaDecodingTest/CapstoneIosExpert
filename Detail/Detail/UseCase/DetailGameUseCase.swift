//
//  DetailGameUseCase.swift
//  Detail
//
//  Created by Phincon on 22/09/21.
//

import Foundation
import RxSwift

final class DetailGameUseCase {
    let detailGameRepo: DetailGameRepo
    
    init(detailGameRepo: DetailGameRepo) {
        self.detailGameRepo = detailGameRepo
    }
    
    func getListGame(withId id: Int) -> Observable<DetailGameModel> {
        detailGameRepo.getListGame(withId: id)
    }
}
