package displays
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * 表格显示容器
	 * <p>
	 * Grid container 
	 * 
	 * @author featherJ
	 */	
	public class GridContainer extends Sprite
	{
		private static const MAX_W_NUM:int = 5;
		private var gridDisplay:Shape;		
		private var textf:TextFormat;
		public function GridContainer()
		{
			gridDisplay = new Shape();
			textf = new TextFormat();
			textf.size = 12;
			textf.color = 0x666666;
		}
		
		private var displayList:Array = [];
		public function addDisplay(displayObject:DisplayObject,name:String):void
		{
			var label:TextField = new TextField();
			label.autoSize = TextFieldAutoSize.LEFT;
			label.selectable = false;
			label.defaultTextFormat = textf;
			label.text = name;
			displayList.push({"display":displayObject,"label":label});
			updateDisplay();
			dispatchEvent(new Event("displayAdded"))
		}
		
		public function updateDisplay():void
		{
			var maxW:int = 0;
			var maxH:int = 0;
			for(var i:int = 0;i<displayList.length;i++)
			{
				var display:DisplayObject = displayList[i]["display"];
				this.addChild(display);
				var label:TextField = displayList[i]["label"];
				label.scaleX = 1/this.scaleX;
				label.scaleY = 1/this.scaleY;
				this.addChild(label);
				maxW = Math.max(display.width,maxW);
				maxH = Math.max(display.height+label.height,maxH);
			}
			for(i = 0;i<displayList.length;i++)
			{
				display = displayList[i]["display"];
				label = displayList[i]["label"];
				display.scaleX = display.scaleY = 1;
				var minScale:Number = Math.min(maxW/display.width,(maxH-label.height)/display.height);
				display.width *= minScale;
				display.height *= minScale;
				display.x = (i%MAX_W_NUM)*maxW+maxW/2-display.width/2;
				display.y = (maxH/2-display.height/2) > label.height ? 
					int(i/MAX_W_NUM)*maxH+maxH/2-display.height/2 : int(i/MAX_W_NUM)*maxH+maxH-label.height-display.height;
				minScale = Math.min(1,maxW/label.width);
				var sourceH:Number = label.height;
				label.scaleX *= minScale;
				label.scaleY *= minScale;
				label.x = (i%MAX_W_NUM)*maxW+maxW/2-label.width/2;
				label.y = int(i/MAX_W_NUM)*maxH+maxH-sourceH+sourceH/2-label.height/2;
			}
			var numRow:int = Math.ceil(displayList.length/MAX_W_NUM);
			gridDisplay.graphics.clear();
			gridDisplay.graphics.lineStyle(1,0xcccccc);
			for(i = 0;i<=MAX_W_NUM;i++)
			{
				gridDisplay.graphics.moveTo(maxW*i,0);
				gridDisplay.graphics.lineTo(maxW*i,(numRow)*maxH);
			}
			for(i = 0;i<=numRow;i++)
			{
				gridDisplay.graphics.moveTo(0,i*maxH);
				gridDisplay.graphics.lineTo(maxW*MAX_W_NUM,i*maxH);
			}
			gridDisplay.graphics.endFill();
			this.addChild(gridDisplay);
		}
	}
}