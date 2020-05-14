//
//  File.swift
//  ChoicePopup
//
//  Created by Arsen Leontijevic on 9/18/19.
//  Copyright © 2019 Ralf Ebert. All rights reserved.
//
import UIKit
import Foundation
class AlertTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    public var height = 140
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let pc = AlertPresentationController(presentedViewController: presented, presenting: presenting)
        pc.height = self.height
        return pc
    }
}
