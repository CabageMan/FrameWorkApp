//
//  KnobController.swift
//  FrameworkApp
//
//  Created by ViktorB on 30/04/2019.
//  Copyright © 2019 Ramotion. All rights reserved.
//

import UIKit

final class KnobControl: UIControl {
    
    
    // MARK: Properties
    var minValue: CGFloat = 0
    
    var maxValue: CGFloat = 1
    
    private (set) var value: CGFloat = 0
    
    func setValue(_ newValue: CGFloat, isAnimated: Bool = false) {
        value = min(maxValue, (max(minValue, newValue)))
    }
    
    
    var isContinuous: Bool = true
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
}

private class KnobRender {
    
    // MARK: Properties
    let trackLayer = CAShapeLayer()
    
    let pointerLayer = CAShapeLayer()
    
    var color: UIColor = .green {
        didSet{
            trackLayer.strokeColor = color.cgColor
            pointerLayer.strokeColor = color.cgColor
        }
    }
    
    var lineWidth: CGFloat = 3 {
        didSet {
            trackLayer.lineWidth = lineWidth
            pointerLayer.lineWidth = lineWidth
            updateTrackLayerPath()
            updatePointerLayerPath()
        }
    }
    
    var startAngle: CGFloat = -(.pi * 11 / 8) {
        didSet {
            updateTrackLayerPath()
        }
    }
    
    var endAngle: CGFloat = .pi * 3 / 8 {
        didSet {
            updateTrackLayerPath()
        }
    }
    
    var pointerLength: CGFloat = 6 {
        didSet {
            updateTrackLayerPath()
            updatePointerLayerPath()
        }
    }
    
    private (set) var pointerAngle: CGFloat = -(.pi * 11 / 8)
    
    func setPointerAngle(_ newAngle: CGFloat, isAnimated: Bool = false) {
        pointerAngle = newAngle
    }
    
    
    // MARK: Initializers
    
    
    // MARK: Actions
    private func updateTrackLayerPath() {
        
    }
    
    private func updatePointerLayerPath() {
        
    }
}
