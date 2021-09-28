//
//  DetailGameInjection.swift
//  Detail
//
//  Created by Phincon on 22/09/21.
//

import Foundation
import Swinject
import UIKit
import NetworkServices

class DetailGameInjection {
    static let shared = DetailGameInjection()
    
    let container = Container() {
        container in
        
        container.register(Network.self) { _ in
            Network<DetailGameModel>.init()
        }
        
        container.register(DetailGameRepo.self) { resolver in
            DetailGameImpl(apiServices: resolver.resolve(Network<DetailGameModel>.self)!)
        }
        
        container.register(DetailGameUseCase.self) { resolver in
            DetailGameUseCase(detailGameRepo: resolver.resolve(DetailGameRepo.self)!)
        }
        
        container.register(DetailMovieVM.self) { resolver in
            DetailMovieVM(detailUseCase: resolver.resolve(DetailGameUseCase.self)!)
        }
    }
}
