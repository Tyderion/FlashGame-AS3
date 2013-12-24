package environment {
	import flash.display.MovieClip;
	import utilities.*;
	
	/**
	 * ...
	 * @author Gabriel
	 */
	public dynamic class Environment extends MovieClip {
		public function Environment() {
			super();
			this.gotoAndPlay(Random.random(this.totalFrames));
		}
	}
}