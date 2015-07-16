//
//  HappinessViewController.swift
//  Happiness
//
//  Created by 菜 on 15/7/11.
//  Copyright © 2015年 菜. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController, FaceViewDataSource
{
    
    @IBOutlet weak var faceView: FaveView! {
        didSet {
            faceView.dataSource = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scale:"))
        }
    }
    
    var happiness: Int = 20 {//1到100之间, 1 sands for sad and 100 stands for happy
        didSet {
            happiness = max(min(happiness, 100), 0)
            updateUI()
        }
    }
    
    let happinessChangeScale: CGFloat = 2
    @IBAction func changHappiness(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .Ended: fallthrough
        case .Changed:
            let translation = sender.translationInView(faceView)
            let happinessChange = Int(translation.y / happinessChangeScale)
            if happinessChange != 0 {
                happiness += happinessChange
                sender.setTranslation(CGPointZero, inView: faceView)
            }
        default:break
        }
    }
    
   
    
    func smileForFaceView(sender: FaveView) -> Double? {
        return Double(happiness - 50) / 50
    }
    private func updateUI() {
        faceView?.setNeedsDisplay()
    }
}
