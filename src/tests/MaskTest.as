package tests
{
	import com.fancynode.psd.PSD;
	import com.fancynode.psd.infos.ChannelRenderData;
	import com.fancynode.psd.renderer.channelDataRenderer.ChannelDataRenderer;
	import com.fancynode.psd.secitons.layerAndMask.ChannelImageData;
	import com.fancynode.psd.secitons.layerAndMask.LayerRecord;
	import com.fancynode.psd.secitons.layerAndMask.Mask;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.utils.ByteArray;

	/**
	 * 蒙版测试
	 * <p>
	 * Mask Test 
	 * 
	 * @author featherJ
	 */	
	public class MaskTest extends TestCase
	{
		public function MaskTest()
		{
			super("Mask");
		}
		
		override protected function doTest(bytes:ByteArray):void
		{
			var psd:PSD = new PSD(bytes);
			psd.parse();
			var layerRecord:LayerRecord = psd.layers[0];
			var channel:ChannelImageData = layerRecord.channelImageData;
			
			//遮罩数据 | Mask data
			var mask:Mask = layerRecord.mask;
			
			log("PSD:","{w:"+psd.width+" h:"+psd.height+"}");
			log("LayerCompression: ZIPPrediction");
			log("Layer:","{w:"+layerRecord.width+" h:"+layerRecord.height+" top:"+layerRecord.top+" bottom:"+layerRecord.bottom+" left:"+layerRecord.left+" right:"+layerRecord.right+"}")
			log("Mask:","{w:"+mask.width+" h:"+mask.height+" top:"+mask.top+" bottom:"+mask.bottom+" left:"+mask.left+" right:"+mask.right+"}");
			log("RealMask:","{w:"+mask.realWidth+" h:"+mask.realHeight+" top:"+mask.realTop+" bottom:"+mask.realBottom+" left:"+mask.realLeft+" right:"+mask.realRight+"}");
			log("MaskArgs:","{UserDensity:"+mask.userMaskDensity/255*100+"%"+" UserFeather:"+mask.userMaskFeather+" MaskDensity:"+mask.vectorMaskDensity/255*100+"%"+" MaskDensity:"+mask.vectorMaskFeather+"}")
			
			//图层部分渲染数据 | Layer renderer data
			var layerRenderData:ChannelRenderData = channel.channelRenderData;
			//综合的遮罩渲染数据 | Mult mask renderer data
			var maskRenderData:ChannelRenderData = channel.maskChannelRenderData;
			//真实的遮罩渲染数据 | Real mask renderer data
			var realMaskRenderData:ChannelRenderData = channel.realMaskChannelRenderData;
			
			//图层位图数据 | Layer bitmap data
			var layerBimtapData:BitmapData = ChannelDataRenderer.render(layerRenderData);
			//综合的遮罩位图数据 | Mult mask bitmap data
			var maskBimtapData:BitmapData = ChannelDataRenderer.render(maskRenderData);
			//真实的遮罩位图数据 | Real mask bitmap data
			var realMaskBitmapData:BitmapData = ChannelDataRenderer.render(realMaskRenderData);
			
			//图层位图 | Layer bitmap
			var layerBmp:Bitmap = new Bitmap(layerBimtapData);
			addDisplay(layerBmp,"Layer");
			
			//综合的遮罩位图 | Mult mask bitmap
			var maskBmp:Bitmap = new Bitmap(maskBimtapData);
			addDisplay(maskBmp,"Mask");
			
			//真实的遮罩位图 | Real mask bitmap
			var realMaskBmp:Bitmap = new Bitmap(realMaskBitmapData);
			addDisplay(realMaskBmp,"Real Mask");
			
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