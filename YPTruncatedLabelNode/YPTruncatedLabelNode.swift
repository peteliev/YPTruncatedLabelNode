//
//  YPTruncatedLabelNode.swift
//  YPTruncatedLabelNode
//
//  Created by Zhenya Peteliev on 1/29/19.
//  Copyright © 2019 Zhenya Peteliev. All rights reserved.
//

import SpriteKit

#if os(iOS)
    import UIKit
    public typealias Font = UIFont
#else
    import AppKit
    public typealias Font = NSFont
#endif

public enum TruncationMode {
    case head // Truncate at head of line: "...wxyz"
    case tail // Truncate at tail of line: "abcd..."
    case middle // Truncate middle of line:  "ab...yz"
}

final public class YPTruncatedLabelNode: SKLabelNode {
    
    private struct Configuration {
        static let truncationPattern = "..."
    }
    
    // MARK: - Public Properties
    public var originalText: String? = nil {
        didSet { text = originalText }
    }
    
    public var truncationMode: TruncationMode = .tail
    public var maxWidth: CGFloat = 0
    
    // MARK: - Private Properties
    private var font: Font? {
        guard let fontName = fontName else { return nil }
        return Font(name: fontName, size: fontSize)
    }
    
    // MARK: - Public Methods
    public func boundText() {
        guard let originalText = originalText, let font = font, maxWidth > 0.0 else { return }
        text = buildBoundedString(for: originalText, with: font, maxWidth: maxWidth)
    }
}

// MARK: - Private Methods
private extension YPTruncatedLabelNode {
    
    func width(for text: String, with font: Font) -> CGFloat {
        let size = text.size(withAttributes: [.font: font])
        return size.width
    }
    
    func buildBoundedString(for text: String, with font: Font, maxWidth: CGFloat) -> String {
        let textWidth = width(for: text, with: font)
        
        if textWidth < maxWidth {
            return text
        } else {
            let truncatedString = buildTruncatedString(from: text, with: truncationMode)
            return buildBoundedString(for: truncatedString, with: font, maxWidth: maxWidth)
        }
    }
    
    func buildTruncatedString(from text: String, with truncationMode: TruncationMode) -> String {
        let truncation = Configuration.truncationPattern
        
        switch truncationMode {
        case .head:
            let truncatedText = text
                .replacingOccurrences(of: truncation, with: "")
                .dropFirst()
            return truncation.appending(truncatedText)
        case .tail:
            return text
                .replacingOccurrences(of: truncation, with: "")
                .dropLast()
                .appending(truncation)
        case .middle:
            let untruncatedText = text.replacingOccurrences(of: truncation, with: "")
            
            let halfCount = untruncatedText.count / 2
            let isEvenCount = untruncatedText.count % 2 == 1
            let offset = isEvenCount ? 1 : 0
            
            let firstHalf = untruncatedText.prefix(halfCount + offset)
            let secondHalf = untruncatedText.suffix(halfCount)
            let firstHalfWithoutLast = firstHalf.dropLast()
            
            return firstHalfWithoutLast + truncation + secondHalf
        }
    }
}
