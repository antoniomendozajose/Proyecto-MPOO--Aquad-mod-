//
//  ViewController.swift
//  prueba2.0
//
//  Created by Macbook on 5/13/19.
//  Copyright © 2019 jose. All rights reserved.
//

import UIKit
import os.log

class ViewController: UIViewController, UITextFieldDelegate {
    
    

    
    

    
    
    @IBOutlet weak var priceTextFiled: UITextField!
    @IBOutlet weak var nameTextFiled: UITextField!
    @IBOutlet weak var SaveButtom: UIBarButtonItem!
    @IBOutlet weak var barcodeTextFiled: UITextField!
    @IBOutlet weak var costTextFiled: UITextField!
    @IBOutlet weak var quantityTextFiled: UITextField!
    
    
    /*
     This value is either passed by `ProductoTableViewController` in `prepare(for:sender:)`
     or constructed as part of adding a new product.
     */
    var producto: Productog?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        nameTextFiled.delegate = self
        priceTextFiled.delegate = self
        barcodeTextFiled.delegate = self
        costTextFiled.delegate = self
        quantityTextFiled.delegate = self
        
        // Set up views if editing an existing Product.
        if let producto = producto {
            let num = "\(producto.precio)"
            let id = "\(producto.barcode)"
            let costo = "\(producto.costo)"
            let cantidad = "\(producto.cantidad)"
            navigationItem.title = producto.nombre
            nameTextFiled.text   = producto.nombre
            priceTextFiled.text = num
            barcodeTextFiled.text = id
            costTextFiled.text = costo
            quantityTextFiled.text = cantidad
                //"$" + "\(producto.precio)"
            
            
        }
        
        // Enable the Save button only if the text field has a valid Product name.
        updateSaveButtonState()
        
        

    }
    
    
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddProductMode = presentingViewController is UINavigationController
        if isPresentingInAddProductMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The ViewController is not inside a navigation controller.")
        }
        dismiss(animated: true, completion: nil)
        
    }
    

    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        //navigationItem.title = textField.text
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        SaveButtom.isEnabled = false
    }


    // This method lets you configure a view controller before it's presented.
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === SaveButtom else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = nameTextFiled.text ?? ""
        let price = priceTextFiled.text ?? ""
        let barcode = barcodeTextFiled.text ?? ""
        let cost = costTextFiled.text ?? ""
        let quantity = quantityTextFiled.text ?? ""
        
        
        let num = Int(price)!
        let newBarcode = Int(barcode)!
        let newCost = Int(cost)!
        let newQuantity = Int(quantity)!
        
    
        // Set the product to be passed to productoTableViewController after the unwind segue.
        producto = Productog(nombre: name, precio: num, costo: newCost, barcode: newBarcode, cantidad: newQuantity)
        
        
    }

 
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = nameTextFiled.text ?? ""
        SaveButtom.isEnabled = !text.isEmpty
        let price = priceTextFiled.text ?? ""
        SaveButtom.isEnabled = !price.isEmpty
        let quantity = quantityTextFiled.text ?? ""
        SaveButtom.isEnabled = !quantity.isEmpty
        
        
        
        
        
    }
    
}
