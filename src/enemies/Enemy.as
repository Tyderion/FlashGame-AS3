package enemies {
	import basics.hitboxes.BodyBox;
	import flash.display.MovieClip;
	import flash.events.Event;
	import utilities.interfaces.ILastFrameTrigger;
	import utilities.LastFrameTrigger;
	import utilities.Utilities;
	import utilities.Actions;
	import utilities.KeyCodes;
	
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
		
		public var body_hit:BodyBox;
		
		public function Enemy() {
			super();
			addEventListener(Event.ENTER_FRAME, death, false, 0, true);
		}
		public function death(e:Event):void {
			if (root != null) {
				if ((this.root as Root).keyPresses.isDown(KeyCodes.J)) {
					this.applyDamage(100000);
				}
			}
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