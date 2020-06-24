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
import MainFishServer;

class Main extends hxd.App {
	var arr:Array<Ball> = [];
	var arrFish:Array<Fish> = [];

	var flocks:Array<Flock> = [];
	var ms:MainFishServer;

	override function init() {
		engine.backgroundColor = 0xffffff;

		var g = new Graphics(s2d);
		var gap = 60;
		var w = s2d.width + gap;
		var h = s2d.height + gap;

		Grid.drawGrid(Std.int(w / gap), Std.int(h / gap), gap, gap, g);



		ms = new MainFishServer();

		ms.init();

		var flockArray = ms.flocks;

		for (f in flockArray) {
			var fish:Fish = new Fish(s2d, s2d, f.position, 30);

			fish.flock=f;
			arrFish.push(fish);
		}
	}

	override function update(dt:Float) {
		for (b in arr) {
			b.update(dt);
		}
	
		for (f in arrFish) {
			f.update(dt);
		}
	}

	static function main() {
		new Main();
	}
}
