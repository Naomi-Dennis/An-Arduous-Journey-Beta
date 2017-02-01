package Screens 
{
	import Assets.Utility.CenterObjRelTo;
	import Assets.Utility.ConvertEmbedToSprite;
	import Assets.Utility.DrawButton;
	import Assets.Utility.DrawSquare;
	import Assets.Utility.DrawText;
	import Assets.Utility.DrawTextArea;
	import Assets.Utility.GlowObj;
	import Assets.Utility.PlaceObjBelowRel;
	import Assets.Utility.RemoveFilters;
	import Assets.Utility.RemoveSprite;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.ui.Mouse;
	/**
	 * ...
	 * @author kljjlk
	 */
	public class WizardMissionSelect extends Sprite
	{
		[Embed(source = "../pics/potraits/Wizard.png")]
		public var beserkerImg:Class;
		[Embed(source="../pics/Medieval Town Sketch 1 - Oiled.png")]
		public var bkgrndPic:Class;
		public var overshadow:Sprite = DrawSquare(540, 540);
		public var header:TextField = DrawText("Missions : Ellis Rody", 36, "center");  
		public var aBtns:Array = []; 
		public var ico:Sprite = new Sprite();
		public var backBtn:Sprite = DrawButton("Back", 26);
		public function WizardMissionSelect() 
		{
			var bkgrnd:Sprite = ConvertEmbedToSprite(bkgrndPic);
			bkgrnd.width = 540;
			bkgrnd.height = 540; 
			ico = ConvertEmbedToSprite(beserkerImg); 
			ico.width = 128;
			ico.height = 128; 
			ico.y = 15; 
			CenterObjRelTo(ico, overshadow); 
			CenterObjRelTo(header, overshadow); 
			PlaceObjBelowRel(header, ico);
			overshadow.alpha = 0.7; 
			addChild(bkgrnd);
			addChild(overshadow); 
			addChild(header); 
			addChild(ico); 
			addChild(backBtn); 
			createMissionButtons();
			backBtn.y = 540 - backBtn.height - 5;
			backBtn.x = 5; 
			GlowObj(backBtn, 0xffffff, 3); 
			
			backBtn.addEventListener(MouseEvent.ROLL_OUT, onOut);
			backBtn.addEventListener(MouseEvent.ROLL_OVER, onHover);
			backBtn.addEventListener(MouseEvent.CLICK, goBack);
		}
		public function createMissionButtons():void {
			var offsetY:int = 30; 
			var originY:int = 150; 
			var fontSize:int = 20;
			var missionOne:Sprite = DrawButton("A Temple of Respite", fontSize);
			aBtns = [missionOne];
			CenterObjRelTo(missionOne, header);

			
			PlaceObjBelowRel(missionOne, header, offsetY); 
;
			
			addChild(missionOne);
		
			
			 
			
			GlowObj(missionOne, 0xffffff, 3); 
		}
		public function onHover(e:MouseEvent):void {
			var spr:Sprite = e.currentTarget as Sprite;
			RemoveFilters(spr);
		}
		public function onOut(e:MouseEvent):void {
			var spr:Sprite = e.currentTarget as Sprite;
			GlowObj(spr, 0xffffff, 3); 
		}
		public function enterMission(mission:Sprite):Function {
			return function(e:MouseEvent):void {
				this.parent.addChild(mission);
				RemoveSprite(this);
			}
		}
		public function goBack(e:MouseEvent):void {
			var chooseChar:ChooseCharacter = new ChooseCharacter("campaign");
			this.parent.addChild(chooseChar);
			RemoveSprite(this); 
		}
	}

}