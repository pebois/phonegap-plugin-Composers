//  Composers.m
//
//  Created by Pierre-Emmanuel Bois on 21/09/13.
//
//  Copyright 2012-2013 Pierre-Emmanuel Bois. All rights reserved.
//  MIT Licensed

#import "Composers.h"
#import <Cordova/CDV.h>

@implementation Composers

- (void)sms:(CDVInvokedUrlCommand*)command
{
    Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
	if (messageClass != nil) {
		if (![messageClass canSendText]) {
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
			return;
		}
	} else {
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
		return;
	}
    dispatch_async(dispatch_get_main_queue(), ^{
        NSDictionary* args = [command.arguments objectAtIndex:0];
        if (args != nil && [args count] > 0) {
            NSString* toRecipientsString = [args valueForKey:@"toRecipients"];
            NSString* body = [args valueForKey:@"body"];
            MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
            picker.messageComposeDelegate = self;
            if (body != nil) {
                picker.body = body;
            }
            if (toRecipientsString != nil) {
                [picker setRecipients:[toRecipientsString componentsSeparatedByString:@","]];
            }
            if (picker != nil) {
                [self.viewController presentModalViewController:picker animated:YES];
                //[[UIApplication sharedApplication] setStatusBarHidden:YES];
            }
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@""];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        } else {
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
    });
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
	int msgResult = 0;
	switch (result) {
		case MessageComposeResultCancelled:
			msgResult = 0;
			break;
		case MessageComposeResultSent:
			msgResult = 1;
			break;
		case MessageComposeResultFailed:
			msgResult = 2;
			break;
		default:
			msgResult = 3;
			break;
	}
    [self.viewController dismissModalViewControllerAnimated:YES];
	NSString* jsString = [[NSString alloc] initWithFormat:@"Composers.resultCallback(%d);",msgResult];
	[self writeJavascript:jsString];
}

- (void)email:(CDVInvokedUrlCommand*)command
{
    Class messageClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (messageClass != nil) {
		if (![messageClass canSendMail]) {
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
			return;
		}
	} else {
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
		return;
	}
    dispatch_async(dispatch_get_main_queue(), ^{
        NSDictionary* args = [command.arguments objectAtIndex:0];
        if (args != nil && [args count] > 0) {
            NSString* toRecipientsString = [args valueForKey:@"toRecipients"];
            NSString* ccRecipientsString = [args valueForKey:@"ccRecipients"];
            NSString* bccRecipientsString = [args valueForKey:@"bccRecipients"];
            NSString* subject = [args valueForKey:@"subject"];
            NSString* body = [args valueForKey:@"body"];
            NSString* isHTML = [args valueForKey:@"bodyIsHTML"];
            MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
            picker.mailComposeDelegate = self;
            if (subject != nil) {
                [picker setSubject:subject];
            }
            if (body != nil) {
                if(isHTML != nil && [isHTML boolValue]) {
                    [picker setMessageBody:body isHTML:YES];
                } else {
                    [picker setMessageBody:body isHTML:NO];
                }
            }
            if (toRecipientsString != nil) {
                [picker setToRecipients:[ toRecipientsString componentsSeparatedByString:@","]];
            }
            if (ccRecipientsString != nil) {
                [picker setCcRecipients:[ ccRecipientsString componentsSeparatedByString:@","]];
            }
            if (bccRecipientsString != nil) {
                [picker setBccRecipients:[ bccRecipientsString componentsSeparatedByString:@","]];
            }
            if (picker != nil) {
                [self.viewController presentModalViewController:picker animated:YES];
                //[[UIApplication sharedApplication] setStatusBarHidden:YES];
            }
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@""];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        } else {
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
    });
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	int msgResult = 0;
    switch (result) {
        case MFMailComposeResultCancelled:
			msgResult = 0;
            break;
        case MFMailComposeResultSaved:
			msgResult = 1;
            break;
        case MFMailComposeResultSent:
			msgResult = 2;
            break;
        case MFMailComposeResultFailed:
            msgResult = 3;
            break;
        default:
			msgResult = 4;
            break;
    }
    [self.viewController dismissModalViewControllerAnimated:YES];
	NSString* jsString = [[NSString alloc] initWithFormat:@"Composers.resultCallback(%d);",msgResult];
	[self writeJavascript:jsString];
}

@end
