package Towns
{
	import Assets.Effects.DropShadow;
	import Assets.Utility.CenterObjRelTo;
	import Assets.Utility.DrawButton;
	import Assets.Utility.DrawSquare;
	import Assets.Utility.DrawText;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.utils.getDefinitionByName;
	import Assets.Utility.ConvertEmbedToSprite;
	import items.*;
	import items.armor.*;
	import items.weapon.*;
	/**
	 * ...
	 * @author lk
	 */
	public class ShopStruct extends Sprite
	{
		private var CLASS_REFS_ITEMS:Array = [ Antidote, ConstitutionBook, DefenseBook, DexterityPotion, HealthPotion, MysteriousKey, PrizeBox, StrengthBook, StrengthPotion, Torch, WisdomBook, WisdomPotion];
		private var CLASS_REFS_ARMOR:Array = [ Staff, BearSkin, BlueCape, BluePants, BlueRobe, BrownPants, BrownRobe, BrownShoes, Chainmail, ElvenScalemail, FeatherHatBlue, FeatherHatGreen, FeatherHatRed, FighterGloves, GoldenBuckler, GreenRobe, HatStraw, HatWizardBlackGold, HatWizardBlackRed, HatWizardBlueGreen, HoodCyan, HoodGray, HoodGreen, HoodOrange, IronLeggings, LeatherArmor, LeopardSkin, OrchishRingmail, PlateMail, PurpleRobe, RedRobe, RoyalChainmail, RoyalShield, Scarf, ShirtBlack, ShirtHawaii, ShirtYellowWhite, SteelLeggings, StuddedLeatherArmor, StuddedMetalBuckler, StuddedPlateMail, TowerShield, Vest, WoodenBuckler];
		private var CLASS_REFS_WEAPONS:Array = [ BattleAxe, BlessedBlade, Blowgun, BookBlack, BookBlue, BookRed, BookWhite, Bow, Club, Crossbow, Dagger, DwarvenBattleAxe, Katana, Morningstar, OrchishGreatSword, OrchishLongsword, OrchishShortSword, RougansBattleAxe, Sling, StaffAnucis, StaffArcadi, StaffRenly, StaffScepter, StuddedMorningstar, SwiftKatana ]; 		
		public var nextFoo:Function;
		public var gold:int = 0;
		public var aItems:Array = [];
		public var bkgrnd:Object = {};
		public var myPar:MissionStruct;
		
		public function ShopStruct(_gold:String, _aItems:Array, _bkgrnd:String)
		{
			gold = parseInt(_gold);
			bkgrnd = BackgroundList[_bkgrnd.toLowerCase()]();
			var type:String = "";
			var defName:String = "";
			var itemClass:*;
			for (var i:* in _aItems)
			{
				type = _aItems[i].type.toLowerCase();
				if (type.toLowerCase() != "item" && type.toLowerCase() != "skill")
				{
					defName = "items." + type.toLowerCase() + "." + _aItems[i].name;
				}
				else if (type.toLowerCase() == "skill")
				{
					defName = "skills." + _aItems[i].name;
				}
				else
				{
					defName = "items." + _aItems[i].name;
				}
				itemClass = getDefinitionByName(defName);
				aItems.push({item: new itemClass(), value: parseInt(_aItems[i].value)});
			}
		}
		
		private function nextFunc():void
		{
			myPar.nextFoo();
		}
		
		public function render():void
		{
			var header:TextField = DrawText("You've found a shop", 24, "center", "unzialish");
			header.x = 540 / 2 - header.width / 2;
			header.y = 25
			DropShadow(header);
			var newShop:TravelingSalesman = new TravelingSalesman(aItems, gold, Main.glblPlayer.inventory);
			newShop.callback = nextFunc; 
			newShop.y = 100;
			newShop.x = 540 / 2 - newShop.width / 2;
			var closeBtn:Sprite = DrawButton("Close", 35);
			CenterObjRelTo(closeBtn, newShop);
			closeBtn.y = newShop.y + newShop.height + 150;
			var bkgrndImg:Sprite = ConvertEmbedToSprite(bkgrnd.background);
			bkgrndImg.width = 540;
			bkgrndImg.height = 500;
			bkgrndImg.y = 20
			var overshadow:Sprite = DrawSquare(540, 540);
			overshadow.alpha = 0.4;
			addChild(bkgrndImg);
			
			addChild(overshadow);
			addChild(header);
			addChild(newShop);
		}
		
		public function close(e:MouseEvent):void
		{
			nextFunc();
		}
	
	}

}