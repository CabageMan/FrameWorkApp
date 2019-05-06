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
    private let renderer = KnobRender()
    
    var minValue: CGFloat = 0
    
    var maxValue: CGFloat = 1
    
    private (set) var value: CGFloat = 0
    
    func setValue(_ newValue: CGFloat, isAnimated: Bool = false) {
        value = min(maxValue, (max(minValue, newValue)))
        
        let angleRange = endAngle - startAngle
        let valueRange = maxValue - minValue
        let angleValue = (value - minValue) / valueRange * angleRange + startAngle
        renderer.setPointerAngle(angleValue, animated: isAnimated)
    }
    
    var isContinuous: Bool = true
    
    var linewidth: CGFloat {
        get { return renderer.lineWidth }
        set { renderer.lineWidth = newValue }
    }
    
    var startAngle: CGFloat {
        get { return renderer.startAngle }
        set { renderer.startAngle = newValue }
    }
    
    var endAngle: CGFloat {
        get { return renderer.endAngle }
        set { renderer.endAngle = newValue }
    }
    
    var pointerLength: CGFloat {
        get { return renderer.pointerLength }
        set { renderer.pointerLength = newValue }
    }
    
    // MARK: Initializers
    init(diameter: CGFloat) {
        super.init(frame: .zero)
        renderer.updateBounds(CGRect(x: 0, y: 0, width: diameter, height: diameter))
        renderer.color = tintColor
        renderer.setPointerAngle(renderer.startAngle, animated: false)
        
        layer.addSublayer(renderer.trackLayer)
        layer.addSublayer(renderer.pointerLayer)
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
    
    func setPointerAngle(_ newAngle: CGFloat, animated: Bool = false) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        pointerLayer.transform = CATransform3DMakeRotation(newAngle, 0, 0, 1)
        pointerAngle = newAngle
        if animated {
            let midAngleValue = (max(newAngle, pointerAngle) - min(newAngle, pointerAngle)) / 2
                + min(newAngle, pointerAngle)
            let animation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
            animation.values = [pointerAngle, midAngleValue, newAngle]
            animation.keyTimes = [0.0, 0.5, 1.0]
            animation.timingFunctions = [CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)]
            pointerLayer.add(animation, forKey: nil)
        }
        CATransaction.commit()
    }
    
    // MARK: Initializers
    init() {
        trackLayer.fillColor = UIColor.clear.cgColor
        pointerLayer.fillColor = UIColor.clear.cgColor
    }
    
    // MARK: Actions
    private func updateTrackLayerPath() {
        let bounds = trackLayer.bounds
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let offset = max(pointerLength, lineWidth  / 2)
        let radius = min(bounds.width, bounds.height) / 2 - offset
        
        let ring = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle,
                                endAngle: endAngle, clockwise: true)
        trackLayer.path = ring.cgPath
    }
    
    private func updatePointerLayerPath() {
        let bounds = trackLayer.bounds
        
        let pointer = UIBezierPath()
        pointer.move(to: CGPoint(x: bounds.width - pointerLength - lineWidth/4, y: bounds.midY))
        pointer.addLine(to: CGPoint(x: bounds.width, y: bounds.midY))
        pointerLayer.path = pointer.cgPath
    }
    
    func updateBounds(_ bounds: CGRect) {
        trackLayer.bounds = bounds
//        trackLayer.position = .zero
        updateTrackLayerPath()
        
        pointerLayer.bounds = trackLayer.bounds
        pointerLayer.position = trackLayer.position
        updatePointerLayerPath()
    }
}
