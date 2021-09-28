//
//  DetailGameImpl.swift
//  Detail
//
//  Created by Phincon on 22/09/21.
//

import Foundation
import Alamofire
import RxSwift
import NetworkServices

final class DetailGameImpl: DetailGameRepo{
    
    var apiServices: Network<DetailGameModel>
    let param : Parameters = ["key": Constant.apiKey]
    
    init(apiServices: Network<DetailGameModel>) {
        self.apiServices = apiServices
    }
    
    func getListGame(withId id: Int) -> Observable<DetailGameModel> {
        apiServices.request(url: "games/\(id)", method: .get, parameters: param, encoding: URLEncoding.default, headers: [:])
    }
}
