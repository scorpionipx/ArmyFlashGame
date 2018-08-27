package com.ipx.units 
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import com.ipx.engine.Engine;
	
	public class cannonball_0 extends MovieClip 
	{
		private var stageRef:Stage;
		private var bulletSpeed:Number = 7.5;
		private var scaleWidth:Number = 4; /*describes bullet's width*/
		private var scaleHeigth:Number = 1; /*describes bullet's height*/
		private var target:tower_1;
		private var damage:Number;
		
		public function cannonball_0(stageRef:Stage, x:Number, y:Number, damage:Number) 
		{
			this.damage = damage;
			this.stageRef = stageRef;
			this.target = target;
			height = scaleHeigth;
			width = scaleWidth;
			this.x = x;
			this.y = y;
			addEventListener(Event.ENTER_FRAME, hitTarget, false, 0, true);
		}
		
		private function hitTarget(e:Event) : void
		{
			x += bulletSpeed;
			if (x > 810)
				removeSelf();
			for (var j:int = 0; j < Engine.enemyList.length; j++)
			{
				if (hitTestObject(Engine.enemyList[j].hit))
				{
					trace("hitEnemy => HP: ", Engine.enemyList[j].HP);
					Engine.enemyList[j].HP -= damage;
					removeSelf();
				}
			}
		}
 
		private function removeSelf() : void
		{
			removeEventListener(Event.ENTER_FRAME, hitTarget);
			
			if (stageRef.contains(this))
			{
					stageRef.removeChild(this);
			}
		}
	}
	
}
