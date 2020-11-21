//
//  MainVC.swift
//  dynamic_table_view
//
//  Created by Jeff Jeong on 2020/11/14.
//  Copyright © 2020 Tuentuenna. All rights reserved.
//

import Foundation
import UIKit
import ViewAnimator

class MainVC: UIViewController {
    
    
    @IBOutlet var navToTableVCBtn: UIButton!
    
    @IBOutlet var navToCollectionVCBtn: UIButton!
    
    let zoomAnim = AnimationType.zoom(scale: 0.8)
    let vectorAnim = AnimationType.vector(CGVector(dx: 30, dy: 0))
    let rotateAnim = AnimationType.rotate(angle: CGFloat.pi/2)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MainVC - viewDidLoad() called")
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [weak self] in
//            guard let self = self else { return }
//            self.navToTableVCBtn.animate(animations: [self.zoomAnim])
//            UIView.animate(views: [self.navToTableVCBtn, self.navToCollectionVCBtn], // 애니메이션을 적용할 뷰들
//               animations: [self.vectorAnim, self.zoomAnim, self.rotateAnim], // 적용할 애니메이션들
//               reversed: true, // 애니메이션 반전 여부
//               initialAlpha: 1.0, // 1 이면 불투명 - 초기 알파값
//               finalAlpha: 1.0, // 0 이면 완전 투명 - 애니메이션 끝나고 알파값
//               delay: 0, // 애니메이션 시작 딜레이
//               animationInterval: 1, // 인터벌 - ??
//               duration: 2, // 애니메이션 지속 시간
//               usingSpringWithDamping: 100, // 스프링 덤프 - ??
//               initialSpringVelocity: 1, // 가속도 ???
//               completion: {
//                print("애니메이션이 완료 되었다.")
//               }) // 애니메이션이 끝나고
//        })
        
        
        
        
        
    }
    
}
