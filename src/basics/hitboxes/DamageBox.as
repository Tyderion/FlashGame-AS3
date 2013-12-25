﻿package basics.hitboxes {
	
	import enemies.Enemy;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import utilities.interfaces.Damage.IDamageTrigger;
	
	public class DamageBox extends Hitbox {
		
		
		private var delegate:IDamageTrigger;
		
		public function DamageBox() {
			super();
		}
		
		
		public function checkForPlayer(e:Event) {
			if (this.delegate != null) {
				if (this.hitTestObject(super.rootRef.player.body_hit)) {
					this.delegate.damageAppliedToPlayer(this, super.rootRef.player);
				}
			}
		}
		
		public function checkForEnemies(e:Event) {
			if (this.delegate != null) {
				for (var i:int = 0; i < super.rootRef.numChildren; i++)  {
					var child:DisplayObject = super.rootRef.getChildAt(i);
					if (child is Enemy) {
						var enemy:Enemy = child as Enemy;
						if (this.hitTestObject(enemy.body_hit)) {
							this.delegate.damageAppliedToEnemy(this, enemy);
						}
					}
				}
			
			}
		}
	
	}

}