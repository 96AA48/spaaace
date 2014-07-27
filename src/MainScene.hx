import com.haxepunk.Scene;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Backdrop;
import com.haxepunk.Sfx;

import Spawner;
import Player;
import Button;
import Enemy;
import Lives;
import Score;
import Overlay;
import Save;

class MainScene extends Scene
{
	public override function begin()
	{
		backdrop = new Backdrop("graphics/darkPurple.png", true, true);
		var player = new Player();	
		var button = new Button();
		var spawner = new Spawner();
		var lives = new Lives();
		var score = new Score();

		#if flash
			music = new Sfx("audio/loop.mp3");
		#else
			music = new Sfx("audio/loop.wav");
		#end


		addGraphic(backdrop);

		#if (android || ios)
			add(button);
		#end

		add(player);
		add(lives);
		add(score);
		add(spawner);
		if (Save.load().overlay)
			add(new Overlay());

		music.play(.1, 0, true);
	}

	public override function end() {
		this.removeAll();
		music.stop();
		this.update();
	}

	public override function update() {
		super.update();
		backdrop.y += 1;
	}

	private var backdrop:Backdrop;
	private var music:Sfx;
}