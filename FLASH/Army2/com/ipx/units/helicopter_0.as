package com.ipx.units 
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class helicopter_0 extends MovieClip
	{
		public var HP:Number = 12;
		private var damagePerBullet:Number = 4.5;
		private var fireFrequency:Number = 450; /*bullets delay in ms*/
		private var movementSpeedStandard:Number = 1.5; /*describes helicopter's standard movement speed*/
		private var movementSpeedError:Number = (Math.floor( Math.random() * 30)) / 100;/*adds a diffence between 0 and 0.3 to car movement's speed */
		
		private var tailSpeed:Number = 40; /*SPECIAL: describes helicopter's tail rotation speed*/
		private var flipPropellerTimer:Timer; /*SPECIAL: causes delay between propeller's flips*/
		private var flipPropellerFrequency:Number = 40; /*SPECIAL: determines propeller's flipping frequenncy*/
		private var canFlipPropeller:Boolean = true; /*SPECIAL: determines if propeller can be flipped or not*/
		
		private var scaleWidth:Number = 105; /*describes helicopter's width*/
		private var scaleHeigth:Number = 45; /*describes helicopter's height*/
		private var positionX:int = 900; /*describes helicopter's initial position on X axis*/
		private var positionY:int = 300 - Math.floor( Math.random() * 150 ); /*describes helicopter's initial position on Y axis*/
		private var distanceFromTarget:Number = (280 - Math.floor( Math.random() * 100 )) /*describes helicopter's distance from it's target*/
		private var targetHitPoint:int = 300; /*describe's target's hitBox height (Y)*/
		
		private var stageRef:Stage;
		private var target:tower_1; /*sets the tower as primary target*/
		private var fireTimer:Timer; /*causes delay between fires*/
		private var movementSpeed:Number = movementSpeedStandard + movementSpeedError; /*describes helicopter's real movement speed*/
		
		public function helicopter_0(stageRef:Stage, target:tower_1) 
		{
			this.stageRef = stageRef;
			this.target = target;
			height = scaleHeigth;
			width = scaleWidth;
			x = positionX;
			y = positionY;
			
			addEventListener(Event.ENTER_FRAME, checkHP, false, 0, true);
			fireTimer = new Timer(fireFrequency, 1);
			
			flipPropellerTimer = new Timer(flipPropellerFrequency, 10);
			flipPropellerTimer.addEventListener(TimerEvent.TIMER, flipPropellerHandler, false, 0, true);
			
			addEventListener(Event.ENTER_FRAME, goToTarget, false, 0, true);
			addEventListener(Event.ENTER_FRAME, animation, false, 0, true);
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
				weapon.rotation = - Math.acos((x - target.x) / (Math.sqrt(((y - targetHitPoint) * (y - targetHitPoint)) + ((x - target.x) * (x - target.x))))) * 180 / Math.PI;
			}
			else
			{
				fireTimer.addEventListener(TimerEvent.TIMER, fireTimerHandler, false, 0, true);
				fireBullet();
				removeEventListener(Event.ENTER_FRAME, goToTarget);
			}
		}
		private function animation(e:Event) : void
		{
			tail.rotation += tailSpeed;
			if(canFlipPropeller)
			{
				if(propeller.visible == true)
				{
					propeller.visible = false;
				}
				else
				{
					propeller.visible = true;
				}
				canFlipPropeller = false;
				flipPropellerTimer.start();
			}
		}
		
		private function fireBullet() : void
		{
			fireTimer.reset();
			stageRef.addChild(new bullet_1(stageRef, x - 45, y + 12, weapon.rotation, target, damagePerBullet));
			fireTimer.start();
		}
		
		private function flipPropellerHandler(e:TimerEvent) : void
		{
			canFlipPropeller = true;
		}
		
		private function fireTimerHandler(e:TimerEvent) : void
		{
			fireBullet();
		}
		
		private function removeSelf() : void
		{
			removeEventListener(Event.ENTER_FRAME, goToTarget);
			addEventListener(Event.ENTER_FRAME, animation);
			fireTimer.removeEventListener(TimerEvent.TIMER, fireTimerHandler);
			flipPropellerTimer.removeEventListener(TimerEvent.TIMER, flipPropellerHandler);
			if (stageRef.contains(this))
			{
				removeEventListener(Event.ENTER_FRAME, checkHP);
				stageRef.removeChild(this);
			}
		}
	}
	
}
