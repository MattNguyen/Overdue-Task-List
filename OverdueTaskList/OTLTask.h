//
//  OTLTask.h
//  OverdueTaskList
//
//  Created by Matthew Nguyen on 4/30/14.
//  Copyright (c) 2014 Matthew Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OTLTask : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic) BOOL completion;

-(id)initWithData:(NSDictionary *)dictionary;
-(NSDictionary *)formatAsPropertyList;
-(void)toggleCompletion;
-(BOOL)isOverdue;
@end
