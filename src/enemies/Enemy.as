package enemies {
	import flash.display.MovieClip;
	import flash.events.Event;
	import utilities.interfaces.ILastFrameTrigger;
	import utilities.LastFrameTrigger;
	import utilities.Utilities;
	import utilities.Actions;
	
	/**
	 * Enemy Superclass which implements despawn-time for all enemies with a required animation named death_animation 
	 * which has a label called Actions.IDLE which will be played until the enemy is removed from stage.
	 * Implements ILastFrameTrigger to remove the enemy in the last frame of the death_animation.
	 * @author Gabriel
	 */
	public class Enemy extends HealthEntity implements ILastFrameTrigger {
		
		public var death_animation:LastFrameTrigger;
		public var despawnTime:Number = 20; // Seconds
		private var deadTime:Date;
		
		public function Enemy() {
			super();
		}
		
		public function deathTrigger(e:Event) {
			if (this.deadTime != null) {
				var t:Date = new Date();
				if (t.valueOf() - this.deadTime.valueOf() > this.despawnTime * 1000) {
					removeEventListener(Event.EXIT_FRAME, deathTrigger, false);
					this.parent.removeChild(this);
				}
				if (this.death_animation.currentLabel != Actions.IDLE) {
					this.death_animation.gotoAndPlay(Actions.IDLE);
				}
			}
		}
		
		public function lastFrameEnded(mv:MovieClip) {
			if (mv == death_animation  && this.deadTime == null) {
				addEventListener(Event.EXIT_FRAME, deathTrigger, false, 0, true);
				this.deadTime = new Date();
			}
		}
	}

}