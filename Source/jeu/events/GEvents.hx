package jeu.events;

import openfl.events.Event;

class GEvent extends Event{
	var cD:Int;
	
	public function new(type:String, cD:Int, bubbles:Bool = false, cancelable:Bool = false){
		super(type,bubbles,cancelable);
		this.cD = cD;
	}
	public override function clone ():GEvent {
		
		return new GEvent (type, cD, bubbles, cancelable);
		
	}
	
	
	public override function toString ():String {
		
		return "[CustomEvent type=\"" + type + "\" bubbles=" + bubbles + " cancelable=" + cancelable + " eventPhase=" + eventPhase + " customData=" + cD + "]";
		
	}
	
}