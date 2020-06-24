package fish;

import server.IUpdate;
import h2d.Text;
import haxe.Timer;
import h2d.Scene;
import h2d.Object;
import h2d.Drawable;
import hxmath.math.Vector2;
import h2d.Drawable;
import h2d.Graphics;

class Fish  extends FishAbstract implements IUpdate {
	
	var g:Graphics;
	

	var s2d:Scene;
	var g2:Graphics;

var parent:Object;



	/**
	 * [Description]
	 * @param parent
	 * @param s2d
	 * @param location
	 * @param r
	 * @param useServer  是否用服务器模拟
	 */
	public function new(parent:Object, s2d:Scene, location:Vector2, r:Float, useServer:Bool = false) {
		
		this.parent=parent;
		this.s2d = s2d;
		super(location,r,s2d.width,s2d.height);
		this.location2 = this.location = location;
		// flock = new Flock(location.x, location.y, s2d.width, s2d.height, r);

		flockSeek = new Flock(location.x, location.y, s2d.width, s2d.height, r);

		binding();
	}

	override function createRender(r:Float) {
		
		var color = Std.int(0xFFFFFF * Math.random());
		var pointa:Vector2 = new Vector2(0, 0);
		var pointb:Vector2 = new Vector2(r / 2, r);
		var pointc:Vector2 = new Vector2(0, 2 * r);
		g = new h2d.Graphics(parent);

		g.beginFill(color, 0.1);
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
	}
	function binding() {
		g.x = location.x;
		g.y = location.y;
		g2.x = location2.x;
		g2.y = location2.y;
	}

	
	override function syncLocation() {
		g.x = location.x;
		g.y = location.y;

		g.rotation = flock.velocity.angle;
	}

	/**
	 * 这里同步模拟坐标
	 */
	 override function syncShadowLocation(dir:Vector2) {
		g2.x = location2.x;
		g2.y = location2.y;

		g2.rotation = dir.angle; // what the fuck. 百分百同步了
	}
	





	
}
