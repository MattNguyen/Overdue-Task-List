//
//  OTLViewController.m
//  OverdueTaskList
//
//  Created by Matthew Nguyen on 4/30/14.
//  Copyright (c) 2014 Matthew Nguyen. All rights reserved.
//

#import "OTLViewController.h"
#import "OTLTaskDetailViewController.h"

@interface OTLViewController ()

@end

@implementation OTLViewController

-(NSMutableArray *)tasks
{
    if (!_tasks) {
        _tasks = [[NSMutableArray alloc] init];
    }
    
    return _tasks;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.cancelBarButtonItem = [[UIBarButtonItem alloc] init];
    self.cancelBarButtonItem.title = @"Cancel";
    self.cancelBarButtonItem.action = @selector(resetNavigationBarButtonItems);
    self.cancelBarButtonItem.target = self;
    self.cancelBarButtonItem.style = UIBarButtonItemStylePlain;
    
    [self populateTasksFromNSUserDefaults];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segue Management

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UIBarButtonItem class]]) {
        OTLAddTaskViewController *addTaskVC = segue.destinationViewController;
        addTaskVC.delegate = self;
    }
    
    if ([sender isKindOfClass:[NSIndexPath class]]) {
        if ([segue.destinationViewController isKindOfClass:[OTLTaskDetailViewController class]]) {
            OTLTaskDetailViewController *taskDetailVC = segue.destinationViewController;
            NSIndexPath *indexPath = sender;
            OTLTask *task = self.tasks[indexPath.row];
            taskDetailVC.task = task;
            taskDetailVC.indexPath = indexPath;
        }
    }
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"toTaskDetailViewController"]) {
        if ([sender isKindOfClass:[UITableViewCell class]]) {
            return NO;
        }
    }
    
    return YES;

}

#pragma mark - OTLAddTaskViewControllerDelegate methods

-(void)didCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];

}

-(void)didAddTask:(OTLTask *)task
{
    [self.tasks addObject:task];
    
    // Retrieve existing NSUserDefaults data
    NSMutableArray *tasksAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASKS_KEY] mutableCopy];
    
    // Check to see if data exists; initialize array if not
    if (!tasksAsPropertyLists) tasksAsPropertyLists = [[NSMutableArray alloc] init];
    
    // Save task data to NSUserDefaults
    [tasksAsPropertyLists addObject:[task formatAsPropertyList]];
    [[NSUserDefaults standardUserDefaults] setObject:tasksAsPropertyLists forKey:TASKS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];

    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"toTaskDetailViewController" sender:indexPath];
}

-(void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    OTLTask *task = self.tasks[indexPath.row];
    [task toggleCompletion];
    [self saveTasksToNSUserDefaults];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tasks count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Task Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    OTLTask *task = self.tasks[indexPath.row];
    cell.textLabel.text = task.title;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    cell.detailTextLabel.text = [formatter stringFromDate:task.date];
    
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    OTLTask *taskToMove = self.tasks[sourceIndexPath.row];
    [self.tasks removeObjectAtIndex:sourceIndexPath.row];
    [self.tasks insertObject:taskToMove atIndex:destinationIndexPath.row];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.tasks removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath
                                                 ] withRowAnimation:UITableViewRowAnimationLeft];
    }
    
    [self.tableView reloadData];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    OTLTask *task = self.tasks[indexPath.row];
    
    if (task.completion) {
        cell.backgroundColor = [UIColor greenColor];
    } else if ([task isOverdue]) {
        cell.backgroundColor = [UIColor redColor];
    } else {
        cell.backgroundColor = [UIColor clearColor];
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    [self.tableView reloadData];
    [super viewDidDisappear:YES];
}

- (IBAction)editButtonPressed:(UIBarButtonItem *)sender
{
    if (self.editing) {
        [self saveTasksToNSUserDefaults];
        [self resetNavigationBarButtonItems];

    } else {
        [super setEditing:YES animated:YES];
        [self.tableView setEditing:YES animated:YES];
        
        [self.tableView reloadData];
        
        [self.navigationItem.leftBarButtonItem setTitle:@"Done"];
        [self.navigationItem.leftBarButtonItem setStyle:UIBarButtonItemStyleDone];
        
        [self.navigationItem setRightBarButtonItem:self.cancelBarButtonItem];
    }
}

#pragma mark - Helpers
-(void)resetNavigationBarButtonItems
{
    [super setEditing:NO animated:NO];
    [self.tableView setEditing:NO animated:NO];
    
    [self.tableView reloadData];
    
    [self.navigationItem.leftBarButtonItem setStyle:UIBarButtonItemStylePlain];
    [self.navigationItem setLeftBarButtonItem:self.editBarButtonItem];
    [self.navigationItem setRightBarButtonItem:self.addTaskBarButtonItem];
}

-(void)saveTasksToNSUserDefaults
{
    NSMutableArray *tasksAsPropertyLists = [[NSMutableArray alloc] init];
    
    for (OTLTask *task in self.tasks) {
        [tasksAsPropertyLists addObject:[task formatAsPropertyList]];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:tasksAsPropertyLists forKey:TASKS_KEY];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)populateTasksFromNSUserDefaults
{
    self.tasks = nil;
    
    NSArray *tasksAsPropertyLists = [[NSUserDefaults standardUserDefaults] arrayForKey:TASKS_KEY];
    for (NSDictionary *propertyList in tasksAsPropertyLists) {
        OTLTask *task = [[OTLTask alloc] initWithData:propertyList];
        [self.tasks addObject:task];
    }
}
@end
