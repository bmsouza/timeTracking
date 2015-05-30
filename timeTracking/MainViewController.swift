//
//  ViewController.swift
//  timeTracking
//
//  Created by Bruno Souza on 30/05/15.
//  Copyright (c) 2015 Bruno Souza. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwdField: UITextField!
    @IBOutlet weak var marcacaoLabel: UILabel!
    @IBOutlet weak var dataMarcacaoField: UILabel!
    
    var param_user : String = "user"
    var param_pass : String = "pass"
    var param_dataMarcacao : String = "dataMarcacao"
    var param_params : String = "params"
    
    var hasSubmitted: Bool = false;
    var loginHasValue : Bool = false;
    var passwdHasValue : Bool = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(NSUserDefaults.standardUserDefaults().objectForKey(param_params) != nil) {
            
            var objParams: AnyObject! = NSUserDefaults.standardUserDefaults().objectForKey(param_params);
            var params = objParams as! Dictionary<String, String>
            var user = params["user"];
            println(user);
            println(params[param_pass]);
            println(params[param_dataMarcacao]);
        } else {
            println("Sem usuário configurado");
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func registrar(sender: AnyObject) {
        
        updateValuesControl();
        
        controlFieldContent(loginHasValue, passwdHasValue: passwdHasValue);
        if(loginHasValue && passwdHasValue) {
            var dataMarcacao : String = "21/12/1212 12:12";
            
            var params : Dictionary<String, String> = [param_user : loginField.text, param_pass: passwdField.text, param_dataMarcacao : dataMarcacao];
            var userDefaults = NSUserDefaults.standardUserDefaults();
            userDefaults.setObject(params, forKey: param_params);
            
            self.marcacaoLabel.text = "Marcação realizada com sucesso!";
            self.dataMarcacaoField.text = dataMarcacao;
//        } else {
//            controlFieldContent(loginHasValue, passwdHasValue: passwdHasValue);
//            var userDefaults = NSUserDefaults.standardUserDefaults();
//            userDefaults.setObject(nil, forKey: param_params);
        }
        
        hasSubmitted = true;
    }

    func updateValuesControl() {
        self.loginHasValue = count(loginField.text) != 0;
        self.passwdHasValue = count(passwdField.text) != 0;
    }
    
    func controlFieldContent(loginHasValue: Bool , passwdHasValue: Bool) {
        if(loginHasValue) {
            makeValidField(loginField);
        } else {
            makeErrorField(loginField);
        }
        
        if(passwdHasValue) {
            makeValidField(passwdField);
        } else {
            makeErrorField(passwdField);
        }
    }
    
    func makeValidField(textField: UITextField!) {
        var layer: CALayer! = textField.layer;
        layer.masksToBounds = true;
        layer.cornerRadius = 0.0;
        layer.borderWidth = 0.0;
        layer.borderColor = UIColor( red: 0, green: 0, blue:0, alpha: 1).CGColor;
        
        textField.backgroundColor = UIColor( red: 1, green: 1, blue:1, alpha: 1);
        textField.textColor = UIColor( red: 0, green: 0, blue:0, alpha: 1);
    }
    
    func makeErrorField(textField: UITextField!) {
        var layer: CALayer! = textField.layer;
        layer.masksToBounds = true;
        layer.cornerRadius = 8.0;
        layer.borderWidth = 1;
        layer.borderColor = UIColor( red: 0.651, green: 0.176, blue:0.176, alpha: 1).CGColor;
        
        textField.backgroundColor = UIColor( red: 0.651, green: 0.176, blue:0.176, alpha: 0.05);
        textField.textColor = UIColor( red: 0.651, green: 0.176, blue:0.176, alpha: 1);
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true);
        
        if(hasSubmitted) {
            updateValuesControl()
            controlFieldContent(loginHasValue, passwdHasValue: passwdHasValue);
        }
    }
}