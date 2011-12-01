<?php
class ControllerModuleBlock extends Controller
{
	public function getList($sitemapid="", $count = 5,$headername = "", $template = array(),$medias=array())
	{
		$arr = array($sitemapid,$count,$headername,$template);
		$this->data['output'] = $this->loadModule('module/pagelist','getList',$arr);
		$this->id="news";
		$this->template="common/output.tpl";
		$this->render();

	}

	public function getSitemaps($sitemapid="",$count = 0,$headername = "", $template = array())
	{
		$this->load->model('core/sitemap');
		$siteid = $this->user->getSiteId();
		$this->data['sitemap'] = $this->model_core_sitemap->getItem($sitemapid, $siteid);
		$this->data['list']=$this->getMenu($sitemapid);
		$this->id="sitemap";
		$this->template="sitebar/catalogue.tpl";
		$this->render();
	}

	public function getMenu($parentid)
	{


		$siteid = $this->user->getSiteId();

		$rootid = $this->model_core_sitemap->getRoot($this->document->sitemapid, $siteid);

		if($this->document->sitemapid == "")
		$rootid = 'homepage';
		$str = "";


		$sitemaps = $this->model_core_sitemap->getListByParent($parentid, $siteid);

		foreach($sitemaps as $item)
		{
			$childs = $this->model_core_sitemap->getListByParent($item['sitemapid'], $siteid);
				
			$currenttab = "";
			if($item['sitemapid'] == $rootid)
			$currenttab = "class='current-tab'";
				
			$link = "<a ".$currenttab.">".$item['sitemapname']."</a>";
				
			if($item['moduleid'] != "group")
			{
				$link = "<a ".$currenttab." href='index.php?route=page/detail&sitemapid=".$item['sitemapid']."'>".$item['sitemapname']."</a>";
			}
			if($item['moduleid'] == "homepage"){
				$link = "<a ".$currenttab." href='index.php'>".$item['sitemapname']."</a>";
			}
				
			$str .= "<li>";
			$str .= $link;
				
			if(count($childs) > 0)
			{
				$str .= "<ul>";
				$str .= $this->getMenu($item['sitemapid']);
				$str .= "</ul>";
			}

			$str .= "</li>";
		}

		return $str;

	}
}
?>