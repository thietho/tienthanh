<?php
class ControllerAddonPhieuthu extends Controller
{
	private $error = array();
   	function __construct() 
	{
		$this->load->model("core/module");
		$moduleid = $_GET['route'];
		$this->document->title = $this->model_core_module->getBreadcrumbs($moduleid);
		if($this->user->checkPermission($moduleid)==false)
		{
			$this->response->redirect('?route=page/home');
		}
		
	 	$this->load->model("addon/thuchi");
		$this->load->model("core/category");
		$this->data['tkthu'] = array();
		$this->model_core_category->getTree("tkthu",$this->data['tkthu']);
		unset($this->data['tkthu'][0]);
   	}
	
	public function index()
	{
		$this->getList();
	}
	
	public function insert()
	{
    	$this->getForm();
	}
	
	public function update()
	{
		$this->data['haspass'] = false;
		$this->data['readonly'] = 'readonly="readonly"';
		$this->data['class'] = 'readonly';	
		$this->getForm();
  	}
	
	
	
	public function delete() 
	{
		$listmaphieu=$this->request->post['delete'];
		
		if(count($listmaphieu))
		{
			foreach($listmaphieu as $maphieu)
			{
				$this->model_addon_thuchi->delete($maphieu);	
			}
			$this->data['output'] = "true";
		}
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
  	}
	
	private function getList() 
	{
		$this->data['insert'] = $this->url->http('addon/phieuthu/insert');
		$this->data['delete'] = $this->url->http('addon/phieuthu/delete');		
		
		$this->data['datas'] = array();
		$where = " AND loaithuchi = 'thu'";
		$data = $this->request->get;
		foreach($data as $key =>$val)
		{
			$data[$key] = urldecode($val);	
		}
		$_GET = $data;
		if(trim($data['sophieu']))
		{
			$where .= " AND sophieu like '%".$data['sophieu']."%'";
		}
		
		if(trim($data['tungay']))
		{
			$where .= " AND ngaylap >= '".$this->date->formatViewDate($data['tungay'])."'";
		}
		
		if(trim($data['denngay']))
		{
			$where .= " AND ngaylap <= '".$this->date->formatViewDate($data['denngay'])."'";
		}
		
		if(trim($data['tenkhachhang']))
		{
			$where .= " AND tenkhachhang like '%".$data['tenkhachhang']."%'";
		}
		if(trim($data['nguoithuchien']))
		{
			$where .= " AND nguoithuchien like '%".$data['nguoithuchien']."%'";
		}
		
		if(trim($data['sotientu']))
		{
			$where .= " AND quidoi >= '".$this->string->toNumber($data['sotientu'])."'";
		}
		
		if(trim($data['sotienden']))
		{
			$where .= " AND quidoi <= '".$this->string->toNumber($data['sotienden'])."'";
		}
		
		if(trim($data['dienthoai']))
		{
			$where .= " AND dienthoai like '%".$data['dienthoai']."%'";
		}
		
		$where .= " Order by ngaylap DESC";
		$rows = $this->model_addon_thuchi->getList($where);
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
		//for($i=0; $i <= count($this->data['datas'])-1 ; $i++)
		//for($i=0;$i < count($rows[$i]);$i++)
		{
			$this->data['datas'][$i] = $rows[$i];
			$this->data['datas'][$i]['link_edit'] = $this->url->http('addon/phieuthu/update&maphieu='.$this->data['datas'][$i]['maphieu']);
			$this->data['datas'][$i]['text_edit'] = "Edit";
			
			
			
		}
		
		$this->id='content';
		$this->template="addon/phieuthu_list.tpl";
		$this->layout=$this->user->getLayout();
		
		$this->render();
	}
	
	
	private function getForm()
	{		
		
		if ((isset($this->request->get['maphieu'])) ) 
		{
      		$this->data['item'] = $this->model_addon_thuchi->getItem($this->request->get['maphieu']);
			
    	}
		else
		{
			$this->data['item']['ngaylap'] = $this->date->getToday();
		}
		
		$this->id='content';
		$this->template='addon/phieuthu_form.tpl';
		$this->layout=$this->user->getLayout();
		$this->render();
	}
	
	public function view()
	{
		$this->data['item'] = $this->model_addon_thuchi->getItem($this->request->get['maphieu']);
		
		$this->id='content';
		$this->template='addon/phieuthu_view.tpl';
		if($_GET['dialog']=='print')
		{
			$this->layout='layout/print';
		}
		$this->render();
	}
	
	public function updateTinhTrang()
	{
		$data = $this->request->post;
		$this->model_addon_thuchi->updateCol($data['maphieu'],'tinhtrang',$data['tinhtrang']);
		$this->data['output'] = "true";
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	
	public function save()
	{
		$data = $this->request->post;
		
		if($this->validateForm($data))
		{
			$data['loaithuchi'] = "thu";
			$now = $this->date->getToday();
			$year = $this->date->getYear($now);
			$month = $this->date->getMonth($now);
			$data['prefix'] = $month.$year."PT";
			$data['quidoi'] = $this->document->toVND($this->string->toNumber($data['sotien']),$data['donvi']);
			if($data['maphieu']=="")
			{
				$data['maphieu'] = $this->model_addon_thuchi->insert($data);	
			}
			else
			{
				$this->model_addon_thuchi->update($data);	
			}
			
			$this->data['output'] = "true-".$data['maphieu'];
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
		
		if (trim($data['tenkhachhang']) == "") 
		{
      		$this->error['tenkhachhang'] = "Bạn chưa nhập tên khách hàng";
    	}
		
		
		
		if (trim($data['email']) != "") 
		{
      		if ($this->validation->_checkEmail($data['email']) == false )
				$this->error["email"] = "Email không đúng định dạng";
    	}
		if (trim($data['nguoithuchien']) == '') 
		{
      		$this->error['nguoithuchien'] = "Bạn chưa nhập người thu";
    	}
		if (trim($data['sotien']) == "") 
		{
      		$this->error['sotien'] = "Bạn chưa nhập số tiền thu";
    	}
		if (count($this->error)==0) {
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
	
}
?>