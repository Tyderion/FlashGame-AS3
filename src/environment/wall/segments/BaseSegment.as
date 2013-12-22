package environment.wall.segments {
	import basics.hitboxes.CollisionBox;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Gabriel
	 */
	public dynamic class BaseSegment extends MovieClip {
		
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