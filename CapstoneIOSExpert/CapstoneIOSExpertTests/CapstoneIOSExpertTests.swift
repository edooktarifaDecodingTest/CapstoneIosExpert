//
//  CapstoneIOSExpertTests.swift
//  CapstoneIOSExpertTests
//
//  Created by Phincon on 21/09/21.
//

import XCTest
import Swinject
import RxSwift
import NetworkServices

@testable import CapstoneIOSExpert


class CapstoneIOSExpertTests: XCTestCase {
    var sut: ListGameVM!
    var disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        
        sut = ListGameInjection.shared.container.resolve(ListGameVM.self)!
    }

    override class func tearDown() {
        super.tearDown()
        
    }
    
    func test_fetch_games_failed(){
        
        let error = ErrorMessage.unknownError.rawValue
        
        sut.getNewList()
        
        sut.errorMessage.drive(onNext: {
            (message) in
            if let message = message {
                XCTAssertEqual(message.rawValue, error)
            }
        }).disposed(by: disposeBag)
    }
    
    func test_number_of_rows(){
        let numberOfRow = sut.numberOfEmployees
        
        sut.getNewList()
        sut.getListGamesData.drive(onNext: { list in
            XCTAssertEqual(list.count, 0, "count number of rows is not same")
        }).disposed(by: disposeBag)
    }
}
