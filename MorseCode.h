//
//  MorseCode.h
//  Telegram App
//
//  Created by Sandeep  Raghunandhan on 7/20/14.
//  Copyright (c) 2014 Sandeep  Raghunandhan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MorseCode : NSObject
-(NSString *)morseToEnglish:(NSString *)text;
-(NSString *)englishToMorse:(NSString *)text;

@property (nonatomic, readonly) NSMapTable *morseTree;

@property (nonatomic, readonly) NSArray *characters;
@property (nonatomic, readonly) NSArray *morseCodes;

@end
