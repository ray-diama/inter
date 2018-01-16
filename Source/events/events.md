# Event System - Evesys

## Events in OpenFL - recap
OpenFL follows the DOM event specifications, in OpenFL words it is the Display list
For handling events in OpenFL, there's two key principles to remember:
    * Only the event dispatcher object can listen to the event as it is the target
        * in case the event dispatcher is a display object, its parent throughout the display list can also listen
    * events have three phases: capture, target and bubbling
        * Capture and bubbling phase can be listened by the parents throughout the display list
            * Capture happens before target phase
            * bubbling happens after target phase
        * target is only listened by the target
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
Events package hold all of the event classes related to the game
from app launch to exit

App Events

Game Events
_____________

gameInitEvent
cameraChange

gameSettingChanges
gameSettingUpdate


    1vs1
   ______
   start
   cardcheck(npc)
   marqueur rotation
   marquer timer
   marquer timer extra time
   cardPlayed
   specialCardPlayed
   directionChange
   Skip
   PickupCards
   PickUpPunishment
   refillPioche
   2cardsLeft
   End

    1vsMany
   _________

    1vsMany:continuum
   ___________________

    tournament
   ____________
