//
//  MyCollectionVC.swift
//  dynamic_table_view
//
//  Created by Jeff Jeong on 2020/11/14.
//  Copyright © 2020 Tuentuenna. All rights reserved.
//

import Foundation
import UIKit
import ViewAnimator


class MyCollectionVC: UIViewController {
    
    
    @IBOutlet var mySegmentControl: UISegmentedControl!
    @IBOutlet var myCollectionView: UICollectionView!
    
    // 임시배열
    var tempArray : [Any] = []
    
    // 아래에서 위로 올라오는 애니메이션 배열
    private let animations = [
        AnimationType.vector(CGVector(dx: 0, dy: 50)),
//        AnimationType.zoom(scale: 0.8),
//        AnimationType.rotate(angle: CGFloat.pi/2)
    ]
    
    fileprivate let systemImageNameArray = [
        "moon", "zzz", "sparkles", "cloud", "tornado", "smoke.fill", "tv.fill", "gamecontroller", "headphones", "flame", "bolt.fill", "hare", "tortoise", "moon", "zzz", "sparkles", "cloud", "tornado", "smoke.fill", "tv.fill", "gamecontroller", "headphones", "flame", "bolt.fill", "hare", "tortoise", "ant", "hare", "car", "airplane", "heart", "bandage", "waveform.path.ecg", "staroflife", "bed.double.fill", "signature", "bag", "cart", "creditcard", "clock", "alarm", "stopwatch.fill", "timer"
    ]
    
    
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        // 정대리 유튜브 커뮤니티 상속 13번 글 참고
        super.viewDidLoad()
        print("MyCollectionVC - viewDidLoad() called")
        
        // 콜렉션 뷰에 대한 설정
        myCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        
    
        // 닙파일을 가져온다
        let myCustomCollectionViewCellNib = UINib(nibName: String(describing: MyCustomCollectionViewCell.self), bundle: nil)
        
        // 가져온 닙파일로 콜렉션뷰에 쎌로 등록한다
        self.myCollectionView.register(myCustomCollectionViewCellNib, forCellWithReuseIdentifier: String(describing: MyCustomCollectionViewCell.self))
        
        // 콜렉션뷰의 콜렉션뷰 레이아웃을 설정한다.
        self.myCollectionView.collectionViewLayout = createCompositionalLayoutForFirst()
     
        
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
        
        self.myCollectionView.refreshControl = refreshControl
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            [weak self] in
            guard let self = self else { return }
            // 테이블뷰와 연결된 데이터 변경
            self.tempArray = self.systemImageNameArray
            
            // 테이블뷰의 UI 갱신
            self.myCollectionView.reloadData()
            
            self.myCollectionView.performBatchUpdates({
                // 애니메이션 돌리기
                UIView.animate(views: self.myCollectionView.orderedVisibleCells,
                               animations: self.animations)
            }, completion: nil)
            
           
        })
        
    } // viewDidLoad()
    
    
    @objc fileprivate func handleRefresh(sender: AnyObject){
        print("MyCollectionVC - handleRefresh() called")
        // 기존 데이터 지우기
        self.tempArray.removeAll()
        // 사라지는 애니메이션 처리
        UIView.animate(views: self.myCollectionView.orderedVisibleCells,
                       animations: self.animations,
                       reversed: true, // 애니메이션 반전
                       initialAlpha: 1.0, // 처음에는 보였다가
                       finalAlpha: 0.0, // 끝에 안보임,
                       options: [.curveEaseIn],
                       completion: {
                        self.myCollectionView.reloadData()
                       })
        self.myCollectionView.refreshControl?.endRefreshing()
        
        //TODO: - API 땡겨서 데이터 가져오기
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: { [weak self] in
            guard let self = self else { return }
            
            // 진동주기
            let vibrate = UIImpactFeedbackGenerator(style: .light)
            vibrate.impactOccurred()
            
            // 콜렉션뷰와 연결된 데이터 변경
            self.tempArray = self.systemImageNameArray
            // 콜렉션뷰의 UI 갱신
            self.myCollectionView.reloadData()
            self.myCollectionView.performBatchUpdates({
                // 애니메이션 돌리기
                UIView.animate(views: self.myCollectionView.orderedVisibleCells,
                               animations: self.animations,
                               reversed: false,
                               initialAlpha: 0.0,
                               finalAlpha: 1.0,
    //                           options: [.curveLinear],
                               completion: nil)
            }, completion: nil)
        })
    }

    
    @IBAction func onCollectionViewTypeChanged(_ sender: UISegmentedControl) {
        print("MyCollectionVC - onCollectionViewTypeChanged() called / sender.selectedSegmentIndex : \(sender.selectedSegmentIndex)")
        switch sender.selectedSegmentIndex {
        case 0:
            // 테이블뷰 형태
            self.myCollectionView.collectionViewLayout = createCompositionalLayoutForFirst()
        case 1:
            // 2 x 2 그리드 형태
            self.myCollectionView.collectionViewLayout = createCompositionalLayoutForSecond()
        case 2: // 3 x 3 그리드 형태
            self.myCollectionView.collectionViewLayout = createCompositionalLayoutForThird()
        default:
            break
        }
    }
    
} //


