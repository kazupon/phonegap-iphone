//   
//  UIDevice+AdditionsTest.m
//  PhoneGapLib
//  
//  Created by kazuya kawaguchi on 2011-02-16.
//  Copyright 2011 bluebridge k.k. All rights reserved.
//  

#import "UIDevice+Additions.h"
#import <GTMiOS/GTMiOS.h>


@interface UIDevice_AdditionsTest : GHTestCase {
}
@end


@implementation UIDevice_AdditionsTest

#pragma mark -
#pragma mark GHUnit setup & teardonw 

- (BOOL)shouldRunOnMainThread {
    return YES;
}
    
- (void)setUpClass {
}
  
- (void)tearDownClass {
}

- (void)setUp {
}


- (void)tearDown {
}


#pragma mark -
#pragma mark test

- (void)testWiFiMACAddress {
    UIDevice *device = [UIDevice currentDevice];
    NSString *macAddress = [device WiFiMACAddress];
    GHTestLog(@"MAC Address : %@", macAddress);
    GHAssertTrue([macAddress gtm_matchesPattern:@"^([0-9A-F]{2}):([0-9A-F]{2}):([0-9A-F]{2}):([0-9A-F]{2}):([0-9A-F]{2}):([0-9A-F]{2})$"], nil);
}

- (void)testWiFiIPAddress {
    UIDevice *device = [UIDevice currentDevice];
    NSString *ipAddress = [device WiFiIPAddress];
    GHTestLog(@"IP Address : %@", ipAddress);
    GHAssertTrue([ipAddress gtm_matchesPattern:@"^([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})$"], nil);
}

@end

