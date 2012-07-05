//
//  Car.h
//  iHome
//
//  Created by  on 12-6-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Car : NSObject{
    NSString *name;
}
-(NSString *)name;
-(void)setName:(NSString *)newName;
@end
