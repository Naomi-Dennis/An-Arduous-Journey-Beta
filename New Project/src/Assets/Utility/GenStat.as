package Assets.Utility
{
	/**
	 * ...
	 * @author Naomi J. Dennis
	
	 */
	
	public function GenStat(rollMulti:int, multi:int, face:int=4):int
	{
		var i:int = 0;
		var total:int = 0;
		for (i = 0; i < rollMulti; i++) {
			total += RollDie(multi, face);
		}
		return total;
	}

}