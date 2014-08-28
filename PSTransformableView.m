//
//  PSTransformableView.m
//
//  Created by Igor Matyushkin on 15.08.14.
//  Copyright (c) 2014 Igor Matyushkin. All rights reserved.
//

#import "PSTransformableView.h"

@interface PSTransformableView ()

@property float lastRotation;

@end

@implementation PSTransformableView

@synthesize panGestureEnabled = _panGestureEnabled;

@synthesize pinchGestureEnabled = _pinchGestureEnabled;

@synthesize rotationGestureEnabled = _rotationGestureEnabled;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
        [self customInitialization];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if(self)
    {
        [self customInitialization];
    }
    
    return self;
}

- (void)customInitialization
{
    /*
     * Enable all gestures.
     */
    
    _panGestureEnabled = YES;
    _pinchGestureEnabled = YES;
    _rotationGestureEnabled = YES;
    
    
    /*
     * Add tap gesture recognizer.
     */
    
    UITapGestureRecognizer *viewTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                               action:@selector(viewDidRetrieveGestureWithRecognizer:)];
    
    viewTapGestureRecognizer.delegate = self;
    
    [self addGestureRecognizer:viewTapGestureRecognizer];
    
    
    /*
     * Add long press gesture recognizer.
     */
    
    UILongPressGestureRecognizer *viewLongPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                                                 action:@selector(viewDidRetrieveGestureWithRecognizer:)];
    
    viewLongPressGestureRecognizer.delegate = self;
    
    [self addGestureRecognizer:viewLongPressGestureRecognizer];
    
    
    /*
     * Add pan gesture recognizer.
     */
    
    UIPanGestureRecognizer *viewPanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                               action:@selector(viewDidRetrieveGestureWithRecognizer:)];
    
    viewPanGestureRecognizer.delegate = self;
    
    [self addGestureRecognizer:viewPanGestureRecognizer];
    
    
    /*
     * Add pinch gesture recognizer.
     */
    
    UIPinchGestureRecognizer *viewPinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                                                                     action:@selector(viewDidRetrieveGestureWithRecognizer:)];
    
    viewPinchGestureRecognizer.delegate = self;
    
    [self addGestureRecognizer:viewPinchGestureRecognizer];
    
    
    /*
     * Add rotation gesture recognizer.
     */
    
    UIRotationGestureRecognizer *viewRotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self
                                                                                                              action:@selector(viewDidRetrieveGestureWithRecognizer:)];
    
    viewRotationGestureRecognizer.delegate = self;
    
    [self addGestureRecognizer:viewRotationGestureRecognizer];
}

#pragma mark Property accessors

- (BOOL)isPanGestureEnabled
{
    return _panGestureEnabled;
}

- (void)setPanGestureEnabled:(BOOL)panEnabled
{
    _panGestureEnabled = panEnabled;
}

- (BOOL)isPinchGestureEnabled
{
    return _pinchGestureEnabled;
}

- (void)setPinchGestureEnabled:(BOOL)pinchEnabled
{
    _pinchGestureEnabled = pinchEnabled;
}

- (BOOL)isRotationGestureEnabled
{
    return _rotationGestureEnabled;
}

- (void)setRotationGestureEnabled:(BOOL)rotationEnabled
{
    _rotationGestureEnabled = rotationEnabled;
}

#pragma mark Public methods

#pragma mark Private methods

- (void)viewDidRetrieveGestureWithRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    PSTransformableViewGestureType gestureType;
    
    if([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]])
    {
        if(!_tapGestureEnabled)
        {
            return;
        }
        
        gestureType = PSTransformableViewGestureTypeTap;
    }
    else if([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]])
    {
        if(!_longPressGestureEnabled)
        {
            return;
        }
        
        gestureType = PSTransformableViewGestureTypeLongPress;
    }
    else if([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]])
    {
        if(!_panGestureEnabled)
        {
            return;
        }
        
        gestureType = PSTransformableViewGestureTypePan;
    }
    else if([gestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]])
    {
        if(!_pinchGestureEnabled)
        {
            return;
        }
        
        gestureType = PSTransformableViewGestureTypePinch;
    }
    else if([gestureRecognizer isKindOfClass:[UIRotationGestureRecognizer class]])
    {
        if(!_rotationGestureEnabled)
        {
            return;
        }
        
        gestureType = PSTransformableViewGestureTypeRotation;
    }
    else
    {
        gestureType = PSTransformableViewGestureTypeUnknown;
    }
    
    PSTransformableViewGestureState gestureState;
    
    switch(gestureRecognizer.state)
    {
        case UIGestureRecognizerStatePossible:
        {
            /*
             * This gesture state shouldn't be sent to delegate.
             * Therefore, finish the method.
             */
            
            return;
        }
        case UIGestureRecognizerStateBegan:
        {
            gestureState = PSTransformableViewGestureStateBegan;
            
            switch(gestureType)
            {
                case PSTransformableViewGestureTypeTap:
                {
                    break;
                }
                case PSTransformableViewGestureTypeLongPress:
                {
                    break;
                }
                case PSTransformableViewGestureTypePan:
                {
                    CGPoint translatedPoint = [(UIPanGestureRecognizer*)gestureRecognizer translationInView:self];
                    
                    self.center = CGPointMake(self.center.x + translatedPoint.x, self.center.y + translatedPoint.y);
                    
                    [((UIPanGestureRecognizer *)gestureRecognizer) setTranslation:CGPointZero inView:self];
                    
                    break;
                }
                case PSTransformableViewGestureTypePinch:
                {
                    CGFloat scale = ((UIPinchGestureRecognizer *)gestureRecognizer).scale;
                    
                    self.transform = CGAffineTransformScale(self.transform, scale, scale);
                    
                    ((UIPinchGestureRecognizer *)gestureRecognizer).scale = 1.0f;
                    
                    break;
                }
                case PSTransformableViewGestureTypeRotation:
                {
                    _lastRotation = 0.f;
                    
                    break;
                }
                case PSTransformableViewGestureTypeUnknown:
                {
                    break;
                }
            }
            
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            gestureState = PSTransformableViewGestureStateChanged;
            
            switch(gestureType)
            {
                case PSTransformableViewGestureTypeTap:
                {
                    break;
                }
                case PSTransformableViewGestureTypeLongPress:
                {
                    break;
                }
                case PSTransformableViewGestureTypePan:
                {
                    CGPoint translatedPoint = [(UIPanGestureRecognizer*)gestureRecognizer translationInView:self];
                    
                    self.center = CGPointMake(self.center.x + translatedPoint.x, self.center.y + translatedPoint.y);
                    
                    [((UIPanGestureRecognizer *)gestureRecognizer) setTranslation:CGPointZero inView:self];
                    
                    break;
                }
                case PSTransformableViewGestureTypePinch:
                {
                    CGFloat scale = ((UIPinchGestureRecognizer *)gestureRecognizer).scale;
                    
                    self.transform = CGAffineTransformScale(self.transform, scale, scale);
                    
                    ((UIPinchGestureRecognizer *)gestureRecognizer).scale = 1.0f;
                    
                    break;
                }
                case PSTransformableViewGestureTypeRotation:
                {
                    float rotation = 0.f - _lastRotation + ((UIRotationGestureRecognizer *)gestureRecognizer).rotation;
                    
                    self.transform = CGAffineTransformRotate(self.transform, rotation);
                    
                    _lastRotation = ((UIRotationGestureRecognizer *)gestureRecognizer).rotation;
                    
                    break;
                }
                case PSTransformableViewGestureTypeUnknown:
                {
                    break;
                }
            }
            
            break;
        }
        case UIGestureRecognizerStateEnded:
        {
            gestureState = PSTransformableViewGestureStateEnded;
            
            switch(gestureType)
            {
                case PSTransformableViewGestureTypeTap:
                {
                    break;
                }
                case PSTransformableViewGestureTypeLongPress:
                {
                    break;
                }
                case PSTransformableViewGestureTypePan:
                {
                    break;
                }
                case PSTransformableViewGestureTypePinch:
                {
                    break;
                }
                case PSTransformableViewGestureTypeRotation:
                {
                    _lastRotation = 0.f;
                    
                    break;
                }
                case PSTransformableViewGestureTypeUnknown:
                {
                    break;
                }
            }
            
            break;
        }
        case UIGestureRecognizerStateFailed:
        {
            /*
             * This gesture state shouldn't be sent to delegate.
             * Therefore, finish the method.
             */
            
            return;
        }
        case UIGestureRecognizerStateCancelled:
        {
            gestureState = PSTransformableViewGestureStateCancelled;
            
            break;
        }
        default:
        {
            gestureState = PSTransformableViewGestureStateUnknown;
            
            break;
        }
    }
    
    if([_delegate respondsToSelector:@selector(transformableView:retrievedGestureOfType:inState:touchedPoints:)])
    {
        NSMutableArray *touchedPoints = [NSMutableArray array];
        
        for(NSUInteger i = 0; i < gestureRecognizer.numberOfTouches; i++)
        {
            CGPoint point = [gestureRecognizer locationOfTouch:i inView:self];
            NSValue *pointValue = [NSValue valueWithCGPoint:point];
            
            [touchedPoints addObject:pointValue];
        }
        
        [_delegate transformableView:self
              retrievedGestureOfType:gestureType
                             inState:gestureState
                       touchedPoints:touchedPoints];
    }
}

#pragma mark Delegate methods

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end
