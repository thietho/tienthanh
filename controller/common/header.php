<?php
class ControllerCommonHeader extends Controller
{
	public function index()
	{
		$this->id="header";
		$this->template="common/header.tpl";
		$this->data['mainmenu'] = $this->getMenu("");
		$this->render();
	}

	public function getMenu($parentid)
	{
		$this->load->model("core/sitemap");
			
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
				$link = "<a id='menu_".$item['sitemapid']."' class='menu ".$currenttab."'  href='#route=page/detail&sitemapid=".$item['sitemapid']."' onclick='control.loadContent(this.href)'>".$item['sitemapname']."</a>";
			}
			if($item['moduleid'] == "homepage"){
				$link = "<a id='menu_".$item['sitemapid']."' class='menu ".$currenttab."' href='#' onclick='control.loadContent(\"".HTTP_SERVER."?ajax=true&sitemapid=".$item['sitemapid']."\")'>".$item['sitemapname']."</a>";
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