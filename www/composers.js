//  composers.js
//
//  Created by Pierre-Emmanuel Bois on 21/09/13.
//
//  Copyright 2012-2013 Pierre-Emmanuel Bois. All rights reserved.
//  MIT Licensed

var Composers = {
    resultCallback: null,
    sms: function (args, startCallback, endCallback, errorCallback) {
        Composers.resultCallback = endCallback;
        cordova.exec(startCallback, errorCallback, "Composers", "sms", [args]);
    },
    email: function (args, startCallback, endCallback, errorCallback) {
        Composers.resultCallback = endCallback;
        cordova.exec(startCallback, errorCallback, "Composers", "email", [args]);
    }
};

module.exports = Composers;
