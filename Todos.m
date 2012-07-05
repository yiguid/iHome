//
//  Todos.m
//  iHome
//
//  Created by  on 12-7-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Todos.h"

@implementation Todos
@synthesize uniqueId,title,content,enddate;
-(id)initWithUniqueId:(int)uniqueId title:(NSString *)title content:(NSString  *)content enddate:(NSDate *)enddate;
{
    self = [super init];
    if(self){
        self.uniqueId = uniqueId;
        self.title = title;
        self.content = content;
        self.enddate = enddate;
    }
    return self;
}

@end
