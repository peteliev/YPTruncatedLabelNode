//
//  YPTruncatedLabelNode.swift
//  YPTruncatedLabelNode
//
//  Created by Zhenya Peteliev on 1/29/19.
//  Copyright © 2019 Zhenya Peteliev. All rights reserved.
//

import SpriteKit

public enum TruncationMode {
    case head // Truncate at head of line: "...wxyz"
    case tail // Truncate at tail of line: "abcd..."
    case middle // Truncate middle of line:  "ab...yz"
}

final public class YPTruncatedLabelNode: SKLabelNode {
    
    private struct Configuration {
        static let truncationPattern = "..."
    }
    
    // MARK: - Private Properties
    private var font: NSFont? {
        guard let fontName = fontName else { return nil }
        return NSFont(name: fontName, size: fontSize)
    }
    
    // MARK: - Public Properties
    public var originalText: String? = nil {
        didSet { text = originalText }
    }
    
    public var maxWidth: CGFloat = 0
    
    // MARK: - Public Methods
    public func boundText() {
        guard let originalText = originalText, let font = font, maxWidth > 0.0 else { return }
        text = buildBoundedString(for: originalText, with: font, maxWidth: maxWidth)
    }
}

// MARK: - Private Methods
private extension YPTruncatedLabelNode {
    
    func width(for text: String, with font: NSFont) -> CGFloat {
        let size = text.size(withAttributes: [.font: font])
        return size.width
    }
    
    func buildBoundedString(for text: String, with font: NSFont, maxWidth: CGFloat) -> String {
        let textWidth = width(for: text, with: font)
        
        if textWidth < maxWidth {
            return text
        } else {
            let boundedString = text
                .replacingOccurrences(of: Configuration.truncationPattern, with: "")
                .dropLast()
                .appending(Configuration.truncationPattern)
            
            return buildBoundedString(for: boundedString, with: font, maxWidth: maxWidth)
        }
    }
}
