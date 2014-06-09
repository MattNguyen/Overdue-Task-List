//
//  OTLAddTaskViewController.m
//  OverdueTaskList
//
//  Created by Matthew Nguyen on 4/30/14.
//  Copyright (c) 2014 Matthew Nguyen. All rights reserved.
//

#import "OTLAddTaskViewController.h"

@interface OTLAddTaskViewController ()

@end

@implementation OTLAddTaskViewController

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
    self.titleTextField.delegate = self;
    self.descriptionTextView.delegate = self;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addButtonPressed:(UIButton *)sender {
    [self.delegate didAddTask:[self returnNewTask]];
}

- (IBAction)cancelButtonPressed:(UIButton *)sender {
    [self.delegate didCancel];
}

-(OTLTask *)returnNewTask
{
    OTLTask *newTask = [[OTLTask alloc] init];
    newTask.title = self.titleTextField.text;
    newTask.description = self.descriptionTextView.text;
    newTask.date = self.datePicker.date;
    
    return newTask;
}

#pragma - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.titleTextField resignFirstResponder];
    
    return YES;
}

#pragma - UITextViewDelegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [self.descriptionTextView resignFirstResponder];
        
        return NO;
    } else {
        return YES;
    }
}
@end

