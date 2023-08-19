//
//  View+Extension.swift
//  Pokedex
//
//  Created by Dsi Soporte Tecnico on 18/08/23.
//

import Foundation

extension UIView {
    func takeScreenshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        if let context = UIGraphicsGetCurrentContext() {
            layer.render(in: context)
            let screenshot = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return screenshot
        }
        return nil
    }
}
