//
//  FavouriteVC.swift
//  Favourite
//
//  Created by Phincon on 22/09/21.
//

import UIKit
import RxSwift
import Core
import CommonLibHelperCapstone

public class FavouriteVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDataView: UIView!
    
    let disposeBag = DisposeBag()
    
    private var vm: FavouriteGameVM!
    public var getList: ListGame?
    private var navigateTo: Routers!
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        vm = ListGameInjection.shared.container.resolve(FavouriteGameVM.self)!
        navigateTo = Routers(view: self)
        
        let frameworkBundle = Bundle(identifier: "asd.Favourite")
        let nib = UINib(nibName: "FavouriteGameCell", bundle: frameworkBundle)
        tableView.register(nib, forCellReuseIdentifier: "FavouriteGameCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        noDataView.isHidden = true
        vm.getListGamesData.drive(onNext: {
            [unowned self] list in
            
            if list.count == 0 {
                noDataView.isHidden = false
            } else {
                noDataView.isHidden = true
            }
            
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        vm.getListGameFromCoreData()
    }
}

extension FavouriteVC: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.numberOfEmployees
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteGameCell", for: indexPath) as! FavouriteGameCell
        
        if let item = vm.modelForIndex(at: indexPath.row){
            cell.showListGame(with: item)
            cell.delegate = self
            cell.favouriteTrashBtn.tag = indexPath.row
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateTo.favouriteMoveToDetail(withId: indexPath.row, vm: vm)
    }
}

extension FavouriteVC: FavouriteGameSelected {
    func didSelectAt(_ tag: Int) {
        if let favouriteGames = vm.modelForIndex(at: tag){
            presentAlertWithTitle(title: "Remove Favourite?", message: "Apakah anda yakin menghapus \(favouriteGames.name ?? "") dari list Favourite?", options: "OK", "Cancel") { option in
                
                switch option {
                case 0:
                    self.vm.updateListFavourite(selectedIndex: false, withId: Int(favouriteGames.id))
                    self.vm.getListGameFromCoreData()
                    self.tableView.reloadData()
                case 1:
                    self.dismiss(animated: true, completion: nil)
                default:
                    break
                }
            }
        }
    }
}
