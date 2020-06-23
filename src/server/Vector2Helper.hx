package server;

import hxmath.math.Vector2;

class Vector2Helper {
	public static function setLength(v:Vector2, len:Float):Vector2 {
		var l = v.normalize() * len;

		return l;
	}

	public static function isZero(v:Vector2):Bool {
		return v == Vector2.zero;
	}

	public static function random():Vector2 {
		var p1 = new Vector2(0, 1);
		var p2 =new Vector2(1, 0);
		var p3 =new Vector2(1, 1);
		var arr=[p1,p2,p3];
		return arr[Random.int(0,2)];
	}
}
