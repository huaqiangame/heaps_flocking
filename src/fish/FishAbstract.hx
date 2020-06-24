package fish;

import server.IUpdate;
import hxmath.math.Vector2;

/**
 * 这个用于抽象客户端，可以绑定不同引擎
 */
class FishAbstract implements IUpdate {
	var location2:Vector2;
	var temp:Float = 0;
	var lastTime:Float = 0;
	var targetPos:Vector2;

	public var flockSeek(default, default):Flock;
	public var flock(default, default):Flock;

	var location:Vector2;

	public function new(location:Vector2, r:Float, width:Int, height:Int) {
		this.location2 = this.location = location;
	
		flockSeek = new Flock(location.x, location.y, width, height, r);
    	createRender(r);
    }

	public function createRender(r:Float) {}

	/**
	 * 这里同步实体坐标
	 */
	function syncLocation() {
		// g.x = location.x;
		// g.y = location.y;

		// g.rotation = flock.velocity.angle;
	}

	/**
	 * 这里同步模拟坐标
	 */
	function syncShadowLocation(dir:Vector2) {
		// g2.x = location2.x;
		// g2.y = location2.y;

		// g2.rotation = dir.angle; // what the fuck. 百分百同步了
	}

	public function update(dt:Float) {
		if (flock != null) {
			location = flock.position;
			// g.x = location.x; //这里在子类继承并赋值
			// g.y = location.y;

			// g.rotation = flock.velocity.angle;
			syncLocation();
		}
		temp += dt;

		if (temp >= Random.float(0.2, 2)) { // 这里模拟了服务器发送数据。
			tween(location);
			temp = 0;
		}

		update2(dt);
	}

	public function tween(p:Vector2) {
		targetPos = p;
	}

	/**
	 * 模拟服务器发送，然后返回还原。
	 * @param dt
	 */
	public function update2(dt:Float) {
		if (flockSeek != null && targetPos != null) {
			var dir = targetPos - location2;
			flockSeek.track(targetPos, dir);

			dir = flock.position - location2;
			location2 = flock.position;

			syncShadowLocation(dir);
		}
	}
}
