//
//  producto.swift
//  prueba2.0
//
//  Created by Macbook on 5/13/19.
//  Copyright © 2019 jose. All rights reserved.
//

import Foundation
import os.log

class Productog: NSObject, NSCoding {
    

    
    var nombre: String
    var precio: Int
    var costo: Int
    var barcode: Int
    var cantidad: Int
    

    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("productos")
    

    
    struct PropertyKey {
        static let nombre = "nombre"
        static let precio = "precio"
        static let costo = "costo"
        static let barcode = "barcode"
        static let cantidad = "cantidad"
        
    }
    
    init?(nombre: String, precio: Int, costo: Int, barcode: Int, cantidad: Int) {
        
        
        // Initialize stored properties.
        self.nombre = nombre
        self.precio = precio
        self.costo = costo
        self.barcode = barcode
        self.cantidad = cantidad
        
        if nombre.isEmpty || precio < 0 || costo < 0 || barcode < 0 || cantidad < 0 {
            return nil
            
            
            }
        }

    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(nombre, forKey: PropertyKey.nombre)
        aCoder.encode(precio, forKey: PropertyKey.precio)
        aCoder.encode(costo, forKey: PropertyKey.costo)
        aCoder.encode(barcode, forKey: PropertyKey.barcode)
        aCoder.encode(cantidad, forKey: PropertyKey.cantidad)
        
    }
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let nombre = aDecoder.decodeObject(forKey: PropertyKey.nombre) as? String else {
            os_log("Unable to decode the name for a Product object.", log: OSLog.default, type: .debug)
            return nil
        }
        let precio = aDecoder.decodeInteger(forKey: PropertyKey.precio)
        let barcode = aDecoder.decodeInteger(forKey: PropertyKey.barcode)
        let costo = aDecoder.decodeInteger(forKey: PropertyKey.costo)
        let cantidad = aDecoder.decodeInteger(forKey: PropertyKey.cantidad)
        
     
        self.init(nombre: nombre, precio: precio, costo: costo, barcode: barcode, cantidad: cantidad)
        
    }

}