//MARK: - 콜렉션뷰 콤포지셔널 레이아웃 관련
extension MyCollectionVC {
    
    // 콤포지셔널 레이아웃 설정
    fileprivate func createCompositionalLayoutForFirst() -> UICollectionViewLayout {
        print("createCompositionalLayoutForFirst() called")
        // 콤포지셔널 레이아웃 생성
        let layout = UICollectionViewCompositionalLayout{
            // 만들게 되면 튜플 (키: 값, 키: 값) 의 묶음으로 들어옴 반환 하는 것은 NSCollectionLayoutSection 콜렉션 레이아웃 섹션을 반환해야함
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            // 아이템에 대한 사이즈 - absolute 는 고정값, estimated 는 추측, fraction 퍼센트
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            
            // 위에서 만든 아이템 사이즈로 아이템 만들기
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // 아이템 간의 간격 설정
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            // 변경할 부분
            let groupHeight =  NSCollectionLayoutDimension.fractionalWidth(1/3)
            
            // 그룹사이즈
            let grouSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: groupHeight)
            
            // 그룹사이즈로 그룹 만들기
//            let group = NSCollectionLayoutGroup.horizontal(layoutSize: grouSize, subitems: [item, item, item])
            
            // 변경할 부분
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: grouSize, subitem: item, count: 1)
            
            // 그룹으로 섹션 만들기
            let section = NSCollectionLayoutSection(group: group)
//            section.orthogonalScrollingBehavior = .groupPaging
            
            // 섹션에 대한 간격 설정
            section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
            return section
        }
        return layout
    }
    
    // 콤포지셔널 레이아웃 설정
    fileprivate func createCompositionalLayoutForSecond() -> UICollectionViewLayout {
        print("createCompositionalLayoutForSecond() called")
        // 콤포지셔널 레이아웃 생성
        let layout = UICollectionViewCompositionalLayout{
            // 만들게 되면 튜플 (키: 값, 키: 값) 의 묶음으로 들어옴 반환 하는 것은 NSCollectionLayoutSection 콜렉션 레이아웃 섹션을 반환해야함
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            // 아이템에 대한 사이즈 - absolute 는 고정값, estimated 는 추측, fraction 퍼센트
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            
            // 위에서 만든 아이템 사이즈로 아이템 만들기
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // 아이템 간의 간격 설정
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            // 변경할 부분
            let groupHeight =  NSCollectionLayoutDimension.fractionalWidth(1/2)
            
            // 그룹사이즈
            let grouSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: groupHeight)
            
            // 그룹사이즈로 그룹 만들기
//            let group = NSCollectionLayoutGroup.horizontal(layoutSize: grouSize, subitems: [item, item, item])
            
            // 변경할 부분
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: grouSize, subitem: item, count: 2)
            
            // 그룹으로 섹션 만들기
            let section = NSCollectionLayoutSection(group: group)
//            section.orthogonalScrollingBehavior = .groupPaging
            
            // 섹션에 대한 간격 설정
            section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
            return section
        }
        return layout
    }
    
    // 콤포지셔널 레이아웃 설정
    fileprivate func createCompositionalLayoutForThird() -> UICollectionViewLayout {
        print("createCompositionalLayoutForThird() called")
        // 콤포지셔널 레이아웃 생성
        let layout = UICollectionViewCompositionalLayout{
            // 만들게 되면 튜플 (키: 값, 키: 값) 의 묶음으로 들어옴 반환 하는 것은 NSCollectionLayoutSection 콜렉션 레이아웃 섹션을 반환해야함
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            // 아이템에 대한 사이즈 - absolute 는 고정값, estimated 는 추측, fraction 퍼센트
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            
            // 위에서 만든 아이템 사이즈로 아이템 만들기
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // 아이템 간의 간격 설정
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            // 변경할 부분
            let groupHeight =  NSCollectionLayoutDimension.fractionalWidth(1/3)
            
            // 그룹사이즈
            let grouSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: groupHeight)
            
            // 그룹사이즈로 그룹 만들기
//            let group = NSCollectionLayoutGroup.horizontal(layoutSize: grouSize, subitems: [item, item, item])
            
            // 변경할 부분
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: grouSize, subitem: item, count: 3)
            
            // 그룹으로 섹션 만들기
            let section = NSCollectionLayoutSection(group: group)
//            section.orthogonalScrollingBehavior = .groupPaging
            
            // 섹션에 대한 간격 설정
            section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
            return section
        }
        return layout
    }
    
}


// 데이터 소스 설정 - 데이터와 관련된 것들
extension MyCollectionVC: UICollectionViewDataSource {
    
    // 각 섹션에 들어가는 아이템 갯수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tempArray.count
    }
    
    // 각 콜렉션뷰 쎌에 대한 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MyCustomCollectionViewCell.self), for: indexPath) as! MyCustomCollectionViewCell
        
        if self.tempArray.count > 0 {
            cell.imageName = self.tempArray[indexPath.item] as! String
        }
        
        return cell
    }
    
    
}

// 콜렉션뷰 델리겟 - 액션과 관련된 것들
extension MyCollectionVC: UICollectionViewDelegate {
    
}

