//
//  ListGameImpl.swift
//  Domain
//
//  Created by Phincon on 22/09/21.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa
import NetworkServices
import Core

public final class ListGameImpl: ListGameRepo{
    
    var apiServices: Network<ListGameModel>
    private var listFromCoreData = BehaviorRelay<ListGame?>(value: nil)
    private var getListDataFromCoreData = BehaviorRelay<[ListGame]>(value: [])
    
    let param : Parameters = ["key": Constant.apiKey]
    
    var localData : CoreDataManager
    
    public init(apiServices: Network<ListGameModel>, localData: CoreDataManager) {
        self.apiServices = apiServices
        self.localData = localData
    }
    
    public func getListGame() -> Observable<ListGameModel> {
        apiServices.request(url: "games", method: .get, parameters: param, encoding: URLEncoding.default, headers: [:])
    }
    
    public func insertListGameCoreData(insertList withData: ListResultGame) -> Observable<ListGame?>{
        listFromCoreData.accept(localData.insertGameList(insertList: withData))
        return listFromCoreData.asObservable()
    }
    
    public func getListGameCoreData() -> Observable<[ListGame]> {
        getListDataFromCoreData.accept(localData.fetchAllGames() ?? [])
        return getListDataFromCoreData.asObservable()
    }
    
    public func updateListCoreData(selectedIndex favourite: Bool, withIndex index: Int) -> Observable<ListGame?> {
        listFromCoreData.accept(localData.updateDataList(listSelected: favourite, withIndex: index))
        return listFromCoreData.asObservable()
    }
    
    public func getListGameCoreDataFavourite() -> Observable<[ListGame]> {
        getListDataFromCoreData.accept(localData.fetchAllGamesFavourite() ?? [])
        return getListDataFromCoreData.asObservable()
    }

    public func updateListFavourite(selectedIndex favourite: Bool, withId id: Int) -> Observable<ListGame?> {
        listFromCoreData.accept(localData.updateDataListFavourite(listSelected: favourite, withIndex: id))
        return listFromCoreData.asObservable()
    }
}
