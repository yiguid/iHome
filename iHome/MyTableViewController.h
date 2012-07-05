//
//  MyTableViewController.h
//  iHome
//
//  Created by  on 12-7-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TodosDB;
@interface MyTableViewController : UITableViewController{
    TodosDB *db;
    NSMutableArray *todos;
}
//@property(nonatomic,retain) NSMutableDictionary *lists; //新增
//@property(nonatomic,retain) NSArray *datasource;
- (IBAction)addTodosButtomPushed:(id)sender;
-(void)setupArray;
@end
