//
//  DetailGameRepo.swift
//  Detail
//
//  Created by Phincon on 22/09/21.
//

import Foundation
import RxSwift

protocol DetailGameRepo {
    func getListGame(withId id: Int) -> Observable<DetailGameModel>
}
