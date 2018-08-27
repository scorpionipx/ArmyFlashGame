package  com.ipx.engine
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.ipx.engine.Enemy;
	import com.ipx.units.car_0;
	import com.ipx.units.car_1;
	import com.ipx.units.car_2;
	import com.ipx.units.tower;
	import com.ipx.units.tower_1;
	import com.ipx.units.aircraft_0;
	import com.ipx.units.helicopter_0;
	import com.ipx.units.tank_0;
	
	
	public class Engine extends MovieClip 
	{
		public var i:int;
		public static var enemyList:Array = new Array();
		public var IPXtower:tower_1;
		
		public function Engine() 
		{
			IPXtower = new tower_1(stage);
			stage.addEventListener(MouseEvent.CLICK, myClickReaction);
			stage.addChild(IPXtower);
			
			addUnits_car_0(0);
			addUnits_car_1(2);
			addUnits_car_2(0);
			addUnits_helicopter_0(0);
			addUnits_tank_0(1);
		}
		
		private function addUnits_car_1(n:int = 1):void
		{
			var counter:int;
			for(counter = 0;counter < n; counter ++)
			{
				var IPXunit:car_1 = new car_1(stage, IPXtower);
				stage.addChild(IPXunit);
				enemyList.push(IPXunit);
				IPXunit.addEventListener(Event.REMOVED_FROM_STAGE, removeEnemy, false, 0, true);
			}
		}
		
		private function addUnits_car_2(n:int = 1):void
		{
			var counter:int;
			for(counter = 0;counter < n; counter ++)
			{
				var IPXunit:car_2 = new car_2(stage, IPXtower);
				stage.addChild(IPXunit);
				enemyList.push(IPXunit);
				IPXunit.addEventListener(Event.REMOVED_FROM_STAGE, removeEnemy, false, 0, true);
			}
		}
		
		private function addUnits_car_0(n:int = 1):void
		{
			var counter:int;
			for(counter = 0;counter < n; counter ++)
			{
				var IPXunit:car_0 = new car_0(stage, IPXtower);
				stage.addChild(IPXunit);
				enemyList.push(IPXunit);
				IPXunit.addEventListener(Event.REMOVED_FROM_STAGE, removeEnemy, false, 0, true);
			}
		}
		
		private function addUnits_helicopter_0(n:int = 1):void
		{
			var counter:int;
			for(counter = 0;counter < n; counter ++)
			{
				var IPXunit:helicopter_0 = new helicopter_0(stage, IPXtower);
				stage.addChild(IPXunit);
				enemyList.push(IPXunit);
				IPXunit.addEventListener(Event.REMOVED_FROM_STAGE, removeEnemy, false, 0, true);
			}
		}
		
		private function addUnits_tank_0(n:int = 1):void
		{
			var counter:int;
			for(counter = 0;counter < n; counter ++)
			{
				var IPXunit:tank_0 = new tank_0(stage, IPXtower);
				stage.addChild(IPXunit);
				enemyList.push(IPXunit);
				IPXunit.addEventListener(Event.REMOVED_FROM_STAGE, removeEnemy, false, 0, true);
			}
		}
		
		private function removeEnemy(e:Event)
		{
			enemyList.splice(enemyList.indexOf(e.currentTarget), 1);
		}
		
		function myClickReaction (e:MouseEvent):void
		{
			trace(enemyList.length);
		}
		
	}
	
}
