package Assets.Utility 
{
	import flash.media.Sound;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
		public function AddSound(sndObj:*):Sound
		{
			var snd:Sound = new sndObj() as Sound; 
			return snd; 
		}


}