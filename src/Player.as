package {
	
	import basics.hitboxes.BodyBox;
	import basics.Light;
	import enemies.Baby;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import utilities.*;
	
	/**
	 * The player class controls the player movieclip. The Player is controlled by the keyboard.
	 */
	public class Player extends HealthEntity {
		
		private var speed:Number = 5;
		private var rootRef:Root;
		public var animations:MovieClip;
		public var feet_hit:BodyBox;
		public var body_hit:BodyBox;
		private var _direction;
		
		public var light:Light;
		
		public function Player() {
			super();
			this.rootRef = root as Root;
			this.rootRef.player = this;
			_direction = Directions.DOWN;
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
			addEventListener(Event.ENTER_FRAME, moveLightToDarkness, false, 0, true);
		
		}
		
		public function get Direction():String {
			
			if (this.rootRef.upPressed) {
				_direction = Directions.UP;
			}
			if (this.rootRef.downPressed) {
				_direction = Directions.DOWN;
			}
			if (this.rootRef.leftPressed) {
				_direction = Directions.LEFT;
			}
			if (this.rootRef.rightPressed) {
				_direction = Directions.RIGHT;
			}
			
			return _direction;
		}
		
		public function get Action():String {
			if (this.rootRef.leftPressed || this.rootRef.upPressed || this.rootRef.rightPressed || this.rootRef.downPressed) {
				return Actions.WALK;
			} else if (this.rootRef.attackPressed) {
				return Actions.HIT;
			} else {
				return Actions.IDLE;
			}
		}
		
		public function loop(e:Event):void {
			var xchange = 0;
			var ychange = 0;
			if (this.rootRef.leftPressed) {
				xchange -= speed;
			} else if (this.rootRef.rightPressed) {
				xchange += speed;
			}
			
			if (this.rootRef.upPressed) {
				ychange -= speed;
			} else if (this.rootRef.downPressed) {
				ychange += speed;
			}
			
			var c:Rectangle = this.rootRef.scrollRect;
			if (!this.rootRef.collidesWithWall(this.x + xchange, this.y + ychange)) {
				this.rootRef.scrollRect = new Rectangle(c.x += xchange, c.y += ychange, c.width, c.height);
			} else if (!this.rootRef.collidesWithWall(this.x, this.y + ychange)) {
				this.rootRef.scrollRect = new Rectangle(c.x, c.y += ychange, c.width, c.height);
				
			} else if (!this.rootRef.collidesWithWall(this.x + xchange, this.y)) {
				this.rootRef.scrollRect = new Rectangle(c.x += xchange, c.y, c.width, c.height);
			}
			c = this.rootRef.scrollRect;
			this.x = c.width / 2 + c.x;
			this.y = c.height / 2 + c.y;
			this.animations.gotoAndPlay(this.Action + "_" + this.Direction);
		
		}
		
		private function moveLightToDarkness(e:Event) {
			if (this.rootRef.darkness) {
				var t:Light = this.light;
				this.light.parent.removeChild(light);
				this.light.entity = this;
				this.rootRef.darkness.addLight(this.light);
				removeEventListener(Event.ENTER_FRAME, moveLightToDarkness, false);
			}
		}
	}
}

