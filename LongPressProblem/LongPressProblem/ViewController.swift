//
//  ViewController.swift
//  LongPressProblem
//
//  Created by ibec on 10/3/17.
//  Copyright © 2017 ibec. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var touchView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addNewKeyboardSettings()
        
        let longRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressed(_:)))
//        longRecognizer.delegate = self.gestureDelegate
        self.touchView.addGestureRecognizer(longRecognizer)
    }

    func longPressed(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            showMenuController()
        }
        
    }
    
    //MARK: - MENUCONTROLLER FUNCTIONS
    func showMenuController() {
        
        becomeFirstResponder()
        
        let menu = UIMenuController.shared
        let deleteItem = UIMenuItem(title: "Delete", action: #selector(self.deleteMessage))
        menu.menuItems = [deleteItem]
        
        
        menu.setTargetRect(CGRect(x: 0.0, y: 0.0, width: 20, height: 20), in: self.touchView)
        menu.setMenuVisible(true, animated: true)
    }
    
    override func copy(_ sender: Any?) {
        print("copy")
        let pasteboard = UIPasteboard.general
        pasteboard.string = "Sdfds"
    }
    
    func deleteMessage() {
        print("Delete")
    }

    override var canBecomeFirstResponder: Bool {
        
        return true
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        // You need to only return true for the actions you want, otherwise you get the whole range of
        //  iOS actions. You can see this by just removing the if statement here.
        return action == #selector(self.deleteMessage) || action == #selector(UIResponderStandardEditActions.copy(_:))
    }
    
    
    
    func addNewKeyboardSettings(){
        self.hideKeyboardWhenTappedAround()
        print("hidewhentap")
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    
    func hideKeyboardWhenTappedAround(cancelsTouchesInView: Bool = true, delegate: UIGestureRecognizerDelegate? = nil) {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = cancelsTouchesInView
        
        tap.delegate = delegate
        tap.require(toFail: UILongPressGestureRecognizer())
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
//    func keyboardWillShow(notification: NSNotification) {
//        
//        if self.view.frame.origin.y == 0{
//            self.view.frame.origin.y -= 40
//        }
//    }
//    
//    func keyboardWillHide(notification: NSNotification) {
//        
//        if self.view.frame.origin.y != 40{
//            
//            self.view.frame.origin.y += keyboardMoveValue
//        }
//    }
}

