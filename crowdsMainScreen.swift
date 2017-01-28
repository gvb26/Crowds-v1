//
//  crowdsMainScreen.swift
//  CrowdsV2
//
//  Created by Gaurang Bham on 4/16/16.
//  Copyright © 2016 Gaurang Bham. All rights reserved.
//

import UIKit
import GoogleMaps
import MapKit
import Foundation
import AVFoundation
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l >= r
  default:
    return !(lhs < rhs)
  }
}

fileprivate func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l <= r
  default:
    return !(rhs < lhs)
  }
}

class crowdsMainScreen: UIViewController, UITableViewDataSource, UITableViewDelegate, GMSMapViewDelegate {
    @IBOutlet var Controller: UISegmentedControl!
    @IBOutlet var ListView: UITableView!
     let refreshControl: UIRefreshControl = UIRefreshControl()
    @IBOutlet var GMSMaps: GMSMapView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    
    var Urban_Eatery=""
    var Library = ""
    var Rec_Center = ""
    var Hans = ""
    var Creese = ""
    var Northside = ""
    //var e = "Empty"
    //var n = "Normal"
    //var pc = "Pretty Crowded"
    //var oc = "OverCrowded"
    
    var firstLocationUpdate: Bool?
    let locationManager=CLLocationManager()
    @IBAction func ChangeView(_ sender: AnyObject) {
        if Controller.selectedSegmentIndex == 0{
            GMSMaps.isHidden = true
            ListView.isHidden = false
        }

        if Controller.selectedSegmentIndex == 1 {
            ListView.isHidden = true
            GMSMaps.isHidden = false


        }
                }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        refreshControl.addTarget(self, action : #selector(crowdsMainScreen.UIRefreshControlAction), for: . valueChanged)
        self.ListView.addSubview(refreshControl)
        
        ListView.isHidden = false
        GMSMaps.isHidden = true
        
        if let url = URL(string: "http://crowds.site88.net/data/crowds.php") {
            do {
                let contents = try NSString(contentsOf: url, usedEncoding: nil)
                
                var IndividualNumbers = contents.components(separatedBy: ",")
                Urban_Eatery = IndividualNumbers[2]
                Rec_Center = IndividualNumbers[3]
                Library = IndividualNumbers[4]
                Hans = IndividualNumbers[5]
                Creese = IndividualNumbers[6]
                Northside = IndividualNumbers[7]
                
                print("Urban Eatery: \(Urban_Eatery)")
                print("The Drexel Recreation Center: \(Rec_Center)")
                print("Library: \(Library)")
                print("Hans: \(Hans)")
                print("Creese: \(Creese)")
                print("Northside : \(Northside)")
                
            } catch {
                Urban_Eatery = ""
                // contents could not be loaded
            }
        } else {
            Urban_Eatery = ""
            print("The Server is Down")
        }
        
        print("\(Urban_Eatery)")
        
        self.GMSMaps.delegate = self
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: 39.9556, longitude: -75.1895, zoom: 17)
        
        // Markers for the different places
        let gym = GMSMarker()
        gym.position = CLLocationCoordinate2DMake(39.956512, -75.190709)
        gym.title = "Daskalakis Athletic Center"
        if (Int(Rec_Center) >= 0 && Int(Rec_Center) <= 50 ){
            gym.icon = UIImage(named: "empty.png")
            
        }
        else if (Int(Rec_Center) >= 51 && Int(Rec_Center) <= 100){
            gym.icon = UIImage(named: "normal.png")
        }
        else if (Int(Rec_Center) >= 101 && Int(Rec_Center) <= 150){
            gym.icon = UIImage(named: "pretty_crowded.png")
        }
        else
        {
            gym.icon = UIImage(named: "overcrowded.png")
        }
        gym.appearAnimation = kGMSMarkerAnimationPop
        gym.map = GMSMaps

        let library = GMSMarker()
        library.position = CLLocationCoordinate2DMake(39.955401, -75.189884)
        library.title = "Hagerty Library"
        if (Int(Library) >= 0 && Int(Library) <= 25 ){
            library.icon = UIImage(named: "empty.png")
            
        }
        else if (Int(Library) >= 26 && Int(Library) <= 50){
            library.icon = UIImage(named: "normal.png")
        }
        else if (Int(Library) >= 51 && Int(Library) <= 75){
            library.icon = UIImage(named: "pretty_crowded.png")
        }
        else
        {
            library.icon = UIImage(named: "overcrowded.png")
        }
        library.appearAnimation = kGMSMarkerAnimationPop
        library.map = GMSMaps
        
