package {
	import basics.hitboxes.AttackBox;
	import basics.hitboxes.CollisionBox;
	import basics.hitboxes.DamageBox;
	import basics.Light;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Gabriel
	 */
	public class Entity extends MovieClip {
		private var lights:Array = new Array();
		
		public function Entity() {
			super();
			addEventListener(Event.ENTER_FRAME, moveLightToDarkness, false, 0, true);
		}
		
		public function get CollisionBoxes() {
			return this.getBoxesOfType(CollisionBox);
		}
		
		public function get DamageBoxes() {
			return this.getBoxesOfType(DamageBox);
		}
		
		public function get AttackBoxes() {
			return this.getBoxesOfType(AttackBox);
		}
		
		private function getBoxesOfType(type:Class):Array {
			var results:Array = new Array();
			for (var i:int = 0; i < this.numChildren; i++) {
				var obj:DisplayObject = getChildAt(i);
				if (obj is type) {
					results.push(obj);
				}
			}
			return results;
		}
		
		private function moveLightToDarkness(e:Event) {
			var rootRef:Root = root as Root;
			if (rootRef.darkness != null) {
				var removed:Array = new Array();
				for (var i:int = 0; i < this.numChildren; i++) {
					var child:DisplayObject = this.getChildAt(i);
					if (child is Light) {
						removed.push(child);
					}
				}
				for (var j:int = 0; j < removed.length; j++) {
					var light:Light = removed[j] as Light;
					light.entity = this;
					this.removeChild(light);
					rootRef.darkness.addLight(light)
					this.lights.push(light);
				}
				removeEventListener(Event.ENTER_FRAME, moveLightToDarkness, false);
				addEventListener(Event.REMOVED_FROM_STAGE, removeLight, false, 0, true);
			}
		}
		
		private function removeLight(e:Event) {
			var rootRef:Root = root as Root;
			for (var i:int = 0; i < this.lights.length; i++) {
				var light:Light = this.lights[i];
				rootRef.darkness.removeChild(light);
			}
		}
	}

}