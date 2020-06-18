//
//  ICETutorialPage.swift
//  ICETutorial
//
//  Created by Patrick Trillsam on 5/06/2014.
//  Copyright (c) 2014 Patrick Trillsam. All rights reserved.
//

import Foundation
import UIKit

class ICETutorialLabelStyle {
    
    var text: String?
    var font = UIFont.systemFont(ofSize: 17)
    var color = UIColor.white
    var linesNumber = 0
    var offset: CGFloat = 0
    
    init() {}
    
    init(text: String) {
        self.text = text
    }

    init(text: String, font: UIFont, color: UIColor) {
        self.text = text
        self.font = font
        self.color = color
    }

}


class ICETutorialPage {
    
    var title: ICETutorialLabelStyle!
    var subTitle: ICETutorialLabelStyle!
    var pictureName: String?
    var duration: TimeInterval?
    
    init(title: String, subTitle: String, pictureName: String, duration: TimeInterval) {
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
