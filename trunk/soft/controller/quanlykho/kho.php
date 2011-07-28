<?php
class ControllerQuanlykhoKho extends Controller
{
	private $error = array();
   
	public function index()
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
		//$this->load->language('quanlykho/kho');
		//$this->data = array_merge($this->data, $this->language->getData());
		
		$this->document->title = $this->language->get('heading_title');
		
		$this->load->model("quanlykho/kho");
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
			//$this->load->language('quanlykho/kho');
			//$this->data = array_merge($this->data, $this->language->getData());
			
			
			$this->load->model("quanlykho/kho");
			$this->data['haspass'] = false;
			$this->data['readonly'] = 'readonly="readonly"';
			if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validateForm())) 
			{
				$this->request->post['makho'] = $this->request->get['makho'];
				$this->request->post['birthday'] = $this->date->formatViewDate($this->request->post['birthday']);
				$this->model_quanlykho_kho->updateitem($this->request->post);
				$this->session->data['success'] = $this->language->get('text_success');
				$this->redirect($this->url->http('quanlykho/kho'));
			}
		
			$this->getForm();
		}
		
  	}
	
	
	public function delete() 
	{
		$listmakho=$this->request->post['delete'];
		//$listmakho=$_POST['delete'];
		$this->load->model("quanlykho/kho");
		if(count($listmakho))
		{
			$this->model_quanlykho_nhom->deletedatas($listmakho);
			$this->data['output'] = "Xóa thành công";
		}
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
  	}
	
	private function getList() 
	{
		$this->data['insert'] = $this->url->http('quanlykho/kho/insert');
		$this->data['delete'] = $this->url->http('quanlykho/kho/delete');		
		
		$this->data['datas'] = array();
		$rows = $this->model_quanlykho_kho->getKhos();
		
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
			$this->data['datas'][$i]['link_edit'] = $this->url->http('quanlykho/kho/update&makho='.$this->data['datas'][$i]['makho']);
			$this->data['datas'][$i]['text_edit'] = "Sửa";
			$this->data['datas'][$i]['link_active'] = $this->url->http('quanlykho/kho/active&makho='.$this->data['datas'][$i]['makho']);
			
		}
		$this->data['refres']=$_SERVER['QUERY_STRING'];
		$this->id='content';
		$this->template="quanlykho/kho_list.tpl";
		$this->layout="layout/center";
		
		if($this->request->get['opendialog']=='true')
		{
			$this->layout="layout/dialog";
			$this->data['dialog'] = true;
			//$this->data['list'] = $this->url->http('quanlykho/nhacungung&opendialog=true');
		}
		
		$this->render();
	}
	
	
	private function getForm()
	{
		$this->data['error'] = @$this->error;
		$this->load->model("quanlykho/kho");
		
		
		
		if ((isset($this->request->get['makho'])) ) 
		{
      		$this->data['item'] = $this->model_quanlykho_kho->getKho($this->request->get['makho']);
			
    	}
		
		$this->id='content';
		$this->template='quanlykho/kho_form.tpl';
		$this->layout="layout/center";
		
		$this->render();
	}
	
	public function save()
	{
		$data = $this->request->post;
		if($this->validateForm($data))
		{
			$this->load->model("quanlykho/kho");
			$this->model_quanlykho_kho->saveKho($data);
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
    	if ($data['makho'] == "") 
		{
      		$this->error['makho'] = "Bạn chưa nhập mã kho";
    	}
		else
		{
			if($data['id']=="")
			{
				$this->load->model("quanlykho/kho");
				$item = $this->model_quanlykho_kho->getKho($data['makho']);
				if(count($item))
				{
					$this->error['makho'] = "Mã kho đã được sử dụng";
				}
			}
		}
		
		if ((strlen($data['tenkho']) == 0)) 
		{
      		$this->error['tenkho'] = "Bạn chưa nhập tên kho";
    	}

		if (count($this->error)==0) {
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
	
	public function viewTonKho()
	{
		$this->load->model("quanlykho/kho");
		$this->load->model("quanlykho/nguyenlieu");
		$this->load->model("quanlykho/phieunhapxuat");
		$makho = $this->request->get['id'];
		$where = "";
		if($makho!="")
		{
			$this->data['datas'][0] = $this->model_quanlykho_kho->getKho($makho);
		}
		else
		{
			$this->data['datas'] = $this->model_quanlykho_kho->getKhos($where);
		}
		
		foreach($this->data['datas'] as $key => $val)
		{
			$where = " AND maphieu = (SELECT id
										FROM `qlkphieunhapxuat`
										WHERE makho = '".$val['makho']."'
									)";
			$where .= " AND phieuxuat = 0 AND trangthai = 'completed'";
			$this->data['datas'][$key]['chitiets'] = $this->model_quanlykho_phieunhapxuat->getChiTietPhieuXuatNhap($where);
		}
		
		$this->id='content';
		$this->template="quanlykho/kho_tonkho.tpl";
		$this->layout="layout/dialog";
		$this->data['dialog'] = true;
		$this->render();
	}
	//Cac ham xu ly tren form
	public function getKho()
	{
		$col = $this->request->get['col'];
		$val = $this->request->get['val'];
		
		
		/*
		$operator = $this->request->get['operator'];
		if($operator == "")
			$operator = "equal";
		$this->load->model("quanlykho/kho");
		$where = "";
		switch($operator)
		{
			case "equal":
				$where = " AND ".$col." = '".$val."'";
				break;
			case "like":
				$where = " AND ".$col." = '%".$val."%'";
				break;
			case "other":
				$where = " AND ".$col." <> '".$val."'";
				break;
			case "in":
				$where = " AND ".$col." in  (".$val.")";
				break;
			
		}
		*/	
		
		$this->load->model("quanlykho/kho");
		$datas =  array();
		$datas[0] = $this->model_quanlykho_kho->getKho($val);
		
		$this->data['output'] = json_encode(array('khos' => $datas));
		
		$this->id="kho";
		$this->template="common/output.tpl";
		$this->render();
	}
	
	
}
?>