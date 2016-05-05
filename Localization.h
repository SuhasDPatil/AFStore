//
//  Localization.h
//  AFStoreNew
//
//  Created by Suhas on 12/03/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import <Foundation/Foundation.h>


// some macros (optional, but makes life easy)

// Use "LocalizedString(key)" the same way you would use "NSLocalizedString(key,comment)"
#define LocalizedString(key) [[Localization sharedLocalSystem] localizedStringForKey:(key)]

// "language" can be (for american english): "en", "en-US", "english". Analogous for other languages.

#define LocalizationSetLanguage(language) [[Localization sharedLocalSystem] setLanguage:(language)]


@interface Localization : NSObject


// a singleton:
+ (Localization*) sharedLocalSystem;

// this gets the string localized:
- (NSString*) localizedStringForKey:(NSString*) key;

//set a new language:
- (void) setLanguage:(NSString*) lang;






@end
