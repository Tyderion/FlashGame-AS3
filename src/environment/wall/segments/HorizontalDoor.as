package environment.wall.segments {
	import basics.hitboxes.InteractionBox;
	import utilities.Random;
	
	public class HorizontalDoor extends BaseSegment {
		
		
		
		public var hitbox2:InteractionBox;
		public var hitbox3:InteractionBox;
		public var hitbox4:InteractionBox;
		
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
		
		public function get isDoorOpen() {
			return this.currentFrame >= 3;
		}
	}
	
}
