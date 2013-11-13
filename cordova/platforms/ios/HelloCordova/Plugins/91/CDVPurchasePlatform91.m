//
//  CDVPurchasePlatform91.m
//  HelloCordova
//
//  Created by 中 青宝 on 13-11-8.
//
//

#import "CDVPurchasePlatform.h"
#import <NdComPlatform/NdComPlatform.h>

static CDVInvokedUrlCommand *loginCommand = nil;

@implementation CDVPurchasePlatform

- (void)pluginInitialize
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SNSInitResult:) name:(NSString *)kNdCPInitDidFinishNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SNSLoginResult:) name:(NSString *)kNdCPLoginNotification object:nil];
}

- (void)getInfo:(CDVInvokedUrlCommand *)command
{
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                         messageAsDictionary:@{@"type": @"91"}]
                                callbackId:command.callbackId];
}

- (void)init:(CDVInvokedUrlCommand *)command
{
    static BOOL hasRun = false;
    if (hasRun)
    {
        return;
    }
    hasRun = true;
    
    NSDictionary *options = [command.arguments firstObject];
    
    NdInitConfigure *cfg = [[NdInitConfigure alloc] init];
	cfg.appid = [[options objectForKey:@"appId"] intValue];
	cfg.appKey = [options objectForKey:@"appKey"];
    cfg.orientation = UIInterfaceOrientationLandscapeLeft;
	[[NdComPlatform defaultPlatform] NdInit:cfg];
    
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK]
                                callbackId:command.callbackId];
}

- (void)login:(CDVInvokedUrlCommand *)command
{
    if (loginCommand != nil)
    {
        return;
    }
    
    loginCommand = command;
    
	[[NdComPlatform defaultPlatform] NdLogin:0];
}

- (void)relogin:(CDVInvokedUrlCommand *)command
{
    if (loginCommand != nil || [[NdComPlatform defaultPlatform] isLogined] == false)
    {
        return;
    }
    
    loginCommand = command;
    
    [[NdComPlatform defaultPlatform] NdSwitchAccount];
}

- (void)purchase:(CDVInvokedUrlCommand *)command
{
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsArray:command.arguments]
                                callbackId:command.callbackId];
    
}

- (void)SNSInitResult:(NSNotification *)notify
{
    NSLog(@"SNSInitResult: %@", notify);
}

//登录
- (void)SNSLoginResult:(NSNotification *)notify
{
	NSDictionary *dict = [notify userInfo];
	BOOL success = [[dict objectForKey:@"result"] boolValue];
	NdGuestAccountStatus* guestStatus = (NdGuestAccountStatus*)[dict objectForKey:@"NdGuestAccountStatus"];
	
	//登录成功后处理
	if([[NdComPlatform defaultPlatform] isLogined] && success) {
		
        NSDictionary *loginInfo = @{@"uin": [[NdComPlatform defaultPlatform] loginUin],
                                    @"session": [[NdComPlatform defaultPlatform] sessionId]};
        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                             messageAsDictionary:loginInfo]
                                    callbackId:loginCommand.callbackId];
        
		//也可以通过[[NdComPlatform defaultPlatform] getCurrentLoginState]判断是否游客登录状态
		if (guestStatus) {
			NSString* strUin = [[NdComPlatform defaultPlatform] loginUin];
			NSString* strTip = nil;
			if ([guestStatus isGuestLogined]) {
				strTip = [NSString stringWithFormat:@"游客账号登录成功,\n uin = %@", strUin];
			}
			else if ([guestStatus isGuestRegistered]) {
				strTip = [NSString stringWithFormat:@"游客成功注册为普通账号,\n uin = %@", strUin];
			}
			
			if ([strTip length] > 0) {
//				[DemoComFunc messageBox: strTip];
			}
		}
		else {
			// 普通账号登录成功!
		}
		
//		[self updateView];
//		[self dismissModalViewControllerAnimated:YES];
	}
	//登录失败处理和相应提示
	else {
        
        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR
                                                             messageAsDictionary:dict]
                                    callbackId:loginCommand.callbackId];
        
		int error = [[dict objectForKey:@"error"] intValue];
		NSString* strTip = [NSString stringWithFormat:@"登录失败, error=%d", error];
		switch (error) {
			case ND_COM_PLATFORM_ERROR_USER_CANCEL://用户取消登录
				if (([[NdComPlatform defaultPlatform] getCurrentLoginState] == ND_LOGIN_STATE_GUEST_LOGIN)) {
					strTip =  @"当前仍处于游客登录状态";
				}
				else {
					strTip = @"用户未登录";
				}
				break;
				
				// {{ for demo tip
			case ND_COM_PLATFORM_ERROR_APP_KEY_INVALID://appId未授权接入, 或appKey 无效
				strTip = @"登录失败, 请检查appId/appKey";
				break;
			case ND_COM_PLATFORM_ERROR_CLIENT_APP_ID_INVALID://无效的应用ID
				strTip = @"登录失败, 无效的应用ID";
				break;
			case ND_COM_PLATFORM_ERROR_HAS_ASSOCIATE_91:
				strTip = @"有关联的91账号，不能以游客方式登录";
				break;
				
				// }}
			default:
				break;
		}
//		[DemoComFunc messageBox:strTip];
	}
    
    loginCommand = nil;
}

@end
