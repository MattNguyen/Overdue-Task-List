//
//  OTLTask.m
//  OverdueTaskList
//
//  Created by Matthew Nguyen on 4/30/14.
//  Copyright (c) 2014 Matthew Nguyen. All rights reserved.
//

#import "OTLTask.h"

@implementation OTLTask

-(id)initWithData:(NSDictionary *)dictionary
{
    if ((self = [super init])) {
        self.title = dictionary[TASK_TITLE];
        self.description = dictionary[TASK_DESCRIPTION];
        self.date = dictionary[TASK_DATE];
        self.completion = [dictionary[TASK_COMPLETION] boolValue];
    }
    return self;
}

-(NSDictionary *)formatAsPropertyList
{
    NSDictionary *propertyList = @{
                                   TASK_TITLE: self.title,
                                   TASK_DESCRIPTION: self.description,
                                   TASK_DATE: self.date,
                                   TASK_COMPLETION: @(self.completion)
                                 };
    
    return propertyList;
}

-(void)toggleCompletion
{
    self.completion = !self.completion;
}

-(BOOL)isOverdue
{
    NSDate *currentDate = [NSDate date];
    NSComparisonResult result = [self.date compare:currentDate];
    if (result == NSOrderedDescending) {
        return YES;
    } else {
        return NO;
    }
}
@end
