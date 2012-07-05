//
//  ThirdViewController.m
//  iHome
//
//  Created by  on 12-6-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//



#import "ThirdViewController.h"

@interface ThirdViewController()
@property (nonatomic) double storeNumber;
@property (nonatomic) BOOL isEnteringNumber;
@property (nonatomic) int op;
@end

@implementation ThirdViewController
@synthesize calculator= _calculator;
@synthesize isEnteringNumber,storeNumber,op;


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
    [self setCalculator:nil];
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
- (IBAction)numberPressed:(UIButton *)sender {
    NSLog(@"You Pressed %@",sender.currentTitle);
    if(isEnteringNumber == YES){
        self.calculator.text = [self.calculator.text stringByAppendingString:sender.currentTitle];
    }
    else{
        storeNumber = [self.calculator.text doubleValue];
        self.calculator.text = sender.currentTitle;
    }
    isEnteringNumber = YES;

}
- (IBAction)opPressed:(UIButton *)sender {
    isEnteringNumber = NO;
    if ([sender.currentTitle isEqualToString:@"+"]) op = 1;
    else if ([sender.currentTitle isEqualToString:@"-"]) op = 2;
    else if ([sender.currentTitle isEqualToString:@"*"]) op = 3;
    else op = 4;
}

- (IBAction)clearPressed:(id)sender {
    self.calculator.text = @"0";
    isEnteringNumber = NO;
}

- (double)cal:(int)theOp val1:(double)val1 val2:(double)val2{
    double out = 0;
    switch (theOp) {
        case 1:
            out = val1 + val2;
            break;
        case 2:
            out = val1 - val2;
            break;
        case 3:
            out = val1 * val2;
            break;
        case 4:
            out = val1 / val2;
            break;
        default:
            break;
    }
    return out;
}

- (IBAction)btneq:(id)sender {
    double out = [self cal:op val1:storeNumber val2:[self.calculator.text doubleValue]];
    self.calculator.text = [[NSString alloc] initWithFormat:@"%g", out];
}
@end
