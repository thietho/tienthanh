<?php

class ControllerQuanlykhoPhieukhieunai extends Controller
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
		//$this->load->language('quanlykho/phieukhieunai');
		//$this->data = array_merge($this->data, $this->language->getData());
		
		$this->document->title = $this->language->get('heading_title');
		
		$this->load->model("quanlykho/phieukhieunai");
		$this->getList();
	}
	
	public function insert()
	{
		if(!$this->user->hasPermission($this->getRoute(), "add"))
		{
			$this->response->redirect("?route=common/permission");
		}
		
    	$this->getForm('kn');
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
			
			$this->load->model("quanlykho/phieukhieunai");
			$this->data['haspass'] = false;
			$this->data['readonly'] = 'readonly="readonly"';
			
			$this->getForm('kn');
		}
		
  	}
	
	public function phanhoi()
	{
		if(!$this->user->hasPermission($this->getRoute(), "edit"))
		{
			$this->response->redirect("?route=common/permission");
		}
		else
		{
			//$this->load->language('quanlykho/kho');
			//$this->data = array_merge($this->data, $this->language->getData());
			
			$this->load->model("quanlykho/phieukhieunai");
			$this->data['haspass'] = false;
			$this->data['readonly'] = 'readonly="readonly"';
			
			$this->getForm('ph');
		}
		
  	}
	
	
	public function delete() 
	{
		$listmaphieu=$this->request->post['delete'];
		//$listmakho=$_POST['delete'];
		$this->load->model("quanlykho/phieukhieunai");
		if(count($listmaphieu))
		{
			$this->model_quanlykho_phieukhieunai->deleteListPhieuKhieuNai($listmaphieu);
			$this->data['output'] = "Xóa thành công";
		}
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
  	}
	
	private function getList() 
	{
		$this->load->model("quanlykho/nhanvien");
		
		$this->data['insert'] = $this->url->http('quanlykho/phieukhieunai/insert');
		$this->data['delete'] = $this->url->http('quanlykho/phieukhieunai/delete');		
		
		$this->data['datas'] = array();
		$where = "";
		
		if($this->request->get['tungay'] != "")
		{
			$datasearch['tungay'] = $this->date->formatViewDate($this->request->get['tungay']);
		}
		
		if($this->request->get['denngay'] != "")
		{
			$datasearch['denngay'] = $this->date->formatViewDate($this->request->get['denngay']);
		}
		
		if($this->request->get['trangthai'] != "")
		{
			$datasearch['trangthai'] = $this->request->get['trangthai'];
		}
		
		$arr = array();
		
		/*
		foreach($datasearchlike as $key => $item)
		{
			if($item !="")
				$arr[] = " AND " . $key ." like '%".$item."%'";
		}
		*/
		
		/*
		foreach($datasearch as $key => $item)
		{
			if($item !="")
				$arr[] = " AND " . $key ." = '".$item."'";
		}
		*/
		
		//$where = implode("",$arr);
		
		if($datasearch['tungay'] != "")
		{
			$where .= " AND ngaylap >= '" .$datasearch['tungay'] . "'" ;
		}
		
		if($datasearch['denngay'] != "")
		{
			$where .= " AND ngaylap <= '" .$datasearch['denngay'] . "'";
		}
		
		if($datasearch['trangthai'] != "")
		{
			$where .= " AND trangthai = '" .$datasearch['trangthai'] . "'";
		}
		
		$rows = $this->model_quanlykho_phieukhieunai->getPhieuKhieuNais($where);
		
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
			
			$nhanvientiepnhan = $this->model_quanlykho_nhanvien->getItem($this->data['datas'][$i]['nhanvientiepnhan']);
			$this->data['datas'][$i]['nvtn'] = $nhanvientiepnhan['hoten'];
			
			$nhanvienxuly = $this->model_quanlykho_nhanvien->getItem($this->data['datas'][$i]['nhanvienxuly']);
			$this->data['datas'][$i]['nvxl'] = $nhanvienxuly['hoten'];
			
			$this->data['datas'][$i]['link_edit'] = $this->url->http('quanlykho/phieukhieunai/update&maphieu='.$this->data['datas'][$i]['maphieu']);
			$this->data['datas'][$i]['text_edit'] = "Sửa";
			
			$this->data['datas'][$i]['link_phanhoi'] = $this->url->http('quanlykho/phieukhieunai/phanhoi&maphieu='.$this->data['datas'][$i]['maphieu']);
			$this->data['datas'][$i]['text_phanhoi'] = "Phản hồi";
			
		}
		$this->data['refres']=$_SERVER['QUERY_STRING'];
		$this->id='content';
		$this->template="quanlykho/phieukhieunai_list.tpl";
		$this->layout="layout/center";
		
		$this->render();
	}
	
	
	private function getForm($khieunai)
	{
		$this->data['error'] = @$this->error;
		$this->load->model("quanlykho/phieukhieunai");
		$this->load->model("quanlykho/khachhang");
		$this->load->model("quanlykho/nhanvien");
		
		if($khieunai == 'kn')
		{
			$nvtn = $this->model_quanlykho_nhanvien->getItemByUsername($this->user->getUserName()); 
			$this->data['item']['nhanvientiepnhan'] = $nvtn['id'];
			$this->data['item']['hoten'] = $nvtn['hoten'];
		}
		
		if ((isset($this->request->get['maphieu'])) ) 
		{
      		$this->data['item'] = $this->model_quanlykho_phieukhieunai->getPhieuKhieuNai($this->request->get['maphieu']);
			$kh = $this->model_quanlykho_khachhang->getItem($this->data['item']['makhachhang']); 
			$this->data['item']['makh'] = $kh['makhachhang'];
			
			$nvtn = $this->model_quanlykho_nhanvien->getItem($this->data['item']['nhanvientiepnhan']); 
			$this->data['item']['hoten'] = $nvtn['hoten'];
			
			if($khieunai == 'ph')
			{
				$nvxl = $this->model_quanlykho_nhanvien->getItemByUsername($this->user->getUserName()); 
				$this->data['item']['nhanvienxuly'] = $nvxl['id'];
				$this->data['item']['nvxlhoten'] = $nvxl['hoten'];
				
				$this->$data['item']['noidungyeucau'] = $this->model_quanlykho_phieu->getPhieuInfo($this->request->get['maphieu'], 'noidungyeucau');
			}
			
    	}
		$this->data['item']['khieunai'] = $khieunai;
		
		$this->id='content';
		$this->template='quanlykho/phieukhieunai_form.tpl';
		$this->layout="layout/center";
		
		$this->render();
	}
	
	public function save()
	{
		$data = $this->request->post;
		if($this->validateForm($data))
		{
			$this->load->model("quanlykho/phieukhieunai");
			$this->model_quanlykho_phieukhieunai->savePhieuKhieuNai($data);
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
		if ($data['nhanvientiepnhan'] == "") 
		{
      		$this->error['nhanvientiepnhan'] = "Bạn chưa chọn nhân viên tiếp nhận";
    	}
		
		if ((strlen($data['tenkhachhang']) > 100)) 
		{
      		$this->error['tenkhachhang'] = "Tên khách hàng không được vượt quá 100 ký tự";
    	}
		
		if ((strlen($data['dienthoai']) > 50)) 
		{
      		$this->error['dienthoai'] = "Điện thoại không được vượt quá 50 ký tự";
    	}
		
		if ((strlen($data['hinhthuc']) > 100)) 
		{
      		$this->error['hinhthuc'] = "Hình thức xử lý không được vượt quá 100 ký tự";
    	}
		
		if ((strlen($data['tenkhachhang']) == 0)) 
		{
      		$this->error['tenkhachhang'] = "Bạn chưa nhập tên khách hàng";
    	}
		

		if (count($this->error)==0) {
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
	//Cac ham xu ly tren form
	
}
?>