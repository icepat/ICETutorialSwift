ICETutorialSwift
================

### Welcome to ICETutorial (Swfit edition).
This small project is an implementation of the newly tutorial introduced by the Path 3.X app, ported to Swift.
Very simple and efficient tutorial, composed with N full-screen pictures that you can swipe for switching to the next/previous page.

Here are the features :
* Compose your own tutorial with N pictures
* Fixed incrusted title (can be easily replaced by an UIImageView, or just removed)
* Scrolling sub-titles for page, with associated descriptions (change the texts, font, color...)
* Auto-scrolling (enable/disable, loop, setup duration for each pages)
* Cross fade between next/previous background
* Full delegate support available (for scrolling and button interactions)

![ICETutorial](https://github.com/icepat/ICETutorial/blob/master/screen_shot.jpg?raw=true)

### Setting-up the ICETutorial
The code is commented, and I guess, easy to read/understand/modify.
All the available settings for the scrolling are located in the header : ICETutorial.h :

**Pages configuration :**
```swift
    // Init the pages texts, and pictures.
    let layer1: ICETutorialPage = ICETutorialPage(title: "Picture 1", subTitle: "Champs-Elysées by night", pictureName: "tutorial_background_00@2x.jpg", duration: 3.0)
    let layer2: ICETutorialPage = ICETutorialPage(title: "Picture 2", subTitle: "The Eiffel Tower with\n cloudy weather", pictureName: "tutorial_background_01@2x.jpg", duration: 3.0)
    let layer3: ICETutorialPage = ICETutorialPage(title: "Picture 3", subTitle: "An other famous street of Paris", pictureName: "tutorial_background_02@2x.jpg", duration: 3.0)
    let layer4: ICETutorialPage = ICETutorialPage(title: "Picture 4", subTitle: "The Eiffel Tower with a better weather", pictureName: "tutorial_background_03@2x.jpg", duration: 3.0)
    let layer5: ICETutorialPage = ICETutorialPage(title: "Picture 5", subTitle: "The Louvre's Museum Pyramide", pictureName: "tutorial_background_04@2x.jpg", duration: 3.0)
    [...] 
```

**Common styles for SubTitles and Descriptions :**
```swift
    // Set the common style for SubTitles and Description (can be overrided on each page).
    let titleStyle: ICETutorialLabelStyle = ICETutorialLabelStyle()
    titleStyle.font = UIFont(name: "Helvetica-Bold", size: 17.0)
    titleStyle.color = UIColor.whiteColor()
    titleStyle.linesNumber = 1
    titleStyle.offsset = 180
        
    let subStyle: ICETutorialLabelStyle = ICETutorialLabelStyle()
    subStyle.font = UIFont(name: "Helvetica", size: 15.0)
    subStyle.color = UIColor.whiteColor()
    subStyle.linesNumber = 1
    subStyle.offsset = 150

    // Load into an array.
    let listPages: [ICETutorialPage] = [layer1, layer2, layer3, layer4, layer5]
  
```

**Init and load :**
```swift
    // Load the ICETutorialController.
    let controller: ICETutorialController = ICETutorialController(pages: listPages)
    
    // Set the common styles, and start scrolling (auto scroll, and looping enabled by default)    
    controller.commonPageTitleStyle = titleStyle
    controller.commonPageSubTitleStyle = subStyle
    controller.startScrolling()
```

**The title is located in the ICETutorialController.swift :**
```swift
// Setup the Title Label.
func setOverlayTitle() {
  self.overlayLogo!.text = "Welcome"
}
```

**Delegate implementation :**
```swift
#pragma mark - ICETutorialController delegate
- (void)tutorialController:(ICETutorialController *)tutorialController scrollingFromPageIndex:(NSUInteger)fromIndex toPageIndex:(NSUInteger)toIndex {
    NSLog(@"Scrolling from %lu to %lu", (unsigned long)fromIndex, (unsigned long)toIndex);
}

- (void)tutorialControllerDidReachLastPage:(ICETutorialController *)tutorialController {
    NSLog(@"Tutorial reached the last page.");
}

- (void)tutorialController:(ICETutorialController *)tutorialController didClickOnLeftButton:(UIButton *)sender {
    NSLog(@"Button 1 pressed.");
}

- (void)tutorialController:(ICETutorialController *)tutorialController didClickOnRightButton:(UIButton *)sender {
    NSLog(@"Button 2 pressed.");
    NSLog(@"Auto-scrolling stopped.");
    
    [self.viewController stopScrolling];
}
```

Checkout the others projects available on my account [@Icepat](https://github.com/icepat/) :

[ICETutorial](https://github.com/icepat/ICETutorial)

A nice tutorial like the one introduced in the Path 3.X App

[ICETutorialSwift](https://github.com/icepat/ICETutorialSwift)

A nice tutorial like the one introduced in the Path 3.X App (in Swift) 


Questions or ideas : patrick.trillsam@gmail.com.


###License :

The MIT License

Copyright (c) 2015 Patrick Trillsam - ICETutorial

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON INFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
