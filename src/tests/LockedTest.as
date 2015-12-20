package tests
{
	import com.fancynode.psd.PSD;
	import com.fancynode.psd.infos.ChannelRenderData;
	import com.fancynode.psd.renderer.channelDataRenderer.ChannelDataRenderer;
	import com.fancynode.psd.secitons.layerAndMask.LayerRecord;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.utils.ByteArray;

	/**
	 * 锁定测试
	 * <p>
	 * Locked test
	 *  
	 * @author featherJ
	 */	
	public class LockedTest extends TestCase
	{
		public function LockedTest()
		{
			super("Locked");
		}
		
		override protected function doTest(bytes:ByteArray):void
		{
			var psd:PSD = new PSD(bytes);
			psd.parse();
			for each(var layer:LayerRecord in psd.layers)
			{
				log("------ LayerName:"+layer.name+" ------");
				log("isFolder:"+layer.isFolder+"\tisFolderEnd:"+layer.isFolderEnd+"\tallLocked:"+layer.allLocked+"\tposLocked:"+layer.positionLocked)
			}
			//预览图数据 | Preview image data
			var previewRenderData:ChannelRenderData = psd.imageData.channelRenderData;
			//预览图的位图数据 | Preview image bitmap data
			var previewBitmapData:BitmapData = ChannelDataRenderer.render(previewRenderData);
			//预览图位图 | Preview bitmap
			var previewBmp:Bitmap = new Bitmap(previewBitmapData);
			addDisplay(previewBmp,"Preview");
		}
	}
}