package  
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author IJUST
	 */
	public class Card extends MovieClip
	{
		public var CardNumber:int;//数值1~13
		public var CardColor:int;//花色
		public var rnd:Number = Math.random();//随机数值，排序用
		public var Index:int;
		public var CardValue:int=0;
		private var imgLoader:Loader=new Loader();
		private var urlRec:URLRequest = new URLRequest();
		public var isselect:Boolean = false;
		public var isOutSelect:Boolean = false;
		
		//Index从1至54
		public function Card(index:int) 
		{
			this.Index = index;
			CardColor = Math.ceil(index / 13);
			CardNumber = (index % 13 == 0)?13:(index % 13);
			
			if (CardNumber==0)
			{
				CardValue = 13;
			}
			
			if (CardNumber==1) 
			{
				CardValue = 14;
			}
			
			if (CardNumber==2) 
			{
				CardValue = 20;
			}
			
			if (index==53) 
			{
				CardColor = data.JOKERVOICE;
				CardNumber = 53;
				CardValue = 53;
			}
			if (index==54) 
			{
				CardColor = data.JOKER;
				CardNumber = 54;
				CardValue = 54;
			}
			if (CardNumber>=3&&CardNumber<=13)
			{
				CardValue = CardNumber;
			}
			if (index==55) 
			{
				CardColor = data.BG;
				CardNumber = 55;
			}
			
			switch (CardColor) 
			{
				case data.CLUBS:
					urlRec.url = "BF/C/"+CardNumber + ".jpg";
				break;
				case data.DIAMONDS:
					urlRec.url = "BF/D/"+CardNumber + ".jpg";
				break;
				case data.HEARTS:
					urlRec.url = "BF/H/"+CardNumber + ".jpg";
				break;
				case data.SPADE:
					urlRec.url = "BF/S/"+CardNumber + ".jpg";
				break;
				case data.JOKERVOICE:
					urlRec.url = "BF/joker2.jpg";
				break;
				case data.JOKER:
					urlRec.url = "BF/joker.jpg";
				break;
				case data.BG:
					urlRec.url = "BF/bg.png";
				break;
				default:
					
				break;
			}
			imgLoader.load(urlRec);
			addChild(imgLoader);
			var drop:DropShadowFilter = new DropShadowFilter(3, 225, 0, 0.5, 3, 3);
			var filt:Array = [drop];
			imgLoader.filters = filt;
			addEventListener(MouseEvent.CLICK, mclick);
		}
		private function mclick(e:MouseEvent):void 
		{
			if (this.CardNumber==55) 
			{
				
			}
			else 
			{
				select();
			}
		}
		public function select():void 
		{
			isselect = !isselect
			if (isselect) 
			{
				Up();
			}
			else 
			{
				Down();
			}
		}
		//向上
		public function Up():void 
		{
			this.y -= 20;
		}
		//向下
		public function Down():void 
		{
			this.y += 20;
		}
		
		
	}

}