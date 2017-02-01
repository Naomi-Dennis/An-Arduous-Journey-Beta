package Assets.Utility 
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author Naomi J. Dennis
	 */
		public function StandardTextFormat(size:int=12, align:String="left", tFont:String="Georgia"):TextFormat
		{
			var tf:TextFormat = new TextFormat();
			tf.color = 0xffffff; 
			tf.font = FontLib[tFont.toLowerCase()]()
			tf.size = size; 
			tf.align = align;
			return tf; 
		}
}