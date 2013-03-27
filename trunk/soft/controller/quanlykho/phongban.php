<?php
class ControllerQuanlykhoPhongBan extends Controller
{
	private $error = array();
   
	public function index()
	{
		$this->load->model("core/module");
		$moduleid = $_GET['route'];
		$this->document->title = $this->model_core_module->getBreadcrumbs($moduleid);
		if($this->user->checkPermission($moduleid)==false)
		{
			$this->response->redirect('?route=page/home');
		}
		
		$this->load->model("quanlykho/phongban");
		$this->getList();
	}
	
	public function insert()
	{
    	$this->getForm();
	}
	
	public function update()
	{			
		$this->load->model("quanlykho/phongban");
		$this->data['haspass'] = false;
		$this->data['readonly'] = 'readonly="readonly"';	
		$this->getForm();
  	}
	
	
	public function delete() 
	{
		$listmaphongban=$this->request->post['delete'];

		$this->load->model("quanlykho/phongban");
		if(count($listmaphongban))
		{
			$this->model_quanlykho_phongban->deleteListPhongBan($listmaphongban);
			$this->data['output'] = "Xóa thành công";
		}
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
  	}
	
	private function getList() 
	{
		$this->data['insert'] = $this->url->http('quanlykho/phongban/insert');
		$this->data['delete'] = $this->url->http('quanlykho/phongban/delete');		
		
		$this->data['datas'] = array();
		$rows = $this->model_quanlykho_phongban->getPhongBans();
		
		//Page
		$page = $this->request->get['page'];		
		$x=$page;		
		$limit = 20;
		$total = count($rows); 
		// work out the pager values 
		$this->data['pager']  = $this->pager->pageLayout($total, $limit, $page); 
		
		$pager  = $this->pager->getPagerData($total, $limit, $page); 
		$offset = $pager->offset; 
		$limit  = $pager->limit; 
		$page   = $pager->page;
		for($i=$offset;$i < $offset + $limit && count($rows[$i])>0;$i++)
		{
			$this->data['datas'][$i] = $rows[$i];
			$this->data['datas'][$i]['link_edit'] = $this->url->http('quanlykho/phongban/update&maphongban='.$this->data['datas'][$i]['maphongban']);
			$this->data['datas'][$i]['text_edit'] = "Sửa";
			
			$this->data['datas'][$i]['link_phanquyen'] = $this->url->http('quanlykho/phongban/phanquyen&maphongban='.$this->data['datas'][$i]['maphongban']);
			$this->data['datas'][$i]['text_phanquyen'] = "Phân quyền";
			
			
		}
		$this->data['refres']=$_SERVER['QUERY_STRING'];
		$this->id='content';
		$this->template="quanlykho/phongban_list.tpl";
		$this->layout="layout/center";
		
		$this->render();
	}
	
	
	private function getForm()
	{
		$this->data['error'] = @$this->error;
		$this->load->model("quanlykho/phongban");
		
		if ((isset($this->request->get['maphongban'])) ) 
		{
      		$this->data['item'] = $this->model_quanlykho_phongban->getPhongban($this->request->get['maphongban']);
			
    	}
		
		$this->id='content';
		$this->template='quanlykho/phongban_form.tpl';
		$this->layout="layout/center";
		
		$this->render();
	}
	
	public function save()
	{
		$data = $this->request->post;
		if($this->validateForm($data))
		{
			$this->load->model("quanlykho/phongban");
			$this->model_quanlykho_phongban->savePhongBan($data);
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
	
	private function validateForm($data)
	{
    	if (trim($data['maphongban']) == "") 
		{
      		$this->error['maphongban'] = "Bạn chưa nhập mã phòng ban";
    	}
		else
		{
			if($data['id'] =="")
			{
				$this->load->model("quanlykho/phongban");
				$item = $this->model_quanlykho_phongban->getPhongBan($data['maphongban']);
				if(count($item)>0)
				{
					$this->error['maphongban'] = "Mã phòng ban đã được sử dụng";
				}
			}
		}
		
		if (trim($data['tenphongban']) == "") 
		{
      		$this->error['tenphongban'] = "Bạn chưa nhập tên phòng ban";
    	}

		if (count($this->error)==0) {
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
	
	public function phanquyen()
	{
		$this->load->model("quanlykho/phongban");
		if ((isset($this->request->get['maphongban'])) ) 
		{
      		$this->data['item'] = $this->model_quanlykho_phongban->getPhongban($this->request->get['maphongban']);
    	}
		
		$this->load->model("core/usertype");
		$this->load->model("core/user");
		$this->load->model("quanlykho/nhanvien");
		$this->load->model("core/module");
		$this->load->model("core/sitemap");
		$this->load->model("common/control");
		
		
		$this->data['permission'] = $this->string->referSiteMapToArray($this->data['item']['permission']);
		
		$this->data['sitemaps'] = array();
		$this->data['listPermission'] = $this->model_core_usertype->listPermission;
		$this->model_core_sitemap->getTreeSitemap("",$this->data['sitemaps'],$this->user->getSiteId());
		$this->data['modules'] = $this->model_core_sitemap->getModuleAddons();
		$this->data['modulesquanlykho'] = $this->model_core_sitemap->getModuleQuanLyKho();
		
		$this->id='content';
		$this->template='quanlykho/phongban_phanquyen.tpl';
		$this->layout="layout/center";
		
		$this->render();
	}
	
	public function savePermission()
	{
		$this->load->model("quanlykho/phongban");
		$maphongban = $this->request->post['maphongban'];
		$permission = $this->request->post['permission'];
		$this->model_quanlykho_phongban->savePermission($maphongban,$permission);
		$this->data['output'] = "true";
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();	
	}
	//Cac ham xu ly tren form
	
}
?>