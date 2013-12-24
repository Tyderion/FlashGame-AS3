package enemies {
	import flash.display.MovieClip;
	import flash.events.Event;
	import utilities.interfaces.ILastFrameTrigger;
	import utilities.LastFrameTrigger;
	import utilities.Utilities;
	
	/**
	 * ...
	 * @author Gabriel
	 */
	public class Enemy extends MovieClip implements ILastFrameTrigger {
		
		public var death_animation:LastFrameTrigger;
		public var despawnTime:Number = 20; // Seconds
		private var deadTime:Date;
		
		public function Enemy() {
			super();
			addEventListener(Event.EXIT_FRAME, deathTrigger, false, 0, true);
		}
		
		public function deathTrigger(e:Event) {
			Utilities.setLastFrameTriggerDelegate(death_animation, this);
			if (this.deadTime != null) {
				var t:Date = new Date();
				if (t.valueOf() - this.deadTime.valueOf() > this.despawnTime * 1000) {
					removeEventListener(Event.EXIT_FRAME, deathTrigger, false);
					this.parent.removeChild(this);
				}
			}
		}
		
		public function lastFrameEnded(mv:MovieClip) {
			if (mv == death_animation  && this.deadTime == null) {
				this.deadTime = new Date();
			}
		}
	}

}