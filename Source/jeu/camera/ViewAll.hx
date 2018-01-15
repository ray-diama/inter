package jeu.camera;
import jeu.carte.Mise;
import jeu.carte.Pioche;

class ViewAll extends Camera{
	public function new(){
		super();
		mise = new Mise((Jeu.Width*0.5),140);
	}
}