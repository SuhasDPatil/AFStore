//
//  Utiles.h
//  AFStore
//
//  Created by Suhas on 20/02/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface Utiles : NSObject

+(void)showAlert:(NSString *)title Message:(NSString *)msg;
+ (NSString *) md5:(NSString *) input;
+ (NSString *)encodeToBase64String:(UIImage *)image ;
+(NSDictionary *) getUser;
+(NSString *)getUserDataForKey:(NSString *)key;
+(NSMutableArray *)SortArray:(NSMutableArray *) inputArray Key:(NSString  *) key;
+ (BOOL) validEmail:(NSString*) emailString;
- (NSTimeInterval) timeStamp;
+(NSString * )getCurrentTime;

@end
