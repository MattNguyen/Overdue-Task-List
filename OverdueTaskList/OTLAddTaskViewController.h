//
//  OTLAddTaskViewController.h
//  OverdueTaskList
//
//  Created by Matthew Nguyen on 4/30/14.
//  Copyright (c) 2014 Matthew Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OTLTask.h"

@protocol OTLAddTaskViewControllerDelegate <NSObject>

-(void)didCancel;
-(void)didAddTask:(OTLTask *)task;

@end

@interface OTLAddTaskViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) id <OTLAddTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *titleTextField;
@property (strong, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)addButtonPressed:(UIButton *)sender;
- (IBAction)cancelButtonPressed:(UIButton *)sender;

@end
