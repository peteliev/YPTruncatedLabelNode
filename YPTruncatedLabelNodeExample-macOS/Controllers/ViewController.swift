//
//  ViewController.swift
//  YPTruncatedLabelNodeExample-macOS
//
//  Created by Zhenya Peteliev on 2/3/19.
//  Copyright © 2019 Zhenya Peteliev. All rights reserved.
//

import Cocoa
import SpriteKit
import YPTruncatedLabelNode

final public class ViewController: NSViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var skView: SKView!
    
    private lazy var labelNode: YPTruncatedLabelNode = {
        let text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        
        let labelNode = YPTruncatedLabelNode()
        labelNode.truncationMode = .tail
        labelNode.originalText = text
        labelNode.fontColor = .black
        labelNode.fontSize = 30
        
        return labelNode
    }()
    
    // MARK: - NSViewController
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.skView {
            let size = view.frame.size
            let scene = SKScene(size: size)
            
            scene.scaleMode = .aspectFill
            scene.backgroundColor = .white
            
            // present the scene
            view.presentScene(scene)
            
            // setup label node
            scene.addChild(labelNode)
            labelNode.position = NSPoint(x: size.width / 2, y: size.height / 2)
        }
    }
    
    public override func viewDidLayout() {
        super.viewDidLayout()
        updateLabelNode()
    }
}

// MARK: - Private Methods
private extension ViewController {
    
    func updateLabelNode() {
        labelNode.maxWidth = view.frame.width
        labelNode.boundText()
    }
}
