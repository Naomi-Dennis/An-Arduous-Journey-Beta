package Assets.Utility 
{
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public function RollDie(multi:Number, face:int=4):int
	{
		var total:int = RandomNumber(face, 1);
		if (multi > 0) {
			return RollDie(multi - 1, face) + total;
		}
		else {
			return total; 
		}
	}

}