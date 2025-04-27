//
//  UIAlertController+.swift
//  AddAndSaveAnotationsUsingAppleMap
//
//  Created by Faseeh PM on 17/01/25.
//

import UIKit

extension UIAlertController {
    
    static func createPinPointAlert(
        title: String = "Add Pinpoint",
        message: String = "Enter title and description",
        onAdd: @escaping (_ title: String, _ description: String) -> Void
    ) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addTextField { $0.placeholder = "Title" }
        alert.addTextField { $0.placeholder = "Description" }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            guard let title = alert.textFields?[0].text, !title.isEmpty,
                  let description = alert.textFields?[1].text else { return }
            onAdd(title, description)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        return alert
    }
    
    static func createInfoAlert(
        title: String = "Info",
        message: String,
        actionTitle: String = "OK",
        actionHandler: (() -> Void)? = nil
    ) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default) { _ in
            actionHandler?()
        }
        alert.addAction(action)
        return alert
    }
}
