//
//  HtmlRequest.swift
//  timeTracking
//
//  Created by Bruno Souza on 01/06/15.
//  Copyright (c) 2015 Bruno Souza. All rights reserved.
//

import UIKit

class HtmlRequest: NSObject {
    
    let URL_TT_CHECK_IN_OUT = "https://tt.ciandt.com/.net/index.ashx/SaveTimmingEvent" as String;
    
    var headers =
    ["Accept" : "Accept:*/*",
        "Cookie" : "clockDeviceToken=nHuH/qaEaN1TzYclwDbze2UcjZeQtjjudvHqcjFufA==",
        "Origin" : "android",
        "User-Agent" : "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.94 Safari/537.36"] as Dictionary<NSString, NSString>;
    
    var params =
    ["asd" : "asd",
        "deviceID" : "2",
        "eventType": "1",
        "cracha": "",
        "costCenter": "",
        "leave": "",
        "func" : "",
        "cdiDispositivoAcesso": "2",
        "cdiDriverDispositivoAcesso" : "10",
        "cdiTipoIdentificacaoAcesso": "7",
        "oplLiberarPETurmaRVirtual" : "false",
        "cdiTipoUsoDispositivo": "1",
        "qtiTempoAcionamento" : "0",
        "d1sEspecieAreaEvento": "Nenhuma",
        "d1sAreaEvento": "Nenhum",
        "d1sSubAreaEvento": "Nenhum(a)",
        "d1sEvento": "Nenhum",
        "oplLiberarFolhaRVirtual" : "false",
        "oplLiberarCCustoRVirtual" : "false",
        "qtiHorasFusoHorario" : "0",
        "cosEnderecoIP" : "127.0.0.1",
        "nuiPorta" : "7069",
        "oplValidaSenhaRelogVirtual" : "false",
        "useUserPwd" : "true",
        "useCracha" : "false",
        "dtTimeEvent" : "",
        "oplLiberarFuncoesRVirtual" : "false",
        "sessionID" : "0",
        "selectedEmployee" : "0",
        "selectedCandidate" : "0",
        "selectedVacancy" : "0",
        "dtFmt" : "d/m/Y",
        "tmFmt" : "H:i:s",
        "shTmFmt" : "H:i",
        "dtTmFmt" : "d/m/Y H:i:s",
        "language" : "0"] as Dictionary<NSString, NSString>;
    
    func doPost(user : String, passwd : String) {
        params["userName"] = user;
        params["password"] = passwd;
        //headers["Content-type"] = "application/x-www-form-urlencoded";
    
        post(params, url: URL_TT_CHECK_IN_OUT);
        
    }
    
    func post(params : Dictionary<NSString, NSString>, url : String) {
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        for header in headers {
            request.addValue((header.1 as! String), forHTTPHeaderField: header.0 as! String)
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        
        var err: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions(0), error: &err)
        
        
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            let req = NSString(data: request.HTTPBody!, encoding: NSUTF8StringEncoding)
            
            println("Header: \(self.headers)")
            
            println("Request: \(req!)")
            
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            
            println("Body: \(strData)")
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
            
            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            if(err != nil) {
                println(err!.localizedDescription)
                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Error could not parse JSON: '\(jsonStr)'")
                
            }
            else {
                // The JSONObjectWithData constructor didn't return an error. But, we should still
                // check and make sure that json has a value using optional binding.
                if let parseJSON = json {
                    // Okay, the parsedJSON is here, let's get the value for 'success' out of it
                    var success = parseJSON["success"] as? Int
                    println("Succes: \(success)")
                }
                else {
                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                    let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Error could not parse JSON: \(jsonStr)")
                }
            }
        })
        
        task.resume()
    }
}
