package com.ipx.units 
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	
	public class aircraft_0 extends MovieClip 
	{
		private var stageRef:Stage;
		private var target:tower_1;
		
		public function aircraft_0(stageRef:Stage, target:tower_1) 
		{
			this.stageRef = stageRef;
			this.target = target;
			height = scaleHeigth;
			width = scaleWidth;
			x = positionX;
			y = positionY;
			addEventListener(Event.ENTER_FRAME, goToTower, false, 0, true);
		}
		
		private var scaleWidth:Number = 150; /*describes aircfrat's width*/
		private var scaleHeigth:Number = 45; /*describes aircfrat's height*/
		private var positionX:int = 900; /*describes aircfrat's initial position on X axis*/
		private var positionY:int = 200 - Math.floor( Math.random() * 190 ); /*describes car's initial position on Y axis*/
		private var distanceFromTarget:Number = (250 - Math.floor( Math.random() * 100 )) /*describes  aircfrat's fire distance from it's target*/
		private var targetHitPoint:int = 150; /*describe's target's hit point height*/
		private var movementSpeedError:Number = (Math.floor( Math.random() * 10)) / 10;/*adds a diffence between 0 and 1 to aircraft movement's speed */
		private var movementSpeedStandard:Number = 3.9; /*describes aircraft's standard movement speed*/
		private var movementSpeed:Number = movementSpeedStandard + movementSpeedError; /*describes aircfrat's movement speed*/
		
		private function goToTower(e:Event) : void
		{
			if((x - target.x) > distanceFromTarget)
			{
				x -= movementSpeed;
				/*fire wep*/
			}
			else
			{
				removeEventListener(Event.ENTER_FRAME, goToTower);
			}
		}
	}
	
}
