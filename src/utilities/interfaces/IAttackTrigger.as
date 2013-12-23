package utilities.interfaces 
{
	import basics.hitboxes.AttackBox;
	
	/**
	 * ...
	 * @author Gabriel
	 */
	public interface IAttackTrigger 
	{
		function attackBoxTriggeredByPlayer(attackBox:AttackBox);
	}
	
}