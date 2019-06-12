//
//  costosViewController.swift
//  prueba2.0
//
//  Created by Macbook on 6/12/19.
//  Copyright © 2019 jose. All rights reserved.
//

import UIKit

class costosViewController: UIViewController {
    
    
    
    @IBOutlet weak var cantidadVendida: UITextField!
    
    @IBOutlet weak var precioVenta: UITextField!
    
    @IBOutlet weak var costoFijo: UITextField!
    
    @IBOutlet weak var costoProducto: UITextField!
    
    @IBOutlet weak var Inventario: UITextField!
  
    
    @IBOutlet weak var ganancia: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

 
    }
    
    @IBAction func calcular(_ sender: UIButton) {
        let cv = cantidadVendida.text ?? ""
        let pv = precioVenta.text ?? ""
        let cp = costoProducto.text ?? ""
        let inv = Inventario.text ?? ""
        
        let CV = Int(cv)!
        let PV = Int(pv)!
        let costop = Int(cp)!
        let inventario = Int(inv)!
        
        var g = 0
        
        g = CV*PV - costop*inventario
        ganancia.text = "\(g)"
    }
    
  

}
