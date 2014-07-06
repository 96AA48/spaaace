import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Text;

class Score extends Entity {

	public function new() {
		super(0, 100);
		super(HXP.width, 30);

		name = "score";
		score = 0;
		scoreText = new Text("0", 0, 0, {size : 50});

		layer = -3;

		this.addGraphic(scoreText);

	}

	public function add(x:Int) {
		score += x;
		scoreText.text = score + "";
	}

	public function rem(x:Int) {
		if (score != 0) {
			score -= x;
			scoreText.text = score + "";
		}
	}

	public override function update() {
		scoreText.originX = this.originX = 100;
		
		super.update();
	}

	public var score:Int;
	private var scoreText:Text;

}