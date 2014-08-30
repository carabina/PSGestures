PSGestures is a library for iOS. It's designed to allow developer to handle gestures without any code. Just subclass your view from *PSTransformableView* and get pan, zoom and rotation working!

But if you want to do more and implement custom behavior for gestures, it’s also possible with this library. Just set a delegate to your transformable view.

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

Now you can start the app and pan, zoom and rotate the view. All gestures are handled automatically by *PSTransformable* view class.

Let's disable default implementation for some of gestures. It's possible this way:

    customView.panGestureEnabled = NO;
    customView.pinchGestureEnabled = NO;
    customView.rotationGestureEnabled = YES;

When you want to receive debug information regarding with gestures, or want to implement additional custom behavior, it's possible with *PSTransformableViewDelegate* protocol:

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

This method will receive gesture's type, state and array of NSValue objects containing CGPoint for every of touched points. So, the only method tells you as much as all existing UIGestureRecognizer subclasses together. *PSGestures* provides all needed information without needs to write gesture selectors.

**License**

PSGestures is available under the MIT license. See the LICENSE file for more info.