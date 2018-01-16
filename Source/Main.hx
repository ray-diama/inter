package;

import openfl.display.DisplayObjectContainer;
import openfl.display.Sprite;
import openfl.geom.Rectangle;
import openfl.geom.Point;

using jeu.carte.cartes;

class Main extends Sprite {
	
	var pioche:Element;
	var mise:Element;
	var npc:Joueur;
	var player:Humain;
	public function new () {
		
		super ();
		pioche = new Element(this);
		pioche.aleatoire();
		mise = new Element(this,0);
		npc:Joueur = new Joueur(this,1);
		player:Humain = new Humain(this);
		distribut(pioche.main.cartes,mise,[npc,player]);
	}

	function distribut(p:Array<Carte>,m:Element,js:Array<Joueur>, marqueur:Int=0){
		var totalCarte:Int = 4 * js.length;
		var mar:Int = marqueur;
		var min:Int = 0;
		var max:Int = js.length-1;
		var dir:Int = 1;
		for(i in 0...totalCarte){
			if(dir==1){
				if(mar>max) mar = min;
			}
			else if(dir==-1){
				if(mar<min) mar = max;
			}
			else{
				trace("il y a eu une erreur avec dir = "+dir);
			}
			js[mar].main.cartes.push(p.splice(p.length-1,1)[0]);
			js[mar].addLastCarte();
			mar+=dir;
		}
		m.main.cartes.push(p.splice(p.length-1,1)[0]);
		m.addLastCarte();
		//trigger start
		for(j in js)j.mainToString();
	}

	function pickUpCards(e:GameEvents){
		var n:Int = cast e.gameData; //number of cards to pick up

	}
}

class Element{
	public var tapis:Sprite;//a remplacer avec un bitmap, mais pour l'instant est le conteneur des cartes
	public var main:Paquet;
	public var target:Point;
	var parent:DisplayObjectContainer;
	
	public function new(parent:DisplayObjectContainer, position:Int=-1){
		this.parent = parent;

		tapis = new Sprite();
		this.parent.addChild(tapis);
		main = (position==-1)? new Paquet(1):new Paquet();
			
		if(position==-1){
			tapis.x = 7; 
			tapis.y = 5;
			tapis.graphics.lineStyle(0.5,0);
			tapis.graphics.beginFill(Math.floor(Math.random()* 0xffffff));
			tapis.graphics.drawRect(0,0,120,91);
			target = new Point(5,5);
			for (i in main.cartes){ i.x = target.x; i.y = target.y;}
		}
		else if(position == 0){
			tapis.x = 322.75;
			tapis.y = 122.5;
			tapis.graphics.lineStyle(0.5,0);
			tapis.graphics.beginFill(Math.floor(Math.random()* 0xffffff));
			tapis.graphics.drawRect(0,0,153, 91);
			target = new Point(49,5);
		}
		tapis.addChild(main);
	}
	public function aleatoire() main.aleatoire();
	public function addLastCarte(){
		main.cartes[main.cartes.length-1].x = target.x;
		main.cartes[main.cartes.length-1].y = target.y;
		main.addChild(main.cartes[main.cartes.length-1]);
	}
	public function toString():String{
		return "target: ("+target.x+","+target.y+");\nmain- array.length: "+main.cartes.length
				+"\n\tdisObj.length: "+main.numChildren;
	}
	public function destroy(){}

}
/**
	la classe joueur detient les elements utile pour un
	participant de la partie.
	presentement un joueur n'est pas un sprite.
	la construction d'un objet de la classe demande de faire appel
	a un object contenaire et une position
*/
class Joueur extends Element{
	public var position:Int;/**/
	
	/**
		les position possible sont:
		1 - pour placer un joueur en haut
		2 - pour placer un joueur a gauche
		3 - pour placer un joueur a droite
		4 - pour le joueur qui sera un etre humain
	*/
	public function new(parent:DisplayObjectContainer, position:Int){
		super(parent,position);
		
		this.position = position;
		
		switch(position){
			case 1 : tapis_1(); main.mouseEnabled=false;
			case 2 : tapis_2(); main.mouseEnabled=false;
			case 3 : tapis_3(); main.mouseEnabled=false;
			case 4 : tapis_4();
		}
	}
	
