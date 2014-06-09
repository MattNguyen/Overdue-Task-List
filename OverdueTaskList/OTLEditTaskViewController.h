//
//  OTLEditTaskViewController.h
//  OverdueTaskList
//
//  Created by Matthew Nguyen on 4/30/14.
//  Copyright (c) 2014 Matthew Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OTLTask.h"

@protocol OTLEditTaskViewControllerDelegate <NSObject>

-(void)didCancel;
-(void)didEditTask:(OTLTask *)task;

@end

@interface OTLEditTaskViewController : UIViewController <UITextViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) id <OTLEditTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *titleTextField;
@property (strong, nonatomic) IBOutlet UITextView *descriptionTextField;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) OTLTask *task;

- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender;

@end