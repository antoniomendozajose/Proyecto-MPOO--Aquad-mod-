//
//  ProductoTableViewController.swift
//  prueba2.0
//
//  Created by Macbook on 5/14/19.
//  Copyright © 2019 jose. All rights reserved.
//

import UIKit
import os.log


class ProductoTableViewController: UITableViewController {
    
    var producto = [Productog]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Load any saved products
        if let savedProducts = loadProducts() {
            producto += savedProducts
        }
        else{
        // Load the sample data.
        loadSimpleProducts()
        }
        

    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
        case "AddItem":
            os_log("Adding a new product.", log: OSLog.default, type: .debug)
        case "ShowDetail":
            guard let productDetailViewController = segue.destination as? ViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedProductCell = sender as? productoTAbleView else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedProductCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedProduct = producto[indexPath.row]
            productDetailViewController.producto = selectedProduct
            
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
            
            
        }
        
        
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // Delete the row from the data source
            producto.remove(at: indexPath.row)
            saveProducts()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance
        }
    }
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
       
        return true
    }
    



    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return producto.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "productoTableView"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? productoTAbleView  else {
            fatalError("The dequeued cell is not an instance of productoTableView.")
        }
        
        // Fetches the appropriate product for the data source layout.
        let productillo = producto[indexPath.row]
        
        cell.nameLabel.text = productillo.nombre
        //cell.precioLabel.text = String(productillo.precio)
        cell.precioLabel.text = "$" + " \(productillo.precio)"
        cell.idLabel.text = "\(productillo.barcode)"
        cell.gananciaLabel.text = "$" + " \(productillo.precio - productillo.costo)"
        
        return cell
    }

    private func loadSimpleProducts() {
        guard let pro1 = Productog(nombre: "lapiz", precio: 15, costo: 10, barcode: 1234543, cantidad: 1234) else {
            fatalError("Unable to instantiate product1")
        }
        
        guard let pro2 = Productog(nombre: "Goma", precio: 10, costo: 8, barcode: 543232, cantidad: 120) else {
            fatalError("Unable to instantiate product2")
        }
        
        producto += [pro1, pro2]
        
    }
    

    @IBAction func unwindToProductList(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as? ViewController, let product = sourceViewController.producto {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing product.
                producto[selectedIndexPath.row] = product
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else{
            // Add a new product.
            let newIndexPath = IndexPath(row: producto.count, section: 0)
            
            producto.append(product)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            // Save the products.
            saveProducts()
            
        }
    
    }
    private func saveProducts() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(producto, toFile: Productog.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("products successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save products...", log: OSLog.default, type: .error)
        }
    }
    private func loadProducts() -> [Productog]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Productog.ArchiveURL.path) as? [Productog]
    }
    

}
