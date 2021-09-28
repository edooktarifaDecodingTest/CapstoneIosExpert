//
//  Router.swift
//  Favourite
//
//  Created by Phincon on 22/09/21.
//

import Foundation
import UIKit
import Detail
import Core
import Profile

class Routers {
    var view: UIViewController!
    
    init(view: UIViewController) {
        self.view = view
    }
    
    func favouriteMoveToDetail(withId index: Int, vm: FavouriteGameVM){
        
        let vc = DetailViewController(nibName: "DetailViewController", bundle: Bundle(identifier: "asd.Detail"))
        
        if let item = vm.modelForIndex(at: index)?.id{
            vc.id = Int(item)
        }
        
        self.view.navigationController?.pushViewController(vc, animated: true)
    }
}
