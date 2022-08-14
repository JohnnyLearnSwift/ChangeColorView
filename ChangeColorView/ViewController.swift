//
//  ViewController.swift
//  ChangeColorView
//
//  Created by Eugenie Tyan on 07.06.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var colorView: UIView!
    @IBOutlet var valueLabels: [UILabel]!
    @IBOutlet var sliders: [UISlider]!
    @IBOutlet var valueTextFields: [UITextField]!
    
    var delegate: ViewControllerDelegate!
    var color: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsVC()
    }
    
    @IBAction func dragSlider(_ sender: UISlider) {
        guard let sliderIndex = sliders.firstIndex(of: sender) else { return }
        let value = sliders[sliderIndex].value
        valueLabels[sliderIndex].text = String(round(value * 100) / 100)
        valueTextFields[sliderIndex].text = String(round(value * 100) / 100)
        changeViewBackgroundColor()
    }
    
    @IBAction func buttonDonePressed() {
        view.endEditing(true)
        color = UIColor(red: CGFloat(sliders[0].value),
                        green: CGFloat(sliders[1].value),
                        blue: CGFloat (sliders[2].value),
                        alpha: 1.0)
        delegate.setNewColor(color: color)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text else { return }
        guard let numberValue = Float(newValue) else {
            switch textField {
            case valueTextFields[0]:
                textField.text = valueLabels[0].text
            case valueTextFields[1]:
                textField.text = valueLabels[1].text
            case valueTextFields[2]:
                textField.text = valueLabels[2].text
            default:
                break
            }
            return
            
        }

        switch textField {
        case valueTextFields[0]:
            sliders[0].value = numberValue
            valueLabels[0].text = String(round(numberValue * 100) / 100)
        case valueTextFields[1]:
            sliders[1].value = numberValue
            valueLabels[1].text = String(round(numberValue * 100) / 100)
        case valueTextFields[2]:
            sliders[2].value = numberValue
            valueLabels[2].text = String(round(numberValue * 100) / 100)
        default:
            break
        }
        
        changeViewBackgroundColor()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    private func getRGBValues(from color: UIColor) {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        
        color.getRed(&red, green: &green, blue: &blue, alpha: nil)
        let rgb = [red, green, blue]
        
        //решение не универсальное, альтернатива 3 цикла с zip запускать
        for number in 0...2 {
            let roundValue = String(round(Double(rgb[number]) * 100) / 100)
            valueLabels[number].text = roundValue
            sliders[number].value = Float(rgb[number])
            valueTextFields[number].text = roundValue
        }
    }
    
    private func changeViewBackgroundColor() {
        //костыли везде, хочется глаза выколоть от такого кода
        colorView.backgroundColor = UIColor(red: CGFloat(sliders[0].value),
                                            green: CGFloat(sliders[1].value),
                                            blue: CGFloat (sliders[2].value),
                                            alpha: 1.0)
    }
    
    private func settingsVC() {
        for textField in valueTextFields {
            textField.delegate = self
        }
        navigationController?.navigationBar.isHidden = true
        colorView.layer.cornerRadius = 10
        colorView.backgroundColor = color
        getRGBValues(from: color)
    }
}
