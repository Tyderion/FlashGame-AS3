package {
	
	import basics.BloodSplatter;
	import basics.hitboxes.InteractionBox;
	import environment.nature.Tree;
	import environment.wall.Wall;
	import flash.display.MovieClip;
	import flash.events.Event;
	import interfaces.HealthBar;
	
	import utilities.*;
	
	import vendor.KeyObject;
	
	public dynamic class Root extends MovieClip {
		
		var healthbar:HealthBar;
		private var _walls:Array = new Array();
		
		private var keyPresses:KeyObject;
		private var _leftPressed:Boolean = false; //keeps track of whether the left arrow key is pressed
		private var _rightPressed:Boolean = false; //same, but for right key pressed
		private var _upPressed:Boolean = false; //...up key pressed
		private var _downPressed:Boolean = false; //...down key pressed
		private var _attackPressed:Boolean = false; //...down key pressed
		
		public var player:Player;
		
		public function Root() {
			// constructor code
			healthbar = new HealthBar(100, 100, 0.5, 0.5);
			stage.addChild(healthbar);
			keyPresses = new KeyObject(this.stage);
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
			
			for (var a = 0; a < 5; a++) {
				if (a == 2) continue;
				trace(a);
			};
			
			
			/* Swap Sort xD TODO */
			for (var i = 0; i < this.numChildren; i++) {
				var childClip:MovieClip = getChildAt(i) as MovieClip;
				if (childClip is Tree || childClip is Wall) {
					for (var j = 0; j < this.numChildren; j++) {
						var childClip2:MovieClip = getChildAt(j) as MovieClip;
						if (childClip2 is Tree || childClip2 is Wall) {
							if (childClip == childClip2) continue;
							if ( childClip.y < childClip2.y && getChildIndex(childClip) > getChildIndex(childClip2)
							 ||  childClip.y > childClip2.y && getChildIndex(childClip) < getChildIndex(childClip2) ) {
								 swapChildren(childClip, childClip2);
							 }
						}
					}
				}
			}
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
				if (childClip is Tree) {
					if (shouldSwapWithPlayer(childClip, 0)) {
							swapChildren(childClip, player);
						}
				} else if (childClip is Wall) {
					var wall:Wall = childClip as Wall;
					var offsetDoor:Number = 35;
					var offsetElse:Number = 10;
					if (wall.isDoor && wall.doorOpen) {
						if (Math.abs(this.player.x - wall.x) < 25) {
							if (shouldSwapWithPlayer(wall, offsetDoor)) {
								swapChildren(wall, player);
							}
						} else {
							if (shouldSwapWithPlayer(wall, offsetElse)) {
								swapChildren(wall, player);
							}
						}
					} else if (shouldSwapWithPlayer(wall, offsetElse)) {
						swapChildren(wall, player);
					}
				}
			}
		
		}
		
		private function shouldSwapWithPlayer(wall:MovieClip, offset:Number):Boolean {
			return (this.player.y - offset) < wall.y && getChildIndex(this.player) > getChildIndex(wall) 
				|| (this.player.y - offset) > wall.y && getChildIndex(this.player) < getChildIndex(wall)
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
				} else if (childClip is Wall) {
					
					var wall:Wall = childClip as Wall;
					if (wall.isDoor) {
					if (wall.door == null) {
						continue;
					}
					for each (var hitbox:InteractionBox in wall.door.getHitboxes()) {
						if (hitbox.hitTestPoint(x_next, y_next, false)) {
							return true;
						}
					}
				} else if (wall.hitbox.hitTestPoint(x_next, y_next, false)) {
					return true;
				}
				}
			}
			return false;
		
		}
	}

}
