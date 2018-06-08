//
//  RegisterViewController.swift
//  firebase7app
//
//  Created by mescurra on 4/29/18.
//  Copyright © 2018 mescurra. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var nameTextView: UITextField!
    
    
    @IBOutlet weak var numberTextView: UITextField!
    
    
    @IBOutlet weak var emailTextView: UITextField!
    
    
    @IBOutlet weak var passwordTextView: UITextField!
    
    var refUsers: DatabaseReference!
    var userList = [UserModel]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.placeHolderTextField()
        refUsers = Database.database().reference().child("usuarios")
        refUsers.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0{
                self.userList.removeAll()
                for users in snapshot.children.allObjects as! [DataSnapshot]{
                    let usersObject = users.value as? [String: AnyObject]
                    let userName = usersObject?["userName"]
                    let userNumber = usersObject?["userNumber"]
                    let userEmail = usersObject?["userEmail"]
                    let userPassword = usersObject?["userPassword"]
                    let userId = usersObject?["id"]
                    let user = UserModel(id: userId as! String, name: userName as! String, number: userNumber as! String, email: userEmail as! String, password: userPassword as! String)
                    self.userList.append(user)
                }
            }
        })
    }
    
    // MARK: - RegisterButton
    @IBAction func registerButton(_ sender: UIButton) {
        self.alertValidateTextField()
    }
    
    // MARK: - PlaceHolderTextField
    func placeHolderTextField(){
        self.nameTextView.placeholder = "Name"
        self.numberTextView.placeholder = "Phone"
        self.emailTextView.placeholder = "Email"
        self.passwordTextView.placeholder = "Password"
    }
    
    // MARK: - Validate TextFields
    func alertValidateTextField(){
        if (nameTextView.text?.isEmpty)! {
            let alert = UIAlertController(title: "Debe escribir un nombre", message: "", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        } else if (numberTextView.text?.isEmpty)! {
            let alert = UIAlertController(title: "Debe escribir un phone", message: "", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        } else if (emailTextView.text?.isEmpty)! {
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
            addUsers()
        }
    }
    
    // MARK: - AddUsers in Firebase
    func addUsers(){
        let key = refUsers.childByAutoId().key
        let user = ["id": key, "userName": nameTextView.text! as String, "userNumber": numberTextView.text! as String, "userEmail": emailTextView.text! as String, "userPassword": passwordTextView.text! as String]
        refUsers.child(key).setValue(user)
        self.createUsersAuthentication()
        self.clearTextFields()
    }
    
    // MARK: - Clear Text Field
    func clearTextFields(){
        self.nameTextView.text = nil
        self.numberTextView.text = nil
        self.emailTextView.text = nil
        self.passwordTextView.text = nil
    }
    
    // MARK: - Create Users in Authentication Firebase
    func createUsersAuthentication(){
        Auth.auth().createUser(withEmail: emailTextView.text!, password: passwordTextView.text!, completion: { (user, error) in
            if user != nil {
                print("Success")
                self.emailTextView.text = nil
                self.passwordTextView.text = nil
            } else {
                if error != nil {
                    print("Error")
                }else{
                    print("Ok")
                }
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
