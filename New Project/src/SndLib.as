package
{
	import Assets.Utility.AddSound;
	
	
	/**
	 * ...
	 * @author Naomi J. Dennis
	
	 */
	public class SndLib
	{
		[Embed(source="/snd/Button Click.mp3")]
		private static var click:Class;
		[Embed(source="snd/hurt sound 2.mp3")]
		private static var hurt:Class;
		[Embed(source="snd/Walking On Grass 5s.mp3")]
		private static var walking:Class;
		[Embed(source = "snd/Win Battle Sound.mp3")]
		private static var winBattle:Class; 
		[Embed(source = "snd/Lose Sound.mp3")]
		private static var loseSnd:Class; 
		[Embed(source = "snd/Heal.mp3")]
		private static var healSnd:Class; 
		[Embed(source = "snd/Hurt Sound.mp3")]
		private static var manHurtSnd:Class; 
		[Embed(source = "snd/Whoosh.mp3")]
		private static var whooseSnd:Class; 
		[Embed(source = "snd/Lakeside Sounds.mp3")]
		private static var lakesideSnd:Class; 
		[Embed(source = "snd/Calm Ocean Sounds.mp3")]
		private static var oceanSnd:Class; 
		public function SndLib()
		{
		
		}
		public static function manHurt():void{
			Main.sndConfig.playSound(manHurtSnd); 
		}
		public static function heal():void{
			Main.sndConfig.playSound(healSnd);
		}
		public static function winBattleSnd():void {
			Main.sndConfig.playSound(winBattle);
		}
		public static function loseBattleSnd():void {
			Main.sndConfig.playSound(loseSnd);
		}
		public static function playButtonClick():void
		{
			Main.sndConfig.playSound(click);
		}
		
		public static function hurtSnd():void
		{
			Main.sndConfig.playSound(hurt);
		}
		
		public static function walkingSnd():void
		{
			Main.sndConfig.playSound(walking);
		}
		public static function whoosh():void{
			Main.sndConfig.playSound(whooseSnd);
		}
		public static function ocean():void{
			Main.ambienceConfig.playSound(oceanSnd, true);
		}
		public static function lakeside():void{
			Main.ambienceConfig.playSound(lakesideSnd, true);
		}
	}

}