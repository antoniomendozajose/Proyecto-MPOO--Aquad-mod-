//
//  productoTAbleView.swift
//  prueba2.0
//
//  Created by Macbook on 5/14/19.
//  Copyright © 2019 jose. All rights reserved.
//

import UIKit

class productoTAbleView: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var precioLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var gananciaLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
