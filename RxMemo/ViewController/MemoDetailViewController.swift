//
//  MemoDetailViewController.swift
//  RxMemo
//
//  Created by 정기욱 on 2019/11/20.
//  Copyright © 2019 kiwook. All rights reserved.
//

import UIKit

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
        
    }

}
