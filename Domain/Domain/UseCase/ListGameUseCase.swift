//
//  ListGameUseCase.swift
//  Domain
//
//  Created by Phincon on 22/09/21.
//

import Foundation
import RxSwift
import Core

public class ListGameUseCase {
    let listGameRepo: ListGameRepo
    
    public init(listGameRepo: ListGameRepo) {
        self.listGameRepo = listGameRepo
    }
    
    public func getListGame() -> Observable<ListGameModel> {
        listGameRepo.getListGame()
    }
    
    public func insertListGameCoreData(insertList withData: ListResultGame) -> Observable<ListGame?> {
        listGameRepo.insertListGameCoreData(insertList: withData)
    }
    
    public func getListGameCoreData() -> Observable<[ListGame]>{
        listGameRepo.getListGameCoreData()
    }
    
    public func updateListGameCoreData(selectedFavourite favourite: Bool, withIndex index: Int) -> Observable<ListGame?>{
        listGameRepo.updateListCoreData(selectedIndex: favourite, withIndex: index)
    }
    
    public func getListGameCoreDataFavourite() -> Observable<[ListGame]>{
        listGameRepo.getListGameCoreDataFavourite()
    }
    
    public func updateListFavourite(selectedIndex favourite: Bool, withId id: Int) -> Observable<ListGame?>{
        listGameRepo.updateListFavourite(selectedIndex: favourite, withId: id)
    }
}
