//
//  Todos.h
//  iHome
//
//  Created by  on 12-7-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Todos : NSObject{
    int uniqueId;
    NSString *title;
    NSString *content;
    NSDate *enddate;
}

@property(nonatomic,assign)int uniqueId;
@property(nonatomic,retain)NSString *title;
@property(nonatomic,retain)NSString *content;
@property(nonatomic,retain)NSDate *enddate;
-(id)initWithUniqueId:(int)uniqueId title:(NSString *)title content:(NSString  *)content enddate:(NSDate *)enddate;

@end
