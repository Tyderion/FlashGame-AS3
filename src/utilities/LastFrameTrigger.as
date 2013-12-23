package utilities 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import utilities.interfaces.ILastFrameTrigger;
	
	/**
	 * ...
	 * @author Gabriel
	 */
	public class LastFrameTrigger extends MovieClip 
	{
		
		public var delegate:ILastFrameTrigger;
		
		public function LastFrameTrigger() 
		{
			super();
			addEventListener(Event.EXIT_FRAME, checkForLastFrame, false, 0, true);
			addEventListener(Event.REMOVED_FROM_STAGE, cleanup, false, 0, true);
		}
		
		public function checkForLastFrame(e:Event) {
			if (this.currentFrame == this.totalFrames) {
				if (this.delegate != null) {
					this.delegate.lastFrameEnded(this);
				}
			}
		}
		public function cleanup(e:Event) {
			removeEventListener(Event.EXIT_FRAME, checkForLastFrame, false);
			removeEventListener(Event.REMOVED_FROM_STAGE, cleanup, false);
		}

		
	}

}