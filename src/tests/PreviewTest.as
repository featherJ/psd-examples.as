package tests
{
	import com.fancynode.psd.PSD;
	import com.fancynode.psd.infos.ChannelRenderData;
	import com.fancynode.psd.renderer.channelDataRenderer.ChannelDataRenderer;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.utils.ByteArray;

	/**
	 * 文档预览图测试
	 * <p>
	 * Psd document preview image test
	 *  
	 * @author featherJ
	 */	
	public class PreviewTest extends TestCase
	{
		public function PreviewTest()
		{
			super("Preview");
		}
		
		override protected function doTest(bytes:ByteArray):void
		{
			var psd:PSD = new PSD(bytes);
			psd.parse();
			//预览图数据 | Preview image data
			var previewRenderData:ChannelRenderData = psd.imageData.channelRenderData;
			//预览图的位图数据 | Preview image bitmap data
			var previewBitmapData:BitmapData = ChannelDataRenderer.render(previewRenderData);
			//预览图位图 | Preview bitmap
			var previewBmp:Bitmap = new Bitmap(previewBitmapData);
			addDisplay(previewBmp,"Preview");
			log("PSD:","{w:"+psd.width+" h:"+psd.height+"}");
		}
	}
}