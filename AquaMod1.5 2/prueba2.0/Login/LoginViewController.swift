import UIKit
import Firebase

class LoginViewController: UIViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isLogged()
        password.isSecureTextEntry = true
        password.placeholder = "contraseña"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        isLogged()
    }
    
    @IBAction func login(_ sender: UIButton) {
        
        if self.email.text == "" || self.password.text == ""{
            
            let alertController = UIAlertController(title: "error", message: "Por favor, ingrese un correo y contraseña", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController,animated: true, completion: nil)
            
        }
        
        guard let userEmail = email.text,userEmail != "", let userPass = password.text, userPass != "" else {
            return
        }
        
        Auth.auth().signIn(withEmail: userEmail, password: userPass) { (user, error) in
            if let error = error{
                print(error.localizedDescription)
                return
            }else{
                let alertController = UIAlertController(title: "error, usuario no registrado", message: error?.localizedDescription, preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                
                self.present(alertController,animated: true, completion: nil)
                
            }
        }
        
    }
    
    func isLogged(){
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user == nil{
                print("No esta loggeado")
            }else{
                print("Si esta loggeado")
                self.performSegue(withIdentifier: "toLoggedView", sender: self)
            }
        }
    }
    
    
    
    
    
}

