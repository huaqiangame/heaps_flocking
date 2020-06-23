package fish;

import haxe.Timer;
import h2d.Scene;
import h2d.Object;
import h2d.Drawable;
import hxmath.math.Vector2;
import h2d.Drawable;
import h2d.Graphics;

class Fish {
	var acceleration:Vector2;
	var velocity:Vector2;
	var g:Graphics;
	var location:Vector2;

	var s2d:Scene;
	var g2:Graphics;

	public var flock(default, null):Flock;

	var location2:Vector2;
	var lastLocation:Vector2 = Vector2.zero;

	/**
	 * [Description]
	 * @param parent
	 * @param s2d
	 * @param location
	 * @param r
	 * @param useServer  是否用服务器模拟
	 */
	public function new(parent:Object, s2d:Scene, location:Vector2, r:Float, useServer:Bool = false) {
		this.s2d = s2d;
		acceleration = Vector2.zero;
		velocity = Vector2.zero;
		var color = Std.int(0xFFFFFF * Math.random());
		var pointa:Vector2 = new Vector2(0, 0);
		var pointb:Vector2 = new Vector2(r / 2, r);
		var pointc:Vector2 = new Vector2(0, 2 * r);
		g = new h2d.Graphics(parent);

		g.beginFill(color, 0.2);
		// g.lineStyle(1, 0xFF00FF);
		//	g.drawCircle(0, 0, r);

		var graphics = g;

		graphics.moveTo(pointa.x, pointa.y);
		graphics.lineTo(pointb.x, pointb.y);
		graphics.lineTo(pointc.x, pointc.y);
		graphics.lineTo(pointa.x, pointa.y);
		g.endFill();

		g2 = new h2d.Graphics(parent);

		g2.beginFill(color, 0.5);
		// g.lineStyle(1, 0xFF00FF);
		//	g.drawCircle(0, 0, r);

		graphics = g2;

		graphics.moveTo(pointa.x, pointa.y);
		graphics.lineTo(pointb.x, pointb.y);
		graphics.lineTo(pointc.x, pointc.y);
		graphics.lineTo(pointa.x, pointa.y);
		g2.endFill();
		this.location2 = this.location = location;
		flock = new Flock(location.x, location.y, s2d.width, s2d.height, r);
	}

	var temp:Float = 0;

	public function update(dt:Float) {
		if (flock != null) {
			location = flock.position;
			g.x = location.x;
			g.y = location.y;

			g.rotation = flock.velocity.angle;
		}
		temp += dt;

		if (temp >= 0.2) { // 这里模拟了服务器发送数据。
			tween(location);
			temp = 0;
		}

		update2(dt);
	}

	/**
	 * 模拟服务器发送，然后返回还原。
	 * @param dt
	 */
	public function update2(dt:Float) {
		if (velocity * acceleration > 0) { // 加速度和前进向量一定要同方向。
			velocity += acceleration;

			location2 += velocity;

			lastLocation = location;

			g2.x = location2.x;
			g2.y = location2.y;

			g2.rotation = velocity.angle;
			calcAcc(dt);
		} else {
            // trace('fuck');
            acceleration=Vector2.zero;
           // velocity=Vector2.zero;
		}
		// if(location-location)
	}

	var lastTime:Float = 0;
	var targetPos:Vector2;

	/**
	 * 服务器发过来的快照
	 * @param p
	 * @param v
	 */
	public function tween(p:Vector2) {
		var force = p - location2;

		if (force.length > 45 || Date.now().getTime() - lastTime > 1000 || force.length <= 2) {
			location2 = p;
			lastLocation = p;
			lastTime = Date.now().getTime();
			targetPos = p;
			velocity = force.normal;
			return;
		}

		var speed:Float = 0;
		if (targetPos != null) {
			var now = Date.now().getTime();
			var diff = p - targetPos;
			var diffLen = diff.length;
			var diffTime = now - lastTime;

			// trace(diffLen/diffTime);
			speed = diffLen / diffTime;
		}
		targetPos = p;

		acceleration = force.normal / 3;

		// trace(Date.now().getTime()-lastTime,force.length);

		velocity = force.normalizeTo(1.5);
		// trace(velocity.length,speed,acceleration.length);

		lastTime = Date.now().getTime();
	}

	function calcAcc(dt:Float) {
		if (targetPos != null && location2 != null) {
			acceleration *= 0.1;
		}
	}
}
