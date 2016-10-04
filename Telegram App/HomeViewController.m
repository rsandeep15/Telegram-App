//
//  HomeViewController.m
//  Telegram App
//
//  Created by Sandeep  Raghunandhan on 8/7/14.
//  Copyright (c) 2014 Sandeep  Raghunandhan. All rights reserved.
//

#import "HomeViewController.h"
#import "TelegramViewController.h"
#import "MorseReferenceTableViewController.h"
@interface HomeViewController()


@end
@implementation HomeViewController
-(instancetype)init{
    self = [super init];
    if (self)
    {
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"Home";

    }
    return self;
}
- (IBAction)launchTranslator:(id)sender {
    TelegramViewController *tele = [[TelegramViewController alloc]init];
    [self.navigationController pushViewController:tele animated:YES];
}
- (IBAction)launchMorseReference:(id)sender {
    MorseReferenceTableViewController *instructions = [[MorseReferenceTableViewController alloc]init];
    [self.navigationController pushViewController:instructions animated:YES];
}

@end
