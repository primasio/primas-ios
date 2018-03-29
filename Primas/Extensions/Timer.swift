//
//  Timer.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/18.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import Foundation

extension Timer {
    
    
    // MARK: - Pause Timer
    func pauseTimer()  {
        self.fireDate = Date.distantFuture
    }
    
    // MARK: - Resume Timer
    func resumeTimer() {
        self.fireDate = NSDate.init() as Date
    }
    
    
    // MARK: - Resume Timer After interval
    func resumeTimerAfterInterval(interval: TimeInterval)  {
        self.fireDate = Date.init(timeIntervalSinceNow: interval)
    }
    
    // MARK: - Fire Self
    func destory() {
        self.invalidate()
    }
}
