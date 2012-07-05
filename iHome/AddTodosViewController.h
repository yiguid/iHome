//
//  AddTodosViewController.h
//  iHome
//
//  Created by  on 12-7-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddTodosViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *txtTitle;
@property (strong, nonatomic) IBOutlet UITextField *txtContent;
@property (strong, nonatomic) IBOutlet UIDatePicker *pickerEnddate;
@property (strong, nonatomic) IBOutlet UITextField *txtEnddate;
- (IBAction)editEnddate:(id)sender;

@end
