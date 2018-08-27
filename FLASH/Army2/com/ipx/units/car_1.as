package com.ipx.units 
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class car_1 extends MovieClip
	{
		public var HP:Number = 24; /*describes the ammount of HP*/
		private var damagePerBullet:Number = 19.5; /*describes the ammount of damage target receives if hit*/
		private var fireFrequency:Number = 3900; /*bullets fireing delay in ms*/
		private var movementSpeedStandard:Number = 0.6; /*describes car's standard movement speed*/
		private var movementSpeedError:Number = (Math.floor( Math.random() * 50)) / 1000;/*adds a diffence between 0 and 0.05 to car movement's speed */
		
		private var setWeaponSpeed:Number = 0.09; /*SPECIAL: describes car's timme to set weapon before fireing*/
		private var readyToSetWeapon:Boolean = false; /*SPECIAL: weapon cannot fire until value is true*/
		
		private var scaleWidth:Number = 135; /*describes car's width*/
		private var scaleHeigth:Number = 63; /*describes car's height*/
		private var positionX:int = 900 + Math.floor( Math.random() * 15 );; /*describes car's initial position on X axis*/
		private var positionY:int = 450 - Math.floor( Math.random() * 150 ); /*describes car's initial position on Y axis*/
		private var distanceFromTarget:Number = (300 - Math.floor( Math.random() * 100 )) /*describes car's distance from it's target*/
		private var targetHitPoint:int = 300; /*describe's target's hitBox height (Y)*/
		
		private var stageRef:Stage;
		private var target:tower_1; /*sets the tower as primary target*/
		private var fireTimer:Timer; /*causes delay between fires*/
		private var movementSpeed:Number = movementSpeedStandard + movementSpeedError; /*describes car's real movement speed*/
		
		public function car_1(stageRef:Stage, target:tower_1) 
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
			addEventListener(Event.ENTER_FRAME, prepareWeapon, false, 0, true);
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
				f_wheel.rotation -= 2 * movementSpeed;
				m_wheel.rotation -= 2 * movementSpeed;
				b_wheel.rotation -= 2 * movementSpeed;
				
			}
			else
			{
				readyToSetWeapon = true;
				removeEventListener(Event.ENTER_FRAME, goToTarget);
			}
		}
		
		private function prepareWeapon(e:Event) : void
		{
			if(readyToSetWeapon)
			{
				if(weapon.rotation <= Math.acos((x - target.x) / (Math.sqrt(((y - targetHitPoint) * (y - targetHitPoint)) + ((x - target.x) * (x - target.x))))) * 180 / Math.PI)
				{
					weapon.rotation += setWeaponSpeed;
				}
				else
				{
					removeEventListener(Event.ENTER_FRAME, prepareWeapon);
					fireTimer.addEventListener(TimerEvent.TIMER, fireTimerHandler, false, 0, true);
					fireBullet();
				}
			}
		}
		
		private function fireTimerHandler(e:TimerEvent) : void
		{
			fireBullet();
		}
		
		private function fireBullet() : void
		{
			fireTimer.reset();
			stageRef.addChild(new bullet_3(stageRef, x + 10, y - 30 - weapon.rotation / 5, weapon.rotation, target, damagePerBullet));
			fireTimer.start();
		}
		
		private function removeSelf() : void
		{
			removeEventListener(Event.ENTER_FRAME, goToTarget);
			removeEventListener(Event.ENTER_FRAME, prepareWeapon);
			fireTimer.removeEventListener(TimerEvent.TIMER, fireTimerHandler);
			if (stageRef.contains(this))
			{
				removeEventListener(Event.ENTER_FRAME, checkHP);
				stageRef.removeChild(this);
			}
		}
	}
	
}
