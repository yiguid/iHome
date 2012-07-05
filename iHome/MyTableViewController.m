//
//  MyTableViewController.m
//  iHome
//
//  Created by  on 12-7-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MyTableViewController.h"
#import "DetailViewController.h"
#import "AddTodosViewController.h"
#import "/usr/include/sqlite3.h"
#import "Todos.h"
#import "TodosDB.h"


@implementation MyTableViewController
//@synthesize lists; //新增加
//@synthesize datasource;

/*
 - (void)setupArray{
    lists = [[NSMutableDictionary alloc] init];
    [lists setObject:@"待办事项一" forKey:@"事件一"];
    [lists setObject:@"待办事项二" forKey:@"事件二"];
    [lists setObject:@"待办事项三" forKey:@"事件三"];
    [lists setObject:@"待办事项四" forKey:@"事件四"];
    [lists setObject:@"待办事项五" forKey:@"事件五"];
    datasource = [lists allKeys];
}
 */

- (void)testSqlite3{
    sqlite3 *db;
    char *szError = NULL;
    sqlite3_stmt *dbps;
    
    NSString *dbFile = [[NSBundle mainBundle] pathForResource:@"todos" ofType:@"sqlite3"];
    if (sqlite3_open([dbFile UTF8String], &db) != SQLITE_OK) {
        NSLog(@"failed to open db.");
    }
    
    NSString *sql_insert = @"insert into todos (title, content, enddate) values ('testtile', 'testcontent', '1987-09-18')";
    
    if (sqlite3_exec(db, [sql_insert UTF8String], 0, 0, &szError) == SQLITE_OK) {
        NSLog(@"%d", sqlite3_changes(db));
    }
    
    NSString *sql_select = @"SELECT * FROM todos";
    
    sqlite3_prepare_v2(db, [sql_select UTF8String], -1, &dbps, NULL);
    int nResult = sqlite3_step(dbps);
    for (int fld = 0; fld < sqlite3_column_count(dbps); fld++) {
        NSLog(@"%s", sqlite3_column_name(dbps, fld));
    }
    
    while (nResult != SQLITE_DONE) {
        NSLog(@"%s|%s|%s|%s", 
              sqlite3_column_text(dbps, 0),
              sqlite3_column_text(dbps, 1),
              sqlite3_column_text(dbps, 2),
              sqlite3_column_text(dbps, 3));
        nResult = sqlite3_step(dbps);
    }
    
    sqlite3_close(db);
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    //下面新增：定义lists数据 
    self.title = @"待办事项";
    //[self setupArray];
    db = [[TodosDB alloc] init];
    //[self testSqlite3];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    todos = [db getAllTodos];
    [self.tableView reloadData];
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return todos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"myCells";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    //cell.textLabel.text = [datasource objectAtIndex:indexPath.row];
    Todos *todo = [todos objectAtIndex:indexPath.row];
    cell.textLabel.text = todo.title;
    [cell.detailTextLabel setText:todo.content];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        Todos *todo = [todos objectAtIndex:indexPath.row];
        //delete from database
        [db removeTodos:todo];
        //delete from array
        [todos removeObjectAtIndex:indexPath.row];
        //delete from table view
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    DetailViewController *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"detail"];
     // ...
     // Pass the selected object to the new view controller.
    Todos *todo = [todos objectAtIndex:indexPath.row];
    detail.myTitle = todo.title;
    detail.myContent = todo.content;
    [self.navigationController pushViewController:detail animated:YES];
    
     
}
- (IBAction)addTodosButtomPushed:(id)sender {
    AddTodosViewController *addTodosViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"addtodos"];
    [self.navigationController pushViewController:addTodosViewController animated:YES];
}
@end
