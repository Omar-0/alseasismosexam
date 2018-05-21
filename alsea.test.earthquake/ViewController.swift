//
//  ViewController.swift
//  alsea.test.earthquake
//
//  Created by 0mar on 5/21/18.
//  Copyright © 2018 omar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    

    @IBOutlet weak var degressPicker: UIPickerView!
    @IBOutlet weak var initialDatePicker: UIDatePicker!
    @IBOutlet weak var finalDatePicker: UIDatePicker!
    @IBOutlet weak var lastButton: UIButton!
    @IBOutlet weak var newButton: UIButton!
    
    
    var initialDate:String?
    var finalDate:String?
    var degrees:String?
    
    var pickerDataSource = ["5.0", "5.5", "6.5", "7.0", "7.5", "8.0", "8.5", "9.0", "9.5"];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        degressPicker.delegate = self
        degressPicker.dataSource = self
        
        print("Running!!!")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func initialDateChanged(_ sender: UIDatePicker) {
        print("intial date changed")
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        dateFormatter.timeStyle = DateFormatter.Style.none
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        print( dateFormatter.string(from: sender.date) )
        
        initialDate = dateFormatter.string(from: sender.date)

    }
    
    @IBAction func finalDateChanged(_ sender: UIDatePicker) {
        print("final date changed")
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        dateFormatter.timeStyle = DateFormatter.Style.none
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        print( dateFormatter.string(from: sender.date) )
        
        finalDate = dateFormatter.string(from: sender.date)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(pickerDataSource[row])
        degrees = pickerDataSource[row]
    }
    
    
    @IBAction func lastOnClick(_ sender: UIButton) {
        print("last")
    }
    
    @IBAction func newOnClick(_ sender: UIButton) {
        print("new")
    }
}


