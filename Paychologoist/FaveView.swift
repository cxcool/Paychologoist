//
//  FaveView.swift
//  Happiness
//
//  Created by 菜 on 15/7/11.
//  Copyright © 2015年 菜. All rights reserved.
//

import UIKit

protocol FaceViewDataSource: class {
    func smileForFaceView (sender: FaveView) -> Double?
}

@IBDesignable
class FaveView: UIView {

    var lineWith: CGFloat = 3 { didSet { setNeedsDisplay() } }
    var color: UIColor = UIColor.blueColor() { didSet { setNeedsDisplay() }}
    var scale: CGFloat = 0.90 { didSet { setNeedsDisplay() }}
    
    var faceCenter: CGPoint {
        return convertPoint(center, fromView: superview)
    }
    var faceRadius: CGFloat {
        return min(bounds.size.width, bounds.size.height) / 2 * scale
    }
    
    weak var dataSource: FaceViewDataSource?
    
    func scale(gesture: UIPinchGestureRecognizer) {
        if gesture.state == .Changed {
            scale *= gesture.scale
            gesture.scale = 1
        }
    }
    
    private enum Eye {case right, left}
    private struct Scaling {
        static let FaceRadiusToEyeRadiusRatio: CGFloat = 10
        static let FaceRadiusToEyeOffsetRatio: CGFloat = 3
        static let FaceRadiusToEyeSeparationRatio: CGFloat = 1.5
        static let FaceRadusToEyeMouthWidthRatio: CGFloat = 1
        static let FaceRadiusToMouthHeightRadio: CGFloat = 3
        static let FaceRadiusToMouthOffsetRadio: CGFloat = 3
    }
    
    override func drawRect(rect: CGRect) {
        
        let facePath = UIBezierPath(arcCenter: faceCenter, radius: faceRadius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
        facePath.lineWidth = lineWith
        color.set()
        facePath.stroke()
        
        bezierForEye(.left).stroke()
        bezierForEye(.right).stroke()
        
        let smiliness = dataSource?.smileForFaceView(self) ?? 0.0
        let beziPathSmile = bezierForSmile(smiliness)
        beziPathSmile.lineWidth = lineWith
        beziPathSmile.stroke()
    }
    
    private func bezierForEye(whitchEye: Eye) -> UIBezierPath {
        let eyeRadius = faceRadius / Scaling.FaceRadiusToEyeRadiusRatio
        let eyeVerticaloffset = faceRadius / Scaling.FaceRadiusToEyeOffsetRatio
        let eyeHorizontalSeparation = faceRadius / Scaling.FaceRadiusToEyeSeparationRatio
        
        var eyeCenter = faceCenter
        eyeCenter.y -= eyeVerticaloffset
        switch whitchEye {
        case .left: eyeCenter.x -= eyeHorizontalSeparation / 2
        case .right: eyeCenter.x += eyeHorizontalSeparation / 2
        }
        
        let path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
        path.lineWidth = lineWith
        return path
    }
    private func bezierForSmile(digreeOfSmile: Double) -> UIBezierPath {
        let mouthWidth = faceRadius / Scaling.FaceRadusToEyeMouthWidthRatio
        let mouthHeight = faceRadius / Scaling.FaceRadiusToMouthHeightRadio
        let mouthVerticalOffset = faceRadius / Scaling.FaceRadiusToMouthOffsetRadio
        
        let smileHeight = CGFloat(max(min(digreeOfSmile, 1),-1)) * mouthHeight
        
        let start = CGPoint(x: faceCenter.x - mouthWidth / 2, y: faceCenter.y + mouthVerticalOffset)
        let end = CGPoint(x: start.x + mouthWidth, y: start.y)
        let cp1 = CGPoint(x: start.x + mouthWidth / 3, y: start.y + smileHeight)
        let cp2 = CGPoint(x: end.x - mouthWidth / 3, y: cp1.y)
        
        let path = UIBezierPath()
        path.moveToPoint(start)
        path.addCurveToPoint(end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = lineWith
        return path
    }
}


























