package 
{
	/**
	 * ...
	 * @author Naomi J Dennis
	 */
	public class FontLib 
	{
		[Embed(source="04B_03_.TTF",
        fontName = "04B_03_",
        mimeType = "application/x-font",
        advancedAntiAliasing="true",
        embedAsCFF="false")]
		private static var mainFontClass:Class;
		[Embed(source="GEORGIA.TTF",
        fontName = "Georgia",
        mimeType = "application/x-font",
        advancedAntiAliasing="true",
        embedAsCFF = "false")]
		private static var georgiaClass:Class;
		[Embed(source="RAINYHEARTS.TTF",
        fontName = "rainyhearts",
        mimeType = "application/x-font",
        advancedAntiAliasing="true",
        embedAsCFF = "false")]
		private static var rainyHeartsClass:Class;
		[Embed(source="MTCORSVA.TTF",
        fontName = "Monotype Corsiva",
        mimeType = "application/x-font",
        advancedAntiAliasing="true",
        embedAsCFF="false")]
		private static var monotypeClass:Class;
		[Embed(source="UNZIALISH.TTF",
        fontName = "unzialish",
        mimeType = "application/x-font",
        advancedAntiAliasing="true",
        embedAsCFF="false")]
		private static var uniClass:Class;
		[Embed(source="MORRISROMAN-BLACK.TTF",
        fontName = "Morris Roman",
        mimeType = "application/x-font",
        advancedAntiAliasing="true",
        embedAsCFF="false")]
		private static var morrisClass:Class;
		//georgia
		public function FontLib() 
		{
			
		}
		public static function mainFont():String{
			return "04B_03_"
		}
		public static function georgia():String{
			return "Georgia"; 
		}
		public static function rainyhearts():String{
			return "rainyHearts"
		}
		public static function monotype_corsiva():String{
			return "Monotype Corsiva"
		}
		public static function unzialish():String{
			return "unzialish";
		}
		public static function morris_roman():String{
			return "Morris Roman";
		}
		
	}

}