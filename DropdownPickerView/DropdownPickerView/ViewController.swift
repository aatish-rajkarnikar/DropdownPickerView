//
//  ViewController.swift
//  DropdownPickerView
//
//  Created by Aatish Rajkarnikar on 2/8/17.
//  Copyright © 2017 Aatish Rajkarnikar. All rights reserved.
//

import UIKit

class ViewController: UIViewController,DropdownPickerViewDelegate {

    @IBOutlet var pickerView: DropdownPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let countries = NSLocale.isoCountryCodes.map { (code:String) -> String in
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            return NSLocale(localeIdentifier: "en_US").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
        }
        pickerView.dataSource = countries
        pickerView.delegate = self
    }
    
    func pickerView(pickerView: DropdownPickerView, didSelectAt index: NSInteger, withValue value: String) {
        //Is called when user select an option from dropdown.
    }

}


