package environment.wall.segments {
	import basics.hitboxes.InteractionBox;
	
	public class HorizontalDoor extends BaseSegment {
		
		
		
		public var hitbox2:InteractionBox;
		public var hitbox3:InteractionBox;
		public var hitbox4:InteractionBox;
		
		override public function getHitboxes():Array {
			var hitboxes:Array = super.getHitboxes();
			if (hitbox2 != null) hitboxes.push(hitbox2);
			if (hitbox3 != null) hitboxes.push(hitbox3);
			if (hitbox4 != null) hitboxes.push(hitbox4);
			return hitboxes;
		}
		
		public function HorizontalDoor() {
			// constructor code
			
		}
	}
	
}
