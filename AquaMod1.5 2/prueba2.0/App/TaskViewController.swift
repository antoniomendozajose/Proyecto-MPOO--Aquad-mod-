import UIKit
var tasks = [String]()

class TaksViewController: UIViewController, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell!.textLabel!.text = tasks[indexPath.row]
        return cell!
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    @IBAction func addTask(sender: AnyObject){
        //Creamos el UIAlertController
        let alert = UIAlertController(title: "New Task",
                                      message: "Add a new Task",
                                      preferredStyle: .alert)
        
        //Creamos el UIAlertAction que nos permitirá guardar la tarea
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: {  (action:UIAlertAction) -> Void in
            
            let textField = alert.textFields!.first
            tasks.append(textField!.text!)
            self.tableView.reloadData()
        })
        
        //Creamos el UIAlertAction que nos permitirá cancelar
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action: UIAlertAction) -> Void in
        }
        
        
        alert.addTextField {
            (textField: UITextField) -> Void in
        }
        
        //Añadimos las dos UIAlertAction que hemos creado al UIAlertController
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        //Lanzamos el UIAlertController
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
}


