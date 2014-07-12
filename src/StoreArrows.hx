import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Touch;

import StoreItem;

class StoreArrows extends Entity {

	public function new(x:Float, y:Float, type:Int) {
		super(x - 230, y);
		which = type;

		arrowLeft = new Image("graphics/fire05.png");
		arrowLeft.angle = 90;
		arrowLeft.x -= 100;
		arrowLeft.centerOrigin();

		arrowRight = new Image("graphics/fire05.png");
		arrowRight.angle = -90;
		arrowRight.x += 100;
		arrowRight.centerOrigin();

		setHitbox(250, 100);

		this.centerOrigin();

		this.addGraphic(arrowLeft);
		this.addGraphic(arrowRight);
	}

	public override function update() {
		super.update();

		if (Input.mouseReleased) {
			var storeItems:Array<StoreItem> = [];
			this.scene.getClass(StoreItem, storeItems);

			if (Input.mouseY > this.top && Input.mouseY < this.bottom) {
				if (Input.mouseX > this.left && Input.mouseX < this.left + 100) {
					storeItems[which].goLeft();
				}
				if (Input.mouseX < this.right && Input.mouseX > this.right - 100) {
					storeItems[which].goRight();	
				}
			}
		}

		Input.touchPoints(onTouch);

	}

	private function onTouch(touch:Touch) {
		var storeItems:Array<StoreItem> = [];
		this.scene.getClass(StoreItem, storeItems);

		if (touch.y > this.top && touch.y < this.bottom) {
			if (touch.x > this.left && touch.x < this.left + 100) {
				storeItems[which].goLeft();
			}
			if (touch.x < this.right && touch.x > this.right - 100) {
				storeItems[which].goRight();	
			}
		}
	}

	private var arrowLeft:Image;
	private var arrowRight:Image;
	private var which:Int;
}