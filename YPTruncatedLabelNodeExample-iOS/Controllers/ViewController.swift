//
//  ViewController.swift
//  YPTruncatedLabelNodeExample-iOS
//
//  Created by Zhenya Peteliev on 2/3/19.
//  Copyright © 2019 Zhenya Peteliev. All rights reserved.
//

import SpriteKit
import YPTruncatedLabelNode

final public class ViewController: UIViewController {
    
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
        
        let size = skView.frame.size
        let scene = SKScene(size: size)
        scene.scaleMode = .aspectFill
        scene.backgroundColor = .white
        
        // present the scene
        skView.presentScene(scene)
        
        // setup label node
        scene.addChild(labelNode)
        labelNode.position = CGPoint(x: size.width / 2, y: size.height / 2)        
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateLabelNode()
    }
}

// MARK: - Private Methods
private extension ViewController {
    
    func updateLabelNode() {
        labelNode.maxWidth = skView.frame.width
        labelNode.boundText()
    }
}


