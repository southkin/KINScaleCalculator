//
//  ProcessQueue.swift
//  KinderProcessQueue
//
//  Created by kin on 2016. 10. 10..
//  Copyright © 2016년 kin. All rights reserved.
//

import UIKit

public func delaySec(_ delay:Double, closure:@escaping ()->()) {
    let queue = MainQueue
    delaySec(delay, queue:queue, closure:closure)
}
public func delaySec(_ delay:Double, queue:DispatchQueue, closure:@escaping ()->()) {
    let when = DispatchTime.now() + delay
    queue.asyncAfter(deadline: when, execute:closure)
}

var MainQueue: DispatchQueue {
    return DispatchQueue.main
}
var GlobalBackgroundQueue: DispatchQueue {
    return DispatchQueue.global(qos: .background)
}

public protocol ProcessQueueDelegate {
    func didFinish()
}
open class ProcessQueue {
    var delegate:ProcessQueueDelegate?
    var autoStart:Bool
    open var delay:Double
    var queue:[()->()] = []
    var target:DispatchQueue = GlobalBackgroundQueue
    var runningFlag:Bool = false
    public init(delay:Double) {
        self.delay = delay
        self.autoStart = true
    }
    public init(delay:Double,autoStart:Bool) {
        self.delay = delay
        self.autoStart = autoStart
    }
    
    open func addProcess(_ process:@escaping ()->()) {
        queue.append(process)
        if self.autoStart {
            run()
        }
    }
    open func run() {
        guard queue.count != 0 else {
            delegate?.didFinish()
            return
        }
        guard !runningFlag else {
            return
        }
        runningFlag = true
        let closure = self.queue.removeFirst()
        closure()
        delaySec(delay, queue:target) {
            self.runningFlag = false
            self.run()
        }
    }
    open func setDelayWithDuration(_ duration:Double) {
        let cnt = queue.count
        self.delay = duration/Double(cnt)
    }
}
