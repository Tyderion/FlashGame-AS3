package {
	import flash.display.MovieClip;
	
	/**
	 * Implements health with heal and applyDamage functions.
	 * - MaxHealth is only seen by subclasses
	 * - current Health is not seen by any other classes
	 * - HealthPercentage, heal, applyDamage are public.
	 * @author Gabriel
	 */
	public class HealthEntity extends MovieClip {
		protected var maxHealth:Number = 100;
		private var _currentHealth:Number;
		
		public function HealthEntity() {
			super();
			_currentHealth = maxHealth;
		}
		
		/**
		 * Get the percentage of the current health between 0 and 1.
		 */
		public function get HealthPercentage():Number {
			return 1.0 / this.maxHealth * _currentHealth;
		}
		
		/**
		 * Apply Damage reducing current health.  If currentHealth would be smaller than 0, currentHealth is 0.
		 * @param	damage the amount of health subtracted.
		 */
		public function applyDamage(damage:Number) {
			this.currentHealth  =_currentHealth - damage;
		}
		
		/**
		 * Heal the entity, increasing its current health. If currentHealth would be greater than maxHealh, currentHealth is maxHealth.
		 * @param	amount the amount the current health is increased.
		 */
		public function heal(amount:Number) {
			this.currentHealth  = _currentHealth + amount;
		}
		
		private function set currentHealth(value:Number):void {
			if (value > this.maxHealth) {
				value = this.maxHealth;
			} else  if (value < 0 ) {
				value = 0;
			}
			_currentHealth = value;
		}

	
	}

}