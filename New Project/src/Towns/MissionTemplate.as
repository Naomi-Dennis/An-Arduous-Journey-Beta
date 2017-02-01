package Towns 
{
	import Assets.Utility.RemoveSprite;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import Screens.SettingBackground;
	import flash.events.Event; 
	/**
	 * ...
	 * @author lk
	 */
	public class MissionTemplate extends Sprite
	{
		protected var nextEvent:Function;
		protected var currentEvent:Function; 
		protected var lastEvent:Function;
		protected var completed:Boolean = false; 
		protected var gold:int = 0; 
		protected var aEvents:Array = []; 
		protected var missionName:String = ""; 
		protected var currentIndex:int = 0; 
		public function MissionTemplate(_name:String) 
		{
			missionName = _name
		}
		protected function clear():void {
			while (numChildren > 0) {
				removeChild( getChildAt(0) );
			}
		}
		public function resetMission():void {
			currentEvent = aEvents[0]; 
		}
		protected function setEvents(array:Array):void {
			aEvents = array;
		}
		protected function setFirstEvent(evt:Function):void {
			currentEvent = evt; 
		}
		public function begin():void {
			this[Main.glblPlayer.currentRoom](); 
		}
		public function getName():String {
			return missionName;
		}
		public function missionComplete():Boolean {
			return completed;
		}
		public function getReward():int {
			return gold; 
		}
		protected function addNMonsters(list:Array, monstClass:Class, n:int):void {
			for (var i:int = 0; i < n; ++i) {
				list.push(new monstClass()); 
			}
		}
		
		protected function setStoryboard(bkgrnd:Class, msg:String, callback:Function = null):void {
			clear();
			var storyboard:SettingBackground = new SettingBackground(bkgrnd, msg, callback);
			addChild(storyboard); 
		}
		protected function finishMission():void {
			completed = true; 
			Map(this.parent).enable();
			RemoveSprite(this); 
		}
	}

}