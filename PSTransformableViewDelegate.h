//
//  PSTransformableViewDelegate.h
//
//  Created by Igor Matyushkin on 15.08.14.
//  Copyright (c) 2014 Igor Matyushkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSTransformableViewGestureType.h"
#import "PSTransformableViewGestureState.h"

@class PSTransformableView;

@protocol PSTransformableViewDelegate <NSObject>

@required

@optional

/**
 This method is called when transformable view obtains gesture event.
 */
- (void)transformableView:(PSTransformableView *)view retrievedGestureOfType:(PSTransformableViewGestureType)type inState:(PSTransformableViewGestureState)state touchedPoints:(NSArray *)points;

@end
