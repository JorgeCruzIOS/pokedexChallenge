//
//  String+Extension.swift
//  Pokedex
//
//  Created by Dsi Soporte Tecnico on 18/08/23.
//

import Foundation

extension NSMutableAttributedString {
    
    func apply(new: NSMutableAttributedString)-> NSMutableAttributedString{
        append(new)
        return self
    }
}
extension String{
    func decorative(color: UIColor,
                    font: UIFont,
                    spacing: Double = 0,
                    lineBreakMode: NSLineBreakMode = .byWordWrapping,
                    textAlignment: NSTextAlignment = .left)->NSMutableAttributedString{
       
        let attibute = NSMutableParagraphStyle()
        attibute.alignment = textAlignment
        attibute.lineBreakMode = lineBreakMode
        let attributes: [NSAttributedString.Key : Any] = [
                NSAttributedString.Key.foregroundColor: color,
            NSAttributedString.Key.font : font,
                NSAttributedString.Key.paragraphStyle : attibute
        ]
        let stringAttribute = NSMutableAttributedString(string: self, attributes: attributes)
        stringAttribute.addAttributes([.kern : spacing], range: NSRange(location: 0, length: stringAttribute.length - 1))
        return stringAttribute
    }
}
