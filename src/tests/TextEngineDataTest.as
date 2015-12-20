package tests
{
	import com.fancynode.psd.EngineData;
	
	import flash.utils.ByteArray;

	/**
	 * psd文本数据测试
	 * <p>
	 * Psd text engine data test.
	 *  
	 * @author featherJ
	 */	
	public class TextEngineDataTest extends TestCase
	{
		public function TextEngineDataTest()
		{
			super("Text Engine Data")
		}
		
		override protected function doTest(bytes:ByteArray):void
		{
			//解析二进制数据 | Parse bytes data
			var result:Object = EngineData.parse(bytes);
			log("EngineData:");
			log(JSON.stringify(result,null,"\t"));
		}
	}
}