//
//  iTennisAppDelegate.h
//  iTennis
//
//  Created by Crystal Hansen on 11-04-20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iTennisViewController;

@interface iTennisAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    iTennisViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet iTennisViewController *viewController;

@end

