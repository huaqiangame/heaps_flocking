package server;

import fish.Fish;
import haxe.Timer;
import hxmath.math.Vector2;

import hxmath.geom.Rect;

class GameServer {
	static var w:Int;
	static var h:Int;

	static var arr:Map<Int, Rect> = [];

	static var fishRenderMap:Map<Int, Fish> = [];

	static var xyObjectMap:Map<Int, Array<XYObject>> = [];

	static var bindingMap:Map<Int, Fish> = [];

	static var size:Int;

	public static function addForTestBinding(id:Int, target:Fish) {
		bindingMap[id] = target;
	}

	public static function init(w:Int, h:Int, size:Int) {
		GameServer.size = size;
		var vv:Int = Std.int(w / size);

		var hh:Int = Std.int(h / size);

		// var keys=100000000;
		for (j in 0...vv) {
			for (i in 0...hh) {
				var keys = 1000000;
                
                keys+=i;
                keys+=j*1000;

			

				arr[keys] = new Rect(j * size, i * size, size, size);
				// arr[k] = new Rect(j * size, i * size, size, size);
			}
		}

		// TweenX.addRule(Vector2Rules);
	}

	public static function checkInside(x:Float, y:Float):Int {
		var xys = arr;
		for (key => value in arr) {
			if (value.containsPoint(new Vector2(x, y))) {
				return key ;
			}
		}

		return null;
	}

	public static function send(id:Int, xy:Int) {
		Timer.delay(function() {
			// trace('id=$id 坐标有变 xy=$xy');

			sync(id, xy);
		}, Random.int(100, 500));
	}

	static function sync(id:Int, xy:Int) {
		if (!xyObjectMap.exists(id)) {
			xyObjectMap[id] = [];
		}

		if (xy == null) {
			return;
        }
        
        var xdiff=Std.string(xy).substr(1,3);
        var ydiff=Std.string(xy).substr(4,3);


		var xk:Int = Std.parseInt(xdiff);
		var yk:Int = Std.parseInt(ydiff);
		var x:Float = xk * GameServer.size + GameServer.size / 2;
		var y:Float = yk * GameServer.size + GameServer.size / 2;
		var obj:XYObject = {
			id: id,
			x: x,
			y: y,
			time: Date.now().getTime()
		};

		xyObjectMap[id].push(obj);

		if (xyObjectMap[id].length == 1) {
			// todo://立即同步
			// . bindingMap[id]
			var p = new Vector2(xyObjectMap[id][0].x, xyObjectMap[id][0].y);
			bindingMap[id].binding(p, Vector2.zero);
		}
		if (xyObjectMap[id].length == 2) {
			var p = new Vector2(xyObjectMap[id][1].x, xyObjectMap[id][1].y);
			var p0 = new Vector2(xyObjectMap[id][0].x, xyObjectMap[id][0].y);
			var v = p - p0;
			// bindingMap[id].update(p,v);
			var time = xyObjectMap[id][1].time - xyObjectMap[id][0].time;

			if (v.length > 100) {
				trace('warning  超过范围' + v.length);
			}
			bindingMap[id].tween(p, v, time);
		}

		if (xyObjectMap[id].length >= 2) {
			xyObjectMap[id].shift();
		}
	}
}

typedef XYObject = {
	var id:Int;
	var x:Float;
	var y:Float;
	var time:Float;
}
