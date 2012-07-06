//
//  FirstViewController.h
//  iHome
//
//  Created by  on 12-6-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Car.h"

@interface FirstViewController : UIViewController<UITextFieldDelegate>
- (IBAction)welcome:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textName;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
- (NSString *)sayHello:(NSString *) name;


@property (nonatomic) int happiness;  //0 is sad, 100 is very very happy

@end
