import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Text;

import openfl.Assets;

import Save;

class Score extends Entity {

	public function new() {
		super(HXP.halfWidth, 30);

		name = "score";
		score = Save.load().money;
		scoreText = new Text("$" + score, 0, 0, 0, 0, {size : 50, align : "center", color : 0xFFF000});
		scoreText.font = Assets.getFont("font/kenpixel_mini_square.ttf").fontName;

		layer = -6;

		this.addGraphic(scoreText);
	}

	public function add(x:Int) {
		score += x;
		#if debug score += 10000; #end
		scoreText.text = "$" + score;
	}

	public function rem(x:Int) {
		if (score != 0) {
			score -= x;
			scoreText.text = "$" + score;
		}
		if (score < 0) {
			score = 0;
			scoreText.text = "$" + score;
		}
	}

	public override function update() {
		scoreText.centerOrigin();
		this.centerOrigin();
		
		super.update();
	}

	public var score:Int;
	private var scoreText:Text;

}