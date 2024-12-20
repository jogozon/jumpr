//
//  getViewController.swift
//  GozonJosephFInalProject
//
//  Created by Joseph Gozon on 12/11/24.
//

import Foundation
import UIKit

final class getViewController {

    static let shared = getViewController()
    private init() {}

    // Taken from: https://stackoverflow.com/a/30858591
    @MainActor
    func topViewController(controller: UIViewController? = nil) -> UIViewController? {
        let controller = controller ?? UIApplication.shared.keyWindow?.rootViewController

        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
