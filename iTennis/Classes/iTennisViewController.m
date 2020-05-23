//
//  iTennisViewController.m
//  iTennis
//
//  Created by Crystal Hansen on 11-04-20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "iTennisViewController.h"


//when you want constants this is syntax
#define kGameStateRunning 1
#define kGameStatePaused 2

#define kBallSpeedX 10
#define kBallSpeedY	15
#define kCompMoveSpeed 15

#define kScoreToWin 5


@implementation iTennisViewController

@synthesize ball, racquet_y, racquet_g, tapToBegin,score, comp_score,ballVelocity,gameState;


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.gameState = kGameStatePaused;
	ballVelocity = CGPointMake(kBallSpeedX, kBallSpeedY);
	
	[NSTimer scheduledTimerWithTimeInterval:.05 
									 target:self
								   selector:@selector(gameLoop) 
								   userInfo:nil 
									repeats:YES];
}

-(void) gameLoop{
	if(gameState == kGameStateRunning){
		ball.center = CGPointMake(ball.center.x + ballVelocity.x,ball.center.y + ballVelocity.y);
		if(ball.center.x > self.view.bounds.size.width || ball.center.x <0){
			ballVelocity.x = -ballVelocity.x;
		}
		if (ball.center.y >self.view.bounds.size.height || ball.center.y <0) {
			ballVelocity.y = -ballVelocity.y;
		}
	}else {
		if(tapToBegin.hidden){
			tapToBegin.hidden = NO;
		}
	}
	
	//collision detection
	if (CGRectIntersectsRect(ball.frame, racquet_y.frame)) {
		if(ball.center.y < racquet_y.center.y){
			ballVelocity.y = -ballVelocity.y;
			NSLog(@"%f %f",ball.center,racquet_g.center);
		}
	}
	if(CGRectIntersectsRect(ball.frame, racquet_g.frame)){
		if(ball.center.y > racquet_g.center.y){
			ballVelocity.y = -ballVelocity.y;
		}
	}//end collision detect
	
	//begin simple AI
	if (ball.center.y <= self.view.center.y) {
		if (ball.center.x < racquet_g.center.x) {
			CGPoint compLocation = CGPointMake(racquet_g.center.x - kCompMoveSpeed, racquet_g.center.y);
			racquet_g.center = compLocation;
		}
		if (ball.center.y < racquet_g.center.y) {
			//the ball is past the position of the racquet and the racquet movement must stop
			CGPoint compLocation = CGPointMake(racquet_g.center.x - ball.center.x, racquet_g.center.y);
			if (compLocation.x >320) {
				compLocation.x = 300;
			}
			racquet_g.center = compLocation;
			NSLog(@"%f %f",ball.center,racquet_g.center);
		}
	
		if (ball.center.x > racquet_g.center.x) {
			CGPoint compLocation = CGPointMake(racquet_g.center.x + kCompMoveSpeed,racquet_g.center.y);
			racquet_g.center = compLocation;
		}
		
		
		//end simple AI
	}
	//Game Scoring 
	if (ball.center.y <=0) {
		player_score_value++;
		[self reset:(player_score_value >=kScoreToWin)];
	}
	if(ball.center.y > self.view.bounds.size.height){
		computer_score_value++;
		[self reset:(computer_score_value >=kScoreToWin)];
	
	}
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	if (gameState == kGameStatePaused) {
		tapToBegin.hidden = YES;
		gameState = kGameStateRunning;
	}else if (gameState == kGameStateRunning) {
		[self touchesMoved:touches withEvent:event];
	}

}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
	UITouch *touch = [[event allTouches] anyObject];
	CGPoint location = [touch locationInView:touch.view];
	CGPoint xLocation = CGPointMake(location.x, racquet_y.center.y);
	
	racquet_y.center = xLocation;

}
-(void) reset:(BOOL)newGame{

	self.gameState = kGameStatePaused;
	ball.center = self.view.center;
	if(newGame){
		if (computer_score_value > player_score_value) {
			tapToBegin.text = @"Computer Wins!";
			comp_score.text = [NSString stringWithFormat:@"0"];
			score.text =[NSString stringWithFormat: @"0"];
	
		}else {
			tapToBegin.text=@"Player Wins!";
			comp_score.text = [NSString stringWithFormat:@"0"];
			score.text =[NSString stringWithFormat: @"0"];
		}
	}else {
		tapToBegin.text = @"Tap to Begin";
	}
	score.text = [NSString stringWithFormat:@"%d", player_score_value];
	comp_score.text = [NSString stringWithFormat:@"%d", computer_score_value];
	
}
/*
 
 * Improve on user interaction – Make it so when the user taps, the racquet moves towards the tap rather than moves directly to the tap location
 * Improve collision detection – When the ball hits the paddle, use some simple physics to make the speed of the paddle affect the speed (and direction) of the ball
 * Improve on the AI – add some randomness to your AI, make it attempt to “predict” where the ball is going to be
 * Improve Scoring – Make it used tennis scores 15, 30 , etc…
 * Improve scoring – Make it so you must win by 2 points
 
 
*/
 
 
 

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	[ball release];
	[racquet_y release];
	[racquet_g release];
	[comp_score release];
	[score release];
	[tapToBegin release];
}

@end
