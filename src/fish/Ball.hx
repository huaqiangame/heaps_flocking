package fish;

import h2d.Scene;
import h2d.Object;
import h2d.Drawable;
import hxmath.math.Vector2;
import h2d.Drawable;
import h2d.Graphics;
class Ball {
    var velocity:Vector2;
	var g:Graphics;
    var location:Vector2;
    var s2d:Scene;
    public function new(parent:Object,s2d:Scene,location:Vector2,velocity:Vector2) {
        
        this.s2d=s2d;
        g = new h2d.Graphics(parent);

		g.beginFill(Std.int(0xFFFFFF*Math.random()), 0.3);
		g.lineStyle(1, 0xFF00FF);
		g.drawCircle(0, 0, 30);
		g.endFill();

		// g.x=300;
		//  g.y=300;

		//location = new Vector2(100, 100);

        //velocity = new Vector2(1.5, 2.1);
        
        this.location=location;
        this.velocity=velocity;
    }
    public function update(dt:Float) {
		location += velocity;
		if ((location.x > s2d.width - 30) || (location.x < 30)) {
			velocity.x = velocity.x * -1;
		}
		if (location.y > s2d.height - 30 || location.y < 30) {
			// We're reducing velocity ever so slightly
			// when it hits the bottom of the window
			velocity.y = velocity.y * -1;
			// location.y = height;
		}

		g.x = location.x;
		g.y = location.y;
	}
}