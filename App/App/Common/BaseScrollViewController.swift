//
//  BaseScrollViewController.swift
//  App
//
//  Created by Максим Шаптала on 01.02.2021.
//

import UIKit

private extension NSNotification.Name {
    static let kKeyboardWillShow = NSNotification.Name(rawValue: "UIKeyboardWillShowNotification")
    static let kKeyboardWillHide = NSNotification.Name(rawValue: "UIKeyboardWillHideNotification")
    static let kKeyboardDidHide = NSNotification.Name(rawValue: "UIKeyboardDidHideNotification")
}

class BaseScrollViewController<Presenter, View: BaseView>: BaseMVPViewController<Presenter,View> {
    
    private let kAdditionalOffset: CGFloat = 24
    private var keyboardIsOpened = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        self.view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .kKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .kKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(_:)), name: .kKeyboardDidHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        self.view.endEditing(true)
    }
    
    @objc
    private func endEditing() {
        view.endEditing(true)
    }
    
    @objc
    private func keyboardWillShow(_ notification: Notification) {
        guard !keyboardIsOpened else { return }
        keyboardIsOpened = true
        guard view.isKind(of: BaseView.self), let superV = view as? BaseView else { return }
        guard let info: Dictionary = notification.userInfo, let value: NSValue = info["UIKeyboardFrameEndUserInfoKey"] as? NSValue else { return }
        
        var rect = value.cgRectValue
        rect = view.convert(rect, from: nil)
        
        var textFields: [UITextField] = findTF(in: view)
        guard !textFields.isEmpty else { return }
        textFields.sort { (a, b) -> Bool in
            return a.frame.minY > b.frame.minY
        }
        guard let bottomTextField = textFields.first else { return }
        let hiddenRect: CGRect = bottomTextField.frame.intersection(rect)
        guard hiddenRect.height > 0 else { return }
        let offsetHeight = hiddenRect.height + kAdditionalOffset
        superV.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: offsetHeight, right: 0)
        superV.setContentOffset(CGPoint(x: 0, y: offsetHeight), animated: true)
    }
    
    @objc
    private func keyboardWillHide(_ notification: Notification) {
        guard keyboardIsOpened else { return }
        keyboardIsOpened = false
        guard view.isKind(of: BaseView.self), let superV = view as? BaseView else { return }
        superV.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        superV.setContentOffset(CGPoint.zero, animated: true)
    }
    
    @objc
    private func keyboardDidHide(_ notification: Notification) {
        guard view.isKind(of: BaseView.self), let superV = view as? BaseView else { return }
    }
    
}


private extension BaseScrollViewController {
    func findTF(in view: UIView) -> [UITextField] {
        var returnedArray = [UITextField]()
        for subView in view.subviews {
            returnedArray += findTF(in: subView)
            if subView.isKind(of: UITextField.self) {
                returnedArray.append(subView as! UITextField)
                continue
            }
        }
        return returnedArray
    }
}
