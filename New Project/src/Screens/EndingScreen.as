package Screens 
{
	/**
	 * ...
	 * @author ...
	 */
	public class EndingScreen extends ExpositionScreen
	{
		private var expo:String = ""; 
		public function EndingScreen() 
		{
			addLine("");
			addLine("");
			addLine("");
			addLine("");
			addLine("- And thus the demon of Thormund Cave is slaughtered -"); 
			addLine("- His army scatter about the corners of the world, fleeing from townships -");
			addLine("- wandering through the world without a head to lead them -");
			addLine("- Alas, your job is done and the people are safe -");
			addLine("- You rest with your army, drinking and gambling, marrying and breeding as men do -"); 
			//addLine("However, you notice tournaments springing up in Bromide and Wickerman,");
			//addLine("perhaps it's time for a little activity?"); 
			
			setText(expo);
		}
		private function addLine(str:String):void{
			expo += str + "\n\n";
		}
		
	}

}