//
//  MainViewController.swift
//  ChangeColorView
//
//  Created by Eugenie Tyan on 13.08.2022.
//

import UIKit

protocol ViewControllerDelegate {
    func setNewColor(color: UIColor)
}

class MainViewController: UIViewController {
    
    @IBOutlet var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.backgroundColor = UIColor.random
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let VC = segue.destination as? ViewController else { return }
        VC.color = backgroundView.backgroundColor
        VC.delegate = self
    }
    
    @IBAction func unwind(for unwindSegue: UIStoryboardSegue) {
        //Выглядит как костыль
        navigationController?.navigationBar.isHidden = false
    }
}

extension MainViewController: ViewControllerDelegate {
    func setNewColor(color: UIColor) {
        backgroundView.backgroundColor = color
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
}
