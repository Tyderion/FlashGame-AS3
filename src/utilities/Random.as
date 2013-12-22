package utilities 
{
	import basics.hitboxes.InteractionBox;
	/**
	 * ...
	 * @author Gabriel
	 */
	public class Random 
	{
		
		public function Random() 
		{
			
		}
		
		
		public static function random(n:Number):Number {
			return ((int)(Math.random()*1000)) %n;
		}
		
	}

}