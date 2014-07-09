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

class MainScene extends Scene
{
	public override function begin()
	{
		backdrop = new Backdrop("graphics/darkPurple.png", true, true);
		var player = new Player();	
		var button = new Button();
		var spawner = new Spawner();
		var enemy = new Enemy(-160, 0);
		var lives = new Lives();
		var score = new Score();
		var boss = new Boss();

		#if flash
			music = new Sfx("audio/loop.mp3");
		#else
			music = new Sfx("audio/loop.wav");
		#end


		addGraphic(backdrop);

		#if (android || ios)
			add(button);
		#end

		add(boss);
		add(player);
		add(lives);
		add(score);
		add(spawner);
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