package environment {
	import flash.display.MovieClip;
	import utilities.*;
	/**
	 * ...
	 * @author Gabriel
	 */
	public dynamic class Environment extends MovieClip {
		private var RandomFrame;
		public function Environment() {
			RandomFrame = Random.random(25);
			super();
			this.gotoAndPlay(RandomFrame);
		}
	
	}

}