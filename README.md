phonegap-plugin-Composers
============================

Phonegap composers plugin

## Platforms ##

* IOS

## Using the plugin ##

### sms ###
```
Composers.sms({toRecipients: tel}, function (msg) {
    console.log('Composers.sms: start {msg: "'+msg+'"}');
}, function (code) {
    console.log('Composers.sms: done {code: "'+code+'"}');
}, function () {
    console.log('Composers.sms: error');
});
```

### email ###
```
Composers.email({toRecipients: email}, function (msg) {
    console.log('Composers.email: start {msg: "'+msg+'"}');
}, function (code) {
    console.log('Composers.email: done {code: "'+code+'"}');
}, function () {
    console.log('Composers.email: error');
});
```

## Licence ##
```
The MIT License (MIT)

Copyright (c) 2013 Pierre-Emmanuel Bois

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```
