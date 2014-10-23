//
//  SpeechSingleton.h
//  LiveTour2
//
//  Created by Boris Falcinelli on 09/10/14.
//  Copyright (c) 2014 Boris Falcinelli. All rights reserved.
//

#import <Foundation/Foundation.h>
@import AVFoundation;
#import "ImpostazioniManager.h"

#define CONTROLLER_DESCRIZIONE @"descrizioneController"

@interface SpeechSingleton : NSObject  <AVSpeechSynthesizerDelegate> {
    NSString * lingua;
    NSString * testo;
    float rate;
    float pitch;
    
    AVSpeechSynthesizer *synthesizer;
    AVSpeechSynthesisVoice *voice;
    AVSpeechUtterance * _utterance;
}
@property (nonatomic,strong,setter=setControllerAttuale:) NSString * controllerAttuale;

+ (SpeechSingleton *)shared;
- (void)reset;

- (void)setTestoAndStart:(NSString *)txt;
- (void)setControllerAttuale:(NSString *)ca;
- (void)setTestoLettura:(NSString *)txt;

- (void)readingPause;
- (void)readingStart;
- (void)readingStop;

- (BOOL)readingIsActive;
- (BOOL)readingIsInPause;

@end
