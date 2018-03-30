//
//  ViewControllerCinemas.swift
//  MyMovieFinal
//
//  Created by Mickey English on 30/03/2018.
//  Copyright © 2018 Andrei Nagy. All rights reserved.
//

import UIKit
import MapKit

class ViewControllerCinemas: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func greenwichButton(_ sender: UIButton) {
        
        
        // defiing greenwich cinema destination
        let latitude:CLLocationDegrees = 51.490800
        let longitude:CLLocationDegrees = 0.012775
        
        let regionDistance:CLLocationDistance = 1000;
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        
        //        set region of the map
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        
        
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
        
        let placemark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Greenwich Odeon"
        mapItem.openInMaps(launchOptions: options)
        
        
        
        
    }
    
}
