package 
{
	/**
	 * ...
	 * @author Naomi 
	 */
	public class SkillLib 
	{
		private static var skills:Object = { };
		public function SkillLib() 
		{
			
		}
		public static function addSkill(name:String, ap:int, cooldown:int):void{
			skills[name] = new Object(); 
			skills[name].ap = ap; 
			skills[name].cooldown = cooldown;
		}
		public static function getSkill(name:String):Object{
			return skills[name]; 
		}
		public static function getCooldown(name:String):int{
			var obj:Object = getSkill(name);
			return obj.cooldown; 
		}
	}

}