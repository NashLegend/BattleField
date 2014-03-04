package  
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author IJUST
	 */
	public class Panel extends MovieClip 
	{
		
		public function Panel() 
		{
			graphics.beginFill(0x362DE8, 0.2);
			graphics.drawRoundRect(0, 0, 300, 50, 20, 20);
			graphics.endFill();
		}
		
	}

}