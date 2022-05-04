//
//  PasswordTraceView.swift
//  ivi
//
//  Created by Samuel Wong on 14/4/22.
//

import UIKit

protocol PasswordTraceViewDelegate {
    func passwordTraceView(passwordTraceView: PasswordTraceView, didSwipeWithDirection direction: StrokeDirection)
}

protocol PasswordTraceViewDataSource {
    func shouldShowTrace(forPasswordTraceView passwordTraceView: PasswordTraceView) -> Bool
}

class PasswordTraceView: UIView {
    
    private var firstTouch: CGPoint?
    private var endTouch: CGPoint?
    
    var _delegate: PasswordTraceViewDelegate?
    var _dataSource: PasswordTraceViewDataSource?
    
    var shouldShowTrace: Bool {
        get {
            return _dataSource?.shouldShowTrace(forPasswordTraceView: self) ?? false
        }
    }
    
    var shapeLayer: CAShapeLayer = CAShapeLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialize()
    }
}

//MARK: Initialization
extension PasswordTraceView {
    func initialize() {
        self.addBorder()
        self.roundCorners()
        self.backgroundColor = UIColor.black
        self.layer.masksToBounds = true
        
        shapeLayer.strokeColor = UIColor.colourWithHexString("#0089b9").cgColor
        shapeLayer.lineWidth = 3
        shapeLayer.fillColor = UIColor.colourWithHexString("#04d99f").cgColor
        
        layer.addSublayer(shapeLayer)
    }
}

//MARK: Touch Handling
extension PasswordTraceView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            firstTouch = touch.location(in: self)
            
            guard shouldShowTrace else { return }
            shapeLayer.path = UIBezierPath(ovalIn: CGRect(origin: firstTouch!, size: CGSize(width: 12, height: 12))).cgPath
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            endTouch = touch.location(in: self)
            
            guard shouldShowTrace else { return }
            let originX = firstTouch!.x - endTouch!.x
            let originY = firstTouch!.y - endTouch!.y
            let angle = atan2f(Float(originY), Float(originX))
            
            let path = UIBezierPath()
            path.addArc(withCenter: firstTouch!, radius: 6, startAngle: Double(angle) - (Double.pi/2), endAngle: Double(angle) + (Double.pi/2), clockwise: true)
            path.addArc(withCenter: endTouch!, radius: 12, startAngle: Double(angle) + (Double.pi/2), endAngle: Double(angle) - (Double.pi/2), clockwise: true)
            path.close()
            
            shapeLayer.path = path.cgPath
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard firstTouch != nil else { return }
        guard endTouch != nil else { return }
        
        let originX = firstTouch!.x - endTouch!.x
        let originY = firstTouch!.y - endTouch!.y
        let angle = atan2f(Float(originY), Float(originX))
                
        _delegate?.passwordTraceView(passwordTraceView: self, didSwipeWithDirection: StrokeDirection.getDirection(angle: angle))
        
        guard shouldShowTrace else { return }
        let fillAnimation = CABasicAnimation(keyPath: "fill")
        fillAnimation.keyPath = #keyPath(CAShapeLayer.fillColor)
        fillAnimation.duration = 0.2
        fillAnimation.toValue = UIColor.clear.cgColor
        fillAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        fillAnimation.fillMode = CAMediaTimingFillMode.forwards
        fillAnimation.isRemovedOnCompletion = true
        
        let strokeAnimation = CABasicAnimation(keyPath: "stroke")
        strokeAnimation.keyPath = #keyPath(CAShapeLayer.strokeColor)
        strokeAnimation.duration = 0.2
        strokeAnimation.toValue = UIColor.clear.cgColor
        strokeAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        strokeAnimation.fillMode = CAMediaTimingFillMode.forwards
        strokeAnimation.isRemovedOnCompletion = true
        
        CATransaction.begin()
            CATransaction.setCompletionBlock({
                self.shapeLayer.path = nil
            })


        shapeLayer.add(fillAnimation, forKey: nil)
        shapeLayer.add(strokeAnimation, forKey: nil)
        CATransaction.commit()
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}

enum StrokeDirection: Int {
    case Up = 1
    case UpRight
    case Right
    case DownRight
    case Down
    case DownLeft
    case Left
    case UpLeft
    
    var title: String {
        switch self {
        case .Up : return "Up"
        case .UpRight : return "Up Right"
        case .Right : return "Right"
        case .DownRight : return "Down Right"
        case .Down : return "Down"
        case .DownLeft : return "Down Left"
        case .Left : return "Left"
        case .UpLeft : return "Up Left"
        }
    }
    
    static func getDirection(angle: Float) -> StrokeDirection {
        let dAngle = Double(angle)
        let pi = Double.pi
        
        if dAngle <= pi/8 && dAngle >= -pi/8 {
            return .Left
        } else if dAngle > pi/8 && dAngle <= 3*pi/8 {
            return .UpLeft
        } else if dAngle > 3*pi/8 && dAngle <= 5*pi/8 {
            return .Up
        } else if dAngle > 5*pi/8 && dAngle <= 7*pi/8 {
            return .UpRight
        } else if dAngle < -pi/8 && dAngle >= -3*pi/8 {
            return .DownLeft
        } else if dAngle < -3*pi/8 && dAngle >= -5*pi/8 {
            return .Down
        } else if dAngle < -5*pi/8 && dAngle >= -7*pi/8 {
            return .DownRight
        }
        
        return .Right
    }
}
