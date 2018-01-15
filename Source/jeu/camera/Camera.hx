package jeu.camera;

import openfl.display.Sprite;
import openfl.geom.Rectangle;
import openfl.display.SimpleButton;

import jeu.carte.*;
import jeu.events.*;

class Camera extends Sprite{

	//Camera ID
	var type:String;

	//Key variables Display objects
	var pioche:Pioche;
	var mise:Mise;
	var tapis:Array<Sprite>;
	var opt:SimpleButton;
	var snd:SimpleButton;
	var passTurn:SimpleButton;
	var switchView:SimpleButton;

	//logic variables
	var gd:Dynamic;//gd stands for game data, the data of the game that will be shown
	var rect:Rectangle;
	//var rectPlayer:Rectangle; //the utility of these 
	//var rectMise:Rectangle;   //two is still debatable

	//event related variables


	function new(opt:Dynamic){
		super();
		//initialisation
			//pioche
			pioche = new Pioche(0,0);
			
			//tapis
		for (i in 0...opt.players.length){ tapis[i] = new Sprite();}

		//event handler for change in game data
		//event handler for some other stuffs i'll think about after
	}
	public function update(gd:Dynamic){
		//execute the changes
	}
}