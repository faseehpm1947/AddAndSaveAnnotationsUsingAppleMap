//
//  SelfSizedTableView.swift
//  AddAndSaveAnotationsUsingAppleMap
//
//  Created by Faseeh PM on 17/01/25.
//

import UIKit

class SelfSizedTableView: UITableView {

    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return self.contentSize
    }
    override var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }

}
