//
//  ViewController.swift
//  AutoLayoutSplitView
//
//  Created by Alonso on 2019/7/12.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Cocoa

class ViewController: NSViewController,NSSplitViewDelegate {

    @IBOutlet weak var splitView: NSSplitView!
    @IBOutlet weak var leftPane: NSView!
    @IBOutlet weak var middlePane: NSView!
    @IBOutlet weak var rightPane: NSView!
    var lastLeftPaneWidth :CGFloat = 0
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.leftPane.translatesAutoresizingMaskIntoConstraints = false
        self.rightPane.translatesAutoresizingMaskIntoConstraints = false
        lastLeftPaneWidth = self.leftPane.frame.size.width
        splitView.delegate = self
    }
    
    func splitView(_ splitView: NSSplitView, canCollapseSubview subview: NSView) -> Bool {
        if subview == leftPane {
            return true
        }else if subview == rightPane{
            return true
        }
        return false
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}
