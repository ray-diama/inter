package events;

import openfl.events.Event;
import openfl.display.DisplayObjectContainer;
class GameEvents extends Event{ 
	//Game state events
	public static inline var GAME_INIT_EVENT   = "gameInit"; 
	public static inline var GAME_START_EVENT  = "gameStart"; 
	public static inline var GAME_PAUSE_EVENT  = "gamePause"; 
	public static inline var GAME_END_EVENT    = "gameEnd"; 
	public static inline var GAME_RELOAD_EVENT = "gameReload"; 
	public static inline var GAME_OVER_EVENT   = "gameOver";
	//Ingame events
	public static inline var INGAME_PLAY_EVENT = "IngamePlay";
	public static inline var INGAME_CARD_CHECK_EVENT = "IngameCardCheck";
	public static inline var INGAME_CARDS_PLAYED_EVENT = "IngameCardsPlayed";
	public static inline var INGAME_CARDS_MISPLAYED_EVENT = "IngameCardsMisplayed";
	public static inline var INGAME_DIRECTION_CHANGE_EVENT = "IngameDirectionChange";
	public static inline var INGAME_MARKER_ROTATION_EVENT = "IngameMarkerRotation";
	public static inline var INGAME_MARKER_TIMER_EVENT = "IngameMarkerTimer";
	public static inline var INGAME_MARKER_TIMER_EXTRA_TIME_EVENT = "IngameMarkerTimerExtraTime";
	public static inline var INGAME_PICKUP_CARD_EVENT = "IngamePickupCard";
	public static inline var INGAME_PICKUP_PUNISHMENT_EVENT = "IngamePickupPunishment";
	public static inline var INGAME_REFILL_PIOCHE_EVENT = "IngameRefillPioche";
	public static inline var INGAME_2CARDS_LEFT_EVENT = "Ingame2cardsLeft";
	

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