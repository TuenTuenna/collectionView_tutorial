//
//  ViewController.swift
//  dynamic_table_view
//
//  Created by Jeff Jeong on 2020/09/01.
//  Copyright © 2020 Tuentuenna. All rights reserved.
//

import UIKit
import ViewAnimator

let MY_TABLE_VIEW_CELL_ID = "myTableViewCell"

class MyTableVC: UIViewController {

    @IBOutlet weak var myTableView: UITableView!
    
    
    // 임시배열
    var tempArray : [Any] = []
    
    // 아래에서 위로 올라오는 애니메이션 배열
    private let animations = [
        AnimationType.vector(CGVector(dx: 0, dy: 50)),
//        AnimationType.zoom(scale: 0.8),
//        AnimationType.rotate(angle: CGFloat.pi/2)
    ]
    
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
        
        let myTableViewCellNib = UINib(nibName: String(describing: MyTableViewCell.self), bundle: nil)
        
        self.myTableView.register(myTableViewCellNib, forCellReuseIdentifier: MY_TABLE_VIEW_CELL_ID)
        
        self.myTableView.rowHeight = UITableView.automaticDimension
        
        self.myTableView.estimatedRowHeight = 120
        
        self.myTableView.delegate = self
        self.myTableView.dataSource = self

        print("contentArray.count : \(contentArray.count)")
        
        // 리프레시 컨트롤 테이블뷰에 달기
        let refreshControl = UIRefreshControl()
        
        refreshControl.tintColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        
        let boldFont = UIFont.boldSystemFont(ofSize: 20)
        let attributes : [NSAttributedString.Key : Any] = [
            .font : boldFont,
            .foregroundColor : UIColor.init(cgColor: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1))
        ]
        
        refreshControl.attributedTitle = NSAttributedString(string: "땡겨요~!", attributes: attributes)
        
        self.myTableView.refreshControl = refreshControl
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            [weak self] in
            guard let self = self else { return }
            // 테이블뷰와 연결된 데이터 변경
            self.tempArray = self.contentArray
            
            // 테이블뷰의 UI 갱신
            self.myTableView.reloadData()
            
            // 애니메이션 돌리기
            UIView.animate(views: self.myTableView.visibleCells,
                           animations: self.animations)
        })
        
        
        
        
    } // viewDidLoad()

    
    @objc fileprivate func handleRefresh(sender: AnyObject){
        print("MyTableVC - handleRefresh() called")
        
        // 기존 데이터 지우기
        self.tempArray.removeAll()
        
        // 사라지는 애니메이션 처리
        UIView.animate(views: self.myTableView.visibleCells, // 애니메이션을 적용할 뷰들
                       animations: self.animations, // 적용할 애니메이션
                       reversed: true,
                       initialAlpha: 1.0, // 보이다가
                       finalAlpha: 0.0, // 안보이게
                       completion: {
                        self.myTableView.reloadData() // 테이블뷰 UI 갱신
        })
        self.myTableView.refreshControl?.endRefreshing()
        
        //TODO: - API 땡겨서 데이터 가져오기
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: { [weak self] in
            guard let self = self else { return }
            
            // 진동주기
            let vibrate = UIImpactFeedbackGenerator(style: .light)
            vibrate.impactOccurred()
            
            // 테이블뷰와 연결된 데이터 변경
            self.tempArray = self.contentArray
            // 테이블뷰의 UI 갱신
            self.myTableView.reloadData()
            // 애니메이션 돌리기
            UIView.animate(views: self.myTableView.visibleCells,
                           animations: self.animations,
                           reversed: false,
                           initialAlpha: 0.0,
                           finalAlpha: 1.0,
//                           options: [.curveLinear],
                           completion: nil)
        })
        
    }


}


extension MyTableVC: UITableViewDelegate {



}

extension MyTableVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tempArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = myTableView.dequeueReusableCell(withIdentifier: MY_TABLE_VIEW_CELL_ID, for: indexPath) as! MyTableViewCell
        
        
        if tempArray.count > 0 {
            cell.contentLabel.text = tempArray[indexPath.row] as? String
        }
        

        return cell
    }


}
