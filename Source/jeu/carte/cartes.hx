package jeu.carte;

import openfl.Assets;

import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.display.DisplayObjectContainer;
import openfl.display.PixelSnapping;
import openfl.display.Shape;
import openfl.display.Sprite;

import openfl.events.MouseEvent;

import openfl.geom.Rectangle;

import common.Common;

/** Carte
	decendante de la super classe @Sprite, la classe defini l'object carte qui sera utiliser pour le jeu
	les cartes ont les proprietes:
	@Width la largeur de la carte en type Int
	@Height la hauteur de la carte en type Int
	@color la couleur de la carte defini par l'enum @Color
	@type le type de carte defini par l'enum @TypeOfCards
	@value la valeur de la carte en type Int allant de 1 a 13, AS==1, Jack==11, Queen==12, King==13, Joker==-1
	@face l'image de face
	@dos l'image de dos
	@rec le rectangle en type Rectangle limitant la zone de deplacement de la carte
	@pos
**/
class Carte extends Sprite{
	private var Width:Int;
	private var Height:Int;
	public var color:Color;
	public var type:TypeOfCards;
	public var value(get,null):Int;
	private var face:Bitmap;
	private var dos:Bitmap;
	private var rect:Rectangle;
	@:isVar
	private var pos(get,set):Pos;

	public function new(color:Color, valeur:Int){
		
		super();
		
		face = new Bitmap(Assets.getBitmapData( "assets/3x/" + color.getName().toLowerCase() +
			valeur + ".png" ), PixelSnapping.AUTO, true);
		face.width = 55;
		face.height = 81;
		dos = new Bitmap( Assets.getBitmapData("assets/3x/dos.png"), PixelSnapping.AUTO, true);
		this.color = color;
		this.value = (color.equals(Color.Joker))? -1:valeur;
		addChild(face);
	}	
	public function set_pos(x:Pos){
		return pos=x;
	}
	public function get_pos():Pos{
		return pos;
	}
	public function get_value():Int{
		return value;
	}
	public function dragIn(r:Rectangle){
		swapRect(r);
		this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown, false);
		this.addEventListener(MouseEvent.MOUSE_UP, mouseUp, false);
		this.addEventListener(MouseEvent.MOUSE_OUT, mouseUp, false);
	}
	public function swapRect(r:Rectangle){
		rect = r;
	}
	function mouseDown(e:MouseEvent){
		startDrag(false,rect);
		this.parent.setChildIndex(this,this.parent.numChildren-1);
		this.scaleX = this.scaleY = 1.5;
	}
	function mouseUp(e:MouseEvent){
		stopDrag();
		this.scaleX = this.scaleY = 1;
	}
}
enum Color {
	Carreau;
	Coeur;
	Pique;
	Trefle;
	Joker;
}
enum TypeOfCards {
	Normal;
	Super;
	Joker;
	Inter;
}
typedef Pos={
	public var x:Float;
	public var y:Float;
}

class Paquet extends Sprite{
	public var cartes:Array<Carte>;
	//public var parent:DisplayObjectContainer;

	public function new(type:Int=0/*, parent:DisplayObjectContainer*/){
		
		//this.parent = parent;
		super();
		cartes = (type==0)? []: loadCartes();
		
		if(type==3){
			for(i in 0...cartes.length){
				cartes[i].x = cartes[i].width * (i%13);
				cartes[i].y = cartes[i].height * Math.floor(i/13);
				/*parent.*/addChild(cartes[i]);
			}
		}
		else if(type==1){ for(i in 0...cartes.length) addChild(cartes[i]);}
	}
	/*public function addCarte(x:Carte) parent.addChild(x);
	public function removeCarte(x:Carte){
	 	parent.removeChild(x);
	 	cartes.remove(x);
	}*/

	/** loadCartes
		la fonction qui genere l'array de cartes
		a utiliser que la premiere fois lors de l'initiation de la @pioche
	**/
	private function loadCartes():Array<Carte>{
		var arr = [];
		
		for (i in 1...14){
			arr.push(new Carte(Color.Carreau,i));
			arr.push(new Carte(Color.Coeur,  i));
			arr.push(new Carte(Color.Pique,  i));
			arr.push(new Carte(Color.Trefle, i));
		}
		arr.push(new Carte(Joker,1));
		arr.push(new Carte(Joker,2));
		return arr;
	}
	/** aleatoire
	    la fonction qui va reclasser les cartes de maniere aleatoire
		a la fois dans l'array de cartes et dans la display list
	**/
	public function aleatoire(){
		var t:Carte = null;
		var j:Int = 0;
		for(i in 0...cartes.length){
			j = Common.entierAleatoir(0,cartes.length-1);
			t = cartes[i];
			cartes[i] = cartes[j];
			cartes[j] = t;
		}

		for(i in 0...cartes.length) this.setChildIndex(cartes[i],i);
	}
	/** _aletoire
		pareille que la fonction aleatoire, a la difference que les cartes
		sont placees sous forme d'un tableau.
	**/
	public function _aleatoire(){
		var t:Carte = null;
		var j:Int = 0;
		for(i in 0...cartes.length){
			j = Common.entierAleatoir(0,cartes.length-1);
			t = cartes[i];
			cartes[i] = cartes[j];
			cartes[j] = t;
		}

		for(i in 0...cartes.length){
			this.setChildIndex(cartes[i],i);
			cartes[i].x = cartes[i].width * (i%13) * 0.85;
			cartes[i].y = cartes[i].height * Math.floor(i/13) * 0.85;	
		}
	}
	//function entierAleatoir(a:Int,b:Int):Int{ return a + Math.round(( b - a ) * Math.random()); }
	public function ToString():String{
		return "cartes.length: "+cartes.length+"\n\tdisObj.length: "+this.numChildren;
	}
}