//
//  ICETutorialController.swift
//  ICETutorial
//
//  Created by Patrick Trillsam on 5/06/2014.
//  Copyright (c) 2014 Patrick Trillsam. All rights reserved.
//

import Foundation
import UIKit

enum ScrollingState : Int {
    case Auto
    case Manual
    case Looping
}

class ICETutorialController : UIViewController, UIScrollViewDelegate {
 
    var frontLayerView: UIImageView!
    var backLayerView: UIImageView!
    var scrollView: UIScrollView!
    var pageControl: UIPageControl!
    var leftButton: UIButton!
    var rightButton: UIButton!
    
    var overlayLogo: UILabel!
    
    var currentPageIndex: NSInteger!
    var nextPageIndex: NSInteger?
    var currentState: ScrollingState?
    var windowSize: CGSize?
    var pages: ICETutorialPage[]!
    var autoScrollEnabled: Bool!
    var commonPageTitleStyle: ICETutorialLabelStyle!
    var commonPageSubTitleStyle: ICETutorialLabelStyle!
    
    init(pages: ICETutorialPage[]) {
        super.init(nibName: nil, bundle: nil)
        
        self.autoScrollEnabled = true
        self.currentPageIndex = 0
        // Auto-scrollDuration
        self.pages = pages
        
        self.frontLayerView = UIImageView()
        self.backLayerView = UIImageView()
        self.scrollView = UIScrollView()
        
        self.overlayLogo = UILabel()
        self.pageControl = UIPageControl()
        self.leftButton = UIButton()
        self.rightButton = UIButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view!.backgroundColor = UIColor.blackColor()
        
        self.setupView()

        // Overlays.
        self.setOverlayTexts()
        self.setOverlayTitle()
        
        // Preset the origin state.
        self.setOriginLayersState()
    }
    
