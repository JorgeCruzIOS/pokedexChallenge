//
//  PDFBuilderManager.swift
//  Pokedex
//
//  Created by Dsi Soporte Tecnico on 18/08/23.
//

import Foundation
import UIKit

class PDFBuilderManager:NSObject{
    
    let imageToBuild: UIView
    
    @objc init(imageToBuild: UIView) {
        self.imageToBuild = imageToBuild
    }
    
    @objc func buildPDFToDownload(succesfull:@escaping(URL)->Void){
        if let image = imageToBuild.takeScreenshot(), let pdf = createPDFWithImageData(data: image){
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let pdfURL = documentsDirectory.appendingPathComponent("listPokemon.pdf")
            do{
                try pdf.write(to: pdfURL)
                succesfull(pdfURL)
            } catch{
                
            }
        }
    }
    
    private func createPDFWithImageData(data: UIImage) -> Data? {
        let pdfData = NSMutableData()

        UIGraphicsBeginPDFContextToData(pdfData, .zero, nil)
        UIGraphicsBeginPDFPage()

        let imageRect = CGRect(x: 0, y: 0, width: 612, height: data.size.height)
        data.draw(in: imageRect)

        UIGraphicsEndPDFContext()

        return pdfData as Data
    }
}
