//
//  ViewController.swift
//  dynamic_table_view
//
//  Created by Jeff Jeong on 2020/09/01.
//  Copyright © 2020 Tuentuenna. All rights reserved.
//

import UIKit

let MY_TABLE_VIEW_CELL_ID = "myTableViewCell"

class MyTableVC: UIViewController {

    @IBOutlet weak var myTableView: UITableView!
    
    let contentArray = [
        "simply dummy text of the printing and",
        
        "um has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type ",
        
        "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribestablished fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, co",
        
        "ho loves pain itself, who seeks after it and wants to have it, simply because it is pai",
        
        "established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, co",
        
        "ho loves pain itself, who seeks after it and wants to have it, simply because it is pai",
        
        "a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is thaai",
        
        "ho loves pain ita reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is to have it, simply because it is pai",
        
        "ho loves pain itself, who seeks after it and wants to have it, simplho loves pain ita reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is to have it, simply because it y because it is pai",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewController - viewDidLoad() called")
        // Do any additional setup after loading the view.
        
        // 쎌 리소스 파일 가져오기
//        let myTableViewCellNib = UINib(nibName: String(describing: MyTableViewCell.self), bundle: nil)
        
        let myTableViewCellNib = UINib(nibName: String(describing: MyTableViewCell.self), bundle: nil)
        
        self.myTableView.register(myTableViewCellNib, forCellReuseIdentifier: MY_TABLE_VIEW_CELL_ID)
        
        self.myTableView.rowHeight = UITableView.automaticDimension
        
        self.myTableView.estimatedRowHeight = 120
        
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        
        // hide extra blank rows
//        self.myTableView.tableFooterView = UIView()
        
        print("contentArray.count : \(contentArray.count)")
        
    }

    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.contentArray.count
//       }
//
//       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//           let cell = myTableView.dequeueReusableCell(withIdentifier: MY_TABLE_VIEW_CELL_ID, for: indexPath) as! MyTableViewCell
//
//           cell.contentLabel.text = contentArray[indexPath.row]
//
//           return cell
//       }
       

}


extension MyTableVC: UITableViewDelegate {



}

extension MyTableVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contentArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = myTableView.dequeueReusableCell(withIdentifier: MY_TABLE_VIEW_CELL_ID, for: indexPath) as! MyTableViewCell

        cell.contentLabel.text = contentArray[indexPath.row]

        return cell
    }


}
