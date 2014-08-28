//
//  PSTransformableView.h
//
//  Created by Igor Matyushkin on 15.08.14.
//  Copyright (c) 2014 Igor Matyushkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSTransformableViewDelegate.h"

#define PSTransformableView_AreGesturesEnabledByDefault YES

@interface PSTransformableView : UIView<UIGestureRecognizerDelegate>

@property (assign, nonatomic) id<PSTransformableViewDelegate> delegate;

@property (getter = isTapGestureEnabled) BOOL tapGestureEnabled;

@property (getter = isLongPressGestureEnabled) BOOL longPressGestureEnabled;

@property (getter = isPanGestureEnabled) BOOL panGestureEnabled;

@property (getter = isPinchGestureEnabled) BOOL pinchGestureEnabled;

@property (getter = isRotationGestureEnabled) BOOL rotationGestureEnabled;

@end
