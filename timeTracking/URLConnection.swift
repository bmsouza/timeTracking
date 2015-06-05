//
//  URLConnection.swift
//  timeTracking
//
//  Created by Bruno Souza on 02/06/15.
//  Copyright (c) 2015 Bruno Souza. All rights reserved.
//

import UIKit

class URLConnection: NSObject {
    
    func doPost(params : Dictionary<NSString, NSString>, headers : Dictionary<NSString, NSString>, url : String, callBack: ((data: NSData!, response: NSURLResponse!, error: NSError!) -> Void)?) {
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        for header in headers {
            request.addValue((header.1 as! String), forHTTPHeaderField: header.0 as! String)
        }
        
        var contentString = NSMutableString();
        if (count(params) > 0) {
            var first = true;
            for param in params {
                if (!first) {
                    contentString.appendString("&")
                }
                first = false;
                
                contentString.appendString(param.0.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)
                contentString.appendString("=");
                contentString.appendString(param.1.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!);
            }
        }
        
        
        var err: NSError?
        request.HTTPBody = contentString.dataUsingEncoding(NSUTF8StringEncoding)
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            callBack?(data: data, response: response, error: error)
            
        })
        
        task.resume()
    }
    
    func doGet(headers : Dictionary<NSString, NSString>, url : String, callBack: ((data: NSData!, response: NSURLResponse!, error: NSError!) -> Void)?) {
        
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "GET"
        
        for header in headers {
            request.addValue((header.1 as! String), forHTTPHeaderField: header.0 as! String)
        }
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            callBack?(data: data, response: response, error: error)
            
        })
        
        task.resume()
    }
}
