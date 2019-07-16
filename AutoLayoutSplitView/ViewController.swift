//
//  ViewController.swift
//  AutoLayoutSplitView
//
//  Created by Alonso on 2019/7/12.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Cocoa

class ViewController: NSViewController,NSSplitViewDelegate {

    @IBOutlet weak var scrollView: NSScrollView!
    @IBOutlet weak var splitView: NSSplitView!
    @IBOutlet weak var leftPane: NSView!
    @IBOutlet weak var middlePane: NSView!
    @IBOutlet weak var rightPane: NSView!
    @IBOutlet weak var slider: NSSlider!
    var lastLeftPaneWidth :CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.leftPane.translatesAutoresizingMaskIntoConstraints = false
        self.rightPane.translatesAutoresizingMaskIntoConstraints = false
        lastLeftPaneWidth = self.leftPane.frame.size.width
        splitView.delegate = self
    }
    
    @IBAction func leftClick(_ sender: NSButton) {

        NSAnimationContext.runAnimationGroup { (context) in
            context.allowsImplicitAnimation = true
            context.duration = 0.25
            context.timingFunction = CAMediaTimingFunction(name: .easeOut)
            if splitView.isSubviewCollapsed(leftPane){
                splitView.setPosition(lastLeftPaneWidth, ofDividerAt: 0)
            }else{
                lastLeftPaneWidth = leftPane.frame.size.width
                splitView.setPosition(0, ofDividerAt: 0)
            }
            splitView.layoutSubtreeIfNeeded()
        }
    }
    
    @IBAction func rightClick(_ sender: NSButton) {
        NSAnimationContext.runAnimationGroup { (context) in
            context.allowsImplicitAnimation = true
            context.duration = 0.25
            context.timingFunction = CAMediaTimingFunction(name: .easeOut)
            if splitView.isSubviewCollapsed(rightPane){
                splitView.setPosition(NSMaxX(splitView.frame) - rightPane.frame.size.width, ofDividerAt: 1)
            }else{
                splitView.setPosition(NSMaxX(splitView.frame), ofDividerAt: 1)
            }
            splitView.layoutSubtreeIfNeeded()
        }
    }
    
    @IBAction func LoadPicture(_ sender: NSButton) {
        // load photo
        let photoURL = Bundle.main.url(forResource: "butterfly", withExtension: "jpg")
        var image:NSImage? = nil
        if (photoURL != nil){
            image = NSImage(contentsOf: photoURL!)
        }
        
        //let originalSize = image?.size
        let imageRect = NSRect(x: 0, y: 0, width: image?.size.width ?? 0.0, height: image?.size.height ?? 0.0)
        let imageView = NSImageView(frame: imageRect)
        imageView.bounds = imageRect
        imageView.image = image
        
        // to pass to the bindings dictionary below - can't use dot notation (?)
        //let scrollView = scrollView
        scrollView.documentView = imageView
        // turn off autoresizing for scroll view
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        //let views = ["scrollView" : scrollView]
        
//        if let views = views as? [String : NSScrollView] {
//            middlePane.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H|[scrollView]", options: [], metrics: nil, views: views))
//            middlePane.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V|[scrollView]", options: [], metrics: nil, views: views))
//        }
    }
    
    @IBAction func slideAction(_ sender: NSSlider) {
        let scaleFactor = slider.floatValue
        //print(CGFloat(scaleFactor))
        scrollView.magnification = CGFloat(scaleFactor)/100
        scrollView.contentView.needsDisplay = true
    }
    
    func splitView(_ splitView: NSSplitView, canCollapseSubview subview: NSView) -> Bool {
        if subview == leftPane {
            return true
        }else if subview == rightPane{
            return true
        }
        return false
    }
}
