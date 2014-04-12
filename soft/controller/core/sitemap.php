<?php
class ControllerCoreSitemap extends Controller
{
	private $error = array();
	
	public function index()
	{
		$this->load->language('core/sitemap');
		$this->data = array_merge($this->data, $this->language->getData());
		
		$this->document->title = $this->language->get('heading_title');
		
		$this->load->model("core/sitemap");
		$this->load->model("core/file");
		//$this->load->model("core/module");
		
		$this->updatedelete();
		
		$this->getList();
	}
	
	public function getList()
	{
		$this->data['insert'] = $this->url->http('core/sitemap/insert');
		$this->data['delete'] = $this->url->http('core/sitemap/delete');
		
		$this->data["sitemaps"]=array();
		
		$arrSiteMapTree = array();
		$this->model_core_sitemap->getTreeSitemap("", $arrSiteMapTree, $this->user->getSiteId());
		
		$arrstatus=$this->model_core_sitemap->listStatus();
		
		$eid="ex0-node";
		$eclass="child-of-ex0-node";
		
		foreach($arrSiteMapTree as $item )
		{			
			$module=$this->model_core_sitemap->getModules();
			$sitemapname = $item['sitemapname'];
			$modulename = $module['modulename'];
			
			$deep = $item['level'];
			
			$link = $module['modulename'];
			
				
			$tab="";
			if(count($item['countchild'])==0)
				$tab="<span class='tab'></span>";
		
			$class="";
			if($item['parentpath']!="")
				$class=$eclass.$item['parentpath'];
			
			
			$update = $this->url->http('core/sitemap/update&sitemapid='.$item['sitemapid']);
			$this->data["sitemaps"][]=array(
										'sitemapid'=>$item['sitemapid'],
										'prefix'=>$this->string->getPrefix("--",$deep),
										'deep'=>$deep + 1,
										'eid' =>$eid . $item['path'] ,
										'class' =>$class,
										'sitemapname'=>$sitemapname,
										'sitemapparent'=>$item['sitemapparent'],
										'position'=>$item['position'],
										'moduleid'=>$item['moduleid'],
										'modulename'=>$module[$item['moduleid']],
										'status'=>$arrstatus[$item['status']],
										
										'tab'=>$tab,
										'filepath'=>$file[0]['filepath'],
										'update' => $update
								    );
		
		}

		$this->id='content';
		$this->template='core/sitemap_list.tpl';
		$this->layout="layout/center";
		$this->render();
	}
	
	public function insert()
	{
		$this->load->language('core/sitemap');
		$this->data = array_merge($this->data, $this->language->getData());
		
		$this->document->title = $this->language->get('heading_title');
		$this->load->model("core/sitemap");
		$this->load->model("core/file");
		$this->load->model("core/module");
		
		/*if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validateForm())) {
			$filepath = $this->date->getPath()."/sitemap/";
			$file=$this->model_core_file->saveFile($_FILES['image'],$filepath,"image");	
			$data = $this->request->post;
			$data['sitemapid'] = $this->request->post['sitemapid'];
			$data['siteid'] = $this->user->getSiteId();
			$data['sitemapname'] = $this->request->post['sitemapname'];
			$data['sitemapparent'] = $this->request->post['sitemapparent'];
			$data['moduleid'] = $this->request->post['moduleid'];
			$data['position'] = $this->model_core_sitemap->nextPosition($this->request->post['sitemapparent']);
			$data['imageid'] = $file['fileid'];
			$data['imagepath'] = $file['filepath'];
			$data['status'] = $this->request->post['status'];
			$data['languageid'] = 1;
			$this->model_core_sitemap->insertSiteMap($data);
			$this->session->data['success'] = $this->language->get('text_success');
			$this->redirect($this->url->http('core/sitemap'));
		}*/
    
    	$this->getForm();
	}
	
