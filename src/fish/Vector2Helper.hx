package fish;
import hxmath.math.Vector2;
class Vector2Helper {
    

    public  static function limit(v2:Vector2,v:Float) {

        var len=v2.length;

        v2.normalizeTo(Math.min(len,v));
        
    }
}