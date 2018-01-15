package jeu.ai;

using jeu.carte.*;
using jeu.events.*;

class Ai{
	//private static var temp:Array<Carte>;
	/**
		not checking the special cards
		mise
	*/
	public static function basic(mise:Array<Carte>, x:Array<Carte>):Bool{
		var check:Bool = false;

		if(!premiere(mise,x[0])){
			//check value
			//Inter
			//
		}
		
		return check;
	}
	private static function premiere(mise:Carte,x:Carte)return (x.couleur==mise.couleur||x.valeur==mise.valeur)

}