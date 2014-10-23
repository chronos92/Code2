//
//  SpeechSingleton.m
//  LiveTour2
//
//  Created by Boris Falcinelli on 09/10/14.
//  Copyright (c) 2014 Boris Falcinelli. All rights reserved.
//

#import "SpeechSingleton.h"
#import "LocalizationSystem.h"
#import "FormatUtil.h"
#import "SpeecherController.h"
#import "GTMNSString+HTML.h"

@implementation SpeechSingleton

static SpeechSingleton * shared = nil;

@synthesize controllerAttuale;

+ (SpeechSingleton *)shared {
    @synchronized(self){
        if (shared == nil) {
            shared = [[super allocWithZone:NULL] init];
            [shared reset];
        }
    }
    return shared;
}

- (void)reset {
    lingua = AMLocalizedString(@"lingua", @"");
    testo = [[NSString alloc] init];
    rate = 0.10;
    pitch = 0.99;
    voice = [AVSpeechSynthesisVoice voiceWithLanguage:lingua];
    synthesizer = [[AVSpeechSynthesizer alloc] init];
    synthesizer.delegate = self;
    _utterance = nil;
    controllerAttuale = nil;
}

/*
    SETTER
 */
- (void)setTestoAndStart:(NSString *)txt {
    [self setTestoLettura:txt];
    [self readingStart];
}

- (void)setControllerAttuale:(NSString *)ca {
    controllerAttuale = (ca == nil) ? [[NSString alloc] init] : [[NSString alloc] initWithString:ca];
}

- (void)setTestoLettura:(NSString *)txt {
    testo = [[FormatUtil stringByStrippingHTML:txt] gtm_stringByUnescapingFromHTML];
}

/*
    SPEECH OPERATION
 */
- (void)readingStart {
    if ([self readingIsInPause]) {
        [synthesizer continueSpeaking];
    } else {
        _utterance = [[AVSpeechUtterance alloc] initWithString:testo];
        _utterance.rate = rate;
        _utterance.pitchMultiplier = pitch;
        _utterance.voice = voice;
        [synthesizer speakUtterance:_utterance];
    }
}

- (void)readingPause {
    if (synthesizer.speaking) {
        [synthesizer pauseSpeakingAtBoundary:AVSpeechBoundaryWord];
    }
}

- (void)readingStop {
    [synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    [self reset];
}

/*
    SPEECH STATE
 */
- (BOOL)readingIsInPause {
    return synthesizer.isPaused;
}

- (BOOL)readingIsActive {
    return synthesizer.isSpeaking;
}

/*
    SPEECH SYNTHESIZER
 */
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance {
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_START object:nil];
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didPauseSpeechUtterance:(AVSpeechUtterance *)utterance {
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_STOP object:nil];
}

-(void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didContinueSpeechUtterance:(AVSpeechUtterance *)utterance {
    [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFICATION_START object:nil];
}

-(void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance {
    [self reset];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_STOP object:nil];
}

-(void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance *)utterance {
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_STOP object:nil];
}

@end
