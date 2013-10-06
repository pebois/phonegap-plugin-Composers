//  Composers.h
//
//  Created by Pierre-Emmanuel Bois on 21/09/13.
//
//  Copyright 2012-2013 Pierre-Emmanuel Bois. All rights reserved.
//  MIT Licensed

#import <Cordova/CDV.h>
#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MFMessageComposeViewController.h>

@interface Composers : CDVPlugin <MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate> {
}

- (void)sms:(CDVInvokedUrlCommand*)command;
- (void)email:(CDVInvokedUrlCommand*)command;

@end
