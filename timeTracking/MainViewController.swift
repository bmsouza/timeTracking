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
    
    let param_user : String = "user"
    let param_pass : String = "pass"
    let param_dataMarcacao : String = "dataMarcacao"
    let param_params : String = "params"
    
    var hasSubmitted: Bool = false;
    var loginHasValue : Bool = false;
    var passwdHasValue : Bool = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(NSUserDefaults.standardUserDefaults().objectForKey(param_params) != nil) {
            loginField.enabled = false
            passwdField.enabled = false
            
            var objParams: AnyObject! = NSUserDefaults.standardUserDefaults().objectForKey(param_params);
            var params = objParams as! Dictionary<String, String>

            self.loginField.text = params[param_user];
            self.passwdField.text = params[param_pass];
            self.dataMarcacaoField.text = params[param_dataMarcacao];
        } else {
            println("Sem usuário configurado");
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func viewWillAppear(animated: Bool) {
//        [timeTracking getTime:^(NSDate* date){
//            self.date = date;
//            timer =  [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(onTimer:) userInfo:nil repeats:TRUE];
//            [self lblDate].text = [format stringFromDate:date];
//            }];
//        [self registerForKeyboardNotifications];
//        [super viewWillAppear:animated];
//    }

    @IBAction func registrar(sender: AnyObject) {
        
        updateValuesControl();
        
        controlFieldContent(loginHasValue, passwdHasValue: passwdHasValue);
        if(loginHasValue && passwdHasValue) {
            
            enviarMarcacao(loginField.text, passwd : passwdField.text);
            
            atualizarDadosMarcacao("data marcacao")

            //println(retorno)
            
            //self.marcacaoLabel.text = retorno as! String;
            //self.dataMarcacaoField.text = dataMarcacao;
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
    
    func enviarMarcacao(login: String, passwd: String) {
        let htmlRequest = HtmlRequest();
        htmlRequest.doPost(login, passwd : passwd) { (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
            
            var httpResponse = response as! NSHTTPURLResponse;
            var responseHeaders = httpResponse.allHeaderFields as Dictionary;
            //var tese: AnyObject? = responseHeaders["statusCode"]
            self.dataMarcacaoField.text = responseHeaders["timeF"] as! String;
            //sresponseHeaders.status
            
            //var te: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.allZeros, error: nil)
            //var tes = NSJSONSerialization.dataWithJSONObject(te!, options: NSJSONWritingOptions.PrettyPrinted, error: nil)
            //println(tes)
        }
    }
    
    func atualizarDadosMarcacao(dataMarcacao: String) {
        //var params = [param_user : loginField.text, param_pass: passwdField.text, param_dataMarcacao : dataMarcacao] as Dictionary<String, String>;
        var userDefaults = NSUserDefaults.standardUserDefaults();
        var params = userDefaults.objectForKey(param_params) as! Dictionary<String, String>;
        params[param_dataMarcacao] = dataMarcacao;
        userDefaults.setObject(params, forKey: param_params);
        
        
    }
}