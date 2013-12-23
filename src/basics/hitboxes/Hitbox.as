package basics.hitboxes {
	import flash.display.MovieClip;
	import flash.events.Event;
	import vendor.KeyObject;
	import utilities.KeyCodes;
	
	public class Hitbox extends MovieClip {
		
		private var rootRef:Root;
		private var canSwapVisiblity:Boolean = true;
		
		public function Hitbox() {
			super();
			this.rootRef = root as Root;
			this.alpha = 0;
			addEventListener(Event.ENTER_FRAME, debugLoop, false, 0, true);
		}
		
		public function debugLoop(e:Event) {
			if (this.rootRef.keyPresses.isDown(KeyCodes.H)) {
				if (this.canSwapVisiblity) {
					this.swapVisibility();
					this.canSwapVisiblity = false;
				}
			} else {
				this.canSwapVisiblity = true;
			}
		}
		
		private function swapVisibility() {
			if (this.alpha < 0.1) {
				this.alpha = 1;
			} else {
				this.alpha = 0;
			}
		}
	
	}

}
