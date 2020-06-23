package fish;

import h2d.Scene;
import h2d.Object;
import h2d.Drawable;
import hxmath.math.Vector2;
import h2d.Drawable;
import h2d.Graphics;

class Fish {
	var velocity:Vector2;
	var g:Graphics;
	var location:Vector2;
	var s2d:Scene;

	public var flock(default, null):Flock;

	public function new(parent:Object, s2d:Scene, location:Vector2, r:Float) {
		this.s2d = s2d;

		var pointa:Vector2 = new Vector2(0, 0);
		var pointb:Vector2 = new Vector2(r/2, r);
		var pointc:Vector2 = new Vector2(0, 2*r);
		g = new h2d.Graphics(parent);

		g.beginFill(Std.int(0xFFFFFF * Math.random()), 1);
		// g.lineStyle(1, 0xFF00FF);
		//	g.drawCircle(0, 0, r);

		var graphics = g;

		graphics.moveTo(pointa.x, pointa.y);
		graphics.lineTo(pointb.x, pointb.y);
		graphics.lineTo(pointc.x, pointc.y);
		graphics.lineTo(pointa.x, pointa.y);
		g.endFill();

		this.location = location;

		flock = new Flock(location.x, location.y, s2d.width, s2d.height, r);
	}

	public function update(dt:Float) {
		location = flock.position;
		g.x = location.x;
        g.y = location.y;
        
        g.rotation=flock.velocity.angle;
	}
}
