package  
{
	import basics.Light;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Gabriel
	 */
	public class Entity extends MovieClip 
	{
		public var light:Light;
		public function Entity() 
		{
			super();
			addEventListener(Event.ENTER_FRAME, moveLightToDarkness, false, 0, true);
		}
		
		
		private function moveLightToDarkness(e:Event) {
			var rootRef:Root = root as Root;
			if (rootRef.darkness && this.light != null) {
				this.light.parent.removeChild(light);
				this.light.entity = this;
				rootRef.darkness.addLight(this.light);
				removeEventListener(Event.ENTER_FRAME, moveLightToDarkness, false);
			}
		}
		
	}

}