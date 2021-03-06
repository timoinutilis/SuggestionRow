//
//  SuggestionCollectionViewCell.swift
//
//  Adapted from Mathias Claassen 4/14/16 by Hélène Martin 8/11/16
//
//

import Foundation
import Eureka


public protocol EurekaSuggestionCollectionViewCell {
    associatedtype S: SuggestionValue

    func setupForValue(_ value: S)
    func sizeThatFits() -> CGSize
}

/// Default cell for the inputAccessoryView of the SuggestionRow
open class SuggestionCollectionViewCell<T: SuggestionValue>: UICollectionViewCell, EurekaSuggestionCollectionViewCell {
    public typealias S = T

    public var label = UILabel()

    override public init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    func initialize() {
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 1
        label.minimumScaleFactor = 0
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.backgroundColor = tintColor
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        
        contentView.addSubview(label)
        contentView.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[label]|", options: [], metrics: nil, views: ["label": label]))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label]|", options: [], metrics: nil, views: ["label": label]))
    }
    
    open func setupForValue(_ value: T) {
        label.text = "  \(value.suggestionString)"
    }
    
    open func sizeThatFits() -> CGSize {
        label.frame = CGRect(x: 0, y: 0, width: 180, height: 30)
        label.sizeToFit()
        return CGSize(width: label.frame.width + 8, height: 30)
    }
    
    open override func tintColorDidChange() {
        super.tintColorDidChange()
        label.backgroundColor = tintColor
    }
}
