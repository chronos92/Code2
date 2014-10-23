//
//  ADClusterableAnnotation.h
//  ADClusterMapView
//
//  Created by Patrick Nollet on 27/06/11.
//  Copyright 2011 Applidium. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "ADMapCluster.h"
#import "poiAnnotation.h"

@interface ADClusterableAnnotation : poiAnnotation

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (id)initWitId:(NSString *)itemId Name:(NSString *)name Latitude:(double)latitude AndLongitude:(double)longitude;
@end