	var __c:Carte;
	var _as:Array<Int> =[];
	var _2:Array<Int> =[];
	var _10:Array<Int> =[];
	var _j:Array<Int> =[];
	var _joker:Array<Int>=[];
	var _8:Array<Int>=[];
	var _normal:Array<Int>=[];
	var choix:Array<Int>;
	var __choix:Array<Int>;//a utiliser quand je trouverai l'algo pour plusieur cartes
	var pasTrouver:Int=0;

	/**
		cette fonction est faite pour que l'ordi puisse jouer.
		le placement de carte est faite de la sorte:
		- reperer les cartes qui convienne
		- regarder parmis sa main de carte quel enchainement le plus long peut etre fait
	*/
	public function play(?m:Element){}

	public function regarderMain(m:Element=null){
		if(m!=null){
			__c = m.main.cartes[m.main.cartes.length-1];
			choix=[];
			//reperer les cartes qui convienne
			///*erreur a oublier*/for(i in 0...main.cartes.length-1){if(main.cartes[i].value == __c.value){if(choix.indexOf(i)==-1)choix.push(i);}if(main.cartes[i].couleur == __c.couleur){if(choix.indexOf(i)==-1)choix.push(i);}}
			var i=0;
			while(i<main.cartes.length-1){
				if(main.cartes[i].value == __c.value)
					{if(choix.indexOf(i)==-1)choix.push(i);}
				if(main.cartes[i].couleur == __c.couleur)
					{if(choix.indexOf(i)==-1)choix.push(i);}
				if(main.cartes[i].value == 8){
					if(choix.indexOf(i)==-1)choix.push(i);
				}
				if(main.cartes[i].value ==-1) //-1 pour les joker
					{if(choix.indexOf(i)==-1)choix.push(i);}
				i++;
			}
			switch (choix.length) {
				case 0: 
					if(pasTrouver ==0 )
						{trace("pas trouver trigger fetch"); pasTrouver++;}
					else{trace("tjrs pas trouver tigger next"); __c=null;pasTrouver=0;}
				case 1: trace("qu'une carte");
						handCards(choix);
				default:trace("multiple choices");
						makingSelection(false);
			}
		}
		else trace("something happened in class Joueur function regarderMain - Element m is null");
	}
	function makingSelection(complex:Bool=false){
		/* demanière réclusive, si ce n'est pas une sélection,
		on ne peut pas prendre des cartes de même couleur sauf pénalité
		en d'autre termes dans sa main, sauf en cas de 2 ou 10, les joueurs
		ne peuvent pas suivre deux cartesyoutub de même couleur



		petite idée limitation de plusieurs AS à la fois
		*/
		if(complex){
			//in here we will make the choice of the longest selection of cards
			
			break;}
		else{
			//randomingly choosing a card number
			handCards([Math.floor(choix.length * Math.random())]);
		}
	}
	//handing just a card for now but will eventually hand in multiple cards
	function handCards(ids:Array<Int>){
		for(i in 0...ids.length-1){
			main.cartes[ids[i]];
		}
	}
	public override function addLastCarte(){
		main.cartes[main.cartes.length-1].x = target.x+((main.cartes.length-1)*55);
		main.cartes[main.cartes.length-1].y = target.y;
		main.addChild(main.cartes[main.cartes.length-1]);
		checkCarte(main.cartes.length-1);
	}
	function checkMain(){
		_as=[];_2=[];_10=[];_j=[];_joker=[];_8 = [];_normal=[];
		for(i in 0...main.cartes.length-1) checkCarte(i);
	}
	function checkCarte(id:Int){
		switch (main.cartes[id].value) {
			case 1: _as.push(id);
			case 2: _2.push(id);
			case 10: _10.push(id);
			case 11: _j.push(id);
			case -1: _joker.push(id);
			case 8: _8.push(id);
			default: _normal.push(id);
		}
	}

