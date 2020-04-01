//
//  ImageSaver.swift
//  Instafilter
//
//  Created by Rinalds Domanovs on 01/04/2020.
//  Copyright © 2020 Rinalds Domanovs. All rights reserved.
//

import UIKit

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }

    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        
    }
}
