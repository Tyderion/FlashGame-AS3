package enemies {
	
	import basics.hitboxes.BodyBox;
	import basics.hitboxes.AttackBox;
	import flash.display.MovieClip;
	import flash.events.Event;
	import utilities.*;
	import utilities.interfaces.IAttackTrigger;
	
	public class Hand extends MovieClip implements IAttackTrigger {
		
		public var AttackTriggerLeft:AttackBox;
		public var AttackTriggerRight:AttackBox;
		public var AttackTriggerUp:AttackBox;
		public var AttackTriggerDown:AttackBox;
		private var rootRef:Root;
		private var nextAction:String = "idle";
		
		public function Hand() {
			super();
			this.rootRef = this.root as Root;
			

		}
		
		public function attackBoxTriggeredByPlayer(box:AttackBox) {
			this.gotoAndStop("hit_" + this.direction);
			this.attackAnimation.delegate = this;
		}
	}

}
