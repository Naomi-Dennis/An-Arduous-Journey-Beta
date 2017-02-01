package Assets.Utility 
{
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */

		public function RandomNumber(hi:int,low:int) :int
		{
			return Math.floor(Math.random() * (hi - low + 1)) + low; 
		}
		


}