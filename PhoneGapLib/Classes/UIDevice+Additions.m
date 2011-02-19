//   
//  UIDevice+Additions.m
//  PhoneGapLib
//  
//  Created by kazuya kawaguchi on 2011-02-16.
//  Copyright 2011 bluebridge k.k. All rights reserved.
//  

#import "UIDevice+Additions.h"
#import <arpa/inet.h>
#import <sys/socket.h>
#import <ifaddrs.h>
#import <net/if.h>
#import <net/if_dl.h>


#if !defined(IFT_ETHER)
    #define IFT_ETHER 0x6   /* Ethernet CSMACD */
#endif


@implementation UIDevice (Additions)


- (NSString *)WiFiMACAddress {
    BOOL success;
	struct ifaddrs *addrs;
	const struct ifaddrs *cursor;
    const struct sockaddr_dl *dlAddr;
    const uint8_t *base;
    int i;
    
	success = getifaddrs(&addrs) == 0;
	if (success) {
		cursor = addrs;
		while (cursor != NULL) {
			if ((cursor->ifa_addr->sa_family == AF_LINK) && 
                (((const struct sockaddr_dl *)cursor->ifa_addr)->sdl_type == IFT_ETHER)) {
                NSString *name = [NSString stringWithUTF8String:cursor->ifa_name];
                if ([name isEqualToString:@"en0"] ||
                    [name isEqualToString:@"en1"]) {
                    NSMutableString *macAddress = [NSMutableString string];
                    dlAddr = (const struct sockaddr_dl *)cursor->ifa_addr;
                    base = (const uint8_t *)&dlAddr->sdl_data[dlAddr->sdl_nlen];
                    for (i = 0; i < dlAddr->sdl_alen; i++) {
                        if (i != 0) {
                            [macAddress appendString:@":"];
                        }
                        [macAddress appendFormat:@"%02X", base[i]];
                    }
                    return [NSString stringWithString:macAddress];
                }
            }
			cursor = cursor->ifa_next;
		}
		freeifaddrs(addrs);
	}
    
    return @"";
}

- (NSString *)WiFiIPAddress {
    BOOL success;
	struct ifaddrs *addrs;
	const struct ifaddrs *cursor;
    
	success = getifaddrs(&addrs) == 0;
	if (success) {
		cursor = addrs;
		while (cursor != NULL) {
			if (cursor->ifa_addr->sa_family == AF_INET && 
                (cursor->ifa_flags & IFF_LOOPBACK) == 0) {
				NSString *name = [NSString stringWithUTF8String:cursor->ifa_name];
                if ([name isEqualToString:@"en0"] ||
                    [name isEqualToString:@"en1"]) {
                 NSString* addressString = 
                    [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr)];
                 freeifaddrs(addrs);
                 return addressString;
                }
			}
            cursor = cursor->ifa_next;
		}
		freeifaddrs(addrs);
	}
    
	return @"";
}

@end
