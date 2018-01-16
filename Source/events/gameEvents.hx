package events;

import openfl.events.Event;
import openfl.display.DisplayObjectContainer;
class GameEvents extends Event{ 
	public static inline var GAME_STATE_CHANGE_EVENT = "gameStateChangeEvent"; 
	public var gameData:Dynamic;
	public function new(type:String, gameData:Dynamic, bubbles:Bool = false, cancelable:Bool = false){
		super(type, bubbles, cancelable);
		this.gameData = gameData;
	}
	public override function clone():GameEvents{ return new GameEvents(type, gameData, bubbles, cancelable);}
	public override function toString():String{return "[GameEvent type=\"" + type + "\" bubbles=" + bubbles + " cancelable=" + cancelable + " eventPhase=" + eventPhase + " gameData=" + gameData + "]";}
}

class GameStartEvent extends Event{ 
	public var parent(get,null):DisplayObjectContainer;
	public function new(type:String, parent:DisplayObjectContainer, bubbles:Bool = false, cancelable:Bool = false){
		super(type, bubbles, cancelable);
		this.parent = parent;
	}
	function get_parent():DisplayObjectContainer{return parent;}
	public override function clone():GameStartEvent{ return new GameStartEvent(type, parent, bubbles, cancelable);}
	public override function toString():String{return "[GameEvent type=\"" + type + "\" bubbles=" + bubbles + " cancelable=" + cancelable + " eventPhase=" + eventPhase + " parent=" + parent + "]";}
}