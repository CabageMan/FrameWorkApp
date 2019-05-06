//
//  ViewController.swift
//  FrameworkApp
//
//  Created by ViktorB on 30/04/2019.
//  Copyright © 2019 Ramotion. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let knob = KnobControl(diameter: 130)
    private let slider = UISlider()
    
    private let knobSide: CGFloat = 130
    private let subviewsSidePadding: CGFloat = 23
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
      
        view.backgroundColor = .white
        
        view.addSubview(knob)
        knob.translatesAutoresizingMaskIntoConstraints = false
        knob.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        knob.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: knobSide/2 + subviewsSidePadding).isActive = true
//        knob.widthAnchor.constraint(equalToConstant: knobSide).isActive = true
//        knob.heightAnchor.constraint(equalToConstant: knobSide).isActive = true
        
        knob.linewidth = 4
        knob.pointerLength = 10
        
        view.addSubview(slider)
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        slider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: subviewsSidePadding).isActive = true
        slider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -subviewsSidePadding).isActive = true
        slider.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        slider.addTarget(self, action: #selector(sliderChangeValue(sender:)), for: .valueChanged)
    }
    
    @objc private func sliderChangeValue(sender: UISlider) {
        knob.setValue(CGFloat(sender.value), isAnimated: true)
    }
}