    func setupView() {
        self.frontLayerView!.frame = self.view.bounds
        self.backLayerView!.frame = self.view.bounds
        
        // Decoration.
        var gradientView = UIImageView(frame: CGRectMake(0, 368, 320, 200))
        gradientView.image = UIImage(named: "background-gradient.png")
        
        // Title.
        self.overlayLogo!.frame = CGRectMake(84, 116, 212, 50)
        self.overlayLogo!.textColor = UIColor.whiteColor()
        self.overlayLogo!.font = UIFont(name: "Helvetica-Bold", size: 32.0)
        
        // ScrollView configuration.
        self.scrollView!.frame = self.view.bounds
        self.scrollView!.delegate = self
        self.scrollView!.pagingEnabled = true
        self.scrollView!.contentSize = CGSizeMake(5 * 320, self.view.bounds.height)
        
        // PageControl.
        self.pageControl!.frame = CGRectMake(141, 453, 36, 32)
        self.pageControl!.numberOfPages = self.numberOfPages()
        self.pageControl!.currentPage = 0
        self.pageControl!.addTarget(self, action: Selector("didClickOnPageControl"), forControlEvents: UIControlEvents.ValueChanged)
        
        // UIButtons.
        self.leftButton!.frame = CGRectMake(20, 494, 130, 36)
        self.rightButton!.frame = CGRectMake(172, 494, 130, 36)
        self.leftButton!.backgroundColor = UIColor.darkGrayColor()
        self.rightButton!.backgroundColor = UIColor.darkGrayColor()
        self.leftButton!.setTitle("Button 1", forState: UIControlState.Normal)
        self.rightButton!.setTitle("Button 2", forState: UIControlState.Normal)
        self.leftButton!.addTarget(self, action: Selector("didClickOnButton1:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.rightButton!.addTarget(self, action: Selector("didClickOnButton2:"), forControlEvents: UIControlEvents.TouchUpInside)

        
        // Fetch on screen.
        self.view.addSubview(self.frontLayerView)
        self.view.addSubview(self.backLayerView)
        self.view.addSubview(gradientView)
        self.view.addSubview(self.scrollView)
        self.view.addSubview(self.overlayLogo)
        self.view.addSubview(self.pageControl)
        self.view.addSubview(self.leftButton)
        self.view.addSubview(self.rightButton)
    }
    
    func didClickOnButton1(sender: UIButton) {
        
    }
    
    func didClickOnButton2(sender: UIButton) {
        
    }
    
    func didClickOnPageControl(sender: UIPageControl) {
        self.stopScrolling()
        
        // Make the scrollView animation.
        self.scrollToNextPageIndex(sender.currentPage)
    }
    
    // Set the list of pages (ICETutorialPage).
    func setPages(pages: ICETutorialPage[] ) {
        self.pages = pages
    }
    
    func numberOfPages() -> Int {
        if (self.pages) {
            return self.pages!.count
        }
        return 0
    }
    
    func animateScrolling() {
        if (self.currentState == ScrollingState.Manual) {
            return;
        }
        
        // Jump to the next page...
        var nextPage: Int = self.currentPageIndex! + 1
        if (nextPage == self.numberOfPages()) {
            // ...stop the auto-scrolling or...
            if (!self.autoScrollEnabled) {
                self.currentState = ScrollingState.Manual
                return;
            }
            
            // ...jump to the first page.
            nextPage = 0
            self.currentState = ScrollingState.Looping
            
            // Set alpha on layers.
            self.setOriginLayerAlpha()
            self.setBackLayerPictureWithPageIndex(-1)
        } else {
            self.currentState = ScrollingState.Auto
        }
        
        // Make the scrollView animation.
        var nextPagePosition: Float = Float(nextPage) * 320
        self.scrollView!.setContentOffset(CGPointMake(nextPagePosition, 0), animated: true)
        
        // Set the PageControl on the right page.
        self.pageControl!.currentPage = nextPage
        
        // Call the next animation after X seconds.
        self.autoScrollToNextPage()
    }
    
    func autoScrollToNextPage() {
        let page: ICETutorialPage = self.pages[self.currentPageIndex!]
        
        if (self.autoScrollEnabled) {
            NSTimer.scheduledTimerWithTimeInterval(page.duration!, target: self, selector: Selector("animateScrolling"), userInfo: nil, repeats: false)
        }
    }
    
    func scrollToNextPageIndex(nextPageIndex: NSInteger) {
        // Make the scrollView animation.
        self.scrollView!.setContentOffset(CGPointMake(Float(nextPageIndex) * self.view.frame.size.width,0), animated: true)
        
        // Set the PageControl on the right page.
        self.pageControl!.currentPage = nextPageIndex
    }
    
    // Run it.
    func startScrolling() {
        self.autoScrollToNextPage()
    }
    
    // Manually stop the scrolling
    func stopScrolling() {
        self.currentState = ScrollingState.Manual
    }
    
    // State.    
    func getCurrentState() -> ScrollingState {
        return self.currentState!
    }
    
    // Setup the Title Label.
    func setOverlayTitle() {
        self.overlayLogo!.text = "Welcome"
    }
    
    // Setup the Title/Subtitle style/text.
    func setOverlayTexts() {
        var index: Int = 0
        for page in self.pages! {
            if (page.title.text) {
                var title: UILabel = self.overlayLabelWithText(page.title.text!, style: page.title!, commonStyle: self.commonPageTitleStyle, index: index)
                self.scrollView!.addSubview(title)
            }
            if (page.subTitle.text) {
                var subTitle: UILabel = self.overlayLabelWithText(page.subTitle.text!, style: page.subTitle!, commonStyle: self.commonPageSubTitleStyle!, index: index)
                self.scrollView!.addSubview(subTitle)
            }
            index++
        }
    }
    
    func overlayLabelWithText(text: NSString, style: ICETutorialLabelStyle, commonStyle: ICETutorialLabelStyle, index: NSInteger) -> UILabel {
        var position: CGFloat = (CGFloat)(index * 320)
        var positionY: CGFloat = (CGFloat)(540 - commonStyle.offsset)
        var overlayLabel: UILabel = UILabel()
        overlayLabel.frame = CGRectMake(position, positionY, 320, 34)
        
        // SubTitles.
        overlayLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        overlayLabel.numberOfLines = commonStyle.linesNumber
        overlayLabel.backgroundColor = UIColor.clearColor()
        overlayLabel.textAlignment = NSTextAlignment.Center

        // Datas and style.
        overlayLabel.text = text
        if (style.font) {
            overlayLabel.font = style.font
        } else {
            overlayLabel.font = commonStyle.font
        }
        if (style.color) {
            overlayLabel.textColor = style.color
        } else {
            overlayLabel.textColor = commonStyle.color
        }

        return overlayLabel
    }
    
    // Handle the background layer image switch.
    func setBackLayerPictureWithPageIndex(index: NSInteger) {
        self.setBackgroundImage(self.backLayerView!, pageIndex: index + 1)
    }
    
    // Handle the front layer image switch.
    func setFrontLayerPictureWithPageIndex(index: NSInteger) {
        self.setBackgroundImage(self.frontLayerView!, pageIndex: index)
    }
    
    // Handle page image's loading
    func setBackgroundImage(imageView: UIImageView, pageIndex: NSInteger) {
        if (pageIndex >= self.pages!.count) {
            imageView.image = nil
            return
        }
        
        let page: ICETutorialPage = self.pages[pageIndex]
        imageView.image = UIImage(named: page.pictureName!)
    }
    
    // Setup layer's alpha.    
    func setOriginLayerAlpha() {
        self.frontLayerView!.alpha = 1
        self.backLayerView!.alpha = 0
    }
    
    // Preset the origin state.    
    func setOriginLayersState() {
        self.currentState = ScrollingState.Auto
        self.backLayerView!.backgroundColor = UIColor.blackColor()
        self.frontLayerView!.backgroundColor = UIColor.blackColor()
        self.setLayersPicturesWithIndex(0)
    }
        
    // Setup the layers with the page index.
    func setLayersPicturesWithIndex(index: NSInteger) {
        self.currentPageIndex = index
        self.setOriginLayerAlpha()
        self.setFrontLayerPictureWithPageIndex(index)
        self.setBackLayerPictureWithPageIndex(index)
    }
    
    // Animate the fade-in/out (Cross-disolve) with the scrollView translation.    
    func disolveBackgroundWithContentOffset(offset: Float) {
        if (self.currentState == ScrollingState.Looping) {
            // Jump from the last page to the first.
            self.scrollingToFirstPageWithOffset(offset)
        } else {
            // Or just scroll to the next/previous page.
            self.scrollingToNextPageWithOffset(offset)
        }
    }
    
    // Handle alpha on layers when the auto-scrolling is looping to the first page.
    func scrollingToFirstPageWithOffset(offset: Float) {
        // Compute the scrolling percentage on all the page.
        let offsetX: Float = (offset * 320)
        let numberOfPage: Float = 5
        let offsetY: Float = (320 * numberOfPage)
        let finalOffset: Float = offsetX / offsetY
        
        // Scrolling finished...
        if (offset == 0) {
            self.setOriginLayersState()
            return
        }
        
        // Invert alpha for the back picture.
        var backLayerAlpha: Float = (1 - offset)
        var frontLayerAlpha: Float = offset
        
        // Set alpha.
        self.backLayerView!.alpha = backLayerAlpha
        self.frontLayerView!.alpha = frontLayerAlpha
    }
    
    // Handle alpha on layers when we are scrolling to the next/previous page.
    func scrollingToNextPageWithOffset(offset: Float) {
        // Current page index in scrolling.
        var page: Int = Int(offset)
        
        // Keep only the float value.
        var alphaValue: Float = offset - Float(Int(offset));
        
        // This is only when you scroll to the right on the first page.
        // That will fade-in black the first picture.
        if (alphaValue < 0 && self.currentPageIndex == 0) {
            self.backLayerView!.image = nil
            self.frontLayerView!.alpha = (1 + alphaValue)
            return
        }
        
        // Switch pictures, and imageView alpha.
        if (page != self.currentPageIndex ||
            (page == self.currentPageIndex && 0.0 < offset && offset < 1.0)) {
            self.setLayersPicturesWithIndex(page)
        }
        
        // Invert alpha for the front picture.
        var backLayerAlpha: Float = alphaValue
        var frontLayerAlpha: Float = (1 - alphaValue)
        
        // Set alpha.
        self.backLayerView!.alpha = backLayerAlpha
        self.frontLayerView!.alpha = frontLayerAlpha
    }

    func scrollViewDidScroll(scrollView: UIScrollView!) {
        // Get scrolling position, and nextPageindex.
        var scrollingPosition: Float = self.scrollView!.contentOffset.x / 320.0
        var nextPageIndex: Int = Int(scrollingPosition)
        
        // If we are looping, we reset the indexPage.
        if (self.currentState == ScrollingState.Looping) {
            nextPageIndex = 0
        }
        
        // If we are going to the next page, let's call the delegate.
        if (nextPageIndex != self.nextPageIndex) {
            // DELEGATE
            self.nextPageIndex = nextPageIndex
        }
        
        // Delegate when we reach the end.
        if (self.nextPageIndex == self.numberOfPages() - 1) {
            // DELEGATE
        }
        
        // Animate.
        self.disolveBackgroundWithContentOffset(scrollingPosition)
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView!) {
        // At the first user interaction, we disable the auto scrolling.
        if (self.scrollView!.tracking) {
            self.stopScrolling()
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView!) {
        // Update the page index.
        self.pageControl!.currentPage = self.currentPageIndex!;
    }
}