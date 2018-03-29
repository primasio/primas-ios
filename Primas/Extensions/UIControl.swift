//
//  UIControl.swift
//
//  Created by xuxiwen on 2017/11/6.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit

class ActionSingleton {
    var allEventDict: [UIView : () -> ()] = Dictionary()
    var allEditingEventDict: [UIView : () -> ()] = Dictionary()
    var allTouchEventDict: [UIView : () -> ()] = Dictionary()
    var editingChangedEventDict: [UIView : () -> ()] = Dictionary()
    var editingDidBeginEventDict: [UIView : () -> ()] = Dictionary()
    var editingDidEndEventDict: [UIView : () -> ()] = Dictionary()
    var editingDidEndOnExitEventDict: [UIView : () -> ()] = Dictionary()
    var touchCancelEventDict: [UIView : () -> ()] = Dictionary()
    var touchDownEventDict: [UIView : () -> ()] = Dictionary()
    var touchDownRepeatEventDict: [UIView : () -> ()] = Dictionary()
    var touchDragEnterEventDict: [UIView : () -> ()] = Dictionary()
    var touchDragExitEventDict: [UIView : () -> ()] = Dictionary()
    var touchDragInsideEventDict: [UIView : () -> ()] = Dictionary()
    var touchDragOutsideEventDict: [UIView : () -> ()] = Dictionary()
    var touchUpInsideEventDict: [UIView : () -> ()] = Dictionary()
    var touchUpOutsideEventDict: [UIView : () -> ()] = Dictionary()
    
    class var sharedInstance : ActionSingleton {
        struct Action {
            static let instance : ActionSingleton = ActionSingleton()
        }
        return Action.instance
    }
}

extension UIControl{
    
    /// Use this Func to hanlde UIControl Action
    ///
    /// - Parameters:
    ///   - type: UIControlEvents
    ///   - action: escaping Closure
    
