package jeu.carte;
import openfl.display.Sprite;
import openfl.display.Shape;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.display.PixelSnapping;
import openfl.display.DisplayObjectContainer;
import openfl.Assets;

class Carte extends Sprite{
	private var Width:Int;
	private var Height:Int;
	public var color:Color;
	public var type:TypeOfCards;
	public var value(get,null):Int;
	private var face:Bitmap;
	private var dos:Bitmap;
	@:isVar
	private var pos(get,set):Pos;

	public function new(color:Color, valeur:Int){
		
		super();
		
		face = new Bitmap(Assets.getBitmapData( "assets/" + color.getName().toLowerCase() +
			valeur + ".png" ), PixelSnapping.AUTO, true);
		
		dos = new Bitmap( Main.getDos(), PixelSnapping.AUTO, true);
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
	public function addCarte(x:Carte) parent.addChild(x);
	public function removeCarte(x:Carte){
	 	/*parent.*/removeChild(x);
	 	cartes.remove(x);
	}

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
}