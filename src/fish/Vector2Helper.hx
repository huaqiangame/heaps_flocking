package fish;
import hxmath.math.Vector2;
class Vector2Helper {
    

    public  static function limit(v2:Vector2,v:Float) {

        var len=v2.length;

        v2.normalizeTo(Math.min(len,v));
        
    }

    public  static function isZero(v2:Vector2):Bool{

       
        return v2.x==0&&v2.y==0;
        
    }

   
}