//
//  CDVPurchasePlatform.h
//  HelloCordova
//
//  Created by 中 青宝 on 13-11-6.
//
//

#import <Foundation/Foundation.h>

#import <Cordova/CDV.h>

@interface CDVPurchasePlatform : CDVPlugin

- (void)getInfo:(CDVInvokedUrlCommand *)command;
- (void)init:(CDVInvokedUrlCommand *)command;
- (void)login:(CDVInvokedUrlCommand *)command;
- (void)relogin:(CDVInvokedUrlCommand *)command;
- (void)purchase:(CDVInvokedUrlCommand *)command;

@end
