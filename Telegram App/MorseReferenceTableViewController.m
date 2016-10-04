//
//  MorseReferenceTableViewController.m
//  Telegram App
//
//  Created by Sandeep  Raghunandhan on 8/21/14.
//  Copyright (c) 2014 Sandeep  Raghunandhan. All rights reserved.
//
#import "MorseCode.h"
#import "MorseReferenceTableViewController.h"

@interface MorseReferenceTableViewController ()
@property MorseCode *morse;
@end

@implementation MorseReferenceTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        _morse = [[MorseCode alloc]init];
        UINavigationItem *nav = [self navigationItem];
        nav.title = @"Morse Reference";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSLog(@"%lu", (unsigned long)_morse.characters.count);
    return [_morse.characters count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
    long index = indexPath.row;
    NSMutableString *cellText = [[NSMutableString alloc]init];
    [cellText appendString:_morse.characters[index]];
    [cellText appendString:@"\t"];
    [cellText appendString:_morse.morseCodes[index]];
    cell.textLabel.text = cellText;
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Morse Code Reference";
}


@end
