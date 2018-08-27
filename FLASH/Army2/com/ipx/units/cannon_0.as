package com.ipx.units 
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class cannon_0 extends MovieClip 
	{
		private var stageRef:Stage;
		private var fireFrequency:Number = 500;  /*bullets delay in ms*/
		private var damagePerBullet:Number = 2.2; /*describes the ammount of damage target receives if hit*/
		
		private var fireTimer:Timer; /*causes delay between fires*/
		private var gunFireFrequency:Number = 15;
		private var gunFireTimer:Timer; /*causes delay between gunFire effect*/
		
		public function cannon_0(stageRef:Stage) 
		{
			this.stageRef = stageRef;
			
			fireTimer = new Timer(fireFrequency, 1);
			gunFireTimer = new Timer (gunFireFrequency,1);
			
			gunFire.visible = false;
			
			addEventListener(Event.ENTER_FRAME, fire, false, 0, true);
		}
		
		private function fire(e:Event) : void
		{
			removeEventListener(Event.ENTER_FRAME, fire);
			fireTimer.addEventListener(TimerEvent.TIMER, fireTimerHandler, false, 0, true);
			gunFireTimer.addEventListener(TimerEvent.TIMER, gunFireTimerHandler, false, 0, true);
			fireBullet();
		}
		
		private function fireBullet() : void
		{
			gunFire.visible = true;
			fireTimer.reset();
			stageRef.addChild(new cannonball_0(stageRef, x + 10, y - 12, damagePerBullet));
			fireTimer.start();
		}
		
		private function fireTimerHandler(e:TimerEvent) : void
		{
			fireBullet();
			gunFireTimer.reset();
			gunFireTimer.start();
		}
		
		private function gunFireTimerHandler(e:TimerEvent) : void
		{
			gunFire.visible = false;
		}
	}
	
}