        let hans = GMSMarker()
        hans.position = CLLocationCoordinate2DMake(39.953775, -75.188847)
        hans.title = "Hans Dining Hall"
        if (Int(Hans) >= 0 && Int(Hans) <= 25 ){
            hans.icon = UIImage(named: "empty.png")
            
        }
        else if (Int(Hans) >= 26 && Int(Hans) <= 50){
            hans.icon = UIImage(named: "normal.png")
        }
        else if (Int(Hans) >= 51 && Int(Hans) <= 75){
            hans.icon = UIImage(named: "pretty_crowded.png")
        }
        else
        {
            hans.icon = UIImage(named: "overcrowded.png")
        }
        hans.appearAnimation = kGMSMarkerAnimationPop
        hans.map = GMSMaps
        
        let northside = GMSMarker()
        northside.position = CLLocationCoordinate2DMake(39.959060, -75.190595)
        northside.title = "Northside Dining Hall"
        if (Int(Northside) >= 0 && Int(Northside) <= 12 ){
            northside.icon = UIImage(named: "empty.png")
            
        }
        else if (Int(Northside) >= 13 && Int(Northside) <= 25){
            northside.icon = UIImage(named: "normal.png")
        }
        else if (Int(Northside) >= 26 && Int(Northside) <= 38){
            northside.icon = UIImage(named: "pretty_crowded.png")
        }
        else
        {
            northside.icon = UIImage(named: "overcrowded.png")
        }
        northside.appearAnimation = kGMSMarkerAnimationPop
        northside.map = GMSMaps
        
        let urban = GMSMarker()
        urban.position = CLLocationCoordinate2DMake(39.957198, -75.191686)
        urban.title = "Urban Eatery"
        if (Int(Urban_Eatery) >= 0 && Int(Urban_Eatery) <= 25 ){
            urban.icon = UIImage(named: "empty.png")
            
        }
        else if (Int(Urban_Eatery) >= 26 && Int(Urban_Eatery) <= 50){
            urban.icon = UIImage(named: "normal.png")
        }
        else if (Int(Urban_Eatery) >= 51 && Int(Urban_Eatery) <= 75){
            urban.icon = UIImage(named: "pretty_crowded.png")
        }
        else
        {
            urban.icon = UIImage(named: "overcrowded.png")
        }
        urban.appearAnimation = kGMSMarkerAnimationPop
        urban.map = GMSMaps
        
        let creese = GMSMarker()
        creese.position = CLLocationCoordinate2DMake(39.953622, -75.188412)
        creese.title = "Creese Student Center"
        if (Int(Creese) >= 0 && Int(Creese) <= 12 ){
            creese.icon = UIImage(named: "empty.png")
            
        }
        else if (Int(Creese) >= 13 && Int(Creese) <= 25){
            creese.icon = UIImage(named: "normal.png")
        }
        else if (Int(Creese) >= 26 && Int(Creese) <= 38){
            creese.icon = UIImage(named: "pretty_crowded.png")
        }
        else
        {
            creese.icon = UIImage(named: "overcrowded.png")
        }
        creese.appearAnimation = kGMSMarkerAnimationPop
        creese.map = GMSMaps
        
