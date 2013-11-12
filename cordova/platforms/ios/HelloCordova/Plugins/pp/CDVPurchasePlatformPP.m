//
//  CDVPurchasePlatform91.m
//  HelloCordova
//
//  Created by 中 青宝 on 13-11-8.
//
//

#import "CDVPurchasePlatform.h"
#import <PPAppPlatformKit/PPAppPlatformKit.h>


static CDVInvokedUrlCommand *loginCommand = nil;

@interface CDVPurchasePlatform (PPSDK) <PPAppPlatformKitDelegate>

@end

@implementation CDVPurchasePlatform (PPSDK)

- (void)ppPayResultCallBack:(PPPayResultCode)paramPPPayResultCode
{}
- (void)ppVerifyingUpdatePassCallBack
{}
- (void)ppLoginStrCallBack:(NSString *)paramStrToKenKey
{
    NSLog(@"hex: %@", paramStrToKenKey);
    
    NSDictionary *loginInfo = @{@"uin": [NSString stringWithFormat:@"%llu", [[PPAppPlatformKit sharedInstance] currentUserId]],
                                @"session": paramStrToKenKey};
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                         messageAsDictionary:loginInfo]
                                callbackId:loginCommand.callbackId];
}

//- (void)ppLoginHexCallBack:(char *)paramHexToKen
//{
//    NSLog(@"hex: %s", paramHexToKen);
//}

- (void)ppCloseWebViewCallBack:(PPWebViewCode)paramPPWebViewCode
{}
- (void)ppClosePageViewCallBack:(PPPageCode)paramPPPageCode
{}
- (void)ppLogOffCallBack
{}

@end

@implementation CDVPurchasePlatform

- (void)pluginInitialize
{
    [[PPAppPlatformKit sharedInstance] setDelegate:self];
}

- (void)getInfo:(CDVInvokedUrlCommand *)command
{
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                         messageAsDictionary:@{@"type": @"pp"}]
                                callbackId:command.callbackId];
}

- (void)init:(CDVInvokedUrlCommand *)command
{
    NSDictionary *options = [command.arguments firstObject];
    
    [[PPAppPlatformKit sharedInstance] setAppId:[[options objectForKey:@"appId"] intValue] AppKey:[options objectForKey:@"appKey"]];
    [[PPAppPlatformKit sharedInstance] setIsNSlogData:[[options objectForKey:@"isNSLogData"] boolValue]];
    [[PPAppPlatformKit sharedInstance] setRechargeAmount:[[options objectForKey:@"rechargeAmount"] intValue]];
    [[PPAppPlatformKit sharedInstance] setIsLongComet:[[options objectForKey:@"isLongComet"] boolValue]];
    [[PPAppPlatformKit sharedInstance] setIsLogOutPushLoginView:[[options objectForKey:@"isLogOutPushLoginView"] boolValue]];
    [[PPAppPlatformKit sharedInstance] setIsOpenRecharge:[[options objectForKey:@"isOpenRecharge"] boolValue]];
    [[PPAppPlatformKit sharedInstance] setCloseRechargeAlertMessage:[options objectForKey:@"closeRechargeAlertMessage"]];
    
    [PPUIKit sharedInstance];
    [PPUIKit setIsDeviceOrientationLandscapeLeft:YES];
    [PPUIKit setIsDeviceOrientationLandscapeRight:YES];
    [PPUIKit setIsDeviceOrientationPortrait:NO];
    [PPUIKit setIsDeviceOrientationPortraitUpsideDown:NO];
    
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK]
                                callbackId:command.callbackId];
}

- (void)login:(CDVInvokedUrlCommand *)command
{
    loginCommand = command;
    [[PPAppPlatformKit sharedInstance] showLogin];
}

- (void)relogin:(CDVInvokedUrlCommand *)command
{
    [self login:command];
}

- (void)purchase:(CDVInvokedUrlCommand *)command
{
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsArray:command.arguments]
                                callbackId:command.callbackId];
    
}

@end
