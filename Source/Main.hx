package;


import openfl.Assets;
import openfl.display.Sprite;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.geom.Point;

import motion.Actuate;

using events;
using cartes;

class Main extends Sprite {
	
	//frame setting
	var GAME_WIDTH:Int = 800;
	var GAME_HEIGHT:Int = 480;

	//background vars
	var layer1:Sprite;//this layer will be support of all the background design
	var layer2:Sprite;//this layer will be support of the game and its aspects
		var sublayer1:Sprite;//main sublayer
		var sublayer2:Sprite;//hover sublayer
	var layer3:Sprite;//this layer will be support of all controls.

	var tapis_mise:Tapis;
	var tapis_pioche:Tapis;
	var tapis_j1:Tapis;
	var tapis_j2:Tapis;
	var tapis_j3:Tapis;
	var tapis_jp:Tapis;
	public static var dos:BitmapData;/**/
	
	var pioche:Paquet;
	var mise:Paquet;

	public function new () {
		
		super ();
		dos = Assets.getBitmapData("assets/dos.png");
		layer1 = new Sprite();this.addChild(layer1);
		layer2 = new Sprite();this.addChild(layer2);
			sublayer1 = new Sprite();layer2.addChild(sublayer1);
			sublayer2 = new Sprite();layer2.addChild(sublayer2);
		layer3 = new Sprite();this.addChild(layer3);
		pioche = new Paquet(1);
		mise = new Paquet(1);
		viewAll();
		//var p = new Paquet(3);
		//addChild(p);
	}
	/**
	 * function used before changing views 
	 */
	public function cleaningLayer(){
		for(i in 0...layer2.numChildren){layer2.removeChildAt(i);}
	}

	public function viewAll(){
		tapis_pioche = new Tapis(null,120,91);
			tapis_pioche.x = 7;
			tapis_pioche.y = 5;trace("tapis_pioche.x = "+tapis_pioche.x+"\n tapis_pioche.y = "+tapis_pioche.y);
				tapis_pioche.addChild(pioche);
				pioche.x = 5;
				pioche.y = 5;
		tapis_mise = new Tapis(null,153,91);
			tapis_mise.x = (GAME_WIDTH - tapis_mise.width)/2;
			tapis_mise.y = tapis_pioche.y+tapis_pioche.height+25; trace("tapis_mise.x = "+tapis_mise.x+"\ntapis_mise.y = "+tapis_mise.y);
				tapis_mise.addChild(mise);
				mise.x = 5;
				mise.y = 5;
		tapis_j1 = new Tapis(null,190,91);
			tapis_j1.x = (GAME_WIDTH - tapis_j1.width)/2;
			tapis_j1.y = tapis_pioche.y;trace("tapis_j1.x = "+tapis_j1.x+"\ntapis_j1.y = "+tapis_j1.y);
		tapis_j2 = new Tapis(null, 93,110);
			tapis_j2.x = 13;
			tapis_j2.y = tapis_mise.y -5;trace("tapis_j2.x = "+tapis_j2.x+"\ntapis_j2.y = "+tapis_j2.y);
		tapis_j3 = new Tapis(null, 93, 110);
			tapis_j3.x = GAME_WIDTH - 115;
			tapis_j3.y = tapis_j2.y;
		tapis_jp = new Tapis(null, 780,220);trace("tapis_j3.x = "+tapis_j3.x+"\ntapis_j3.y = "+tapis_j3.y);
			tapis_jp.x = (GAME_WIDTH - tapis_jp.width)/2;
			tapis_jp.y = 243;trace("tapis_jp.x = "+tapis_jp.x+"\ntapis_jp.y = "+tapis_jp.y);
		 sublayer1.addChild(tapis_pioche);
		 sublayer1.addChild(tapis_mise);
		 sublayer1.addChild(tapis_j1);
		 sublayer1.addChild(tapis_j2);
		 sublayer1.addChild(tapis_j3);
		 sublayer1.addChild(tapis_jp);
	}

	/*function distribution(p:Array<Carte>,j:Array<Dyanmic>){
		var max = j.length;
		var min = 0;
		var dir = 1;
		var nbr = max *4;
		var marqueur=0;
		for(i in 0...nbr){
			if(dir>0){
				if(marqueur > max) marqueur = min;
				j[marqueur].main.cartes.push(p.splice(p.length-1,1)[0]);
				j[marqueur].addLastCarte();
			}
			else if(dir<0){
				if(marqueur < min) marqueur = max;
				j[marqueur].main.cartes.push(p.splice(p.length-1,1)[0]);
				j[marqueur].addLastCarte();
			}
			marqueur+=dir;
		}
	}
	function donnerUneCarte(target:Int,j:Array<Dynamic>){
		function _q(){
			j[target].main.cartes.push(pioche.cartes.splice(pioche.cartes.length-1,1)[0]);
			j[target].addLastCarte();
		}
		Actuate.tween(pioche.cartes[pioche.cartes.length-1],0.3,{x:j[target].target.x, y:j[target].target.y}).onComplete(_q);
	}*/
	public static function getDos():BitmapData{
		return dos;
	}
	
	
}
class Tapis extends Sprite{
	function new(bd:BitmapData=null,w:Int=null,h:Int=null){
		super();
		if(bd==null) bd = new BitmapData(w,h,false,Math.floor(Math.random() * 0xffffff));
		var b:Bitmap = new Bitmap(bd,null,true);
		this.addChild(b);
		this.graphics.lineStyle(0.5,0);
		this.graphics.drawRect(-0.5,-0.5,b.width+1,b.height+1);
	}/**/
}
class Joueur{
	public var main:Paquet;
	public var target:Point;

	function new(type:Int=0){}
	public function addLastCarte(){
		main.addChild(main.cartes[main.cartes.length-1]);
	}
}