//
//  ViewController.swift
//  alsea.test.earthquake
//
//  Created by 0mar on 5/21/18.
//  Copyright © 2018 omar. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    

    @IBOutlet weak var degressPicker: UIPickerView!
    @IBOutlet weak var initialDatePicker: UIDatePicker!
    @IBOutlet weak var finalDatePicker: UIDatePicker!
    @IBOutlet weak var lastButton: UIButton!
    @IBOutlet weak var newButton: UIButton!
    
    
    var initialDate = ""
    var finalDate = ""
    var degrees = ""
    
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
        requestEarthquake()
        
    }
    
    
    func requestEarthquake() {
        var endPointURL: String = "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=" + initialDate + "&endtime=" + finalDate + "&minmagnitude=" + degrees
        print("url: " + endPointURL)
        Alamofire.request(endPointURL)
            .responseJSON { response in
                guard response.result.error == nil else {
                    print("error calling GET on /todos/1")
                    print(response.result.error!)
                    return
                }
                
                guard let json = response.result.value as? [String: Any] else {
                    print("didn't get todo object as JSON from API")
                    if let error = response.result.error {
                        print("Error: \(error)")
                    }
                    return
                }
                
                print("RAW response is:")
                //print(json)
                
                if let json = response.data {
                    let data = JSON(data: json)
                    var sismos = self.parse(json: data)
                    
                    let viewController:MapViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapViewController") as UIViewController as! MapViewController
                    // .instantiatViewControllerWithIdentifier() returns AnyObject! this must be downcast to utilize it
                    
                    //viewController.sismos = sismos;
                    
                    self.present(viewController, animated: false, completion: nil)
                    
                }
                
                
                //TODO launch map View COntroller
        }
    }
   
    func parse(json: JSON) -> [Sismo]{
        var earthquakes: [Sismo] = []
        for result in json["features"].arrayValue {
            print("Run Sismo")
            let magnitude = result["properties"]["mag"].stringValue
            let lat = result["geometry"]["coordinates"][0].stringValue
            let long = result["geometry"]["coordinates"][1].stringValue
            //petitions.append(obj)
            earthquakes.append( Sismo(magnitud: magnitude, latitude: lat, longitude: long) )
        }
        
        return earthquakes
    }
}

class Sismo{
    var magnitud = ""
    var latitude = "0.0"
    var longitude = "0.0"
    
    init(){
        
    }
    
    init(magnitud :String, latitude: String, longitude: String){
        self.magnitud = magnitud
        self.latitude = latitude
        self.longitude = longitude
        
        print("Sismo: " +  magnitud + "(" + latitude.description + "," + longitude.description + ")")
    }
}


