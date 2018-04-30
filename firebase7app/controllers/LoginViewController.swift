//
//  LoginViewController.swift
//  firebase7app
//
//  Created by mescurra on 4/29/18.
//  Copyright © 2018 mescurra. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextView: UITextField!
    
    @IBOutlet weak var passwordTextView: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.placeHolderTextFields()
    }
    
    // MARK: - PlaceHolder TextFields
    func placeHolderTextFields(){
        self.emailTextView.placeholder = "Email"
        self.passwordTextView.placeholder = "Password"
        self.passwordTextView.isSecureTextEntry = true
        self.emailTextView.becomeFirstResponder()
    }
    
    // MARK: - Login Button
    @IBAction func loginButton(_ sender: UIButton) {
        self.alertTextField()
    }
    
    // MARK: - Alert TextFields
    func alertTextField(){
        if (emailTextView.text?.isEmpty)! {
            let alert = UIAlertController(title: "Debe escribir un email", message: "", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        } else if (passwordTextView.text?.isEmpty)! {
            let alert = UIAlertController(title: "Debe escribir un password", message: "", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        } else {
            accessUser()
            loginUser()
        }
    }
    
    
    // MARK: - AccessUser in Firebase Listener
    func accessUser(){
        Auth.auth().addStateDidChangeListener( { (user, error) in
            if Auth.auth().currentUser != nil{
                print("Accedido en Login")
            } else {
                print("Inhabilitado en Verificated")
            }
        })
    }
    
    // MARK: - LoginUser in Firebase
    func loginUser(){
        Auth.auth().signIn(withEmail: emailTextView.text!, password: passwordTextView.text!, completion: { (user, error) in
            if user != nil {
                print("Entro al sistema")
                self.performSegue(withIdentifier: "showSistema", sender: self)
                self.emailTextView.becomeFirstResponder()
            } else {
                if let myError = error?.localizedDescription{
                    print(myError)
                } else {
                    print("Error")
                }
            }
        })
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
