import UIKit
import Firebase

class SigUpViewController: UIViewController {
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        password.isSecureTextEntry = true
        password.placeholder = "contraseña"
        
    }
    
    
    
    @IBAction func createUser(_ sender: UIButton) {
        
        if self.email.text == "" || self.password.text == "" {
            
            let alertController = UIAlertController(title: "error", message: "Por favor, ingrese un correo y contraseña", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController,animated: true, completion: nil)
            
        }
        
       
        
        guard let userEmail = email.text, userEmail != "", let userPass = password.text, userPass != "" else {
            return
        }
        
        Auth.auth().createUser(withEmail: userEmail, password: userPass) { (user, error) in
            
            if let error = error{
                print(error.localizedDescription)
                return
            }
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    func signUp(){
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user == nil{
                print("No esta loggeado")
            }else{
                print("Si esta loggeado")
                self.performSegue(withIdentifier: "toLoginViewController", sender: self)
            }
        }
    }
    
}

