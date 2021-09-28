//
//  FavouriteGameVM.swift
//  Favourite
//
//  Created by Phincon on 22/09/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import Core
import NetworkServices
import Domain

class FavouriteGameVM{

    var disposeBag = DisposeBag()
    
    public let error = BehaviorRelay<ErrorMessage?>(value: nil)
    private let getList = BehaviorRelay<[ListGame]>(value: [])
    
    private let listUseCase: ListGameUseCase
    
    init(listGameUseCase: ListGameUseCase) {
        self.listUseCase = listGameUseCase
    }
    
    var getListGamesData: Driver<[ListGame]>{
        return getList.asDriver()
    }
    
    var errorMessage: Driver<ErrorMessage?>{
        return error.asDriver()
    }
    
    var numberOfEmployees: Int {
        return getList.value.count
    }
    
    func modelForIndex(at index: Int) -> ListGame? {
        guard index < getList.value.count else {
            return nil
        }
        return getList.value[index]
    }
    
    func getListGameFromCoreData(){
        listUseCase.getListGameCoreDataFavourite().observeOn(MainScheduler.instance).subscribe(onNext: {
            getListGame in
        
            self.getList.accept(getListGame)
            
        }, onError: {
            error in
        }).disposed(by: disposeBag)
    }
    
    func updateListGameFromCoreData(update list: Bool, withIndex index: Int){
        listUseCase.updateListGameCoreData(selectedFavourite: list, withIndex: index).subscribe(onNext: {
            updateList in
            
        }, onError: {
            error in
        }).disposed(by: disposeBag)
    }
    
    func updateListFavourite(selectedIndex favourite: Bool, withId id: Int){
        listUseCase.updateListFavourite(selectedIndex: favourite, withId: id).subscribe(onNext: {
            updateList in
        }, onError: {
            error in
        }).disposed(by: disposeBag)
    }
}
