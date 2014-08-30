//
//  PSTransformableViewGestureType.h
//
//  Created by Igor Matyushkin on 15.08.14.
//  Copyright (c) 2014 Igor Matyushkin. All rights reserved.
//

typedef enum
{
    PSTransformableViewGestureTypeTap,
    PSTransformableViewGestureTypeLongPress,
    PSTransformableViewGestureTypePan,
    PSTransformableViewGestureTypePinch,
    PSTransformableViewGestureTypeRotation,
    PSTransformableViewGestureTypeUnknown
} PSTransformableViewGestureType;

static PSTransformableViewGestureType PSTransformableViewGestureTypeFromGestureRecognizer(UIGestureRecognizer *gestureRecognizer)
{
    PSTransformableViewGestureType gestureType;
    
    if([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]])
    {
        gestureType = PSTransformableViewGestureTypeTap;
    }
    else if([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]])
    {
        gestureType = PSTransformableViewGestureTypeLongPress;
    }
    else if([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]])
    {
        gestureType = PSTransformableViewGestureTypePan;
    }
    else if([gestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]])
    {
        gestureType = PSTransformableViewGestureTypePinch;
    }
    else if([gestureRecognizer isKindOfClass:[UIRotationGestureRecognizer class]])
    {
        gestureType = PSTransformableViewGestureTypeRotation;
    }
    else
    {
        gestureType = PSTransformableViewGestureTypeUnknown;
    }
    
    return gestureType;
}

static NSString * NSStringFromPSTransformableViewGestureType(PSTransformableViewGestureType type)
{
    switch(type)
    {
        case PSTransformableViewGestureTypeTap:
        {
            return @"Tap";
        }
        case PSTransformableViewGestureTypeLongPress:
        {
            return @"Long Press";
        }
        case PSTransformableViewGestureTypePan:
        {
            return @"Pan";
        }
        case PSTransformableViewGestureTypePinch:
        {
            return @"Pinch";
        }
        case PSTransformableViewGestureTypeRotation:
        {
            return @"Rotation";
        }
        case PSTransformableViewGestureTypeUnknown:
        {
            return @"Unknown";
        }
        default:
        {
            return @"";
        }
    }
}