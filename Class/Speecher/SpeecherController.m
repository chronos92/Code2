//
//  SpeecherController.m
//  LiveTour2
//
//  Created by Boris Falcinelli on 13/10/14.
//  Copyright (c) 2014 Boris Falcinelli. All rights reserved.
//

#import "SpeecherController.h"

@implementation SpeecherController

-(void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveStartNotification) name:NOTIFICATION_START object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveStopNotification) name:NOTIFICATION_STOP object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_START object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_STOP object:nil];
}

- (void)reciveStopNotification {}
- (void)reciveStartNotification {}

@end
