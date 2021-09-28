//
//  ListGameRepo.swift
//  Domain
//
//  Created by Phincon on 22/09/21.
//

import Foundation
import RxSwift
import Core

public protocol ListGameRepo {
    func getListGame() -> Observable<ListGameModel>
    func insertListGameCoreData(insertList withData: ListResultGame) -> Observable<ListGame?>
    func getListGameCoreData() -> Observable<[ListGame]>
    func updateListCoreData(selectedIndex favourite: Bool, withIndex index: Int) -> Observable<ListGame?>
    func getListGameCoreDataFavourite() -> Observable<[ListGame]>
    func updateListFavourite(selectedIndex favourite: Bool, withId id: Int) -> Observable<ListGame?>
}
