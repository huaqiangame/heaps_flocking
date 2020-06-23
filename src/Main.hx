import h3d.Vector;
import h2d.Tile;
import h2d.Bitmap;
import hxd.BitmapData;
import help.Grid;
import fish.Flock;
import fish.Fish;
import fish.Ball;
import hxmath.math.Vector2;
import h2d.Drawable;
import h2d.Graphics;

class Main extends hxd.App {
	var arr:Array<Ball> = [];
	var arr2:Array<Fish> = [];

	var flocks:Array<Flock> = [];

	override function init() {
		engine.backgroundColor = 0xffffff;

		var g = new Graphics(s2d);
        var gap = 30;
		var w = s2d.width+gap;
		var h = s2d.height+gap;
		
        Grid.drawGrid(Std.int(w / gap), Std.int(h / gap), gap, gap, g);
  

		for (j in 0...100) {
			var fish:Fish = new Fish(s2d, s2d, new Vector2(Random.int(31, s2d.width - 35), Random.int(31, 35)), 30);
			arr2.push(fish);
			flocks.push(fish.flock);
		}
	}

	override function update(dt:Float) {
		for (b in arr) {
			b.update(dt);
		}

		for (f in flocks) {
			f.run(flocks);
		}

		for (f in arr2) {
			f.update(dt);
		}
	}

	static function main() {
		new Main();
	}
}