	function tapis_1(){
		tapis.x = 304.25;
		tapis.y = 5;
		tapis.graphics.lineStyle(0.5,0);
		tapis.graphics.beginFill(Math.floor(Math.random() * 0xffffff));
		tapis.graphics.drawRect(0,0,190,91);
		target = new Point(67.5,5);
	}
	function tapis_2(){
		tapis.x = 13;
		tapis.y = 117.5;
		tapis.graphics.lineStyle(0.5,0);
		tapis.graphics.beginFill(Math.floor(Math.random() * 0xffffff));
		tapis.graphics.drawRect(0,0,93,110);
		target = new Point(19, 14.5);
	}
	function tapis_3(){
		tapis.x = 685;
		tapis.y = 117.5;
		tapis.graphics.lineStyle(0.5,0);
		tapis.graphics.beginFill(Math.floor(Math.random() * 0xffffff));
		tapis.graphics.drawRect(0,0,93,110);
		target = new Point(19,14.5);
	}
	function tapis_4(){
		tapis.x = 9.25;
		tapis.y = 243;
		tapis.graphics.lineStyle(0.5,0);
		tapis.graphics.beginFill(Math.floor(Math.random() * 0xffffff));
		tapis.graphics.drawRect(0,0,780,220);
		target = new Point(5,5);
	}
	public function mainToString(){
		trace("_as: "+_as.length);
		trace("_2: "+_2.length);
		trace("_10: "+_10.length);
		trace("_j: "+_j.length);
		trace("_joker: "+_joker.length);
		trace("_8: "+_8.length);
		trace("_normal: "+_normal.length);
	}
	public override function toString():String{
		return "position: "+position+"; target: ("+target.x+","+target.y+
			   ");\nmain- array.length: "+main.cartes.length+"\n\tdisObj.length: "+main.numChildren;
	}
	public override function destroy(){}
}
class Humain extends Joueur{
	
	var areaRangement:Rectangle;
	var areaPlayable:Rectangle;
	var areaDepot:Rectangle;
	var col:Int=0;
	var row:Int=0;
	var carteScale:Float = 1.5;
	var carteSize:PPoint = {x:55,y:81};
	var turnOn:Bool;

	public function new(parent:DisplayObjectContainer){
		super(parent,4);
		areaRangement = new Rectangle(0,0,tapis.width-Math.round(carteSize.x * carteScale),
				tapis.height-Math.round(carteSize.y * carteScale));
		areaPlayable = new Rectangle(0,-121,tapis.width-Math.round(carteSize.x * carteScale),
				341-Math.round(carteSize.y * carteScale));
		areaDepot = new Rectangle(0,-121,tapis.width-Math.round(carteSize.x * carteScale),
				121-Math.round(carteSize.y * 0.25));
		turnOn = false;
		
		tapis.addEventListener(openfl.events.MouseEvent.MOUSE_UP,function(e:openfl.events.MouseEvent){
			if(Std.is(e.target,Carte)){
				var c:Carte = cast e.target;
				if(areaDepot.contains(c.x,c.y)){ 
					turnOn =false;
					//trigger depot
				}
				trace((areaDepot.contains(c.x,c.y))?"dans la zone de depot":"hors zone depot");	
			} 
			else trace("pas la carte");
		});
	}
	public override function addLastCarte(){
		col=0;
		for(i in main.cartes){
			if(i.y == target.y)col++;
		}
		//main.cartes[main.cartes.length-1].x =(main.cartes.length>1)?target.x+ (0.5*col*main.cartes[0].width):target.x;
		//si ca cree des lags, on va le suprimer de sa place respective et le mettre dans 
		main.addChild(main.cartes[main.cartes.length-1]);
		main.cartes[main.cartes.length-1].x = target.x+ (col*main.cartes[0].width);
		main.cartes[main.cartes.length-1].y = target.y;
		main.cartes[main.cartes.length-1].dragIn(areaPlayable);
		
		checkCarte(main.cartes.length-1);

	}
	public override function play(m:Element=null){
		turnOn = true;
		for (i in main.cartes) i.swapRect(areaPlayable);
	}
	public override function destroy(){}

}
typedef PPoint = {
	var x:Int;
	var y:Int;
}
/*
Main.hx:64: tapis_pioche.x = 7
 tapis_pioche.y = 5
Main.hx:70: tapis_mise.x = 322.75
tapis_mise.y = 122.5

tapis_j1.x = 304.25
tapis_j1.y = 5

tapis_j2.x = 13
tapis_j2.y = 117.5

tapis_j3.x = 685
tapis_j3.y = 117.5

tapis_jp.x = 9.25
tapis_jp.y = 243
*/