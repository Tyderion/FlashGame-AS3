package basics 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.BlendMode;
	
	/**
	 * ...
	 * @author Gabriel
	 */
	public class Light extends MovieClip 
	{
		
		private var _entity:Entity;
		
		public function Light(entity:Entity=null) 
		{
			super();
			this.entity = entity;
			this.blendMode = BlendMode.ALPHA;
		}
		
		public function set entity(entity:Entity) {
			if (entity != null) {
				_entity = entity;
				addEventListener(Event.ENTER_FRAME, trackEntity, false, 0 , true);
			}
		}
		
		
		public function trackEntity(e:Event) {
			if (_entity is Player) {
				this.x =  _entity.x - (_entity as Player).offsetx + root.scrollRect.width / 2;
				this.y = _entity.y - (_entity as Player).offsety + root.scrollRect.height/2 ;
			} else {
				this.x = _entity.x;
				this.y = _entity.y;
			}
		}
		
	}

}