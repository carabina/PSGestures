//
//  PSTransformableViewGestureState.h
//
//  Created by Igor Matyushkin on 15.08.14.
//  Copyright (c) 2014 Igor Matyushkin. All rights reserved.
//


typedef enum
{
    PSTransformableViewGestureStateBegan,
    PSTransformableViewGestureStateChanged,
    PSTransformableViewGestureStateEnded,
    PSTransformableViewGestureStateCancelled,
    PSTransformableViewGestureStateUnknown
} PSTransformableViewGestureState;

static PSTransformableViewGestureState PSTransformableViewGestureStateFromGestureRecognizer(UIGestureRecognizer *gestureRecognizer)
{
    PSTransformableViewGestureState gestureState;
    
    switch(gestureRecognizer.state)
    {
        case UIGestureRecognizerStatePossible:
        {
            gestureState = PSTransformableViewGestureStateUnknown;
            
            break;
        }
        case UIGestureRecognizerStateBegan:
        {
            gestureState = PSTransformableViewGestureStateBegan;
            
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            gestureState = PSTransformableViewGestureStateChanged;
            
            break;
        }
        case UIGestureRecognizerStateEnded:
        {
            gestureState = PSTransformableViewGestureStateEnded;
            
            break;
        }
        case UIGestureRecognizerStateFailed:
        {
            gestureState = PSTransformableViewGestureStateUnknown;
            
            break;
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
    
    return gestureState;
}

static NSString * NSStringFromPSTransformableViewGestureState(PSTransformableViewGestureState state)
{
    switch(state)
    {
        case PSTransformableViewGestureStateBegan:
        {
            return @"Began";
        }
        case PSTransformableViewGestureStateChanged:
        {
            return @"Changed";
        }
        case PSTransformableViewGestureStateEnded:
        {
            return @"Ended";
        }
        case PSTransformableViewGestureStateCancelled:
        {
            return @"Cancelled";
        }
        case PSTransformableViewGestureStateUnknown:
        {
            return @"Unknown";
        }
        default:
        {
            return @"";
        }
    }
}