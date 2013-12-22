package environment.wall.segments 
{
	import base.hitboxes.InteractionBox;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Gabriel
	 */
	public dynamic class BaseSegment extends MovieClip 
	{
				
		public var hitbox1:InteractionBox;
		public var hitbox2:InteractionBox;
		
		public function BaseSegment() 
		{
			super();
		}
		
	}

}