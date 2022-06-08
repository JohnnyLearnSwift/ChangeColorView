//
//  ViewController.swift
//  ChangeColorView
//
//  Created by Eugenie Tyan on 07.06.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redValueLabel: UILabel!
    @IBOutlet var greenValueLabel: UILabel!
    @IBOutlet var blueLabelValue: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        blueSlider.minimumTrackTintColor = .blue
        
        changeLabelValue(label: redValueLabel, slider: redSlider)
        changeLabelValue(label: greenValueLabel, slider: greenSlider)
        changeLabelValue(label: blueLabelValue, slider: blueSlider)
        
        view.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.9)
        
        changeViewBackgroundColor()
    }
    
    @IBAction func redSliderChangeValue() {
        changeLabelValue(label: redValueLabel, slider: redSlider)
    }
    @IBAction func greenSliderChangeValue() {
        changeLabelValue(label: greenValueLabel, slider: greenSlider)
    }
    @IBAction func blueSliderChangeValue() {
        changeLabelValue(label: blueLabelValue, slider: blueSlider)
    }
    
    func changeLabelValue (label: UILabel, slider: UISlider) {
        label.text = String(round(slider.value * 100) / 100)
        changeViewBackgroundColor()
    }
    //Commit
    func changeViewBackgroundColor () {
        colorView.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                            green: CGFloat(greenSlider.value),
                                            blue: CGFloat (blueSlider.value),
                                            alpha: 1.0)
    }
    
}

