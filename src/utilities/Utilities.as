package utilities {
	import basics.hitboxes.AttackBox;
	import flash.display.MovieClip;
	import utilities.interfaces.IAttackTrigger;
	
	/**
	 * ...
	 * @author Gabriel
	 */
	public class Utilities {
		
		public function Utilities() {
		
		}
		
		public static function setDelegateIfExists(box:AttackBox, clip:IAttackTrigger) {
			if (box != null && box.delegate != clip) {
				box.delegate = clip;
			}
		}
	}

}