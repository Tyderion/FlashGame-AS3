package environment.nature {
	import basics.hitboxes.InteractionBox;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Gabriel
	 */
	public dynamic class Tree extends MovieClip {
		
		public var hitbox:InteractionBox;
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