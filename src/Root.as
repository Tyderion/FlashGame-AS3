package {
	
	import basics.BloodSplatter;
	import basics.hitboxes.CollisionBox;
	import enemies.Baby;
	import environment.Environment;
	import environment.nature.Tree;
	import environment.wall.segments.BaseSegment;
	import environment.wall.segments.HorizontalDoor;
	import environment.wall.Wall;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import interfaces.HealthBar;
	import utilities.*;
	import vendor.KeyObject;
	
	[SWF(width="600", height="400")] // Override document window size with SWF Metadata Tags [SWF(width='400', height='300', backgroundColor='#ffffff', frameRate='30')]
	public dynamic class Root extends MovieClip {
		
		var healthbar:HealthBar;
		private var _walls:Array = new Array();
		
		public var keyPresses:KeyObject;
		private var _leftPressed:Boolean = false; //keeps track of whether the left arrow key is pressed
		private var _rightPressed:Boolean = false; //same, but for right key pressed
		private var _upPressed:Boolean = false; //...up key pressed
		private var _downPressed:Boolean = false; //...down key pressed
		private var _attackPressed:Boolean = false; //...down key pressed
		
		public var scrollRectWidth:Number = 600;
		public var scrollRectHeight:Number = 400;
	
		public var player:Player;
		
		
		private var timesToSort:Number = 3;
		
		public function Root() {
			
			
			this.scrollRect = new Rectangle(this.player.x -scrollRectWidth/2 ,this.player.y - scrollRectHeight/2,600,400);
			healthbar = new HealthBar(100, 100, 0.5, 0.5);
			stage.addChild(healthbar);
			keyPresses = new KeyObject(this.stage);
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
			
			addEventListener(Event.ENTER_FRAME, sort, false, 0, true);
		
		}
		
		function sort(e:Event) {
			/* Swap Sort xD TODO */
			timesToSort--;
			for (var i = 0; i < this.numChildren; i++) {
				var childClip:MovieClip = getChildAt(i) as MovieClip;
				if (childClip is Environment || childClip is BaseSegment) { //TODO: Loop through all?
					for (var j = 0; j < this.numChildren; j++) {
						var childClip2:MovieClip = getChildAt(j) as MovieClip;
						if (childClip2 is Environment || childClip2 is Wall) { //TODO: Loop through all?
							if (childClip == childClip2)
								continue;
							if (childClip.y < childClip2.y && getChildIndex(childClip) > getChildIndex(childClip2) 
							 || childClip.y > childClip2.y && getChildIndex(childClip) < getChildIndex(childClip2)) {
								setChildIndex(childClip, getChildIndex(childClip2))
							}
						}
					}
				}
			}
			if (timesToSort == 0) 			removeEventListener(Event.ENTER_FRAME, sort, false);
		}
		
		var wait = 10;
		
		// Keys
		
		public function get downPressed():Boolean {
			return _downPressed;
		}
		
		public function get upPressed():Boolean {
			return _upPressed;
		}
		
		public function get rightPressed():Boolean {
			return _rightPressed;
		}
		
		public function get leftPressed():Boolean {
			return _leftPressed;
		}
		
		public function get attackPressed():Boolean {
			return _attackPressed;
		}
		
		public function get walls():Array {
			return _walls;
		}
		
		public function addWall(wall:Wall) {
			this.walls.push(wall);
		}
		
		public function loop(e:Event):void {
			
			//this.bloodSplat(Random.random(this.width), Random.random(this.height));
			this.checkKeypresses();
			if (wait <= 0) {
				
				if (healthbar.currentHealth <= 0) {
					healthbar.currentHealth = 200;
				} else {
					healthbar.currentHealth = healthbar.currentHealth - 10;
				}
				wait = 10;
			} else {
				wait--;
			}
			
			for (var i = 0; i < this.numChildren; i++) {
				var childClip:MovieClip = getChildAt(i) as MovieClip;
				if (childClip is Environment || childClip is Baby) {
					if (shouldSwapWithPlayer(childClip, 0)) {
						setChildIndex(childClip, getChildIndex(player))
					}
				} else if (childClip is BaseSegment) {
					var wall:BaseSegment = childClip as BaseSegment;
					var offsetDoor:Number = 35;
					var offsetElse:Number = 10;
					if (wall.isDoor && (wall as HorizontalDoor).isDoorOpen) {
						if (Math.abs(this.player.x - wall.x) < 25) {
							if (shouldSwapWithPlayer(wall, offsetDoor)) {
								//swapChildren(wall, player);
								setChildIndex(wall, getChildIndex(player))
							}
						} else {
							if (shouldSwapWithPlayer(wall, offsetElse)) {
								//swapChildren(wall, player);
								setChildIndex(wall, getChildIndex(player))
							}
						}
					} else if (shouldSwapWithPlayer(wall, offsetElse)) {
						
						setChildIndex(wall, getChildIndex(player))
							//swapChildren(wall, player);
					}
				}
			}
		
		}
		
		private function shouldSwapWithPlayer(wall:MovieClip, offset:Number):Boolean {
			return (this.player.y - offset) < wall.y && getChildIndex(this.player) > getChildIndex(wall) || (this.player.y - offset) > wall.y && getChildIndex(this.player) < getChildIndex(wall)
		}
		
		public function checkKeypresses():void {
			if (keyPresses.isDown(KeyCodes.LeftArrow) || keyPresses.isDown(KeyCodes.a)) { // if left arrow or A is pressed
				_leftPressed = true;
			} else {
				_leftPressed = false;
			}
			if (keyPresses.isDown(KeyCodes.UpArrow) || keyPresses.isDown(KeyCodes.w)) { // if up arrow or W is pressed
				_upPressed = true;
			} else {
				_upPressed = false;
			}
			
			if (keyPresses.isDown(KeyCodes.RightArrow) || keyPresses.isDown(KeyCodes.d)) { //if right arrow or D is pressed
				_rightPressed = true;
			} else {
				_rightPressed = false;
			}
			
			if (keyPresses.isDown(KeyCodes.DownArrow) || keyPresses.isDown(KeyCodes.s)) { //if down arrow or S is pressed
				_downPressed = true;
			} else {
				_downPressed = false;
			}
			
			if (keyPresses.isDown(KeyCodes.Spacebar)) { //if down arrow or S is pressed
				_attackPressed = true;
			} else {
				_attackPressed = false;
			}
		}
		
		public function bloodSplat(x:Number, y:Number) {
			var blood:BloodSplatter = new BloodSplatter();
			blood.x = x;
			blood.y = y;
			stage.addChild(blood);
		}
		
		public function collidesWithWall(x_next:Number, y_next:Number) {
			for (var i = 0; i < this.numChildren; i++) {
				var childClip:MovieClip = getChildAt(i) as MovieClip;
				if (childClip is Tree) {
					var tree:Tree = childClip as Tree;
					if (tree.hitbox.hitTestPoint(x_next, y_next, false)) {
						return true;
					}
				} else if (childClip is BaseSegment) {
					
					var wall:BaseSegment = childClip as BaseSegment;
					
					for each (var hitbox:CollisionBox in wall.Hitboxes) {
							if (hitbox.hitTestPoint(x_next, y_next, false)) {
								return true;
							}
						}
				}
			}
			return false;
		
		}
	}

}
