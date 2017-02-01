package Towns 
{
	import flash.display.Sprite;
	import Screens.SettingBackground;
	import items.*;
	import items.weapon.*;
	import items.armor.*; 
	/**
	 * ...
	 * @author lk
	 */
	public class SettingStruct extends Sprite
	{
		private var CLASS_REFS_ITEMS:Array = [Antidote, ConstitutionBook, DefenseBook, DexterityPotion, HealthPotion, MysteriousKey, PrizeBox, StrengthBook, StrengthPotion, Torch, WisdomBook, WisdomPotion];
		private var CLASS_REFS_ARMOR:Array = [ BearSkin, BlueCape, BluePants, BlueRobe, BrownPants, BrownRobe, BrownShoes, Chainmail, ElvenScalemail, FeatherHatBlue, FeatherHatGreen, FeatherHatRed, FighterGloves, GoldenBuckler, GreenRobe, HatStraw, HatWizardBlackGold, HatWizardBlackRed, HatWizardBlueGreen, HoodCyan, HoodGray, HoodGreen, HoodOrange, IronLeggings, LeatherArmor, LeopardSkin, OrchishRingmail, PlateMail, PurpleRobe, RedRobe, RoyalChainmail, RoyalShield, Scarf, ShirtBlack, ShirtHawaii, ShirtYellowWhite, SteelLeggings, StuddedLeatherArmor, StuddedMetalBuckler, StuddedPlateMail, TowerShield, Vest, WoodenBuckler];
		private var CLASS_REFS_WEAPONS:Array = [ Staff, BattleAxe, BlessedBlade, Blowgun, BookBlack, BookBlue, BookRed, BookWhite, Bow, Club, Crossbow, Dagger, DwarvenBattleAxe, Katana, Morningstar, OrchishGreatSword, OrchishLongsword, OrchishShortSword, RougansBattleAxe, Sling, StaffAnucis, StaffArcadi, StaffRenly, StaffScepter, StuddedMorningstar, SwiftKatana ]; 		
		public var nextFoo:Function;
		public var prompt:String; 
		public var bkgrnd:Object = { };
		public var aActions:Array = [];
		public var myPar:MissionStruct; 
		private var finalEvent:Boolean; 
		public function SettingStruct(_prompt:String, _bkgrnd:String, _aActions:Array, finalEv:Boolean=false) 
		{
			prompt = _prompt;
			finalEvent = finalEv; 
			aActions = _aActions; 
			bkgrnd = BackgroundList[_bkgrnd.toLowerCase()](); 
		}
		public function render():void {
			setStoryboard();
			var action:String = "";
			var detail:String = "";
			for (var i:* in aActions) {
				action = aActions[i].action.toLowerCase();
				detail = aActions[i].value;
				Main.glblPlayer[action](detail); 
			}
			
		}
		private function nextFunc():void {
			myPar.nextFoo();
		}
		public function setStoryboard():void {
			var storyboard:SettingBackground;
			if(finalEvent){
				storyboard= new SettingBackground(bkgrnd.background, prompt, nextFunc);
			}
			else{
				storyboard= new SettingBackground(bkgrnd.background, prompt, nextFunc, finalEvent);
			}
			addChild(storyboard); 
		}
		
	}

}