//
//  MemoListViewController.swift
//  RxMemo
//
//  Created by 정기욱 on 2019/11/20.
//  Copyright © 2019 kiwook. All rights reserved.
//

import UIKit


class MemoListViewController: UIViewController, ViewModelBindableType {
    
    var viewModel : MemoListViewModel!
    
    @IBOutlet weak var listTableView: UITableView!

    @IBOutlet weak var addButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func bindViewModel() {
        
    }


}
