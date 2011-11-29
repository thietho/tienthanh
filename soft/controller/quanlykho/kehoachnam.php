<?php
class ControllerQuanlykhoKehoachnam extends Controller
{
	private $error = array();
	private $loaikehoach = 'kehoachnam';
	private $setup = array(
						'quy' => 4,
						'thang' => 3
						);
	function __construct() 
	{
		if(!$this->user->hasPermission($this->getRoute(), "access"))
		{
			$this->response->redirect("?route=common/permission");
		}
		$this->data['permissionAdd'] = true;
		$this->data['permissionEdit'] = true;
		$this->data['permissionDelete'] = true;
		if(!$this->user->hasPermission($this->getRoute(), "add"))
		{
			$this->data['permissionAdd'] = false;
		}
		if(!$this->user->hasPermission($this->getRoute(), "edit"))
		{
			$this->data['permissionEdit'] = false;
		}
		if(!$this->user->hasPermission($this->getRoute(), "delete"))
		{
			$this->data['permissionDelete'] = false;
		}
		//$this->load->language('quanlykho/nguyenlieu');
		//$this->data = array_merge($this->data, $this->language->getData());
		
		$this->document->title = $this->language->get('heading_title');
		$this->load->model("quanlykho/kehoach");
		$this->load->helper('image');
   	}
	public function index()
	{
		$this->getList();
	}
	
	public function insert()
	{
		if(!$this->user->hasPermission($this->getRoute(), "add"))
		{
			$this->response->redirect("?route=common/permission");
		}
		
    	$this->getForm();
	}
	
	public function update()
	{
		if(!$this->user->hasPermission($this->getRoute(), "edit"))
		{
			$this->response->redirect("?route=common/permission");
		}
		else
		{
			//$this->load->language('quanlykho/taisan');
			//$this->data = array_merge($this->data, $this->language->getData());
			
			
			$this->load->model("quanlykho/taisan");
			$this->data['haspass'] = false;
			$this->data['readonly'] = 'readonly="readonly"';
			
		
			$this->setup();
		}
		
  	}
	

	public function delete() 
	{
		$listid=$this->request->post['delete'];
		//$listmadonvi=$_POST['delete'];
		$this->load->model("quanlykho/taisan");
		if(count($listid))
		{
			$this->model_quanlykho_kehoach->deletedatas($listid);
			$this->data['output'] = "Xóa thành công";
		}
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
  	}
	
	private function getList() 
	{
		
		$this->data['insert'] = $this->url->http('quanlykho/kehoachnam/insert');
		$this->data['delete'] = $this->url->http('quanlykho/kehoachnam/delete');		
		$this->data['list'] = $this->url->http('quanlykho/kehoachnam');
		$this->data['datas'] = array();
		$where = " AND loai = '".$this->loaikehoach."' AND quy = 0 AND thang = 0";
		$rows = $this->model_quanlykho_kehoach->getList($where);
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
		{
			$this->data['datas'][$i] = $rows[$i];
			$this->data['datas'][$i]['link_edit'] = $this->url->http('quanlykho/kehoachnam/update&id='.$this->data['datas'][$i]['id']);
			$this->data['datas'][$i]['text_edit'] = "Sửa";
		}
		
		$this->id='content';
		$this->template="quanlykho/kehoachnam_list.tpl";
		$this->layout="layout/center";
		$this->render();
	}
	
	private function getForm()
	{	
		if ((isset($this->request->get['id'])) ) 
		{
      		$this->data['item'] = $this->model_quanlykho_kehoach->getItem($this->request->get['id']);
			
    	}	
		$this->id='content';
		$this->template='quanlykho/kehoachnam_form.tpl';
		$this->layout="layout/center";
		
		$this->render();
	}
	
	private function setup()
	{
		$this->data['item'] = $this->model_quanlykho_kehoach->getItem($this->request->get['id']);
		$this->id='content';
		$this->template='quanlykho/kehoachnam_setup.tpl';
		$this->layout="layout/center";
		
		$this->render();
	}
	
	public function save()
	{
		$data = $this->request->post;
		if($this->validateForm($data))
		{
			$data['loai'] = $this->loaikehoach;
			if($data['id']=="")
			{
				$data['id'] = $this->model_quanlykho_kehoach->insert($data);
				$this->saveKeHoachNam($data);
			}
			else
			{
				$this->model_quanlykho_kehoach->update($data);
			}
			$this->data['output'] = "true-".$data['id'];
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
	
	private function saveKeHoachNam($data)
	{
		
		for($i=1;$i<=$this->setup['quy'];$i++)
		{
			$data['quy'] = $i;
			$data['thang'] = 0;
			$this->model_quanlykho_kehoach->insert($data);
			for($j=1;$j<=$this->setup['thang'];$j++)
			{
				$data['thang'] = $j;
				$this->model_quanlykho_kehoach->insert($data);
			}
		}
		
	}
	
	private function validateForm($data)
	{
    	if($data['nam'] == "")
		{
      		$this->error['nam'] = "Bạn chưa nhập năm";
    	}
		else
		{
			if($data['id'] == "")
			{
				$where = " AND nam ='".$data['nam']."'" ;
				$item = $this->model_quanlykho_kehoach->getList($where);
				if(count($item)>0)
					$this->error['nam'] = "Kế hoạch năm " . $data ." đã có rồi";
			}
		}
		

		if (count($this->error)==0) {
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
	
	//Cac ham xu ly tren form
	public function getKeHoach()
	{
		$col = $this->request->get['col'];
		$val = $this->request->get['val'];
		$operator = $this->request->get['operator'];
		if($operator == "")
			$operator = "equal";
		$this->load->model("quanlykho/taisan");
		$where = "";
		switch($operator)
		{
			case "equal":
				$where = " AND ".$col." = '".$val."'";
				break;
			case "like":
				$where = " AND ".$col." like '%".$val."%'";
				break;
			case "other":
				$where = " AND ".$col." <> '".$val."'";
				break;
			case "in":
				$where = " AND ".$col." in  (".$val.")";
				break;
			
		}
		
			
		$datas = $this->model_quanlykho_kehoach->getList($where);
		$this->data['output'] = json_encode(array('taisans' => $datas));
		$this->id="taisan";
		$this->template="common/output.tpl";
		$this->render();
	}
	
}
?>