    func addAction(_ type: UIControlEvents, action: @escaping () -> ()){
        let actionSingleton = ActionSingleton.sharedInstance
        if type == .allEvents{
            actionSingleton.allEventDict.updateValue( action, forKey: self)
            self.addTarget(self, action: #selector(self.triggerAllAction), for: type)
        }else if type == .allEditingEvents{
            actionSingleton.allEditingEventDict.updateValue( action, forKey: self)
            self.addTarget(self, action: #selector(self.triggerAllEditingAction), for: type)
        }else if type == .allTouchEvents{
            actionSingleton.allTouchEventDict.updateValue( action, forKey: self)
            self.addTarget(self, action: #selector(self.triggerAllTouchAction), for: type)
        }else if type == .editingChanged{
            actionSingleton.editingChangedEventDict.updateValue( action, forKey: self)
            self.addTarget(self, action: #selector(self.triggerEditingChangedAction), for: type)
        }else if type == .editingDidBegin{
            actionSingleton.editingDidBeginEventDict.updateValue( action, forKey: self)
            self.addTarget(self, action: #selector(self.triggerEditingDidBeginAction), for: type)
        }else if type == .editingDidEnd{
            actionSingleton.editingDidEndEventDict.updateValue( action, forKey: self)
            self.addTarget(self, action: #selector(self.triggerEditingDidEndAction), for: type)
        }else if type == .editingDidEndOnExit{
            actionSingleton.editingDidEndOnExitEventDict.updateValue( action, forKey: self)
            self.addTarget(self, action: #selector(self.triggerEditingDidEndOnExitAction), for: type)
        }else if type == .touchCancel{
            actionSingleton.touchCancelEventDict.updateValue( action, forKey: self)
            self.addTarget(self, action: #selector(self.triggerTouchCancelAction), for: type)
        }else if type == .touchDown{
            actionSingleton.touchDownEventDict.updateValue( action, forKey: self)
            self.addTarget(self, action: #selector(self.triggerTouchDownAction), for: type)
        }else if type == .touchDownRepeat{
            actionSingleton.touchDownRepeatEventDict.updateValue( action, forKey: self)
            self.addTarget(self, action: #selector(self.triggerTouchDownRepeatAction), for: type)
        }else if type == .touchDragEnter{
            actionSingleton.touchDragEnterEventDict.updateValue( action, forKey: self)
            self.addTarget(self, action: #selector(self.triggerTouchDragEnterAction), for: type)
        }else if type == .touchDragExit{
            actionSingleton.touchDragExitEventDict.updateValue( action, forKey: self)
            self.addTarget(self, action: #selector(self.triggerTouchDragExitAction), for: type)
        }else if type == .touchDragInside{
            actionSingleton.touchDragInsideEventDict.updateValue( action, forKey: self)
            self.addTarget(self, action: #selector(self.triggerTouchDragInsideAction), for: type)
        }else if type == .touchDragOutside{
            actionSingleton.touchDragOutsideEventDict.updateValue( action, forKey: self)
            self.addTarget(self, action: #selector(self.triggerTouchDragOutsideAction), for: type)
        }else if type == .touchUpInside{
            actionSingleton.touchUpInsideEventDict.updateValue( action, forKey: self)
            self.addTarget(self, action: #selector(self.triggerTouchUpInsideAction), for: type)
        }else if type == .touchUpOutside{
            actionSingleton.touchUpOutsideEventDict.updateValue( action, forKey: self)
            self.addTarget(self, action: #selector(self.triggerTouchUpOutsideAction), for: type)
        }
    }
    @objc fileprivate func triggerAllAction(){
        let actionSingleton = ActionSingleton.sharedInstance
        actionSingleton.allEventDict[self]!()
    }
    @objc fileprivate func triggerAllEditingAction(){
        let actionSingleton = ActionSingleton.sharedInstance
        actionSingleton.allEditingEventDict[self]!()
    }
    @objc fileprivate func triggerAllTouchAction(){
        let actionSingleton = ActionSingleton.sharedInstance
        actionSingleton.allTouchEventDict[self]!()
    }
    @objc fileprivate func triggerEditingChangedAction(){
        let actionSingleton = ActionSingleton.sharedInstance
        actionSingleton.editingChangedEventDict[self]!()
    }
    @objc fileprivate func triggerEditingDidBeginAction(){
        let actionSingleton = ActionSingleton.sharedInstance
        actionSingleton.editingDidBeginEventDict[self]!()
    }
    @objc fileprivate func triggerEditingDidEndAction(){
        let actionSingleton = ActionSingleton.sharedInstance
        actionSingleton.editingDidEndEventDict[self]!()
    }
    @objc fileprivate func triggerEditingDidEndOnExitAction(){
        let actionSingleton = ActionSingleton.sharedInstance
        actionSingleton.editingDidEndOnExitEventDict[self]!()
    }
    @objc fileprivate func triggerTouchCancelAction(){
        let actionSingleton = ActionSingleton.sharedInstance
        actionSingleton.touchCancelEventDict[self]!()
    }
    @objc fileprivate func triggerTouchDownAction(){
        let actionSingleton = ActionSingleton.sharedInstance
        actionSingleton.touchDownEventDict[self]!()
    }
    @objc fileprivate func triggerTouchDownRepeatAction(){
        let actionSingleton = ActionSingleton.sharedInstance
        actionSingleton.touchDownRepeatEventDict[self]!()
    }
    @objc fileprivate func triggerTouchDragEnterAction(){
        let actionSingleton = ActionSingleton.sharedInstance
        actionSingleton.touchDragEnterEventDict[self]!()
    }
    @objc fileprivate func triggerTouchDragExitAction(){
        let actionSingleton = ActionSingleton.sharedInstance
        actionSingleton.touchDragExitEventDict[self]!()
    }
    @objc fileprivate func triggerTouchDragInsideAction(){
        let actionSingleton = ActionSingleton.sharedInstance
        actionSingleton.touchDragInsideEventDict[self]!()
    }
    @objc fileprivate func triggerTouchDragOutsideAction(){
        let actionSingleton = ActionSingleton.sharedInstance
        actionSingleton.touchDragOutsideEventDict[self]!()
    }
    @objc fileprivate func triggerTouchUpInsideAction(){
        let actionSingleton = ActionSingleton.sharedInstance
        actionSingleton.touchUpInsideEventDict[self]!()
    }
    @objc fileprivate func triggerTouchUpOutsideAction(){
        let actionSingleton = ActionSingleton.sharedInstance
        actionSingleton.touchUpOutsideEventDict[self]!()
    }
}
