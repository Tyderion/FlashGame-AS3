﻿package enemies {
	
	import basics.hitboxes.BodyBox;
	import basics.hitboxes.AttackBox;
	import flash.display.MovieClip;
	import flash.events.Event;
	import utilities.*;
	import utilities.interfaces.IAttackTrigger;
	import utilities.interfaces.ILastFrameTrigger;
	
	public class Baby extends Enemy implements IAttackTrigger {
		
		public static var blabla = "String";
		
		private var HorizontalLimit = 100;
		private var VerticalLimit = 50;
		
		private var rootRef:Root;
		private var speed:Number;
		private var xspeed:Number;
		private var yspeed:Number;
		private var direction:String;
		private var nextAction:String = "idle";
		
		public var AttackTriggerLeft:AttackBox;
		public var AttackTriggerRight:AttackBox;
		
		public var attackAnimation:LastFrameTrigger;
		
		private var FixPositionX;
		private var FixPositionY;
		
		private var Wait;
		
		public function Baby() {
			super();
			this.rootRef = this.root as Root;
			Wait = Random.random(25);
			FixPositionX = int(this.x);
			FixPositionY = int(this.y);
			this.speed = Random.random(6) + 2;
			xspeed = this.speed;
			yspeed = 0;
			this.direction = Directions.RIGHT;
			addEventListener(Event.ENTER_FRAME, wait, false, 0, true);
		}
		
		public function wait(e:Event) {
			if (Wait > 0) {
				Wait--;
			} else {
				removeEventListener(Event.ENTER_FRAME, wait, false)
				addEventListener(Event.ENTER_FRAME, walk, false, 0, true);
			}
		}
		
		public function walk(e:Event):void {
			this.setAttackTriggerDelegate()
			
			if (this.x < (FixPositionX - HorizontalLimit)) {
				xspeed = this.speed;
				this.direction = Directions.RIGHT;
			}
			if (this.x > (FixPositionX + HorizontalLimit)) {
				
				xspeed = -this.speed;
				this.direction = Directions.LEFT;
			}
			
			if (this.y > (FixPositionY + VerticalLimit)) {
				yspeed = -this.speed;
				this.direction = Directions.UP;
			}
			
			if (this.y < (FixPositionY - VerticalLimit)) {
				yspeed = this.speed;
				this.direction = Directions.DOWN;
			}
			
			if ((xspeed != 0 || yspeed != 0)) {
				if (this.rootRef.collidesWithWall(this.x + xspeed, this.y + yspeed) || this.rootRef.collidesWithWall(this.x + xspeed + this.width * 2 / 3, this.y + yspeed)) {
					xspeed = -xspeed;
					this.direction = Directions.oppositeOf(this.direction);
				}
				this.nextAction = "baby_"+Actions.WALK+"_";
				this.x += xspeed;
				this.y += yspeed;
			}
			
			this.gotoAndStop(this.nextAction + this.direction);
		
		}
		
		private function setAttackTriggerDelegate() {
			if (this.AttackTriggerRight && this.AttackTriggerRight.delegate != this)
				this.AttackTriggerRight.delegate = this;
			if (this.AttackTriggerLeft && this.AttackTriggerLeft.delegate != this)
				this.AttackTriggerLeft.delegate = this;
		}
		
		public function attackBoxTriggeredByPlayer(box:AttackBox) {
			xspeed = 0;
			yspeed = 0;
			this.gotoAndStop(Actions.HIT + "_" + this.direction);
			this.attackAnimation.delegate = this;
			removeEventListener(Event.ENTER_FRAME, walk, false);
			removeEventListener(Event.ENTER_FRAME, wait, false);
		}
		
		override public function lastFrameEnded(animation:MovieClip) {
			super.lastFrameEnded(animation);
			this.parent.removeChild(this);
		}
	}

}

