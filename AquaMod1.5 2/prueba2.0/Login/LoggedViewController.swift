import UIKit
import Firebase

class LoggedViewController: UIViewController {
    
    @IBOutlet weak var usuario: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usuario.text =  Auth.auth().currentUser?.email
    }
    
    @IBAction func logout(){
        do{
            try Auth.auth().signOut()
            dismiss(animated: true, completion: nil)
        }catch let error{
            print(error.localizedDescription)
        }
    }
    
}


