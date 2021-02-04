//
//  UIView+Extension.swift
//  AnnounceKitColorTest
//
//  Created by Faiz on 04/02/2021.
//

import UIKit

extension UIView {
    func pinToSuperView(inset:UIEdgeInsets = .zero) {
        guard let superview = self.superview else { return }
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: inset.top).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: inset.bottom).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: inset.left).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: inset.right).isActive = true
    }
}
