package com.ipx.units 
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	
	public class bullet_0 extends MovieClip 
	{
		private var stageRef:Stage;
		private var bulletSpeed:Number = 7.5;
		private var scaleWidth:Number = 16.6; /*describes bullet's width*/
		private var scaleHeigth:Number = 5; /*describes bullet's height*/
		private var rotationInRadians:Number;
		private var target:tower_1;
		private var damage:Number;
		
		public function bullet_0(stageRef:Stage, x:Number, y:Number, r:Number, target:tower_1, damage:Number) 
		{
			this.damage = damage;
			this.stageRef = stageRef;
			this.target = target;
			height = scaleHeigth;
			width = scaleWidth;
			this.x = x;
			this.y = y;
			this.rotation = r;
			rotationInRadians = r * Math.PI / 180;
			addEventListener(Event.ENTER_FRAME, hitTarget, false, 0, true);
		}
		
		private function hitTarget(e:Event) : void
		{
			x -= Math.cos(rotationInRadians) * bulletSpeed; //uses the cosine to get the xVel from the speed and rotation
			y -= Math.sin(rotationInRadians) * bulletSpeed; //uses the sine to get the yVel
 
			if (x < 90)
				removeSelf();
		}
 
		private function removeSelf() : void
		{
			removeEventListener(Event.ENTER_FRAME, hitTarget);
			
			target.healtPoints -= damage;
			
			
			if (stageRef.contains(this))
			{
					stageRef.removeChild(this);
			}
		}
	}
	
}
