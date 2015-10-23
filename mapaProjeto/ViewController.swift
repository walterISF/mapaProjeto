//
//  ViewController.swift
//  mapaProjeto
//
//  Created by Student on 23/10/15.
//  Copyright © 2015 Student. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation //determina a localizacao do usuario

class ViewController: UIViewController, CLLocationManagerDelegate{
    var localUsuario = CLLocationManager()
    @IBOutlet weak var mapa: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        localUsuario.delegate = self
        localUsuario.requestWhenInUseAuthorization()
        
        
    }
    
    func localUsuario(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse{//esse if verifica se o status é autorizado enquanto o aplicativo esta em primeiro plano
            mapa.showsUserLocation = true//se o if for verdadeiro mostraremos a localização do usuario no mapView
            
            if let location = localUsuario.location?.coordinate{//centralizamos o mapa na localizacao do usuario
                mapa.setCenterCoordinate(location, animated: true)
                
            } else{
                localUsuario.startUpdatingLocation()//caso a localizacao do usuario nao exista estaremos procurando fela atravez desse metodo e esse metodo chama outro o didUpdateLocations em seguida
            }
        }
    }
    
    func localUsuario(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        localUsuario.stopUpdatingLocation()
        
        if let location = locations.last as? CLLocation{
            mapa.setCenterCoordinate(location.coordinate, animated: true)
            mapa.camera.altitude = pow(2,11)
        }
        
        
    }
    
}


