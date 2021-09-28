//
//  ListVM.swift
//  CapstoneIOSExpert
//
//  Created by Phincon on 22/09/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import NetworkServices
import Core
import Domain
import Common

class ListGameVM {
    
    var disposeBag = DisposeBag()
    
    public let error = BehaviorRelay<ErrorMessage?>(value: nil)
    private let getList = BehaviorRelay<[ListGame]>(value: [])
    
    var listUseCase: ListGameUseCase
    
    var getListGamesData: Driver<[ListGame]>{
        return getList.asDriver()
    }
    
    var errorMessage: Driver<ErrorMessage?>{
        return error.asDriver()
    }
    
    var numberOfEmployees: Int {
        return getList.value.count
    }
    
    init(listGameUseCase: ListGameUseCase) {
        self.listUseCase = listGameUseCase
    }
    
    func modelForIndex(at index: Int) -> ListGame? {
        guard index < getList.value.count else {
            return nil
        }
        return getList.value[index]
    }
    
    
    func getNewList() {
        listUseCase.getListGame()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {
                listGames in
                
                for data in listGames.results {
                    self.insertListGameCoreData(insertList: data)
                }
                
                self.getListGameFromCoreData()
            },
            onError: {
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
    
    func insertListGameCoreData(insertList withData: ListResultGame){
        listUseCase.insertListGameCoreData(insertList: withData).observeOn(MainScheduler.instance).subscribe(onNext: {
            insertGame in
            
            guard let insertGame = insertGame else { return }
            self.getList.add(element: insertGame)
            
        }, onError: {
            error in
        }).disposed(by: disposeBag)
    }
    
    func getListGameFromCoreData(){
        
        listUseCase.getListGameCoreData().observeOn(MainScheduler.instance).subscribe(onNext: {
            getListGame in
            print(getListGame.count)
            if getListGame != [] {
                self.getList.accept(getListGame)
            } else {
                self.getNewList()
            }
        }, onError: {
            error in
            print(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
    
    func updateListGameFromCoreData(update list: Bool, withIndex index: Int){
        listUseCase.updateListGameCoreData(selectedFavourite: list, withIndex: index).subscribe(onNext: {
            updateList in
            
        }, onError: {
            error in
        }).disposed(by: disposeBag)
    }
}
