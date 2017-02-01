package Screens 
{
	import Assets.Utility.CloningSprite;
	import Assets.Utility.DrawButton;
	import Assets.Utility.RemoveSprite;
	import Towns.MissionStruct;
	import Towns.SettingStruct;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import mobs.PlayersLibrary;
	/**
	 * ...
	 * @author ...
	 */
	public class PrologueScreen extends ExpositionScreen
	{
		private var expo:String = ""; 
		private var tutStruct:MissionStruct; 
		public function PrologueScreen() 
		{
			super(false);
			addLine("Would  you  like  to  skip  the  prologue?");
			addLine("If  you  are  new  to  the  game,  it  is  recommended  that  you  play  the  prologue.");
			setText(expo);
			addChild(continueBtn);
			var skipTut:Sprite = DrawButton("Skip", 24);
			skipTut.x = 540 / 2 - skipTut.width / 2; 
			skipTut.y = continueBtn.y + continueBtn.height + 20; 
			addChild(skipTut);
			var event1:SettingStruct = new SettingStruct("Your name is Jack. You're leaning against the wall of the bar with your friends Arnold and Reggie.","barracks", []); 
			var event2:SettingStruct = new SettingStruct("The men inside speak of the dangerous monsters lurking threatening the town.\n\"We need to find a way over to Thormund\", Arnold says.","barracks", []); 
			var event3:SettingStruct = new SettingStruct("\"Thormund's a long way away\" Jack says. \"How'd we even get there?\"\n\n\"I have an idea!\" Reggie says before leaving the wall and entering the bar.", "barracks", []); 
			var event4:SettingStruct = new SettingStruct("A few moments later he steps out with one of the men. \"So you lot want to venture to Thormund eh? Well, I have you know it's not as easy as all that. First we have to secure the neighboring towns then you can get your crack at Thormund.\" the man says.","barracks", []); 
			var event5:SettingStruct = new SettingStruct("The man looks you all up and down. \"You all look like you might make the journey, but let's see if you can kill a man. Have at me.\"", "barracks", []); 
			var event6:BattleStruct = new BattleStruct("1","barracks", ["Donald"]);
			event6.isTut = true;
			var event7:SettingStruct = new SettingStruct("\"Well, that's it then.\" the man says. \"You can come with us to the first town. It's called Wickerman I think.\"", "barracks", []); 
			tutStruct = new MissionStruct("Prologue", "", [event1, event2, event3, event4, event5, event6, event7], null, "2"); 
			continueBtn.addEventListener(MouseEvent.CLICK, startTut);
			skipTut.addEventListener(MouseEvent.CLICK, skipHandle); 
			
		}
		private function startTut(e:MouseEvent):void{
			if(!Main.army.loaded){
				Main.army.addToCurrent(PlayersLibrary.createJack()); 
				Main.army.addToCurrent(PlayersLibrary.createArnold()); 
				Main.army.addToCurrent(PlayersLibrary.createReggie()); 
			}
			tutStruct.addEventListener(Event.REMOVED_FROM_STAGE, resetArmy);
			addChild(tutStruct);
			tutStruct.begin();
		} 
		private function resetArmy(e:Event):void{
			if(!Main.army.loaded){
				Main.army.clearCurrents();
				Main.army.deleteAll();
				if(Main.army.getCurrent().length == 0){
					Main.army.setArmy([PlayersLibrary.createJack(), PlayersLibrary.createReggie(), PlayersLibrary.createArnold()])
				}
			}
			tutStruct.removeEventListener(Event.REMOVED_FROM_STAGE, resetArmy);
			RemoveSprite(this); 
			
		}
		private function skipHandle(e:MouseEvent):void{
			RemoveSprite(this);
			if(Main.army.getCurrent().length == 0){
				Main.army.setArmy([PlayersLibrary.createJack(), PlayersLibrary.createArnold(), PlayersLibrary.createReggie()])
			}
		}
		private function addLine(str:String):void{
			expo += str + "\n\n";
		}
	}

}