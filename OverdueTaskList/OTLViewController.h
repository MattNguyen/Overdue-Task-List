//
//  OTLViewController.h
//  OverdueTaskList
//
//  Created by Matthew Nguyen on 4/30/14.
//  Copyright (c) 2014 Matthew Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OTLAddTaskViewController.h"

@interface OTLViewController : UIViewController <OTLAddTaskViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *tasks;
@property (strong, nonatomic) UIBarButtonItem *cancelBarButtonItem;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *addTaskBarButtonItem;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *editBarButtonItem;

- (IBAction)editButtonPressed:(UIBarButtonItem *)sender;

@end
