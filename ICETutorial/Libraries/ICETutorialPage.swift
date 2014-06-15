//
//  ICETutorialPage.swift
//  ICETutorial
//
//  Created by Patrick Trillsam on 5/06/2014.
//  Copyright (c) 2014 Patrick Trillsam. All rights reserved.
//

import Foundation
import UIKit

class ICETutorialLabelStyle : NSObject {
    
    var text: String?
    var font: UIFont?
    var color: UIColor?
    var linesNumber: Int = 0
    var offsset: Int = 0
    
    init() {
        super.init()
    }

    init(text: String) {
        self.text = text
    }

    init(text: String, font: UIFont, color: UIColor) {
        self.text = text
        self.font = font
        self.color = color
    }
}


class ICETutorialPage : NSObject {
    
    var title: ICETutorialLabelStyle!
    var subTitle: ICETutorialLabelStyle!
    var pictureName: String?
    var duration: NSTimeInterval?
    
    init(title: String, subTitle: NSString, pictureName: String, duration: NSTimeInterval) {
        self.title = ICETutorialLabelStyle(text: title)
        self.subTitle = ICETutorialLabelStyle(text: subTitle)
        self.pictureName = pictureName
        self.duration = duration
    }
    
    func setSubTitleStyle(style: ICETutorialLabelStyle) {
        self.subTitle = style
    }
    
    func setTitleStyle(style: ICETutorialLabelStyle) {
        self.title = style
    }
}