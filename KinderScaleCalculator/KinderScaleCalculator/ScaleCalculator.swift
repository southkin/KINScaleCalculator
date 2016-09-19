//
//  ScaleCalculator.swift
//  KinderScaleCalculator
//
//  Created by kin on 2016. 9. 6..
//  Copyright © 2016년 kin. All rights reserved.
//

import UIKit
internal class test {
    internal init() {
        print("aa")
    }
}
public enum DeviceType {
    case iphone_320_480 // iPhone 4s
    case iphone_320_568 // iPhone 5, iPhone 5s
    case iphone_375_667 // iPhone 6, iPhone 6s
    case iphone_414_736 // iPhone 6+, iPhone 6s+
    case ipad_768_1024 // iPad
    case ipad_1024_1366 // iPad Pro
    case `else`
}
let rects:[DeviceType:CGSize] = [
    .iphone_320_480:CGSize(width: 320, height: 480),
    .iphone_320_568:CGSize(width: 320, height: 568),
    .iphone_375_667:CGSize(width: 375, height: 667),
    .iphone_414_736:CGSize(width: 414, height: 736),
    .ipad_768_1024:CGSize(width: 768, height: 1024),
    .ipad_1024_1366:CGSize(width: 1024, height: 1366)
]
open class ScaleCalculator: NSObject {
    let deviceType:DeviceType
    let baseType:DeviceType
    let w_scale:CGFloat
    let h_scale:CGFloat
    
    public init(device:DeviceType) {
        switch UIScreen.main.bounds.size {
        case rects[.iphone_320_480]! :
            deviceType = .iphone_320_480
            break
        case rects[.iphone_320_568]! :
            deviceType = .iphone_320_568
            break
        case rects[.iphone_375_667]! :
            deviceType = .iphone_375_667
            break
        case rects[.iphone_414_736]! :
            deviceType = .iphone_414_736
            break
        case rects[.ipad_768_1024]! :
            deviceType = .ipad_768_1024
            break
        case rects[.ipad_1024_1366]! :
            deviceType = .ipad_1024_1366
            break
        default:
            deviceType = .else
            break
        }
        baseType = device
        w_scale = rects[deviceType]!.width / rects[baseType]!.width
        h_scale = rects[deviceType]!.height / rects[baseType]!.height
    }
    open func convert<T>(_ value:T) -> T {
        return convert(value, adjustHeight: false)
    }
    open func convert<T>(_ value:T, adjustHeight:Bool) -> T {
        if let swiftFloat:Float = value as? Float {
            return self.float(CGFloat(swiftFloat),adjustHeight: adjustHeight) as! T
        }
        if let floatValue:CGFloat = value as? CGFloat {
            return self.float(floatValue,adjustHeight: adjustHeight) as! T
        }
        if let rect = value as? CGRect {
            return self.rect(rect, adjustHeight: adjustHeight) as! T
        }
        if let size = value as? CGSize {
            return self.size(size, adjustHeight: adjustHeight) as! T
        }
        if let point = value as? CGPoint {
            return self.point(point, adjustHeight: adjustHeight) as! T
        }
        if let view = value as? UIView {
            self.setView(view)
            return value
        }
        if let layer = value as? CALayer {
            self.setLayer(layer)
            return value
        }
        return value
    }
    open func float(_ float:CGFloat) -> CGFloat {
        return self.float(float,adjustHeight: false)
    }
    open func float(_ float:CGFloat, adjustHeight:Bool) -> CGFloat {
        return adjustHeight ? float * w_scale : float * h_scale
    }
    open func rect(_ rect:CGRect) -> CGRect {
        return self.rect(rect,adjustHeight: false)
    }
    open func rect(_ rect:CGRect, adjustHeight:Bool) -> CGRect {
        return CGRect(x: rect.origin.x * w_scale,
                          y: rect.origin.y * (adjustHeight ? h_scale : w_scale),
                          width: rect.size.width * w_scale,
                          height: rect.size.height * (adjustHeight ? h_scale : w_scale))
    }
    open func size(_ size:CGSize) -> CGSize {
        return self.size(size,adjustHeight: false)
    }
    open func size(_ size:CGSize, adjustHeight:Bool) -> CGSize {
        return CGSize(width: size.width * w_scale, height: size.height * (adjustHeight ? h_scale : w_scale))
    }
    open func point(_ point:CGPoint) -> CGPoint {
        return self.point(point,adjustHeight: false)
    }
    open func point(_ point:CGPoint, adjustHeight:Bool) -> CGPoint {
        return CGPoint(x: point.x * w_scale, y: point.y * (adjustHeight ? h_scale : w_scale))
    }
    open func setView(_ view:UIView) {
        setView(view,adjustHeight: false)
    }
    open func setView(_ view:UIView, adjustHeight:Bool) {
        let frame = rect(view.frame,adjustHeight: adjustHeight)
        view.frame = frame
    }
    open func setLayer(_ layer:CALayer) {
        setLayer(layer,adjustHeight: false)
    }
    open func setLayer(_ layer:CALayer, adjustHeight:Bool) {
        let frame = rect(layer.frame, adjustHeight:adjustHeight)
        layer.frame = frame
    }
}
