package com.ipx.units 
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class tank_0 extends MovieClip
	{
		public var HP:Number = 21; /*describes the ammount of HP*/
		private var damagePerBullet:Number = 10.5; /*describes the ammount of damage target receives if hit*/
		private var fireFrequency:Number = 1050; /*bullets delay in ms*/
		private var movementSpeedStandard:Number = 0.7; /*describes tank's standard movement speed*/
		private var movementSpeedError:Number = (Math.floor( Math.random() * 20)) / 100;/*adds a diffence between 0 and 0.2 to car movement's speed */
		
		private var scaleWidth:Number = 133.5; /*describes tank's width*/
		private var scaleHeigth:Number = 41.2; /*describes tank's height*/
		private var positionX:int = 900; /*describes tank's initial position on X axis*/
		private var positionY:int = 450 - Math.floor( Math.random() * 150 ); /*describes tank's initial position on Y axis*/
		private var distanceFromTarget:Number = (300 - Math.floor( Math.random() * 100 )) /*describes tank's distance from it's target*/
		private var targetHitPoint:int = 300; /*describe's target's hitBox height (Y)*/
		
		private var stageRef:Stage;
		private var target:tower_1; /*sets the tower as primary target*/
		private var fireTimer:Timer; /*causes delay between fires*/
		private var movementSpeed:Number = movementSpeedStandard + movementSpeedError; /*describes tank's real movement speed*/
		
		public function tank_0(stageRef:Stage, target:tower_1) 
		{
			this.stageRef = stageRef;
			this.target = target;
			height = scaleHeigth;
			width = scaleWidth;
			x = positionX;
			y = positionY;
			
			addEventListener(Event.ENTER_FRAME, checkHP, false, 0, true);
			fireTimer = new Timer(fireFrequency, 1);
			
			addEventListener(Event.ENTER_FRAME, goToTarget, false, 0, true);
		}
		
		private function checkHP(e:Event) : void
		{
			if(HP <= 0)
			{
				removeSelf();
			}
		}
		
		private function goToTarget(e:Event) : void
		{
			if((x - target.x) > distanceFromTarget)
			{
				x -= movementSpeed;
				wheel0.rotation -= 2 * movementSpeed;
				wheel1.rotation -= 2 * movementSpeed;
				wheel2.rotation -= 2 * movementSpeed;
				wheel3.rotation -= 2 * movementSpeed;
				wheel4.rotation -= 2 * movementSpeed;
				wheel5.rotation -= 2 * movementSpeed;
				wheel6.rotation -= 2 * movementSpeed;
				wheel7.rotation -= 2 * movementSpeed;
				wheel8.rotation -= 2 * movementSpeed;
				weapon.rotation = Math.acos((x - target.x) / (Math.sqrt(((y - targetHitPoint) * (y - targetHitPoint)) + ((x - target.x) * (x - target.x))))) * 180 / Math.PI;
			}
			else
			{
				removeEventListener(Event.ENTER_FRAME, goToTarget);
				fireTimer.addEventListener(TimerEvent.TIMER, fireTimerHandler, false, 0, true);
				fireBullet();
			}
		}
		
		private function fireTimerHandler(e:TimerEvent) : void
		{
			fireBullet();
		}
		
		private function fireBullet() : void
		{
			fireTimer.reset();
			stageRef.addChild(new bullet_0(stageRef, x - 10, y - 15, weapon.rotation, target, damagePerBullet));
			fireTimer.start();
		}
		
		private function removeSelf() : void
		{
			removeEventListener(Event.ENTER_FRAME, goToTarget);
			fireTimer.removeEventListener(TimerEvent.TIMER, fireTimerHandler);
			if (stageRef.contains(this))
			{
				removeEventListener(Event.ENTER_FRAME, checkHP);
				stageRef.removeChild(this);
			}
		}
	}
	
}
