//
//  OTLTaskDetailViewController.h
//  OverdueTaskList
//
//  Created by Matthew Nguyen on 4/30/14.
//  Copyright (c) 2014 Matthew Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OTLTask.h"
#import "OTLEditTaskViewController.h"

@interface OTLTaskDetailViewController : UIViewController <OTLEditTaskViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) OTLTask *task;
@property (strong, nonatomic) NSIndexPath *indexPath;

- (IBAction)editButtonPressed:(UIBarButtonItem *)sender;

@end
