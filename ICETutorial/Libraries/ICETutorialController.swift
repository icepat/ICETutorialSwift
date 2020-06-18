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
    case auto
    case manual
    case looping
}

class ICETutorialController : UIViewController, UIScrollViewDelegate {
    
    var frontLayerView = UIImageView()
    var backLayerView = UIImageView()
    var scrollView = UIScrollView()
    var pageControl = UIPageControl()
    var leftButton = UIButton()
    var rightButton = UIButton()
    
    var overlayLogo = UILabel()
    
    var currentPageIndex = 0
    var nextPageIndex = 0
    var currentState = ScrollingState.auto
    var pages: [ICETutorialPage]
    var autoScrollEnabled = true
    var commonPageTitleStyle: ICETutorialLabelStyle!
    var commonPageSubTitleStyle: ICETutorialLabelStyle!
    
    init(pages: [ICETutorialPage]) {
        self.pages = pages
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view?.backgroundColor = UIColor.black
        
        setupView()
        
        // Overlays
        setOverlayTexts()
        setOverlayTitle()
        
        // Preset the origin state.
        setOriginLayersState()
    }
    
    func setupView() {
        frontLayerView.frame = view.bounds
        backLayerView.frame = view.bounds
        
        // Decoration
        let gradientView = UIImageView(frame: view.bounds)
        gradientView.image = UIImage(named: "background-gradient.png")
        
        // Title
        overlayLogo.frame = CGRect.init(origin: CGPoint.init(x: 0, y: 40), size: CGSize.init(width: view.bounds.size.width, height: 40))
        overlayLogo.textColor = .white
        overlayLogo.textAlignment = .center
        overlayLogo.font = .boldSystemFont(ofSize: 32)
        
        // ScrollView configuration
        scrollView.frame = view.bounds
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.contentSize = CGSize(width: CGFloat(pages.count) * view.bounds.width, height: view.bounds.height)
        
        // PageControl
        var rect = CGRect.zero
        rect.size.width = CGFloat(pages.count) * 8.0
        rect.size.height = 32
        rect.origin.x = (view.bounds.size.width - rect.size.width) / 2.0
        rect.origin.y = view.bounds.size.height - 120
        pageControl.frame = rect
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        pageControl.addTarget(self, action: #selector(didClickOnPageControl(sender:)), for: UIControl.Event.valueChanged)
        
        // UIButtons
        rect.size.width = 130
        rect.size.height = 36
        rect.origin.x = 30
        rect.origin.y = view.bounds.size.height - 80.0
        leftButton.frame = rect
        rect.origin.x = view.bounds.size.width - rect.size.width - rect.origin.x
        rightButton.frame = rect
        leftButton.backgroundColor = .darkGray
        rightButton.backgroundColor = .darkGray
        leftButton.setTitle("Button 1", for: .normal)
        rightButton.setTitle("Button 2", for: .normal)
        leftButton.addTarget(self, action: #selector(didClickOnButton1(sender:)), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(didClickOnButton2(sender:)), for: .touchUpInside)
        
        // Fetch on screen
        view.addSubview(frontLayerView)
        view.addSubview(backLayerView)
        view.addSubview(gradientView)
        view.addSubview(scrollView)
        view.addSubview(overlayLogo)
        view.addSubview(pageControl)
        view.addSubview(leftButton)
        view.addSubview(rightButton)
    }
    
    @objc func didClickOnButton1(sender: UIButton) {
        
    }
    
    @objc func didClickOnButton2(sender: UIButton) {
        
    }
    
    @objc func didClickOnPageControl(sender: UIPageControl) {
        stopScrolling()
        
        // Make the scrollView animation
        scrollToNextPageIndex(nextPageIndex: sender.currentPage)
    }
    
    // Set the list of pages (ICETutorialPage)
    func setPages(pages: [ICETutorialPage] ) {
        self.pages = pages
    }
    
    @objc func animateScrolling() {
        if (currentState == ScrollingState.manual) {
            return;
        }
        
        // Jump to the next page...
        var nextPage = currentPageIndex + 1
        if (nextPage == pages.count) {
            // ...stop the auto-scrolling or...
            if (!autoScrollEnabled) {
                currentState = ScrollingState.manual
                return;
            }
            
            // ...jump to the first page.
            nextPage = 0
            currentState = ScrollingState.looping
            
            // Set alpha on layers.
            setOriginLayerAlpha()
            setBackLayerPictureWithPageIndex(index: -1)
        } else {
            currentState = ScrollingState.auto
        }
        
        // Make the scrollView animation.
        let nextPagePosition = CGFloat(nextPage) * view.frame.size.width
        scrollView.setContentOffset(CGPoint(x: nextPagePosition, y: 0), animated: true)
        
        // Set the PageControl on the right page.
        pageControl.currentPage = nextPage
        
        // Call the next animation after X seconds.
        autoScrollToNextPage()
    }
    
    func autoScrollToNextPage() {
        if (autoScrollEnabled) {
            Timer.scheduledTimer(timeInterval: pages[currentPageIndex].duration!, target: self, selector: #selector(animateScrolling), userInfo: nil, repeats: false)
        }
    }
    
    func scrollToNextPageIndex(nextPageIndex: NSInteger) {
        // Make the scrollView animation.
        scrollView.setContentOffset(CGPoint(x: CGFloat(nextPageIndex) * view.frame.size.width, y: 0), animated: true)
        
        // Set the PageControl on the right page.
        pageControl.currentPage = nextPageIndex
    }
    
    // Run it.
    func startScrolling() {
        autoScrollToNextPage()
    }
    
    // Manually stop the scrolling
    func stopScrolling() {
        currentState = ScrollingState.manual
    }
    
    // Setup the Title Label.
    func setOverlayTitle() {
        overlayLogo.text = "Welcome"
    }
    
    // Setup the Title/Subtitle style/text.
    func setOverlayTexts() {
        var index: Int = 0
        for page in pages {
            let title = overlayLabelWithText(text: page.title.text!, style: page.title!, commonStyle: commonPageTitleStyle, index: index)
            scrollView.addSubview(title)
            let subTitle = overlayLabelWithText(text: page.subTitle.text!, style: page.subTitle!, commonStyle: commonPageSubTitleStyle!, index: index)
            scrollView.addSubview(subTitle)
            index += 1
        }
    }
    
    func overlayLabelWithText(text: String, style: ICETutorialLabelStyle, commonStyle: ICETutorialLabelStyle, index: Int) -> UILabel {
        let position = CGFloat(index) * view.bounds.size.width
        let positionY = view.bounds.size.height - commonStyle.offset
        let overlayLabel = UILabel()
        overlayLabel.frame = CGRect(x: position, y: positionY, width: view.bounds.size.width, height: 34)
        
        // SubTitles.
        overlayLabel.translatesAutoresizingMaskIntoConstraints = false
        overlayLabel.numberOfLines = commonStyle.linesNumber
        overlayLabel.backgroundColor = .clear
        overlayLabel.textAlignment = .center
        
        // Datas and style.
        overlayLabel.text = text as String
        overlayLabel.font = commonStyle.font
        if (style.font != commonStyle.font) {
            overlayLabel.font = style.font
        }
        overlayLabel.textColor = commonStyle.color
        if (style.color != commonStyle.color) {
            overlayLabel.textColor = style.color
        }
        
        return overlayLabel
    }
    
    // Handle the background layer image switch.
    func setBackLayerPictureWithPageIndex(index: NSInteger) {
        setBackgroundImage(imageView: backLayerView, pageIndex: index + 1)
    }
    
    // Handle the front layer image switch.
    func setFrontLayerPictureWithPageIndex(index: NSInteger) {
        setBackgroundImage(imageView: frontLayerView, pageIndex: index)
    }
    
    // Handle page image's loading
    func setBackgroundImage(imageView: UIImageView, pageIndex: NSInteger) {
        if (pageIndex >= pages.count) {
            imageView.image = nil
            return
        }
        
        let page: ICETutorialPage = pages[pageIndex]
        imageView.image = UIImage(named: page.pictureName!)
    }
    
    // Setup layer's alpha.    
    func setOriginLayerAlpha() {
        frontLayerView.alpha = 1
        backLayerView.alpha = 0
    }
    
    // Preset the origin state.    
    func setOriginLayersState() {
        currentState = ScrollingState.auto
        backLayerView.backgroundColor = .black
        frontLayerView.backgroundColor = .black
        setLayersPicturesWithIndex(index: 0)
    }
    
    // Setup the layers with the page index.
    func setLayersPicturesWithIndex(index: NSInteger) {
        currentPageIndex = index
        setOriginLayerAlpha()
        setFrontLayerPictureWithPageIndex(index: index)
        setBackLayerPictureWithPageIndex(index: index)
    }
    
    // Animate the fade-in/out (Cross-disolve) with the scrollView translation.    
    func disolveBackgroundWithContentOffset(offset: CGFloat) {
        if (currentState == ScrollingState.looping) {
            // Jump from the last page to the first.
            scrollingToFirstPageWithOffset(offset: offset)
        } else {
            // Or just scroll to the next/previous page.
            scrollingToNextPageWithOffset(offset: offset)
        }
    }
    
    // Handle alpha on layers when the auto-scrolling is looping to the first page.
    func scrollingToFirstPageWithOffset(offset: CGFloat) {
        // Compute the scrolling percentage on all the page.
        let offsetX = offset * view.bounds.size.width
        let numberOfPage = CGFloat(pages.count)
        let offsetY = view.bounds.size.width * numberOfPage
        let finalOffset = offsetX / offsetY
        
        // Scrolling finished...
        if (finalOffset == 0) {
            setOriginLayersState()
            return
        }
        
        // Invert alpha for the back picture.
        let backLayerAlpha = 1.0 - finalOffset
        let frontLayerAlpha = finalOffset
        
        // Set alpha.
        backLayerView.alpha = backLayerAlpha
        frontLayerView.alpha = frontLayerAlpha
    }
    
    // Handle alpha on layers when we are scrolling to the next/previous page.
    func scrollingToNextPageWithOffset(offset: CGFloat) {
        // Current page index in scrolling.
        let page: Int = Int(offset)
        
        // Keep only the float value.
        let alphaValue = offset - CGFloat(Int(offset));
        
        // This is only when you scroll to the right on the first page.
        // That will fade-in black the first picture.
        if (alphaValue < 0 && currentPageIndex == 0) {
            backLayerView.image = nil
            frontLayerView.alpha = 1.0 + alphaValue
            return
        }
        
        // Switch pictures, and imageView alpha.
        if (page != currentPageIndex ||
            (page == currentPageIndex && 0.0 < offset && offset < 1.0)) {
            setLayersPicturesWithIndex(index: page)
        }
        
        // Invert alpha for the front picture.
        let backLayerAlpha = alphaValue
        let frontLayerAlpha = 1.0 - alphaValue
        
        // Set alpha.
        backLayerView.alpha = backLayerAlpha
        frontLayerView.alpha = frontLayerAlpha
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Get scrolling position, and nextPageindex.
        let scrollingPosition = scrollView.contentOffset.x / view.bounds.size.width
        var nextPageIndex = Int(scrollingPosition)
        
        // If we are looping, we reset the indexPage.
        if (currentState == ScrollingState.looping) {
            nextPageIndex = 0
        }
        
        // If we are going to the next page, let's call the delegate.
        if (self.nextPageIndex != nextPageIndex) {
            // DELEGATE
            self.nextPageIndex = nextPageIndex
        }
        
        // Delegate when we reach the end.
        if (nextPageIndex == pages.count - 1) {
            // DELEGATE
        }
        
        // Animate.
        disolveBackgroundWithContentOffset(offset: scrollingPosition)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // At the first user interaction, we disable the auto scrolling.
        if (scrollView.isTracking) {
            stopScrolling()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // Update the page index.
        pageControl.currentPage = currentPageIndex;
    }
    
}
