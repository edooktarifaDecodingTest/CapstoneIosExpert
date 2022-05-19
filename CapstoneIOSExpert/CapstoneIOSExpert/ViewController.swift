//
//  ViewController.swift
//  CapstoneIOSExpert
//
//  Created by Phincon on 21/09/21.
//

import UIKit
import Detail
import NetworkServices
import RxSwift
import Core

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var vm: ListGameVM!
    var disposeBag = DisposeBag()
    
    var arrSelectedRows:[Int] = []
    var selected = Bool()
    
    private var navigateTo: Router!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.register(UINib(nibName: "ListGameCell", bundle: nil), forCellWithReuseIdentifier: "ListGameCell")
        
//        title = "HomeTitle".localized()
        title = "HomeTitle".localized(identifier: "asd.CapstoneIOSExpert")
        
        navigateTo = Router(view: self)
        
        vm = ListGameInjection.shared.container.resolve(ListGameVM.self)!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showData()
    }
    
    private func showData(){
        vm.getListGamesData.drive(onNext: {
            [unowned self] detail in
            arrSelectedRows.removeAll()
            
            for i in detail.enumerated() {
                if i.element.favourite == true {
                    arrSelectedRows.append(i.offset)
                }
            }
            
            self.collectionView.reloadData()
        }).disposed(by: disposeBag)
        
        vm.errorMessage.drive(onNext: {
            [unowned self] (message) in
            if let message = message {
//                self.showAlert(title: "Error", message: message.rawValue)
            }
        }).disposed(by: disposeBag)
        
        vm.getListGameFromCoreData()
    }
    
    @IBAction func moveToFavourite(){
        navigateTo.moveToFavourite()
    }
    
    @IBAction func moveToProfile(){
        navigateTo.moveToProfile()
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.numberOfEmployees
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListGameCell", for: indexPath) as! ListGameCell

        if let item = vm.modelForIndex(at: indexPath.row){

            cell.showListGame(with: item)
            cell.saveToFavouriteBtn.addTarget(self, action: #selector(checkBoxSelection), for: .touchUpInside)
            cell.saveToFavouriteBtn.tag = indexPath.row

            if arrSelectedRows.contains(indexPath.row) {
                cell.saveToFavouriteBtn.setImage(#imageLiteral(resourceName: "icons8-love-50"), for: .normal)
            } else {
                cell.saveToFavouriteBtn.setImage(#imageLiteral(resourceName: "icons8-love-48"), for: .normal)
            }
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 10 - 10*2)/2, height: collectionView.frame.height / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(vm.modelForIndex(at: indexPath.row)?.id)
        navigateTo.moveToDetailGames(withId: indexPath.row, vm: vm)
    }
    
    @objc func checkBoxSelection(_ sender:UIButton)
    {
        if let games = vm.modelForIndex(at: sender.tag){
            addToFavourite(withList: games, withIndex: sender.tag)
        }
    }
    
    func addToFavourite(withList result: ListGame, withIndex index: Int){
        if result.favourite == true {
            removeAndUpdateList(withList: result, withIndex: index, withTitle: "Apakah anda yakin mengahapus list Favourite?", withDetail: "Apakah anda yakin mengahapus \(result.name ?? "") dari Favourite?")
        } else {
            removeAndUpdateList(withList: result, withIndex: index, withTitle: "Simpan data ke favourite?", withDetail: "Apakah anda yakin menyimpan \(result.name ?? "") ke Favourite?")
        }
    }
    
    func removeAndUpdateList(withList result: ListGame, withIndex index: Int, withTitle title: String, withDetail detail:String){
        presentAlertWithTitle(title: title, message: detail, options: "OK", "Cancel") { option in
            switch option {
            case 0:
                if self.arrSelectedRows.contains(index){
                    self.vm.updateListGameFromCoreData(update: false, withIndex: index)
                } else {
                    self.vm.updateListGameFromCoreData(update: true, withIndex: index)
                    self.navigateTo.moveToFavouriteWithData(withList: result)
                }
                self.vm.getListGameFromCoreData()
                
            case 1:
                self.dismiss(animated: true, completion: nil)
            default:
                break
            }
        }
    }
}

