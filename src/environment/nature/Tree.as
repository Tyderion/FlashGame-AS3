package environment.nature {
	import basics.hitboxes.CollisionBox;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Gabriel
	 */
	public dynamic class Tree extends MovieClip {
		
		public var hitbox:CollisionBox;
		public function Tree() {
			super();
			this.gotoAndPlay(1);
			addEventListener(Event.ENTER_FRAME, onEnterFrame, false, 0, false);
		}
		
		
		public function onEnterFrame(e:Event):void {
			if (this.currentFrame == this.totalFrames) {
				this.gotoAndPlay(1);
			}
		}
	
	}

}