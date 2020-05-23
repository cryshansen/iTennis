//
//  iTennisViewController.h
//  iTennis
//
//  Created by Crystal Hansen on 11-04-20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iTennisViewController : UIViewController {

	IBOutlet UIImageView *ball;
	IBOutlet UIImageView *racquet_y;
	IBOutlet UIImageView *racquet_g;
	IBOutlet UILabel *tapToBegin;
	IBOutlet UILabel *score;
	
	IBOutlet UILabel *comp_score;
	
	CGPoint ballVelocity;
	NSInteger gameState;
	
	NSInteger player_score_value;
	NSInteger computer_score_value;
	
}

@property (nonatomic,retain) IBOutlet UIImageView *ball;
@property (nonatomic,retain) IBOutlet UIImageView *racquet_y;
@property (nonatomic,retain) IBOutlet UIImageView *racquet_g;
@property (nonatomic,retain) IBOutlet UILabel *tapToBegin;

@property (nonatomic,retain) IBOutlet UILabel *score;
@property (nonatomic,retain) IBOutlet UILabel *comp_score;

@property (nonatomic) CGPoint ballVelocity;
@property (nonatomic) NSInteger gameState;


-(void) reset:(BOOL)newGame;

@end

