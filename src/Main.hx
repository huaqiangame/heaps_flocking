import fish.Flock;
import fish.Fish;
import fish.Ball;
import hxmath.math.Vector2;
import h2d.Drawable;
import h2d.Graphics;

class Main extends hxd.App {


    var arr:Array<Ball>=[];
    var arr2:Array<Fish>=[];

    var flocks:Array<Flock>=[];
	override function init() {
		var tf = new h2d.Text(hxd.res.DefaultFont.get(), s2d);
		tf.text = "Hello World !";


        for(i in 0...100){

            var b:Ball=new Ball(s2d,s2d,new Vector2(Random.int(31,s2d.width-31),Random.int(31,s2d.height-31)),new Vector2(Random.float(1,5),Random.float(1,5)));
            arr.push(b);
        }


        for(j in 0...200){
            var fish:Fish=new Fish(s2d,s2d,new Vector2(Random.int(31,s2d.width-35),Random.int(31,35)),30);
            arr2.push(fish);
            flocks.push(fish.flock);
        }
	
	}

	override function update(dt:Float) {
        
        for(b in arr){
            b.update(dt);
        }

        for(f in flocks){
            f.run(flocks);
        }

        for(f in arr2){
            f.update(dt);
        }
	}

	static function main() {
		new Main();
	}
}
