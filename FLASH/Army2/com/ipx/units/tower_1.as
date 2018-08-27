package com.ipx.units 
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.events.TouchEvent;
	
	public class tower_1 extends MovieClip 
	{
		Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
		private var stageRef:Stage;
		public var healtPoints:Number = 200;
		public var movement:Boolean = false;
		private var trackDirection:int = 1;
		public var trackSpeed:Number = 1.8;
		private var up_wheelSpeed:Number = trackSpeed * 1.5;
		private var down_wheelSpeed:Number = 3.5;
		private var upLimit:int = -290 + 25;
		private var downLimit:int = 175;
		public var IPXcannon:cannon_0;
		private var IPXcannonX:Number = 135;
		private var IPXcannonY:Number = 224;
		private var scaleWidth:Number = 80; /*describes cannon's width*/
		private var scaleHeigth:Number = 32; /*describes cannon's height*/
		
		public function tower_1(stageRef:Stage) 
		{
			this.stageRef = stageRef;
			x = positionX;
			y = positionY;
			IPXcannon = new cannon_0(stageRef);
			IPXcannon.x = IPXcannonX;
			IPXcannon.y = IPXcannonY;
			IPXcannon.width = scaleWidth;
			IPXcannon.height = scaleHeigth;
			stageRef.addChild(IPXcannon);
			addEventListener(Event.ENTER_FRAME, moveTrack, false, 0, true);
			button_down.addEventListener(TouchEvent.TOUCH_BEGIN, enableMovementDown);
			button_up.addEventListener(TouchEvent.TOUCH_BEGIN, enableMovementUp);
			button_up.addEventListener(TouchEvent.TOUCH_END , disableMovement);
			button_down.addEventListener(TouchEvent.TOUCH_END , disableMovement);		
			trackInitialPosition = track.y;
			}
		
		private var positionX = 36;
		private var positionY = 300;
		private var trackInitialPosition:Number;

		function disableMovement(event:TouchEvent):void
		{
			movement = false;
		}

		function enableMovementDown(event:TouchEvent):void
		{
			movement = true;
			trackDirection = +1;
		}
		
		function enableMovementUp(event:TouchEvent):void
		{
			movement = true;
			trackDirection = -1;
		}
		
		private function moveTrack(e:Event) : void
		{
			if(movement)
			{
				if(trackDirection == -1)
				{
					if(track.y > upLimit)
					{
						track.y += trackSpeed * trackDirection;
						u_wheel.rotation += up_wheelSpeed * trackDirection;
						d_wheel.rotation += down_wheelSpeed * -trackDirection;
					}
				}
				else
				{
					if(track.y < downLimit)
					{
						track.y += trackSpeed * trackDirection;
						u_wheel.rotation += up_wheelSpeed * trackDirection;
						d_wheel.rotation += down_wheelSpeed * -trackDirection;
					}
				}
				IPXcannon.y = IPXcannonY - trackInitialPosition + track.y;
			}
		}
	}
}
