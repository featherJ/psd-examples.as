package tests
{
	import com.fancynode.psd.PSD;
	import com.fancynode.psd.infos.ChannelRenderData;
	import com.fancynode.psd.renderer.channelDataRenderer.ChannelDataRenderer;
	import com.fancynode.psd.secitons.layerAndMask.additionalLayerInfo.infos.TypeTool;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.utils.ByteArray;

	/**
	 * 文本图层测试
	 * <p>
	 * Text layer test
	 * 
	 * @author featherJ
	 */	
	public class TextTest extends TestCase
	{
		public function TextTest()
		{
			super("Text");
		}
		
		override protected function doTest(bytes:ByteArray):void
		{
			var psd:PSD = new PSD(bytes);
			psd.parse();
			
			var typeTool:TypeTool = psd.layers[0].text;
			log("PSD:","{w:"+psd.width+" h:"+psd.height+"}");
			log("Fonts:",typeTool.fonts);
			var color:String = "";
			for(var i:int = 0;i<typeTool.colors.length;i++)
				color += "{r:"+typeTool.colors[i][0]+" g:"+typeTool.colors[i][1]+" b:"+typeTool.colors[i][2]+" a:"+typeTool.colors[i][3]+"},"
			color = color.slice(0,color.length-1);
			log("Colors:",color);
			log("Leadings:",typeTool.leadings);
			log("Sizes:",typeTool.sizes);
			log("Text:",typeTool.textValue);
			
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