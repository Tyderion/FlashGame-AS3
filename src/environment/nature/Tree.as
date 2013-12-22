package environment.nature {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Gabriel
	 */
	public class Tree extends MovieClip {
		
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