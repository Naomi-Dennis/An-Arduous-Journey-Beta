package Screens 
{
	import Assets.Utility.CenterObjRelTo;
	import Assets.Utility.ConvertEmbedToSprite;
	import Assets.Utility.DrawButton;
	import Assets.Utility.DrawText;
	import Assets.Effects.GlowObj;
	import Assets.Utility.PlaceObjBelowRel;
	import Assets.Utility.RemoveSprite;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class BarracksScreen extends Sprite
	{
		public var bkgrnd:Sprite = new ScreenBackground( { width:300, height: 300}, 0xcc0000, 0x800000); 
		public var logo:Sprite = new Sprite(); 
		public var header:TextField = DrawText("B a r r a c k s", 30);
		public var enemies:Array = [new Mob()]//array of enemy objects 
		
		public var trainingBtn:Sprite = DrawButton("Training", 15); 
		public var challengesBtn:Sprite = DrawButton("Challenges", 15); 
		public var leaveBtn:Sprite = DrawButton("Leave", 30);
		
		[Embed(source = "../pics/BarracksIcon.png")]
		public var logoClass:Class; 
		public function BarracksScreen() 
		{
			//leave btn //
			leaveBtn.x = bkgrnd.width - leaveBtn.width - 10;
			leaveBtn.y = bkgrnd.height - leaveBtn.height - 10;
			//fight btn //
			//header // 
			CenterObjRelTo(header, bkgrnd); 
			header.y = 10; 
			// training  //
			CenterObjRelTo(trainingBtn, bkgrnd); 
			trainingBtn.y = 150; 
			// challenges  // 
			CenterObjRelTo(challengesBtn, bkgrnd); 
			PlaceObjBelowRel(challengesBtn, trainingBtn);
			// logo //
			logo = ConvertEmbedToSprite(logoClass); 
			logo.width = 70;
			logo.height = 70; 
			CenterObjRelTo(logo, header); 
			logo.y = 10;
			header.y = Math.abs(logo.height / 2 - header.height / 2) + logo.y
			GlowObj(header, 0xffffff, 10); 
			addChild(bkgrnd); 
			addChild(logo);
			addChild(leaveBtn);
			addChild(header);
			addChild(trainingBtn);
			addChild(challengesBtn);
			
			
			// event listeners // 
			leaveBtn.addEventListener(MouseEvent.CLICK, leaveHandle);
		}
		
		public function leaveHandle(e:MouseEvent):void {
			RemoveSprite(this); 
		}
		public function loadChallenges():void {
			
		}
		public function loadTrainingSessions():void {
			
		}
		public function loadLevel():void {
			
		}
		
	}

}