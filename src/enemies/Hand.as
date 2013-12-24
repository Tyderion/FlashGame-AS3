package enemies {
	
	import basics.hitboxes.BodyBox;
	import basics.hitboxes.AttackBox;
	import flash.display.MovieClip;
	import flash.events.Event;
	import utilities.Directions;
	import utilities.Actions;
	import utilities.Utilities;
	import utilities.interfaces.IAttackTrigger;
	
	
	public class Hand extends MovieClip implements IAttackTrigger {
		
		public var AttackTriggerLeft:AttackBox;
		public var AttackTriggerRight:AttackBox;
		public var AttackTriggerUp:AttackBox;
		public var AttackTriggerDown:AttackBox;
		private var rootRef:Root;
		private var nextAction:String = Actions.IDLE;
		
		public function Hand() {
			super();
			this.rootRef = this.root as Root;
			addEventListener(Event.ENTER_FRAME, setDelegateIfNotSet, false, 0, true);	
			this.gotoAndStop("idle");
		}
		
		
		public function setDelegateIfNotSet(e:Event) {
			Utilities.setDelegateIfExists(AttackTriggerLeft, this);
			Utilities.setDelegateIfExists(AttackTriggerRight, this);
			Utilities.setDelegateIfExists(AttackTriggerUp, this);
			Utilities.setDelegateIfExists(AttackTriggerDown, this);
		}
		
		public function attackBoxTriggeredByPlayer(box:AttackBox) {
			var direction:String;
			if (box == AttackTriggerLeft) {
				direction = Directions.LEFT;
			} else if  (box == AttackTriggerRight) {
				direction = Directions.RIGHT;
			} else if  (box == AttackTriggerUp) {
				direction = Directions.UP;				
			} else if  (box == AttackTriggerDown) {
				direction = Directions.DOWN;				
			}
			this.gotoAndStop(Actions.HIT+"_" + direction);
		}
	}

}
