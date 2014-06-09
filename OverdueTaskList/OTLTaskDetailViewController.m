//
//  OTLTaskDetailViewController.m
//  OverdueTaskList
//
//  Created by Matthew Nguyen on 4/30/14.
//  Copyright (c) 2014 Matthew Nguyen. All rights reserved.
//

#import "OTLTaskDetailViewController.h"
#import "OTLEditTaskViewController.h"

@interface OTLTaskDetailViewController ()

@end

@implementation OTLTaskDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.titleLabel.text = self.task.title;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    self.dateLabel.text = [formatter stringFromDate:self.task.date];
    
    self.descriptionLabel.text = self.task.description;
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UIBarButtonItem class]]) {
        if ([segue.destinationViewController isKindOfClass:[OTLEditTaskViewController class]]) {
            OTLEditTaskViewController *editTaskVC = segue.destinationViewController;
            editTaskVC.delegate = self;
            editTaskVC.task = self.task;
            
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)editButtonPressed:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"toEditTaskViewController" sender:sender];
}

#pragma mark - OTLEditTaskviewControllerDelegate methods
-(void)didCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)didEditTask:(OTLTask *)task
{
    // Retrieve existing NSUserDefaults data
    NSMutableArray *tasksAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASKS_KEY] mutableCopy];
    
    // Update task property list
    [tasksAsPropertyLists replaceObjectAtIndex:self.indexPath.row withObject:[task formatAsPropertyList]];
    
    // Save task data to NSUserDefaults
    [[NSUserDefaults standardUserDefaults] setObject:tasksAsPropertyLists forKey:TASKS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
