//
//  DetailViewController.h
//  iHome
//
//  Created by  on 12-7-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController{
    NSString *myTitle;
    NSString *myContent;
    IBOutlet UILabel *titleLable;
    IBOutlet UILabel *contentLable;
    
}

@property (nonatomic, strong)NSString *myTitle, *myContent;
@property (nonatomic, strong)IBOutlet UILabel *titleLable, *contentLable;
@end
