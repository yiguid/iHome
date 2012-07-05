//
//  AddTodosViewController.m
//  iHome
//
//  Created by  on 12-7-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AddTodosViewController.h"
#import "Todos.h"
#import "TodosDB.h"

@implementation AddTodosViewController
@synthesize txtTitle;
@synthesize txtContent;
@synthesize pickerEnddate;
@synthesize txtEnddate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

- (void)setupNavButtons
{
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] 
                                    initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                    target:self 
                                    action:@selector(saveTodos:)];
    [self.navigationItem setRightBarButtonItem:doneButton];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNavButtons];
}


- (void)viewDidUnload
{
    [self setTxtTitle:nil];
    [self setTxtContent:nil];
    [self setTxtEnddate:nil];
    [self setPickerEnddate:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(BOOL)textFieldShouldReturn:(UITextField *)theTextField{
    if(theTextField == self.txtTitle || theTextField == self.txtContent){
        [theTextField resignFirstResponder];
    }
    return YES;
}

- (void)saveTodos:(id)sender {
    TodosDB *db = [[TodosDB alloc] init];
    NSString *strTitle = txtTitle.text;
    NSString *strContent = txtContent.text;
    NSString *strEnddate = txtEnddate.text;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    Todos *todo = [[Todos alloc] initWithUniqueId:0 title:strTitle content:strContent enddate:[dateFormatter dateFromString:strEnddate]];
    [db addTodos:todo];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)editEnddate:(id)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    txtEnddate.text = [dateFormatter stringFromDate:pickerEnddate.date];}
@end
