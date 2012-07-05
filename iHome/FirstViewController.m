//
//  FirstViewController.m
//  iHome
//
//  Created by  on 12-6-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"

@implementation FirstViewController
@synthesize textName;
@synthesize labelName;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setLabelName:nil];
    [self setTextName:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
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
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (NSString *)sayHello:(NSString *) name{
    NSString *str = [[NSString alloc] initWithFormat:@"Hello, %@!",name];
    return str;
}

-(BOOL)textFieldShouldReturn:(UITextField *)theTextField{
    if(theTextField == self.textName){
        [theTextField resignFirstResponder];
    }
    return YES;
}

- (IBAction)welcome:(id)sender {
    //self.labelName.text = self.textName.text;
    //NSString *str = [[NSString alloc] initWithFormat:@"Hello, %a!",self.textName.text];
    //self.labelName.text = [self sayHello:self.textName.text];
    Car *newCar = [[Car alloc] init];
    [newCar setName:textName.text];
    labelName.text = [self sayHello:[newCar name]];
    //self.labelName.text = str;
}
@end
