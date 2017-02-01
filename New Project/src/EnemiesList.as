package 
{
	import Assets.Inventory;
	import Assets.Utility.RandomNumber;
	import mobs.Enemies.*;
	import mobs.CampaignEnemies.*;
	/**
	 * ...
	 * @author lk
	 */
	public class EnemiesList 
	{
		
		public function EnemiesList() 
		{
			
		}
		public static function centuar():Class {
			var randomNum:int = RandomNumber(2, 1); 
			if (randomNum == 1) {
				return ArcherCentaur;
			}
			else {
				return MeleeCentaur;
			}
		}
		public static function donald():Class{
			return Donald; 
		}
		public static function archercentuar():Class {
			return  ArcherCentaur;
		}
		public static function blackbear():Class {
			return  BlackBears;
		}
		public static function darkbattlemage():Class {
			return  DarkBattleMage;
		}
		public static function darkpriest():Class {
			return  DarkPriest;
		}
		public static function deeptroll():Class {
			return  DeepTroll;
		}
		public static function devil():Class {	
			return  Devil;
		}
		public static function imp():Class {
			return  Imp;
		}
		public static function irontroll():Class {
			return  IronTroll;
		}
		public static function meleecentuar():Class {
			return  MeleeCentaur;
		}
		public static function ogre():Class {
			return  Ogres;
		}
		public static function orcarcher():Class {
			return  OrcArcher;
		}
		public static function orc():Class{
			var rand:int = RandomNumber(3, 1);
			if (rand == 1){
				return orcarcher();
			}
			else{
				return orcknight(); 
			}
			
		}
		public static function orcknight():Class {
			return  OrcKnight;
		}
		public static function orcwarlord():Class {
			return  OrcWarlord;
		}
		public static function orcwarrior():Class {
			return  OrcWarrior; 
		}
		public static function rat():Class {
			return  Rat;
		}
		public static function rocktroll():Class {
			return  RockTroll;
		}
		public static function shade():Class {
			return  Shade;
		}
		public static function snake():Class {
			return Snake;
		}
		public static function soldierarcher():Class {
			return  SoldierArcher;
		}
		public static function soldierswordsman():Class {
			return  SoldierSwordsman;
		}
		public static function troll():Class {
			return  Troll;
		}
		public static function twoheadedogre():Class {
			return  TwoHeadedOgre; 
		}
		public static function possessedsoldier():Class {
			var randomNum:int = RandomNumber(2, 1); 
			if (randomNum == 1) {
				return VillageFarmerWizard
			}
			else {
				return VillageFarmerWarrior
			}
		}
		public static function possessedvillager():Class {
			var randomNum:int = RandomNumber(2, 1); 
			if (randomNum == 1) {
				return VillageFarmerWizard
			}
			else {
				return VillageFarmerWarrior
			}
		}
		public static function bandit():Class {
			var randomNum:int = RandomNumber(2, 1); 
			if (randomNum == 1) {
				return banditwarrior();
			}
			else {
				return banditarcher();
			}
		}
		public static function banditwarrior():Class {
			return BanditWithSword;  
		}
		public static function banditarcher():Class {
			return BanditWithBow; 
		}
		public static function banditbattlemage():Class {
			return BanditBoss; 
		}
		public static function door():Class {
			return Door; 
		}
		public static function alligator():Class {
			return Alligator; 
		}
		public static function wilddog():Class{
			return WildDog;
		}
		public static function wolf():Class{
			return Wolf; 
		}
		public static function demon():Class{
			return Demon; 
		}
		public static function demontroll():Class{
			return Demon; 
		}
		public static function skeleton():Class{
			return Skeleton; 
		}
		public static function rottingdemon():Class{
			return RottingDemon;
		}
	}

}