        self.GMSMaps?.camera = camera
        GMSMaps.settings.compassButton = true
        GMSMaps.settings.myLocationButton = true
        
        
       
        
        
        
        self.ListView.register(UITableViewCell.self,forCellReuseIdentifier: "cell")
        self.ListView.dataSource = self
           }
    
   /* override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let prefs:UserDefaults = UserDefaults.standard
        let isLoggedIn:Int = prefs.integer(forKey: "ISLOGGEDIN") as Int
        if (isLoggedIn != 1) {
            self.performSegue(withIdentifier: "GotoStart", sender: self)
        } else {
            self.usernameLabel.text = prefs.value(forKey: "USERNAME") as? String
        }
    }
 */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func UIRefreshControlAction() {
        self.ListView.reloadData()
        print("start Action")
        if let url = URL(string: "http://crowds.site88.net/data/crowds.php") {
            do {
                let contents = try NSString(contentsOf: url, usedEncoding: nil)
                
                var IndividualNumbers = contents.components(separatedBy: ",")
                Urban_Eatery = IndividualNumbers[2]
                Rec_Center = IndividualNumbers[3]
                Library = IndividualNumbers[4]
                Hans = IndividualNumbers[5]
                Creese = IndividualNumbers[6]
                Northside = IndividualNumbers[7]
                
                print("Urban Eatery: \(Urban_Eatery)")
                print("The Drexel Recreation Center: \(Rec_Center)")
                print("Library: \(Library)")
                print("Hans: \(Hans)")
                print("Creese: \(Creese)")
                print("Northside : \(Northside)")
                
            } catch {
                Urban_Eatery = ""
                // contents could not be loaded
            }
        } else {
            Urban_Eatery = ""
            print("The Server is Down")
        }
        
        print("\(Urban_Eatery)")
        
        GMSMaps.clear()
        self.GMSMaps.delegate = self
        //let camera: GMSCameraPosition = GMSCameraPosition.cameraWithLatitude(39.9556, longitude: -75.1895, zoom: 17)
        
        // Markers for the different places
        let gym = GMSMarker()
        gym.position = CLLocationCoordinate2DMake(39.956512, -75.190709)
        gym.title = "Daskalakis Athletic Center"
        if (Int(Rec_Center) >= 0 && Int(Rec_Center) <= 50 ){
            gym.icon = UIImage(named: "empty.png")
            
        }
        else if (Int(Rec_Center) >= 51 && Int(Rec_Center) <= 100){
            gym.icon = UIImage(named: "normal.png")
        }
        else if (Int(Rec_Center) >= 101 && Int(Rec_Center) <= 150){
            gym.icon = UIImage(named: "pretty_crowded.png")
        }
        else
        {
            gym.icon = UIImage(named: "overcrowded.png")
        }
        gym.appearAnimation = kGMSMarkerAnimationPop
        gym.map = GMSMaps
        
        let library = GMSMarker()
        library.position = CLLocationCoordinate2DMake(39.955401, -75.189884)
        library.title = "Hagerty Library"
        if (Int(Library) >= 0 && Int(Library) <= 25 ){
            library.icon = UIImage(named: "empty.png")
            
        }
        else if (Int(Library) >= 26 && Int(Library) <= 50){
            library.icon = UIImage(named: "normal.png")
        }
        else if (Int(Library) >= 51 && Int(Library) <= 75){
            library.icon = UIImage(named: "pretty_crowded.png")
        }
        else
        {
            library.icon = UIImage(named: "overcrowded.png")
        }
        library.appearAnimation = kGMSMarkerAnimationPop
        library.map = GMSMaps
        
        let hans = GMSMarker()
        hans.position = CLLocationCoordinate2DMake(39.953775, -75.188847)
        hans.title = "Hans Dining Hall"
        if (Int(Hans) >= 0 && Int(Hans) <= 25 ){
            hans.icon = UIImage(named: "empty.png")
            
        }
        else if (Int(Hans) >= 26 && Int(Hans) <= 50){
            hans.icon = UIImage(named: "normal.png")
        }
        else if (Int(Hans) >= 51 && Int(Hans) <= 75){
            hans.icon = UIImage(named: "pretty_crowded.png")
        }
        else
        {
            hans.icon = UIImage(named: "overcrowded.png")
        }
        hans.appearAnimation = kGMSMarkerAnimationPop
        hans.map = GMSMaps
        
        let northside = GMSMarker()
        northside.position = CLLocationCoordinate2DMake(39.959060, -75.190595)
        northside.title = "Northside Dining Hall"
        if (Int(Northside) >= 0 && Int(Northside) <= 12 ){
            northside.icon = UIImage(named: "empty.png")
            
        }
        else if (Int(Northside) >= 13 && Int(Northside) <= 25){
            northside.icon = UIImage(named: "normal.png")
        }
        else if (Int(Northside) >= 26 && Int(Northside) <= 38){
            northside.icon = UIImage(named: "pretty_crowded.png")
        }
        else
        {
            northside.icon = UIImage(named: "overcrowded.png")
        }
        northside.appearAnimation = kGMSMarkerAnimationPop
        northside.map = GMSMaps
        
        let urban = GMSMarker()
        urban.position = CLLocationCoordinate2DMake(39.957198, -75.191686)
        urban.title = "Urban Eatery"
        if (Int(Urban_Eatery) >= 0 && Int(Urban_Eatery) <= 25 ){
            urban.icon = UIImage(named: "empty.png")
            
        }
        else if (Int(Urban_Eatery) >= 26 && Int(Urban_Eatery) <= 50){
            urban.icon = UIImage(named: "normal.png")
        }
        else if (Int(Urban_Eatery) >= 51 && Int(Urban_Eatery) <= 75){
            urban.icon = UIImage(named: "pretty_crowded.png")
        }
        else
        {
            urban.icon = UIImage(named: "overcrowded.png")
        }
        urban.appearAnimation = kGMSMarkerAnimationPop
        urban.map = GMSMaps
        
        let creese = GMSMarker()
        creese.position = CLLocationCoordinate2DMake(39.953622, -75.188412)
        creese.title = "Creese Student Center"
        if (Int(Creese) >= 0 && Int(Creese) <= 12 ){
            creese.icon = UIImage(named: "empty.png")
            
        }
        else if (Int(Creese) >= 13 && Int(Creese) <= 25){
            creese.icon = UIImage(named: "normal.png")
        }
        else if (Int(Creese) >= 26 && Int(Creese) <= 38){
            creese.icon = UIImage(named: "pretty_crowded.png")
        }
        else
        {
            creese.icon = UIImage(named: "overcrowded.png")
        }
        creese.appearAnimation = kGMSMarkerAnimationPop
        creese.map = GMSMaps
        
        refreshControl.endRefreshing()
    }
    
    var array = ["Daskalakis Athletic Center    " , "Hagerty Library                   ", "Hans Dining Hall                  ", "Northside Dining Hall           ", "Urban Eatery                               ", "Creese Student Center         "]
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //return IndividualNumbers.count
       return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: UITableViewCell! = self.ListView
            .dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!
        if ((indexPath as NSIndexPath).row == 0){
            
            
            if  (Int(Rec_Center) >= 0 && Int(Rec_Center) <= 50 ){
               cell.imageView?.image = UIImage(named: "empty.png")
                cell.textLabel!.text = array[(indexPath as NSIndexPath).row] //+ e
            }
            else if (Int(Rec_Center) >= 51 && Int(Rec_Center) <= 100){
                cell.imageView?.image = UIImage(named: "normal.png")
                cell.textLabel!.text = array[(indexPath as NSIndexPath).row] //+ n
            }
            else if (Int(Rec_Center) >= 101 && Int(Rec_Center) <= 150){
                cell.imageView?.image = UIImage(named: "pretty_crowded.png")
                cell.textLabel!.text = array[(indexPath as NSIndexPath).row] //+ pc
            }
            else
            {
                cell.imageView?.image = UIImage(named: "overcrowded.png")
                cell.textLabel!.text = array[(indexPath as NSIndexPath).row] //+ oc
            }

            return cell
        }
        else if ((indexPath as NSIndexPath).row == 1){
        
            if (Int(Library) >= 0 && Int(Library) <= 25 ){
                cell.imageView?.image = UIImage(named: "empty.png")
                cell.textLabel!.text = array[(indexPath as NSIndexPath).row] //+ e
                
            }
            else if (Int(Library) >= 26 && Int(Library) <= 50){
                cell.imageView?.image = UIImage(named: "normal.png")
                cell.textLabel!.text = array[(indexPath as NSIndexPath).row] //+ n
            }
            else if (Int(Library) >= 51 && Int(Library) <= 75){
                cell.imageView?.image = UIImage(named: "pretty_crowded.png")
                cell.textLabel!.text = array[(indexPath as NSIndexPath).row] //+ pc
            }
            else
            {
                cell.imageView?.image = UIImage(named: "overcrowded.png")
                cell.textLabel!.text = array[(indexPath as NSIndexPath).row] //+ oc
            }

        return cell
        }
        else if ((indexPath as NSIndexPath).row == 2){
            
            if (Int(Hans) >= 0 && Int(Hans) <= 25 ){
                cell.imageView?.image = UIImage(named: "empty.png")
                cell.textLabel!.text = array[(indexPath as NSIndexPath).row] //+ e
            }
            else if (Int(Hans) >= 26 && Int(Hans) <= 50){
                cell.imageView?.image = UIImage(named: "normal.png")
                cell.textLabel!.text = array[(indexPath as NSIndexPath).row] //+ n
            }
            else if (Int(Hans) >= 51 && Int(Hans) <= 75){
                cell.imageView?.image = UIImage(named: "pretty_crowded.png")
                cell.textLabel!.text = array[(indexPath as NSIndexPath).row] //+ pc
            }
            else
            {
                cell.imageView?.image = UIImage(named: "overcrowded.png")
                cell.textLabel!.text = array[(indexPath as NSIndexPath).row] //+ oc
            }

            return cell
        }
        else if ((indexPath as NSIndexPath).row == 3){
            cell.textLabel!.text = array[(indexPath as NSIndexPath).row] //+ e
            if (Int(Northside) >= 0 && Int(Northside) <= 12 ){
                cell.imageView?.image = UIImage(named: "empty.png")
            }
            else if (Int(Northside) >= 13 && Int(Northside) <= 25){
                cell.imageView?.image = UIImage(named: "normal.png")
                cell.textLabel!.text = array[(indexPath as NSIndexPath).row] //+ n
            }
            else if (Int(Northside) >= 26 && Int(Northside) <= 38){
                cell.imageView?.image = UIImage(named: "pretty_crowded.png")
                cell.textLabel!.text = array[(indexPath as NSIndexPath).row] //+ pc
            }
            else
            {
                cell.imageView?.image = UIImage(named: "overcrowded.png")
                cell.textLabel!.text = array[(indexPath as NSIndexPath).row] //+ oc
            }

            return cell
        }
        else if ((indexPath as NSIndexPath).row == 4){
            
            if (Int(Urban_Eatery) >= 0 && Int(Urban_Eatery) <= 25 ){
            cell.imageView?.image = UIImage(named: "empty.png")
            cell.textLabel!.text = array[(indexPath as NSIndexPath).row] //+ e
            }
            else if (Int(Urban_Eatery) >= 26 && Int(Urban_Eatery) <= 50){
                cell.imageView?.image = UIImage(named: "normal.png")
            cell.textLabel!.text = array[(indexPath as NSIndexPath).row] //+ n
            }
            else if (Int(Urban_Eatery) >= 51 && Int(Urban_Eatery) <= 75){
                cell.imageView?.image = UIImage(named: "pretty_crowded.png")
                cell.textLabel!.text = array[(indexPath as NSIndexPath).row] //+ pc
            }
            else
            {
                cell.imageView?.image = UIImage(named: "overcrowded.png")
                cell.textLabel!.text = array[(indexPath as NSIndexPath).row] //+ oc
            }

            return cell
        }
        else if ((indexPath as NSIndexPath).row == 5){
                        if (Int(Creese) >= 0 && Int(Creese) <= 12 ){
                cell.imageView?.image = UIImage(named: "empty.png")
                            cell.textLabel!.text = array[(indexPath as NSIndexPath).row] //+ e

            }
            else if (Int(Creese) >= 13 && Int(Creese) <= 25){
                cell.imageView?.image = UIImage(named: "normal.png")
                            cell.textLabel!.text = array[(indexPath as NSIndexPath).row] //+ n

            }
            else if (Int(Creese) >= 26 && Int(Creese) <= 38){
                cell.imageView?.image = UIImage(named: "pretty_crowded.png")
                            cell.textLabel!.text = array[(indexPath as NSIndexPath).row] //+ pc

            }
            else
            {
                cell.imageView?.image = UIImage(named: "overcrowded.png")
                cell.textLabel!.text = array[(indexPath as NSIndexPath).row] //+ oc

            }

            return cell
        }
        else {
            cell.textLabel!.text = nil
            return cell
        }
    }


    @IBAction func Logout(_ sender: UIButton) {
        let appDomain = Bundle.main.bundleIdentifier
        UserDefaults.standard.removePersistentDomain(forName: appDomain!)
        
        self.performSegue(withIdentifier: "GotoStart", sender: self)
    }
        // Do any additional setup after loading the view.

}
