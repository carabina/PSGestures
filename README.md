PSGestures is a library for iOS. It's designed to allow the developer to handle gestures without any code. Simple subclass your view from *PSTransformableView* to get pan, zoom and rotation working!

However, if you would like to dive deeper and implement custom gesture behavior, this library makes it possible, too; just set a delegate to your transformable view.

**How To Get Started**

* Import *PSGestures.h* file in your project
* Subclass your view from *PSTransformableView*
* Start the app and see the gestures working!


**Requirements**
* iOS 7 and later

**Usage**

Create your own *CustomView* class and subclass it from *PSTransformableView*:

    #import "PSGestures.h"
    
    @interface CustomView : PSTransformableView
    // Your class' public properties and methods
    @end


Then, create an instance of your *CustomView* class and bring it to some superview.

Now you can start the app and pan, zoom, and rotate the view. All gestures are handled automatically by *PSTransformableView* class.

Let's disable default implementation for some of gestures. It's possible this way:

    [customView setGestureWithType:PSTransformableViewGestureTypePan enabled:NO];
    [customView setGestureWithType:PSTransformableViewGestureTypePinch enabled:NO];
    [customView setGestureWithType:PSTransformableViewGestureTypeRotation enabled:YES];

Also, you can check whether or not default gesture behavior is enabled:

    BOOL isEnabled = [customView isGestureWithTypeEnabled:PSTransformableViewGestureTypeRotation];

When you would like to receive debug information regarding with gestures, or want to implement additional custom behavior, it's possible with the *PSTransformableViewDelegate* protocol:

    #import "PSGestures.h"
    
    @interface CustomView : PSTransformableView<PSTransformableViewDelegate>
    @end

Implement the only method of this protocol in your view's *.m* file:

    - (void)transformableView:(PSTransformableView *)view retrievedGestureOfType:(PSTransformableViewGestureType)type inState:(PSTransformableViewGestureState)state touchedPoints:(NSArray *)points
    {
        NSString *typeString = NSStringFromPSTransformableViewGestureType(type);
        NSString *stateString = NSStringFromPSTransformableViewGestureState(state);
        
        NSLog(@"Gesture of type %@ in state %@ with touch count %lu",
              typeString,
              stateString,
              (unsigned long)points.count);
    }

This method will receive gesture's type, state, and array of NSValue objects containing CGPoint for every one of the touched points. So, this method only tells you as much as all existing UIGestureRecognizer subclasses together. *PSGestures* provides all needed information without the need to write gesture selectors.

**License**

PSGestures is available under the MIT license. See the LICENSE file for more info.
