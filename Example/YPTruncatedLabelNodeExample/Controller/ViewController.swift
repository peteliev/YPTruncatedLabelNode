//
//  ViewController.swift
//  YPTruncatedLabelNodeExample
//
//  Created by Zhenya Peteliev on 1/29/19.
//  Copyright © 2019 Zhenya Peteliev. All rights reserved.
//

import Cocoa
import SpriteKit
import YPTruncatedLabelNode

final public class ViewController: NSViewController {

    @IBOutlet private weak var skView: SKView!
    
    private lazy var labelNode: YPTruncatedLabelNode = {
        let text = """
            Lorem ipsum dolor sit amet, consectetur adipiscing elit,
            sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
            """
        
        let labelNode = YPTruncatedLabelNode(text: text)
        labelNode.fontColor = .black
        labelNode.fontSize = 30
        return labelNode
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        if let view = self.skView {
            let size = view.frame.size
            let scene = SKScene(size: size)
            
            scene.scaleMode = .aspectFill
            scene.backgroundColor = .white
            
            // Present the scene
            view.presentScene(scene)
            
            // Setup label node
            scene.addChild(labelNode)
            labelNode.position = NSPoint(x: size.width / 2, y: size.height / 2)
        }
    }
    
    public override func viewDidLayout() {
        super.viewDidLayout()
        // todo
    }
}
