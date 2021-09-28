//
//  ListGameInjection.swift
//  CapstoneIOSExpert
//
//  Created by Phincon on 22/09/21.
//

import Foundation
import Swinject
import UIKit
import NetworkServices
import Core
import Domain

class ListGameInjection {
    static let shared = ListGameInjection()
    
    let container = Container() {
        container in
        
        container.register(Network.self) { _ in
            Network<ListGameModel>.init()
        }
        
        container.register(CoreDataManager.self) {_ in
            CoreDataManager()
        }
        
        container.register(ListGameRepo.self) { resolver in
            ListGameImpl(apiServices: resolver.resolve(Network<ListGameModel>.self)!, localData: resolver.resolve(CoreDataManager.self)!)
        }
        
        container.register(ListGameUseCase.self) { resolver in
            ListGameUseCase(listGameRepo: resolver.resolve(ListGameRepo.self)!)
        }
        
        container.register(ListGameVM.self) { resolver in
            ListGameVM(listGameUseCase: resolver.resolve(ListGameUseCase.self)!)
        }
    }
}
