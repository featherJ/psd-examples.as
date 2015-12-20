package tests
{
	import com.fancynode.psd.PSD;
	import com.fancynode.psd.nodes.RootNode;
	import com.fancynode.psd.secitons.imageData.ImageData;
	import com.fancynode.psd.secitons.layerAndMask.LayerRecord;
	
	import flash.utils.ByteArray;

	/**
	 * 图层树测试
	 * <p>
	 * Layer tree test
	 * 
	 * @author featherJ
	 */	
	public class LayerTreeTest extends TestCase
	{
		public function LayerTreeTest()
		{
			super("LayerTree");
		}
		override protected function doTest(bytes:ByteArray):void
		{
			var psd:PSD = new PSD(bytes);
			psd.parse();
			var tree:RootNode = psd.root;
			log(psd.root);
		}
	}
}