//
//  SpeecherController.h
//  LiveTour2
//
//  Created by Boris Falcinelli on 13/10/14.
//  Copyright (c) 2014 Boris Falcinelli. All rights reserved.
//

#import <UIKit/UIKit.h>
#define NOTIFICATION_START @"notificationStart"
#define NOTIFICATION_STOP  @"notificationStop"

@interface SpeecherController : UIViewController

- (void)reciveStartNotification;
- (void)reciveStopNotification;

@end
