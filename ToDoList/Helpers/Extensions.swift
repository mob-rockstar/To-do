//
//  Extensions.swift
//  ToDoList
//
//  Created by Panda on 10/31/17.
//  Copyright © 2017 Panda. All rights reserved.
//

import UIKit

extension UIViewController {
    func showSimpleAlert(title: String?, message: String?, closeButtonTitle: String = "Ok", complete:(() -> Void)?) -> Void {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: closeButtonTitle, style: .cancel, handler: { action in
            if complete != nil {
                complete!()
            }
        })
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
