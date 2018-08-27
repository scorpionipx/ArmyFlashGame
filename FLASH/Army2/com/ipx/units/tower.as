package com.ipx.units {
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	
	public class tower extends MovieClip 
	{
		private var stageRef:Stage;
		public var healtPoints:Number = 200;
		
		public function tower(stageRef:Stage) 
		{
			this.stageRef = stageRef;
			x = positionX;
			y = positionY;
		}
		
		private var positionX = 100;
		private var positionY = 250;
	}
}
