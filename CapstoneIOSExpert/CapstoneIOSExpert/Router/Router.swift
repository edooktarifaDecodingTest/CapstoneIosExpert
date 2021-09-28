//
//  Router.swift
//  CapstoneIOSExpert
//
//  Created by Phincon on 22/09/21.
//

import Foundation
import UIKit
import Detail
import Favourite
import Core
import Profile

class Router {
    var view: UIViewController!
    
    init(view: UIViewController) {
        self.view = view
    }
    
    func moveToDetailGames(withId index: Int, vm: ListGameVM) {
        let vc = DetailViewController(nibName: "DetailViewController", bundle: Bundle(identifier: "asd.Detail"))
        if let withId = vm.modelForIndex(at: index){
            vc.id = Int(withId.id)
        }
        self.view.navigationController?.pushViewController(vc, animated: true)
    }
    
    func moveToFavourite(){
        let vc = FavouriteVC(nibName: "FavouriteVC", bundle: Bundle(identifier: "asd.Favourite"))
        self.view.navigationController?.pushViewController(vc, animated: true)
    }
    
    func moveToFavouriteWithData(withList list: ListGame){
        
        let vc = FavouriteVC(nibName: "FavouriteVC", bundle: Bundle(identifier: "asd.Favourite"))
        vc.getList = list
        self.view.navigationController?.pushViewController(vc, animated: true)
    }
    
    func moveToProfile(){
        let vc = ProfileVC(nibName: "ProfileVC", bundle: Bundle(identifier: "asd.Profile"))
        self.view.navigationController?.pushViewController(vc, animated: true)
    } 
}
