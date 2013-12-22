package basics {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class BloodSplatter extends MovieClip {
		
		
		public function BloodSplatter() {
			// constructor code
			
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
		}
		
				
		public function loop(e:Event):void {
			if (this.currentFrame == this.totalFrames) {
				this.gotoAndPlay(3);
			}
		}
	}
	
}
