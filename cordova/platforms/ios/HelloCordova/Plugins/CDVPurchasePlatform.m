//
//  CDVPurchasePlatform.m
//  HelloCordova
//
//  Created by 中 青宝 on 13-11-6.
//
//

#import "CDVPurchasePlatform.h"

@implementation CDVPurchasePlatform

- (void)getInfo:(CDVInvokedUrlCommand *)command
{
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                         messageAsDictionary:@{@"type": @"test"}]
                                callbackId:command.callbackId];
}

- (void)init:(CDVInvokedUrlCommand *)command
{
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                         messageAsDictionary:[NSDictionary dictionaryWithObjects:command.arguments forKeys:command.arguments]]
                                callbackId:command.callbackId];
}

- (void)login:(CDVInvokedUrlCommand *)command
{
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                         messageAsDictionary:[NSDictionary dictionaryWithObjects:command.arguments forKeys:command.arguments]]
                                callbackId:command.callbackId];
}

- (void)relogin:(CDVInvokedUrlCommand *)command
{
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                         messageAsDictionary:[NSDictionary dictionaryWithObjects:command.arguments forKeys:command.arguments]]
                                callbackId:command.callbackId];
}

- (void)purchase:(CDVInvokedUrlCommand *)command
{
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsArray:command.arguments]
                                callbackId:command.callbackId];

}

@end
