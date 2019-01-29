//
//  ViewController.swift
//  YPTruncatedLabelNodeExample
//
//  Created by Zhenya Peteliev on 1/29/19.
//  Copyright © 2019 Zhenya Peteliev. All rights reserved.
//

import Cocoa
import SpriteKit
import GameplayKit

class ViewController: NSViewController {

    @IBOutlet var skView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let view = self.skView {
            let scene = SKScene(size: view.frame.size)
            scene.scaleMode = .aspectFill
            scene.backgroundColor = .white
            
            // Present the scene
            view.presentScene(scene)
        }
    }
}

