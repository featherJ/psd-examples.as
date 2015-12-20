package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import displays.GridContainer;
	
	import tests.LayerTreeTest;
	import tests.LockedTest;
	import tests.MaskTest;
	import tests.PreviewTest;
	import tests.TestCase;
	import tests.TextEngineDataTest;
	import tests.TextTest;
	
	/**
	 * 测试
	 * <p>
	 * Test
	 * @author featherJ
	 */	
	public class PsdExamples extends Sprite
	{
		private var testList:Array = new Array();
		private var gridContainer:GridContainer = new GridContainer();
		public function PsdExamples()
		{
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;
			
			//添加显示容器 | Add display container
			this.addChild(gridContainer);
			gridContainer.addEventListener("displayAdded",displayAdded_handler);
			this.stage.addEventListener(Event.RESIZE,resize_handler);
			
			//注册测试用例 | register test case
			this.registerTest(MaskTest,"files/mask-user&vector.psd");
			this.registerTest(PreviewTest,"files/preview.psd");
			this.registerTest(TextTest,"files/text.psd");
			this.registerTest(TextEngineDataTest,"files/text.engineData");
			this.registerTest(LockedTest,"files/locked.psd");
			this.registerTest(LayerTreeTest,"files/preview.psd");
			//运行测试 | run tests
			runTests();
		}
		private function resize_handler(event:Event):void
		{
			updateDisplaySize();
		}
		private function displayAdded_handler(event:Event):void
		{
			updateDisplaySize();
		}
		private function updateDisplaySize():void
		{
			if(gridContainer.width == 0 || gridContainer.height == 0) return;
			var minScale:Number = Math.min(this.stage.stageWidth/gridContainer.width,this.stage.stageHeight/gridContainer.height);
			gridContainer.width *= minScale;
			gridContainer.height *= minScale;
			gridContainer.updateDisplay();
		}
		
		/**
		 * 注册一个测试 
		 * <p>
		 * Register a test case.
		 * @param testClazz 测试类 | Test class.
		 * @param filePath Psd文件路径 | Psd file path.
		 */		
		private function registerTest(testClazz:Class,filePath:String):void
		{
			testList.push({"path":filePath,"clazz":testClazz});
		}
		
		private var currentFilePath:String;
		private var currentTestClass:Class;
		private function runTests():void
		{
			if(testList.length > 0)
			{
				var testObj:Object = testList.shift();
				currentFilePath = testObj["path"];
				currentTestClass = testObj["clazz"];
				var loader:URLLoader = new URLLoader();
				loader.dataFormat = URLLoaderDataFormat.BINARY;
				loader.addEventListener(Event.COMPLETE,loaded_handler);
				loader.addEventListener(IOErrorEvent.IO_ERROR,loaded_handler);
				loader.load(new URLRequest(currentFilePath));
			}
		}
		
		protected function loaded_handler(event:Event):void
		{
			if(event.type == Event.COMPLETE)
			{
				var testCase:TestCase = new currentTestClass();
				testCase.init(this.gridContainer);
				testCase.runTest(event.target.data as ByteArray);
			}
			runTests();
		}
	}
}