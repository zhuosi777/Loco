//
//  ViewController.swift
//  Loco
//
//  Created by zhuosi777 on 2019/10/31.
//  Copyright © 2019 zhuosi777. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import SwiftyJSON

class ViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()

        let camera = GMSCameraPosition.camera(withLatitude: 34.6605287, longitude: 135.5036917, zoom: 15.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: 34.6605287, longitude: 135.5036917)
                marker.title = "なんばスカイオ"
                marker.snippet = "大阪府大阪市中央区難波１丁目７−１８"
                marker.map = mapView
        
        Alamofire.request("https://map.yahooapis.jp/search/local/V1/localSearch?cid=d8a23e9e64a4c817227ab09858bc1330&lat=34.6605287&lon=135.5036917&dist=2&query=%E3%83%A9%E3%83%BC%E3%83%A1%E3%83%B3&appid=dj00aiZpPVdTZUl4dlB2a0RNTSZzPWNvbnN1bWVyc2VjcmV0Jng9NmE-&output=json").responseJSON { response in
            
            if let jsonObject = response.result.value {
                let json = JSON(jsonObject)
                let features = json["Feature"]
                for ( _ ,subJson):(String, JSON) in features {
                    
                    let name = subJson["Name"].stringValue
                    let address = subJson["Property"]["Address"].stringValue
                    let coordinates = subJson["Geometry"]["Coordinates"].stringValue
                    let coordinatesArray = coordinates.split(separator: ",")
                    
                    let lat = coordinatesArray[1]
                    let lon = coordinatesArray[0]
                    let latDouble = Double(lat)
                    let lonDouble = Double(lon)
                    
                    let marker = GMSMarker()
                    marker.position = CLLocationCoordinate2D(latitude: latDouble!,longitude: lonDouble!)
                    marker.title = name
                    marker.snippet = address
                    marker.map = mapView
}
}
}
}
}
