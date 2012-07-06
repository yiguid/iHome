//
//  FirstViewController.m
//  iHome
//
//  Created by  on 12-6-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"
#import "FaceView.h"

@interface FirstViewController() <FaceViewDataSource>
@property (nonatomic, weak) IBOutlet FaceView *faceView;
@end

@implementation FirstViewController
@synthesize textName;
@synthesize labelName;

@synthesize happiness = _happiness;
@synthesize faceView = _faceView;

- (float)smileForFaceView:(FaceView *)sender
{
    return (self.happiness - 50)/50.0;
}

- (void)setHappiness:(int)happiness
{
    _happiness = happiness;
    [self.faceView setNeedsDisplay];  // redraw method
}

- (void)setFaceView:(FaceView *)faceView
{
    _faceView = faceView;
    [self.faceView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] 
                                         initWithTarget:self.faceView action:@selector(pinch:)]];
    [self.faceView addGestureRecognizer:[[UIPanGestureRecognizer alloc] 
                                         initWithTarget:self action:@selector(handleHappinessGesture:)]];
    self.faceView.dataSource = self;
}

- (void)handleHappinessGesture:(UIPanGestureRecognizer *)gesture
{
    if((gesture.state == UIGestureRecognizerStateChanged) ||
       (gesture.state == UIGestureRecognizerStateEnded)){
        CGPoint translation = [gesture translationInView:self.faceView];
        self.happiness += translation.y / 2;
        [gesture setTranslation:CGPointZero inView:self.faceView];
    }
}

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
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
//    } else {
        return YES;
//    }
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
    
    [self.faceView setHidden:NO];
    [self.textName resignFirstResponder];
}
- (IBAction)goBackToMainView:(id)sender {
    [self.faceView setHidden:YES];
}
@end
