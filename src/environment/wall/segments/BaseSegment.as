package environment.wall.segments {
	import basics.hitboxes.CollisionBox;
	import environment.Environment;
	import flash.display.MovieClip;
	
	/**
	 * Basic wall baseclass. Returns the hitbox of the wall and has a helperfunction to test for door.
	 * @author Gabriel
	 */
	public class BaseSegment extends Environment {
		
		public var hitbox1:CollisionBox;
		
		public function get Hitboxes():Array {
			if (hitbox1 == null)
				return new Array();
			else
				return new Array(hitbox1);
		}
		
		public function BaseSegment() {
			super();
		}
		
		public function get isDoor():Boolean {
			return this is HorizontalDoor;
		}
	
	}

}