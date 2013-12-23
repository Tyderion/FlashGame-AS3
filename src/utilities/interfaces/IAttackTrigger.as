package utilities.interfaces 
{
	import basics.hitboxes.AttackBox;
	
	/**
	 * ...
	 * @author Gabriel
	 */
	public interface IAttackTrigger 
	{
		public function attackBoxTriggeredByPlayer(attackBox:IAttackBox);
	}
	
}