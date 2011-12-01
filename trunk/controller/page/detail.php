<?php
class ControllerPageDetail extends Controller
{
	public function index()
	{
		$this->load->model("core/sitemap");

		$siteid = $this->user->getSiteId();

		$this->document->sitemapid = $this->request->get['sitemapid'];
		$mediaid = $this->request->get['mediaid'];

		$this->data['breadcrumb'] = $this->model_core_sitemap->getBreadcrumb($this->document->sitemapid, $siteid, -1);

		if($this->document->sitemapid != "")
		{
			$sitemap = $this->model_core_sitemap->getItem($this->document->sitemapid, $siteid);
				
			switch($sitemap['moduleid'])
			{
				case "module/information":
					$this->data['module'] = $this->loadModule('module/information');
					break;
				case "module/news":
					if($mediaid == "")
					{
						$template = array(
										  'template' => "module/news_list.tpl",
										  'width' => 180,
										  'height' =>180
						);
						$arr = array("",10,"",$template);

						$this->data['module'] = $this->loadModule('module/pagelist','getList',$arr);
					}
					else
					{
						$template = array(
									  'template' => "module/news_detail.tpl",
									  'width' => 180,
									  'height' =>180
						);
						$arr = array("",8,$template);
						$this->data['module'] = $this->loadModule('module/pagedetail','getForm',$arr);
					}
					break;
				case "module/product":
					if($mediaid == "")
					{
						$template = array(
										  'template' => "module/product_list.tpl",
										  'width' => 180,
										  'height' =>180
						);
						$arr = array("",10,"",$template);
						$this->data['module'] = $this->loadModule('module/pagelist','getList',$arr);

					}
					else
					{
						$template = array(
									  'template' => "module/product_detail.tpl",
									  'width' => 180,
									  'height' =>180
						);
						$arr = array("",8,$template);
						$this->data['module'] = $this->loadModule('module/pagedetail','getForm',$arr);
					}
					break;
				case "module/contact":
					$this->data['module'] = $this->loadModule('module/contact');
					break;
			}
		}
		$template = array(
						  'template' => "sample/defaultlist.tpl",
						  'width' => 0,
						  'height' =>0
		);

		$arr = array("site1",5,"",$template);
		$this->data['sample_defaultlist'] = $this->loadModule('module/block','getList',$arr);
		$this->id="content";
		$this->template="page/detail.tpl";
		//$this->layout="layout/home";

		/*$this->children = array(
			'sample_defaultlist' => 'sample/defaultlist',
			'sample_blanklist' => 'sample/blanklist',
			'sample_nicelist' => 'sample/nicelist'
			);*/
		$this->render();
	}
}
?>