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
			this.setVisibility()
			addEventListener(Event.ENTER_FRAME, debugLoop, false, 0, true);
		}
		
		public function debugLoop(e:Event) {
			setVisibility();
		}
		
		private function setVisibility() {
			this.alpha = rootRef.shouldHitboxBeVisible ? 1 : 0;
		}
	
	}

}
