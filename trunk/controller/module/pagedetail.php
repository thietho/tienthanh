<?php
class ControllerModulePagedetail extends Controller
{	
	public function getForm($sitemapid="",$count=8, $template = array(),$media=array())
	{
		$this->load->model("core/media");
		$this->load->helper('image');
		
		if($sitemapid == "")
			$sitemapid = $this->document->sitemapid;
		$mediaid = $this->request->get['mediaid'];
		$siteid = $this->user->getSiteId();
		
		$this->data['post'] = $this->model_core_media->getItem($mediaid);
		
		if(count($this->data['post']) == 0)
		{
			$this->data['post']['description'] = "Updating...";
		}
		
		$this->data['post']['description'] = html_entity_decode($this->data['post']['description']);
		
		if($this->data['post']['imagepath'] != "")
		{
			$this->data['post']['imagethumbnail'] = HelperImage::resizePNG($this->data['post']['imagepath'], $template['width'], $template['height']);
		}
		
		//Get list
		$queryoptions = array();
		$queryoptions['mediaparent'] = '%';
		$queryoptions['mediatype'] = '%';
		$queryoptions['refersitemap'] = $sitemapid;
		$queryoptions['date'] = $this->data['post']['statusdate'];
		$this->data['othernews'] = $this->model_core_media->getOthersMedia($mediaid, $queryoptions, $count);
		for($i=0;$i<count($this->data['othernews']);$i++)
		{
			$this->data['othernews'][$i]['statusdate'] = $this->date->formatMySQLDate($this->data['othernews'][$i]['statusdate'], 'longdate', "/");
			$this->data['othernews'][$i]['link'] = HTTP_SERVER."#route=page/detail&sitemapid=".$sitemapid."&mediaid=".$this->data['othernews'][$i]['mediaid'];
		}
		
		
		$this->id="news";
		$this->template=$template['template'];
		$this->render();
	}
	
	public function getFormProduct($sitemapid="",$count=8, $template = array(),$media=array())
	{
		$this->load->model("core/media");
		$this->load->helper('image');
		
		if($sitemapid == "")
			$sitemapid = $this->document->sitemapid;
		$mediaid = $this->request->get['mediaid'];
		$siteid = $this->user->getSiteId();
		
		$this->data['post'] = $this->model_core_media->getItem($mediaid);
		
		if(count($this->data['post']) == 0)
		{
			$this->data['post']['description'] = "Updating...";
		}
		$this->data['post']['summary'] = str_replace(chr(13),"<br>",$this->data['post']['summary']);
		$this->data['post']['description'] = html_entity_decode($this->data['post']['description']);
		
		if($this->data['post']['imagepath'] != "")
		{
			$this->data['post']['imagethumbnail'] = HelperImage::resizePNG($this->data['post']['imagepath'], $template['width'], $template['height']);
		}
		
		//Get list
		$queryoptions = array();
		$queryoptions['mediaparent'] = '%';
		$queryoptions['mediatype'] = '%';
		$queryoptions['refersitemap'] = $sitemapid;
		//$queryoptions['date'] = $this->data['post']['statusdate'];
		$this->data['othernews'] = $this->model_core_media->getOthersMedia($mediaid, $queryoptions, $count);
		for($i=0;$i<count($this->data['othernews']);$i++)
		{
			$this->data['othernews'][$i]['statusdate'] = $this->date->formatMySQLDate($this->data['othernews'][$i]['statusdate'], 'longdate', "/");
			$this->data['othernews'][$i]['link'] = HTTP_SERVER."#route=page/detail&sitemapid=".$sitemapid."&mediaid=".$this->data['othernews'][$i]['mediaid'];
		}
		
		
		$this->id="news";
		$this->template=$template['template'];
		$this->render();
	}
}
?>