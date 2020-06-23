package fish;
import hxmath.math.Vector2;
using fish.Vector2Helper;
class Flock {
	var acceleration:Vector2;

	var velocity:Vector2;

	public var position(default,null):Vector2;

	var r:Float;

	var maxSpeed:Float;
	var maxForce:Float;
	var width:Float;
	var height:Float;
	var extraSeparation:Float = 1.5; // 分离力
	var extraCohesion:Float = 1; // 平均分开力
	var extraAlign:Float = 1; // 联合力
	var neighborDist:Float = 50; // 每个间隔。
	var desiredSeperation = 60; // 到达这个临界就分离。

	public function new(x:Float, y:Float) {
		acceleration = Vector2.zero;
		velocity = new Vector2(Random.int(-1, 1), Random.int(-1, 1));
		position = new Vector2(x, y);
		r = 3.0;
		maxSpeed = 2;
		maxForce = 0.01;
	}

	

	public function run(targets:Array<Flock>) {
		this.flock(targets);
		this.update();
		this.borders();
		//  this.render();
	}

	function flock(boids:Array<Flock>) {
		var separation:Vector2 = this.separate(boids) * extraSeparation;
		var alignment = this.align(boids) * extraAlign;
		var cohesion = this.cohesion(boids) * extraCohesion;
		this.acceleration = acceleration + separation + alignment + cohesion;
	}

	function update() {
		velocity += acceleration;

		velocity.limit(maxSpeed);
		position += velocity;
		acceleration *= 0;
	}

	/**
	 * align group.
	 * @param boids
	 */
	function align(boids:Array<Flock>) {
		var steer = Vector2.zero;
		var count = 0;
		// for (var i = 0, l = boids.length; i < l; i++) {
		for (other in boids) {
			var distance = this.position.distanceTo(other.position);
			if (distance > 0 && distance < neighborDist) {
				steer += (other.velocity);
				count++;
			}
		}

		if (count > 0) {}
		steer = steer / (count);
		if (steer != Vector2.zero) {
			// Implement Reynolds: Steering = Desired - Velocity
			steer.normalizeTo(this.maxSpeed);
			steer -= (this.velocity);
			steer.normalizeTo(Math.min(steer.length, this.maxForce));
		}
		return steer;
	}

	// Cohesion
	// For the average location (i.e. center) of all nearby boids,
	// calculate steering vector towards that location
	function cohesion(boids:Array<Flock>):Vector2 {
		var sum = Vector2.zero;
		var count = 0;
		for (other in boids) {
			var distance = this.position.distanceTo(other.position);
			if (distance > 0 && distance < neighborDist) {
				sum += other.position; // Add location
				count++;
			}
		}
		if (count > 0) {
			sum = sum / (count);
			// Steer towards the location
			return this.steek(sum, false);
		}
		return sum;
	}

	// A method that calculates a steering vector towards a target
	// Takes a second argument, if true, it slows down as it approaches
	// the target
	function steek(target:Vector2, slowdown:Bool):Vector2 {
		var steer, desired = target - (this.position);
		var distance = desired.length;
		// Two options for desired vector magnitude
		// (1 -- based on distance, 2 -- maxSpeed)
		if (slowdown && distance < 100) {
			// This damping is somewhat arbitrary:
			desired.normalizeTo(this.maxSpeed * (distance / 100)); // 这里不一样。
		} else {
			desired.normalizeTo(this.maxSpeed);
		}
		steer = desired - velocity;
		steer.limit(this.maxForce); // 这里不一样。
		return steer;
	}

	function borders() {
		var vector = Vector2.zero;
		var position = this.position;
		var radius = this.r;

		if (position.x < -radius)
			vector.x = width + radius;
		if (position.y < -radius)
			vector.y = height + radius;
		if (position.x > width + radius)
			vector.x = -width - radius;
		if (position.y > height + radius)
			vector.y = -height - radius;
		if (vector != Vector2.zero) {
			this.position = this.position + (vector);
		}
	}

	/**
	 * separate group
	 * @param boids
	 * @return Point
	 */
	function separate(boids:Array<Flock>):Vector2 {
		var steer = Vector2.zero;
		var count = 0;
		// For every boid in the system, check if it's too close
		// for (var i = 0, l = boids.length; i < l; i++) {
		for (other in boids) {
			// var other = boids[i];
			var vector = position - other.position;
			var distance = vector.length;
			if (distance > 0 && distance < desiredSeperation) {
				// Calculate vector pointing away from neighbor
				steer += vector.normalizeTo(1 / distance);
				count++;
			}
		}
		// Average -- divide by how many
		if (count > 0)
			steer /= count;
		if (steer != Vector2.zero) {
			// Implement Reynolds: Steering = Desired - Velocity
			steer.normalizeTo(this.maxSpeed);
			steer -= this.velocity;
			steer.limit(this.maxForce);
		}
		return steer;
	}
}
