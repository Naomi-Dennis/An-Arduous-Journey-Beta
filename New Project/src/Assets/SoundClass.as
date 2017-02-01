package Assets
{
	import Assets.Utility.AddSound;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Naomi J. Dennis
	
	 */
	public class SoundClass
	{
		private  var sndChan:SoundChannel = new SoundChannel();
		private  var sndTrans:SoundTransform = new SoundTransform();
		private  var sndVol:Number = .5;
		private  var soundOn:Boolean = false;
		private  var aSounds:Array = []; 
		private var songPos:int = 1; 
		private var maxSongPos:int = 1; 
		private var songPlaylist:Array = []; 
		private var playListMode:Boolean = false; 
		private var fadeHandle:Function = null;
		private var fadeTimer:Timer = new Timer(75);
		public function SoundClass()
		{
		
		}
		public function changeMaxNumSongs(n:int):void{
			maxSongPos = n + 1; 
		}
		public function setSongClasses(array:Array):void{
			songPlaylist = array; 
		}
		public function setPlayListToTrue():void{
			playListMode = true; 
		}
		public  function playSound(sndClass:*=null, loop:Boolean = false, fade:Boolean=false):void
		{
			
			if (playListMode){
				sndClass = songPlaylist[0];
			}
			var sndObj:Sound = AddSound(sndClass);
			if(!fade){
				(loop) ? sndChan = sndObj.play(0, 999) : sndChan = sndObj.play();
			}
			else{
				fadeFoo(sndObj, loop);
			}
			aSounds.push(sndObj); 
			adjustSoundVolume(sndVol);
			
			if (playListMode){
				sndChan.addEventListener(Event.SOUND_COMPLETE, playNextSong); 
			}
		}
		private function playNextSong(e:Event):void{
			songPos++; 
			if (songPos == (maxSongPos)){
				songPos = 1;
			}
			var currentSong:Sound = AddSound(songPlaylist[songPos - 1]);
			adjustSoundVolume(sndVol);
			sndChan = currentSong.play();
			sndChan.addEventListener(Event.SOUND_COMPLETE, playNextSong); 
			adjustSoundVolume(sndVol);
		}
		private function fadeFoo(newSnd:Sound, loop:Boolean):void{
			fadeHandle = fadeOut(newSnd, loop)
			fadeTimer.addEventListener(TimerEvent.TIMER, fadeHandle );
			fadeTimer.start();
		}
		private function fadeOut(newSnd:Sound, loop:Boolean):Function{
			return function(e:TimerEvent):void{
				adjustSoundVolume(sndVol - 1);
				if (sndVol == 0){
					e.currentTarget.stop();
					clear();
					fadeTimer.removeEventListener(TimerEvent.TIMER, fadeHandle);
					playSound(newSnd, loop, false); 
				}
			}
		}
		public  function stop():void {
			sndChan.stop();
			
		}
		public  function clear():void {
			sndChan.stop();
			for (var i:* in aSounds) {
				
				aSounds.shift();
			}
		}
		public  function adjustSoundVolume(newVolume:Number):void
		{
			//...
			sndVol = newVolume;
			sndTrans.volume = sndVol;
			sndChan.soundTransform = sndTrans;
		}
	}

}