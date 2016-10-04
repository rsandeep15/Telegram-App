//
//  MorseCode.m
//  Telegram App
//
//  Created by Sandeep  Raghunandhan on 7/20/14.
//  Copyright (c) 2014 Sandeep  Raghunandhan. All rights reserved.
//

#import "MorseCode.h"
@interface MorseCode()

@property (nonatomic) NSArray *letterArray;


@end


@implementation MorseCode

-(instancetype)init
{
    self = [super init];
    _characters = @[@"A", @"B", @"C", @"D",@"E", @"F" , @"G" , @"H", @"I", @"J", @"K", @"L", @"M", @"N",  @"O",  @"P",@"Q", @"R",@"S",@"T", @"U", @"V", @"W",@"X",@"Y",  @"Z", @"0", @"1",  @"2",@"3",@"4", @"5",@"6", @"7",@"8",@"9",@".",@",",@"?", @"!", @"-", @" "];
    _morseCodes = @[@".-",@"-...",@"-.-.",@"-..",@".",@"..-.",@"--.",@"....",@"..",@".---",@"-.-"
                    ,@".-..",@"--",@"-.",@"---",@".--.",@"--.-",@".-.",@"...",@"-",@"..-",@"...-",@".--",@"-..-",@"-.--",@"--..",@"-----",@".----",@"..---",@"...--",@"....-",@".....",@"-....",@"--...",@"---..",@"----.",@".-.-.-" ,@"--..--",@"..--..",@"-.-.--",@"−····− ",@"/"];
    [self performSelectorInBackground:@selector(fillLetterArray) withObject:nil];
    [self performSelectorInBackground: @selector(fillMorseTree) withObject:nil];
    return self;
}

-(void)fillLetterArray
{
    _letterArray = [[NSArray alloc]initWithObjects:@"", @"/", @"E", @"T", @"I", @"A", @"N", @"M", @"S",@"U",@"R", @"W", @"D",@"K",@"G",@"O",@"H",@"V", @"F",
                    @"Ü", @"L", @"Ä", @"P", @"J", @"B", @"X", @"C", @"Y", @"Z", @"Q", @"Ö", @"CH", @"5", @"4", @"Ŝ", @"3", @"É", @"�", @"Đ", @"2", @"�", @"È", @"+", @"�", @"þ", @"À", @"Ĵ", @"1", @"6", @"=", @"/", @"�", @"Ç", @"�", @"Ĥ", @"�", @"7", @"�", @"Ĝ", @"Ñ", @"8", @"�", @"9", @"0", @"�", @"�", @"�", @"�", @"�", @"�", @"�", @"�", @"�", @"�", @"�", @"�", @"?", @"_", @"�", @"�", @"�", @"�", @"\"",@"�", @"�", @".", @"�", @"�", @"�", @"�", @"@", @"�", @"�", @"�", @"'", @"�", @"�", @"-", nil ];
}

-(void)fillMorseTree
{
    _morseTree = [[NSMapTable alloc]init];
    
    
    for (int i = 0; i < _characters.count; i++)
    {
        [_morseTree setObject:_morseCodes[i] forKey:_characters[i]];
    }
    
}
-(NSString *)morseToEnglish:(NSString *)text
{
    NSArray *words = [text componentsSeparatedByString:@" / "];
    NSMutableString *translation = [[NSMutableString alloc]init];
    
    for (int i = 0; i < words.count; i++) {
        NSString *word = words[i];
        NSString *englishWord = [self morseToEnglishHelper:word];
        [translation appendString:englishWord];
        
        // Do not put a space after the last word
        if (i < words.count - 1)
        {
            [translation appendString:@" " ];
        }
    }
    return [NSString stringWithString:translation];
}

-(NSString *)morseToEnglishHelper:(NSString *)word
{
    NSMutableString *translation = [[NSMutableString alloc]init];
    int index = 1;
    for(int i = 0; i < word.length; i++)
    {
        char curChar = [word characterAtIndex:i];
        
        if (curChar == ' ')
        {
            // if index is within bounds and there's a legit character in the array at this index
            if (index < _letterArray.count)
            {
                [translation appendString:_letterArray[index]];
            }
            index = 1;
        }
        else if (curChar == '.' && i == word.length - 1)
        {
            index = index * 2;
            if (index < _letterArray.count)
            {
                [translation appendString:_letterArray[index]];
            }
            index = 1;
        }
        else if (curChar == '-' && i == word.length - 1)
        {
            index = (index * 2) + 1;
            if (index < _letterArray.count)
            {
                [translation appendString:_letterArray[index]];
            }
            index = 1;
        }
        else if (curChar == '.')
        {
            index = index * 2;
        }
        else if (curChar == '-' )
        {
            index = (index * 2) + 1;
        }
    }
    return [NSString stringWithString:translation];
}

-(NSString *)englishToMorse:(NSString *)text
{
    NSMutableString *translation = [[NSMutableString alloc]init];
    for(int i = 0; i < text.length; i++)
    {
        NSString *letter = [[NSString stringWithFormat:@"%c", [text characterAtIndex:i]] uppercaseString];
        NSString *morse = [_morseTree objectForKey:letter];
        if ([letter isEqualToString:@"\n"])
        {
            [translation appendString:@"\n"];
            continue;
        }
        if (morse)
        {
            [translation appendString:morse];
        }
        [translation appendString:@" "];
    }
    return [NSString stringWithString:translation];
}

@end
