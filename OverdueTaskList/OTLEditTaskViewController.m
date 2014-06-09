//
//  OTLEditTaskViewController.m
//  OverdueTaskList
//
//  Created by Matthew Nguyen on 4/30/14.
//  Copyright (c) 2014 Matthew Nguyen. All rights reserved.
//

#import "OTLEditTaskViewController.h"

@interface OTLEditTaskViewController ()

@end

@implementation OTLEditTaskViewController

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
    self.titleTextField.text = self.task.title;
    self.descriptionTextField.text = self.task.description;
    self.datePicker.date = self.task.date;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender
{
    self.task.title = self.titleTextField.text;
    self.task.description = self.descriptionTextField.text;
    self.task.date = self.datePicker.date;
    
    [self.delegate didEditTask:self.task];
    
    [self.navigationController popViewControllerAnimated:YES];
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
        [self.descriptionTextField resignFirstResponder];
        
        return NO;
    } else {
        return YES;
    }
}

@end
