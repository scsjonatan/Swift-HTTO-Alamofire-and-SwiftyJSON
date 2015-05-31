//
//  GETViewController.swift
//  API
//
//  Created by Jonatan Santa Cruz Soria on 15/05/15.
//  Copyright (c) 2015 Jonatan Santa Cruz Soria. All rights reserved.
//

import UIKit
import Alamofire


class GETViewController: UIViewController {
    
    @IBOutlet var imageCam: UIImageView!
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var modelLabel: UILabel!
    @IBOutlet var styleLabel: UILabel!
    @IBOutlet var sizeLabel: UILabel!
    @IBOutlet var colourLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var summaryLabel: UILabel!
    @IBOutlet var modifiedLabel: UILabel!
    
    //tableTshir get its value from IdTableViewController
    
    func sinImagen(){
        self.imageCam.image = UIImage(named: "Unknown.png")
        var alert = UIAlertController(title: "No se tomó fotografía", message: "No habrá imagen disponible", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    func serverError(){
        var alert = UIAlertController(title: "Error", message: "No se puede hacer contacto con el servidor", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    var tableTshirt: Int = 0
    
    func alamoGET() {
        
        //Change to your IP Direction
        Alamofire.request(.GET, "http://192.168.1.71:3000/tshirts")
            .responseJSON {(request, response, Tshirts, error) in
                //println(JSON)
                if Tshirts != nil {
                    let json = JSON(Tshirts!)
                
                    let id = json[self.tableTshirt]["_id"].string
                        self.idLabel.text = id
                    let model = json[self.tableTshirt]["model"].string
                        self.modelLabel.text = model
                    let style = json[self.tableTshirt]["style"].string
                        self.styleLabel.text = style
                    let size = json[self.tableTshirt]["size"].string
                        self.sizeLabel.text = size
                    let colour = json[self.tableTshirt]["colour"].string
                        self.colourLabel.text = colour
                    let price = json[self.tableTshirt]["price"].string
                        self.priceLabel.text = price
                    let summary = json[self.tableTshirt]["summary"].string
                        self.summaryLabel.text = summary
                    let modified = json[self.tableTshirt]["summary"].string
                        self.modifiedLabel.text = modified
                    let image = json[self.tableTshirt]["images"].string
                
                    if image != nil {
                        let decodedData = NSData(base64EncodedString: image!, options: NSDataBase64DecodingOptions(rawValue: 0))
                        var decodedIamge = UIImage(data: decodedData!)
                            self.imageCam.image = decodedIamge
                    }
                
                    else {
                        self.imageCam.image = UIImage(named: "Unknown.png")
                      
                    }
                }
                
                else {
                    self.serverError()

                }
        }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alamoGET()
        println(tableTshirt)
        
              // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
