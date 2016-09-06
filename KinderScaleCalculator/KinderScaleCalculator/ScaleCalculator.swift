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
    case IPHONE_320_480 // iPhone 4s
    case IPHONE_320_568 // iPhone 5, iPhone 5s
    case IPHONE_375_667 // iPhone 6, iPhone 6s
    case IPHONE_414_736 // iPhone 6+, iPhone 6s+
    case IPAD_768_1024 // iPad
    case IPAD_1024_1366 // iPad Pro
    case ELSE
}
let rects:[DeviceType:CGSize] = [
    .IPHONE_320_480:CGSizeMake(320, 480),
    .IPHONE_320_568:CGSizeMake(320, 568),
    .IPHONE_375_667:CGSizeMake(375, 667),
    .IPHONE_414_736:CGSizeMake(414, 736),
    .IPAD_768_1024:CGSizeMake(768, 1024),
    .IPAD_1024_1366:CGSizeMake(1024, 1366)
]
public class ScaleCalculator: NSObject {
    let deviceType:DeviceType
    let baseType:DeviceType
    let w_scale:CGFloat
    let h_scale:CGFloat
    static var shared:ScaleCalculator?
    public func setDefaultDevice(device:DeviceType) {
        ScaleCalculator.shared = ScaleCalculator(device: device)
    }
    static public func convert<T>(value:T) -> T {
        return convert(value, adjustHeight: false)
    }
    static public func convert<T>(value:T, adjustHeight:Bool) -> T {
        if let scale:ScaleCalculator = shared {
            if let floatValue:CGFloat = value as? CGFloat {
                return scale.float(floatValue,adjustHeight: adjustHeight) as! T
            }
            if let rect = value as? CGRect {
                return scale.rect(rect, adjustHeight: adjustHeight) as! T
            }
            if let size = value as? CGSize {
                return scale.size(size, adjustHeight: adjustHeight) as! T
            }
            if let point = value as? CGPoint {
                return scale.point(point, adjustHeight: adjustHeight) as! T
            }
            if let view = value as? UIView {
                scale.setView(view)
                return value
            }
            if let layer = value as? CALayer {
                scale.setLayer(layer)
                return value
            }
        }
        return value
    }
    public init(device:DeviceType) {
        switch UIScreen.mainScreen().bounds.size {
        case rects[.IPHONE_320_480]! :
            deviceType = .IPHONE_320_480
            break
        case rects[.IPHONE_320_568]! :
            deviceType = .IPHONE_320_568
            break
        case rects[.IPHONE_375_667]! :
            deviceType = .IPHONE_375_667
            break
        case rects[.IPHONE_414_736]! :
            deviceType = .IPHONE_414_736
            break
        case rects[.IPAD_768_1024]! :
            deviceType = .IPAD_768_1024
            break
        case rects[.IPAD_1024_1366]! :
            deviceType = .IPAD_1024_1366
            break
        default:
            deviceType = .ELSE
            break
        }
        baseType = device
        w_scale = rects[deviceType]!.width / rects[baseType]!.width
        h_scale = rects[deviceType]!.height / rects[baseType]!.height
    }
    public func float(float:CGFloat) -> CGFloat {
        return self.float(float,adjustHeight: false)
    }
    public func float(float:CGFloat, adjustHeight:Bool) -> CGFloat {
        return adjustHeight ? float * w_scale : float * h_scale
    }
    public func rect(rect:CGRect) -> CGRect {
        return self.rect(rect,adjustHeight: false)
    }
    public func rect(rect:CGRect, adjustHeight:Bool) -> CGRect {
        return CGRectMake(rect.origin.x * w_scale,
                          rect.origin.y * (adjustHeight ? h_scale : w_scale),
                          rect.size.width * w_scale,
                          rect.size.height * (adjustHeight ? h_scale : w_scale))
    }
    public func size(size:CGSize) -> CGSize {
        return self.size(size,adjustHeight: false)
    }
    public func size(size:CGSize, adjustHeight:Bool) -> CGSize {
        return CGSizeMake(size.width * w_scale, size.height * (adjustHeight ? h_scale : w_scale))
    }
    public func point(point:CGPoint) -> CGPoint {
        return self.point(point,adjustHeight: false)
    }
    public func point(point:CGPoint, adjustHeight:Bool) -> CGPoint {
        return CGPointMake(point.x * w_scale, point.y * (adjustHeight ? h_scale : w_scale))
    }
    public func setView(view:UIView) {
        setView(view,adjustHeight: false)
    }
    public func setView(view:UIView, adjustHeight:Bool) {
        let frame = rect(view.frame,adjustHeight: adjustHeight)
        view.frame = frame
    }
    public func setLayer(layer:CALayer) {
        setLayer(layer,adjustHeight: false)
    }
    public func setLayer(layer:CALayer, adjustHeight:Bool) {
        let frame = rect(layer.frame, adjustHeight:adjustHeight)
        layer.frame = frame
    }
}
