package
{
	import Assets.SoundClass;
	import Assets.Utility.ChangeColor;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author lk
	 */
	public class SndControlGUI extends Sprite
	{
		private var sndClassRef:SoundClass;
		private var soundOn:Boolean = true;
		public function SndControlGUI(sndClass:SoundClass, ico:Sprite)
		{
			sndClassRef = sndClass;
			ico.width = 20; 
			ico.height = 20; 
			addChild(ico);
			ChangeColor(this, 0xffffff); 
			addEventListener(MouseEvent.CLICK, toggleSound);
		
		}
		
		public function toggleSound(e:MouseEvent):void
		{
			if (soundOn)
			{
				alpha = 0.5; 
				soundOn = false;
				sndClassRef.adjustSoundVolume(0);
			}
			else if (!soundOn)
			{
				alpha = 1; 
				soundOn = true;
				sndClassRef.adjustSoundVolume(0.5)
			}
		}
	
	}

}