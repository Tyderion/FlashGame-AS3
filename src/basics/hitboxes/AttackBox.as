package basics.hitboxes {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import utilities.interfaces.IAttackTrigger;
	
	public class AttackBox extends Hitbox {
		
		
		public var delegate:IAttackTrigger;
		
		public function AttackBox() {
			super()
			addEventListener(Event.ENTER_FRAME, checkForPlayer, false, 0, true);
			addEventListener(Event.REMOVED_FROM_STAGE, cleanup, false, 0, true);
		}
		
		public function checkForPlayer(e:Event) {
			if (this.hitTestObject((root as Root).player)) {
				if (this.delegate != null) {
					this.delegate.attackBoxTriggeredByPlayer(this);
				}
			}
		}
		
		public function cleanup(e:Event) {
			removeEventListener(Event.ENTER_FRAME, checkForPlayer, false);
			removeEventListener(Event.REMOVED_FROM_STAGE, cleanup, false);
		}
		
	}

}
