//
//  ApiClients.swift
//  NetworkServices
//
//  Created by Phincon on 22/09/21.
//

import Foundation
import Alamofire
import RxSwift

public class Network<T: Codable> {
    
    public init() {}
    
    public func request<T: Codable> (url: String, method: HTTPMethod, parameters: Parameters, encoding: ParameterEncoding, headers: HTTPHeaders) -> Observable<T> {
        
        let absolutePath = "\(Constant.baseUrl)/\(url)"
        
        return Observable<T>.create { observer in
            let request = AF.request(absolutePath, method: method, parameters: parameters, encoding: encoding, headers: headers).responseJSON { response in
                switch response.result {
                case .success:
                    
                    guard let data = response.data else {
                        observer.onError(ApiError.notFound)
                        return
                    }
                    
                    do {
                        let dataJson = try JSONDecoder().decode(T.self, from: data)
                        observer.onNext(dataJson)
                        observer.onCompleted()
                    } catch {
                        observer.onError(error)
                    }
                    
                case .failure(let error):
                    switch response.response?.statusCode {
                    case 403:
                        observer.onError(ApiError.forbidden)
                    case 404:
                        observer.onError(ApiError.notFound)
                    case 409:
                        observer.onError(ApiError.conflict(error: error.localizedDescription))
                    case 500:
                        observer.onError(ApiError.internalServerError)
                    default:
                        observer.onError(error)
                    }
                }
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
