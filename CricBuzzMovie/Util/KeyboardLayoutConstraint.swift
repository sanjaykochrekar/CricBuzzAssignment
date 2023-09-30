//
//  KeybaordConst.swift
//  CricBuzzMovie
//
//  Created by Sanju on 30/09/23.
//


import UIKit

public class KeyboardLayoutConstraint: NSLayoutConstraint {
    
    /// This offset is added on when the keyboard is collapsed.
    var keyboardDownOffset: CGFloat = 0
    
    /// Default's to the offset of the constraint so it can be restored when the keyboard hides
    private var offset: CGFloat = 0
    
    /// The current height of the keyboard. 0 if the keyboard isn't shown
    private var keyboardVisibleHeight: CGFloat = 0
    
    @available(tvOS, unavailable)
    override public func awakeFromNib() {
        super.awakeFromNib()
        offset = constant
        
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardLayoutConstraint.keyboardWillShowNotification(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardLayoutConstraint.keyboardWillHideNotification(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: Notification
    
    @objc
    func keyboardWillShowNotification(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            if let frameValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let frame = frameValue.cgRectValue
                keyboardVisibleHeight = frame.size.height
            }
            
            self.updateConstant()
            switch (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber, userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber) {
            case let (.some(duration), .some(curve)):
                
                let options = UIView.AnimationOptions(rawValue: curve.uintValue)
                UIView.animate(withDuration: TimeInterval(duration.doubleValue), delay: 0, options: options, animations: {
                    UIApplication.shared.keyWindow?.layoutIfNeeded()
                    return
                })
            default:
                break
            }
        }
    }
    
    @objc
    func keyboardWillHideNotification(_ notification: NSNotification) {
        keyboardVisibleHeight = 0
        self.updateConstant()
        
        if let userInfo = notification.userInfo {
            switch (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber,
                    userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber) {
            case let (.some(duration), .some(curve)):
                let options = UIView.AnimationOptions(rawValue: curve.uintValue)
                UIView.animate(withDuration: TimeInterval(duration.doubleValue), delay: 0, options: options, animations: {
                    UIApplication.shared.keyWindow?.layoutIfNeeded()
                    return
                })
            default:
                break
            }
        }
    }
    
    func updateConstant() {
        if keyboardVisibleHeight == 0 {
            self.constant = offset + keyboardDownOffset
            return
        }
        
        self.constant = offset + keyboardVisibleHeight
    }
}
