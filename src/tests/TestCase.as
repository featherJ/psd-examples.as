package tests
{
	import flash.display.DisplayObject;
	import flash.utils.ByteArray;
	
	import displays.GridContainer;

	/**
	 * 测试用例
	 * <p>
	 * Test case 
	 * @author featherJ
	 */	
	public class TestCase
	{
		public function TestCase(title:String):void
		{
			this._title = title;
		}
		
		private var _title:String
		/** 测试名称 | Test title */		
		public function get title():String{
			return _title;
		}
		
		private var _container:GridContainer
		final public function init(container:GridContainer):void
		{
			this._container = container;
		}
		
		final public function runTest(bytes:ByteArray):void
		{
			log(" - "+title+" starting...")
			doTest(bytes);
			log(title+" finished");
			log("")
		}
		/**
		 * 添加一个显示对象和名字
		 * <p>
		 * Add a display object with name
		 * @param display 显示对象 | display object
		 * @param name 名字 | name
		 */		
		protected function addDisplay(display:DisplayObject,name:String):void
		{
			_container.addDisplay(display,this.title+" - "+name);
		}
		
		protected function doTest(bytes:ByteArray):void
		{
			
		}
		
		protected function log(...args):void
		{
			trace(args.join(" "));
		}
	}
}