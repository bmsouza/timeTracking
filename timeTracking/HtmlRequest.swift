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
    let URL_TT_TIME = "https://tt.ciandt.com/.net/index.ashx/GetClockDeviceInfo?deviceID=2";
    
    let headers =
       ["Content-type" : "application/x-www-form-urlencoded",
        "Accept" : "Accept:*/*",
        "Cookie" : "clockDeviceToken=nHuH/qaEaN1TzYclwDbze2UcjZeQtjjudvHqcjFufA==",
        "Origin" : "android",
        "User-Agent" : "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.94 Safari/537.36"] as Dictionary<NSString, NSString>;
    
    var params =
       ["deviceID" : "2",
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
    
    func post(user : String, passwd : String, callBack: ((data: NSData!, response: NSURLResponse!, error: NSError!) -> Void)?) {
        params["userName"] = user;
        params["password"] = passwd;

        URLConnection().doPost(params, headers:headers, url: URL_TT_CHECK_IN_OUT, callBack: callBack);
    }
    
    func get(callBack: ((data: NSData!, response: NSURLResponse!, error: NSError!) -> Void)?) {
        URLConnection().doGet(headers, url: URL_TT_TIME, callBack: callBack);
    }
}
