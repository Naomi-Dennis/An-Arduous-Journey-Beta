package 
{
	import Assets.Utility.RemoveSprite;
	import skills.*;
	import Screens.GetSkillScreen;
	/**
	 * ...
	 * @author lk
	 */
	public class LevelUpScreens 
	{
		[Embed(source = "pics/backgrounds/woods.png")]
		private static var img:Class; 
		public function LevelUpScreens() 
		{
			
		}
		private static function closeWin(win:GetSkillScreen):Function {
			return function():void {
				RemoveSprite(win); 
			}
		}
		public static function general_level_up(mob:Mob):GetSkillScreen {
			var skillUp:GetSkillScreen = new GetSkillScreen(mob, [], img, mob.getName() + " has leveled up!", closeWin(skillUp));
			return skillUp;
		}
		public static function warrior_level_1(mob:Mob):GetSkillScreen {
			var skillUp:GetSkillScreen = new GetSkillScreen(mob, [{skill:new DoubleStrike(), ico:new DoubleStrike().getIcon() }, {skill:new StrongAttack(), ico:new StrongAttack().getIcon()}], img, mob.getName() + " has leveled up!", closeWin(skillUp));
			return skillUp;
		}	
		public static function warrior_level_2(mob:Mob):GetSkillScreen {
			var skillUp:GetSkillScreen = new GetSkillScreen(mob, [{skill:new DefensiveStance(), ico:new DefensiveStance().getIcon()}, {skill:new Fear(), ico:new Fear().getIcon()}], img, mob.getName() + " has leveled up!", closeWin(skillUp));
			return skillUp;	
		}
		public static function warrior_level_3(mob:Mob):GetSkillScreen {
			var skillUp:GetSkillScreen = new GetSkillScreen(mob, [{skill:new LifeSteal(), ico:new LifeSteal().getIcon()}, {skill:new Rage(), ico:new Rage().getIcon()}], img, mob.getName() + " has leveled up!", closeWin(skillUp));
			return skillUp;
		}
		public static function warrior_level_4(mob:Mob):GetSkillScreen {
			var skillUp:GetSkillScreen = new GetSkillScreen(mob, [{skill:new PressurePoints(), ico:new PressurePoints().getIcon()}, {skill:new TripleStrike(), ico:new TripleStrike().getIcon()}], img, mob.getName() + " has leveled up!", closeWin(skillUp));
			return skillUp;
		}
		public static function warrior_level_5(mob:Mob):GetSkillScreen {
			var skillUp:GetSkillScreen = new GetSkillScreen(mob, [{skill:new BleedingHeart(), ico:new BleedingHeart().getIcon()},{skill:new ArmorPiercing(), ico:new ArmorPiercing().getIcon()}], img, mob.getName() + " has leveled up!", closeWin(skillUp));
			return skillUp;
		}
		//////////////////////
		// **** Archer *** //
		////////////////////
		public static function archer_level_1(mob:Mob):GetSkillScreen {
			var skillUp:GetSkillScreen = new GetSkillScreen(mob, [{skill:new DoubleShot(), ico:new DoubleShot().getIcon()}, {skill:new InflictWound(), ico:new InflictWound().getIcon()}], img, mob.getName() + " has leveled up!", closeWin(skillUp));
			return skillUp;
		}
		public static function archer_level_2(mob:Mob):GetSkillScreen {
			var skillUp:GetSkillScreen = new GetSkillScreen(mob, [{skill:new Haste(), ico:new Haste().getIcon()}, {skill:new FireArrow(), ico:new FireArrow().getIcon()}], img, mob.getName() + " has leveled up!", closeWin(skillUp));
			return skillUp;
		}
		public static function archer_level_3(mob:Mob):GetSkillScreen {
			var skillUp:GetSkillScreen = new GetSkillScreen(mob, [{skill:new ArmorPiercing(), ico:new ArmorPiercing().getIcon()}, {skill:new DefensiveStance(), ico:new DefensiveStance().getIcon()}], img, mob.getName() + " has leveled up!", closeWin(skillUp));
			return skillUp;
		}
		public static function archer_level_4(mob:Mob):GetSkillScreen {
			var skillUp:GetSkillScreen = new GetSkillScreen(mob, [{skill:new LifeSteal(), ico:new LifeSteal().getIcon()}, {skill:new NailArrow(), ico:new NailArrow().getIcon()}], img, mob.getName() + " has leveled up!", closeWin(skillUp));
			return skillUp;
		}
		public static function archer_level_5(mob:Mob):GetSkillScreen {
			var skillUp:GetSkillScreen = new GetSkillScreen(mob, [{skill:new PoisonArrow(), ico:new PoisonArrow().getIcon()}, {skill:new TripleShot(), ico:new TripleShot().getIcon()}], img, mob.getName() + " has leveled up!", closeWin(skillUp));
			return skillUp;
		}	
		
		////////////////////
		// **** Mage **** //
		////////////////////
		public static function mage_level_1(mob:Mob):GetSkillScreen {
			var skillUp:GetSkillScreen = new GetSkillScreen(mob, [{skill:new FireStrike(), ico:new FireStrike().getIcon()}, {skill:new LifeSteal(), ico:new LifeSteal().getIcon()}], img, mob.getName() + " has leveled up!", closeWin(skillUp));
			return skillUp;
		}
		public static function mage_level_2(mob:Mob):GetSkillScreen {
			var skillUp:GetSkillScreen = new GetSkillScreen(mob, [{skill:new LowerDefense(), ico:new LowerDefense().getIcon()}, {skill:new LowerConsitution(), ico:new LowerConsitution().getIcon()}], img, mob.getName() + " has leveled up!", closeWin(skillUp));
			return skillUp;
		}
		public static function mage_level_3(mob:Mob):GetSkillScreen {
			var skillUp:GetSkillScreen = new GetSkillScreen(mob, [{skill:new Poison(), ico:new Poison().getIcon()}, {skill:new Anoint(), ico:new Anoint().getIcon()}], img, mob.getName() + " has leveled up!", closeWin(skillUp));
			return skillUp;
		}
		public static function mage_level_4(mob:Mob):GetSkillScreen {
			var skillUp:GetSkillScreen = new GetSkillScreen(mob, [{skill:new PressurePoints(), ico:new PressurePoints().getIcon()}, {skill:new IceAttack(), ico:new IceAttack().getIcon()}], img, mob.getName() + " has leveled up!", closeWin(skillUp));
			return skillUp;
		}
		public static function mage_level_5(mob:Mob):GetSkillScreen {
			var skillUp:GetSkillScreen = new GetSkillScreen(mob, [], img, mob.getName() + " has leveled up!", closeWin(skillUp));
			return skillUp;
		}	
		public static function mage_level_6(mob:Mob):GetSkillScreen {
			var skillUp:GetSkillScreen = new GetSkillScreen(mob, [], img, mob.getName() + " has leveled up!", closeWin(skillUp));
			return skillUp;
		}	
		public static function get_stat(mob:Mob):GetSkillScreen{
			var skillUp:GetSkillScreen = new GetSkillScreen(mob, [], img, mob.getName() + " has leveled up!", closeWin(skillUp));
			return skillUp;
		}
		
	}

}