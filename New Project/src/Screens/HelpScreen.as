package Screens 
{
	import Assets.Utility.CenterObjRelTo;
	import Assets.Utility.ConvertEmbedToSprite;
	import Assets.Utility.DrawButton;
	import Assets.Utility.DrawSquare;
	import Assets.Utility.RemoveSprite;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class HelpScreen extends Sprite
	{
		[Embed(source = "../pics/help images/actionPoints.png")]
		public var actionPtsImg:Class; 
		[Embed(source = "../pics/help images/endTurn.png")]
		public var endTurnImg:Class; 
		[Embed(source = "../pics/help images/healthbar.png")]
		public var healthBarImg:Class; 
		[Embed(source = "../pics/help images/movementPoints.png")]
		public var movementPtsImg:Class; 
		[Embed(source = "../pics/help images/quickslot.png")]
		public var quickslotImg:Class;
		public var close:Sprite = DrawButton("Close", 20); 
		
		public var endTurn:Sprite = new Sprite();
		public var healthBar:Sprite = new Sprite();
		public var movementPts:Sprite = new Sprite();
		public var quickSlots:Sprite = new Sprite();
		public var actionPts:Sprite = new Sprite();
		public var SHADE:Sprite = DrawSquare(540, 540);
		public function HelpScreen() 
		{
			SHADE.alpha = 0;
			endTurn = ConvertEmbedToSprite(endTurnImg);
			healthBar = ConvertEmbedToSprite(healthBarImg);
			movementPts = ConvertEmbedToSprite(movementPtsImg);
			quickSlots = ConvertEmbedToSprite(quickslotImg);
			actionPts = ConvertEmbedToSprite(actionPtsImg);
			movementPts.x -= 10;
			movementPts.y += 60;
			
			healthBar.x = 540 / 2 - healthBar.width / 2; 
			healthBar.y = 15; 
			
			quickSlots.x = 540 / 2 - quickSlots.width / 2 ;
			quickSlots.y = 400;
			
			actionPts.x = 340;
			actionPts.y = 65
			
			addChild(movementPts);
			addChild(healthBar);
			addChild(quickSlots);
			addChild(actionPts);
			addChild(SHADE);
			close.x = 540 / 2 -  close.width / 2; 
			close.y = 540 / 2 - close.height / 2; 
			addChild(close);
			close.addEventListener(MouseEvent.CLICK, closeHelpWin);
		}
		
		public function closeHelpWin(e:MouseEvent):void {
			this.parent.removeChild(this); 
		}
		
	}

}