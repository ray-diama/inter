# Event System - Evesys

## Events in OpenFL - recap
OpenFL follows the DOM event specifications, in OpenFL words it is the Display list
For handling events in OpenFL, there's three key principles to remember:

* Only the event dispatcher object can listen to the event as it is the target
* in case the event dispatcher is a display object, its parent throughout the display list can also listen
+ events have three phases: capture, target and bubbling
    + Capture and bubbling phase can be listened by the parents throughout the display list
        + Capture happens before target phase
        + bubbling happens after target phase
    + target is only listened by the target
        
### Custom Events
Small example of how to create a custom Event

```haxe
import openfl.events.Event;
class CustomEvent extends Event{
    private var customData:Int;
    public function new(type:String, data:Int, bubbles:Bool=false, cancelable:Bool=false){
        super(type, bubbles, cancelable);
        customData = data;
    }
}
```
### EventListener
Small example of how to listen to custom events

**Listening during target phase**
```haxe
class Main extends Sprite{
    public function new(){
        var customEvent:CustomEvent = new CustomEvent("isSomeoneHere",0);
        var mySprite = new Sprite();
        mySprite.addEventListener("isSomeoneHere",function e(evt){ trace("I'm here");});
        mySprite.dispatchEvent(customEvent);
    }
}
```

**Listening during capture phase**
```haxe
class Main extends Sprite{
    public function new(){
        var customEvent:CustomEvent = new CustomEvent("isSomeoneHere",0);
        var mySprite = new Sprite();
        addEventListener("isSomeoneHere",function e(evt){ trace("I'm here");},true);
        mySprite.dispatchEvent(customEvent);
    }
}
```

**Listening during bubbling phase**
```haxe
class Main extends Sprite{
    public function new(){
        var customEvent:CustomEvent = new CustomEvent("isSomeoneHere",0, true);
        var mySprite = new Sprite();
        addEventListener("isSomeoneHere",function e(evt){ trace("I'm here");});
        mySprite.dispatchEvent(customEvent);
    }
}
```
_ _ _
## Event in inter

**To have fun while coding:**

+ most of the events will be listened during the capture phase,
+ some mouse clicks and timer events will be listened during the target phase

**List of Events**

#### App Events

#### Game State Events
+ GAME_INIT_EVENT
+ GAME_START_EVENT
+ GAME_PAUSE_EVENT
+ GAME_END_EVENT
+ GAME_RELOAD_EVENT
+ GAME_OVER_EVENT
	
#### Ingame Events
+ INGAME_PLAY_EVENT
+ INGAME_CARD_CHECK_EVENT
+ INGAME_CARDS_PLAYED_EVENT
+ INGAME_CARDS_MISPLAYED_EVENT
+ INGAME_DIRECTION_CHANGE_EVENT
+ INGAME_MARKER_ROTATION_EVENT
+ INGAME_MARKER_TIMER_EVENT
+ INGAME_MARKER_TIMER_EXTRA_TIME_EVENT
+ INGAME_PICKUP_CARD_EVENT
+ INGAME_PICKUP_PUNISHMENT_EVENT
+ INGAME_REFILL_PIOCHE_EVENT
+ INGAME_2CARDS_LEFT_EVENT


##TODO
+ AppEvents
+ camera related Events
+ 1vsMany
+ 1vsMany:continuum
+ tournament