import com.haxepunk.Scene;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Backdrop;

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
		var enemy = new Enemy(160, 0);
		var lives = new Lives();
		var score = new Score();

		addGraphic(backdrop);

		#if (android || ios)
			add(button);
		#end

		add(player);
		add(lives);
		add(score);
		add(spawner);
		
	}

	public override function update() {
		super.update();
		backdrop.y += 1;
	}

	private var backdrop:Backdrop;
}