package basics.hitboxes {
	
	import flash.display.MovieClip;
	import utilities.interfaces.IAttackTrigger;
	
	public class AttackBox extends Hitbox {
		
		
		public var delegate:IAttackTrigger;
		
		public function AttackBox() {
			super()
		}
		
		public function checkForPlayer(e:Event) {
			if (this.hitTestObject(rootRef.player)) {
				this.delegate.attackBoxTriggeredByPlayer(this);
			}
		}
	}

}
