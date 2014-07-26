import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Touch;

import StoreItem;

class StoreArrows extends Entity {

	public function new(x:Float, y:Float, z:Int) {
		super(x - 230, y);
		which = z;
		if (z != 4)
			currentItem = 1;
		else 
			currentItem = 0;

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

		var storeItems:Array<StoreItem> = [];
		this.scene.getClass(StoreItem, storeItems);

		if (currentItem == 0) 
			arrowLeft.visible = false;
		else 
			arrowLeft.visible = true;

		if (currentItem == storeItems[which].items[which].length - 1) 
			arrowRight.visible = false;
		else
			arrowRight.visible = true;

		if (Input.mouseReleased) {
			if (Input.mouseY > this.top && Input.mouseY < this.bottom) {
				if (Input.mouseX > this.left && Input.mouseX < this.left + 100) {
					storeItems[(storeItems.length - 1) - which].goLeft();
					if (currentItem != 0) currentItem--;
				}
				if (Input.mouseX < this.right && Input.mouseX > this.right - 100) {
					storeItems[(storeItems.length - 1) - which].goRight();
					if (currentItem != storeItems[which].items[which].length - 1) currentItem++;
				}
			}
		}

	}

	private var arrowLeft:Image;
	private var arrowRight:Image;
	private var which:Int;
	private var currentItem:Int;
}