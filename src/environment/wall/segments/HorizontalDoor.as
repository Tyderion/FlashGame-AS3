package environment.wall.segments {
	import basics.hitboxes.CollisionBox;
	import utilities.Random;
	
	public class HorizontalDoor extends BaseSegment {
		
		
		
		public var hitbox2:CollisionBox;
		public var hitbox3:CollisionBox;
		public var hitbox4:CollisionBox;
		
		override public function get Hitboxes():Array {
			var hitboxes:Array = super.Hitboxes;
			if (hitbox2 != null) hitboxes.push(hitbox2);
			if (hitbox3 != null) hitboxes.push(hitbox3);
			if (hitbox4 != null) hitboxes.push(hitbox4);
			return hitboxes;
		}
		
		public function HorizontalDoor() {
			this.gotoAndStop(Random.random(7) + 1);
			
		}
		
		public function get isDoorOpen():Boolean {
			return this.currentFrame >= 3;
		}
	}
	
}
