//
//  AFAppAPIClient.h
//  AFStore
//
//  Created by Suhas on 20/02/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"
#import "SBJson.h"
#import "Utiles.h"

@interface AFAppAPIClient : AFHTTPRequestOperationManager

+ (AFHTTPRequestOperationManager *)sharedClient;
+ (instancetype)WSsharedClient;
@end
