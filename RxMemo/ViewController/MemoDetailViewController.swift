//
//  MemoDetailViewController.swift
//  RxMemo
//
//  Created by 정기욱 on 2019/11/20.
//  Copyright © 2019 kiwook. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class MemoDetailViewController: UIViewController, ViewModelBindableType {

    @IBOutlet var listTableView: UITableView!
    @IBOutlet var deleteButton: UIBarButtonItem!
    
    @IBOutlet var editButton: UIBarButtonItem!
    
    @IBOutlet var shareButton: UIBarButtonItem!
    
    
    var viewModel : MemoDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func bindViewModel() {
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)
        
        viewModel.contents
            .bind(to: listTableView.rx.items) { tableView, row, value in
                switch row {
                case 0:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "contentCell")!
                    cell.textLabel?.text = value
                    return cell
                    
                case 1:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell")!
                    cell.textLabel?.text = value
                    return cell
                    
                default:
                    fatalError()
                }
            }
            .disposed(by: rx.disposeBag)
                
        }
    

}
