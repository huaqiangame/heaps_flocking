import server.IUpdate;
import haxe.MainLoop;
import fish.Flock;
import hxmath.math.Vector2;
import server.GameTimer;

class MainFishServer {
	public var flocks(default, null):Array<Flock>;
	public var stage(default, null):Vector2 ;
	public function new() {
		//	Timer.update();
		stage= new Vector2(1920, 1080);
		flocks = [];
		MainLoop.add(mainLoop);
	}

	function mainLoop() {
		GameTimer.update();
		update(GameTimer.dt);
	}

	public function init() {
		
		var center:Vector2 = stage / 2;
		for (j in 0...30) {
			var flock:Flock = new Flock(Random.float(center.x - 100, center.y - 100), Random.float(center.x + 100, center.y - 100), Std.int(stage.x),
				Std.int(stage.y), 30);
			flocks.push(flock);
		}
	}

	function update(dt:Float) {
		// trace(dt);

		for (f in flocks) {
			f.run(flocks);
		}
	}

	static function main() {
		new MainFishServer();
	}
}
