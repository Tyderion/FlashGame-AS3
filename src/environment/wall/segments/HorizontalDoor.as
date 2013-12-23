﻿package environment.wall.segments {
	import basics.hitboxes.CollisionBox;
	import basics.hitboxes.InteractionBox;
	import utilities.Random;
	import flash.events.Event;
	
	public class HorizontalDoor extends BaseSegment {
		
		private var rootRef:Root;
		public var DoorTrigger:InteractionBox;
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
		
		public function get isDoorOpen():Boolean {
			return this.currentFrame >= 3;
		}
		
		public function HorizontalDoor() {
			this.rootRef = root as Root;
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
		
	}
		
		public function loop(e:Event):void {
		
		if (DoorTrigger.hitTestObject(rootRef.player)) {
			this.gotoAndPlay("open");
		}
		else {
		this.gotoAndStop("closed");
		}
}
}
}