	public function update() {
		$this->load->language('core/sitemap');
		$this->data = array_merge($this->data, $this->language->getData());
		
		$this->document->title = $this->language->get('heading_title');
		$this->load->model("core/sitemap");
		$this->load->model("core/file");
		$this->load->model("core/module");
		
    	/*if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validateForm())) {
			$filepath = $this->date->getPath()."/sitemap/";
			$file=$this->model_core_file->saveFile($_FILES['image'],$filepath,"image");	
			
			$this->request->post['sitemapid'] = $this->request->get['sitemapid'];
			$data = $this->request->post;
			$data['siteid'] = $this->user->getSiteId();
			$data['imageid'] = $file['fileid'];
			$data['imagepath'] = $file['filepath'];
			$data['languageid'] = 1;
			
			$this->model_core_sitemap->updateSiteMap($data);
			$this->session->data['success'] = $this->language->get('text_success');
			$this->redirect($this->url->http('core/sitemap'));
		}*/
    
    	$this->getForm();
  	}
	
	public function save()
	{
		$data = $this->request->post;
		
		if($this->validateForm($data))
		{
			$this->load->model("core/sitemap");
			$data['siteid'] = $this->user->getSiteId();
			if($data['id']=="")
			{
				$data['position'] = $this->model_core_sitemap->nextPosition($data['sitemapparent']);
				$this->model_core_sitemap->insertSiteMap($data);
			}
			else
			{
				$this->model_core_sitemap->updateSiteMap($data);
			}
			
			$this->data['output'] = "true";
		}
		else
		{
			foreach($this->error as $item)
			{
				$this->data['output'] .= $item."<br>";
			}
		}
		
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	
	private function validateForm()
	{
		if ((strlen($this->request->post['sitemapid']) == 0) || (strlen($this->request->post['siteid']) > 50)) {
      		$this->error['sitemapid'] = $this->data['war_ID'];
    	}
		else
		{
/*			if($this->validation->_isId(trim($this->request->post['sitemapid'])) == false)
			{
				$this->error['sitemapid'] = $this->data['war_invalid_ID'];
			}
			else
			{*/
				if($this->request->post['id'] =="")
				{
					$sitemapid = $this->request->post['sitemapid'];
					$this->load->model("core/sitemap");
					$siteamap = $this->model_core_sitemap->getItem($sitemapid,$this->user->getSiteId());
					if(count($siteamap))
						$this->error['sitemapid'] = $this->data['war_existed_ID'];
				}
			//}
		}
    	if ((strlen($this->request->post['sitemapname']) == 0) || (strlen($this->request->post['siteid']) > 50)) {
      		$this->error['sitemapname'] = $this->data['war_existed_name'];
    	}

		if (!$this->error) {
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
	
	private function getForm()
	{
		$this->load->helper('image');
		$this->data['error'] = @$this->error;
		
		if (!isset($this->request->get['sitemapid'])) {
			$this->data['action'] = $this->url->http('core/sitemap/insert');
		} else {
			$this->data['action'] = $this->url->http('core/sitemap/update&sitemapid=' . $this->request->get['sitemapid']);
		}
		
		
		
		$this->data['status']=$this->model_core_sitemap->listStatus();
		$this->data['modules']=$this->model_core_sitemap->getModules();
		
		if ((isset($this->request->get['sitemapid'])) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$sitemapid = $this->request->get['sitemapid'];
      		$sitemap = $this->model_core_sitemap->getItem(urldecode($sitemapid), $this->user->getSiteId());
			//$sitemap_description = $this->model_core_sitemap->getSiteMapDescription($this->request->get['sitemapid'],$this->language->getId() );
			//$file =$this->model_core_file->getFile($sitemap['imageid']);
			
			$this->data['sitemap'] = $sitemap;
			
			$this->data['sitemap']['thumbnail'] = HelperImage::resizePNG($sitemap['imagepath'],200,200);
			$this->data['noimage'] = HelperImage::resizePNG("",200,200);
    	}
		
		$list = array();
		$parent=$this->request->get['parent'];
		if(isset($this->request->get['sitemapid']))
		{
			$this->model_core_sitemap->getTreeSitemapEdit("",$this->request->get['sitemapid'],$list,$this->user->getSiteId());
		}
		else
		{
			$this->data['sitemap']['sitemapparent']=$parent;
			$this->model_core_sitemap->getTreeSitemap("",$list,$this->user->getSiteId());
		}
		
		$this->data["sitemapparent"]=array();
		
		foreach($list as $item )
		{
			//$SiteMapDescription = $this->model_core_sitemap->getSiteMapDescription($item['sitemapid'],$this->language->getId());
			
			$deep=$this->model_core_sitemap->getDeep($item['sitemapid'], $this->user->getSiteId());
			$this->data["sitemapparent"][]=array(
										'sitemapid'=>$item['sitemapid'],
										'sitemapname'=>$this->string->getPrefix("--",$deep).$item['sitemapname'],
										'sitemapparent'=>$item['sitemapparent'],
										'position'=>$item['position'],
										'moduleid'=>$item['moduleid'],
										'status'=>$item['status'],
										'imageid'=>$item['imageid']
											);
			
		}
		
		$this->id='content';
		$this->template='core/sitemap_form.tpl';
		$this->layout="layout/center";
		
		$this->render();
	}
	
	public function updateposition()
	{
		$position=$this->request->post['position'];
		$this->load->model("core/sitemap");
		$this->load->model('core/file');
		if(count($position))
		{
			foreach($position as $key=>$val)
			{
				$this->model_core_sitemap->updateSiteMapPosition($key,$val,$this->user->getSiteId());
			}
			$this->data['output'] = "Cập nhật vị trí thành công";
		}
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
	}
	
	public function updatedelete()
	{
		if($this->request->post['type']!="" )
		{
			$arr=$this->request->post['delete'];
			$position=$this->request->post['position'];
			$this->load->model("core/sitemap");
			$this->load->model('core/file');
			foreach($position as $key=>$val)
			{
				if($arr[$key]=="1")
				{
					$id=$key;
					$data=$this->model_core_sitemap->getItem($id, $this->user->getSiteId());
					$fileid = $data[0]['imageid'];
					if($this->request->post['type']=="Delete")
					if($this->delete($id) && $fileid != "")
					{
						$this->model_core_file->deleteFile($fileid);
					}
				}
				if($this->request->post['type']=="Update")
					$this->model_core_sitemap->updateSiteMapPosition($key,$val);
			}
			$this->response->redirect('?route=core/sitemap');
		}
		
	}
	
	public function delete()
	{
		$arr=$this->request->post['delete'];
		if(count($arr))
		{
			
			$this->load->model("core/sitemap");
			$this->load->model('core/file');
			foreach($arr as $key=>$val)
			{
				$data=$this->model_core_sitemap->getItem($val, $this->user->getSiteId());
				$fileid = $data['imageid'];
				if($this->deleteItem($val) && $fileid != 0)
				{
					$this->model_core_file->deleteFile($fileid);
				}
			}
			$this->data['output'] = "Xóa thành công";
		}
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
	}
	
	public function deleteItem($id)
	{
		$this->load->model('core/sitemap');
		return $this->model_core_sitemap->deleteSitemap($id, $this->user->getSiteId());
	}
	
	public function validateForm1()
	{
		$err=array();
		if(trim($this->request->post['sitemapname'])=="")
			$err['sitemapname']="You must enter sitemap name";
		return $err;
	}
	
	public function getHitCounter()
	{
		$this->load->model('media/media');
		$counter=$this->model_media_media->getInformation("HitCounter","HitCounter",1);
		//print_r($counter[0]['FieldValue']);
		return $counter[0]['FieldValue'];
	}
	
	public function forwardForm()
	{
		$this->load->model("core/sitemap");
		$sitemapid = $this->request->get['sitemapid'];
		$this->data['sitemap'] = $this->model_core_sitemap->getItem($sitemapid, $this->user->getSiteId());
		
		$this->id='content';
		$this->template='core/sitemap_forward.tpl';
		$this->render();
	}
	public function saveCol()
	{
		$data = $this->request->post;
		$this->load->model("core/sitemap");	
		$this->model_core_sitemap->updateCol($data['sitemapid'],$data['col'],$data['val'], $this->user->getSiteId());
		$this->data['output'] = "true";
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
	}
}
?>