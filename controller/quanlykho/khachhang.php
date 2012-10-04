<?php
class ControllerQuanlykhoKhachhang extends Controller
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
		//$this->load->language('quanlykho/khachhang');
		//$this->data = array_merge($this->data, $this->language->getData());
		
		$this->document->title = $this->language->get('heading_title');
		
		$this->load->model("quanlykho/khachhang");
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
			//$this->load->language('quanlykho/khachhang');
			//$this->data = array_merge($this->data, $this->language->getData());
			
			$this->load->model("quanlykho/khachhang");
			$this->data['haspass'] = false;
			$this->data['readonly'] = 'readonly="readonly"';
			
			$this->getForm();
		}
		
  	}
	
	public function delete() 
	{
		$listid=$this->request->post['delete'];
		//$listmadonvi=$_POST['delete'];
		$this->load->model("quanlykho/khachhang");
		if(count($listid))
		{
			$this->model_quanlykho_khachhang->deletedatas($listid);
			$this->data['output'] = "Xóa thành công";
		}
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
  	}
	
	private function getList() 
	{
		$this->load->model("quanlykho/nhom");
		
		$this->data['khuvuc'] = array();
		$this->model_quanlykho_nhom->getTree("khuvuc",$this->data['khuvuc']);
		unset($this->data['khuvuc'][0]);
		
		$this->data['loaikhachhang'] = array();
		$this->model_quanlykho_nhom->getTree("loaikhachhang",$this->data['loaikhachhang']);
		unset($this->data['loaikhachhang'][0]);
		
		$this->data['insert'] = $this->url->http('quanlykho/khachhang/insert');
		$this->data['delete'] = $this->url->http('quanlykho/khachhang/delete');		
		
		$this->data['datas'] = array();
		$where = "";
		
		$datasearchlike['makhachhang'] = $this->request->get['makhachhang'];
		$datasearchlike['hoten'] = $this->request->get['hoten'];
		$datasearchlike['khuvuc'] = $this->request->get['khuvuc'];
		$datasearch['loaikhachhang'] = $this->request->get['loaikhachhang'];
		
		$arr = array();
		foreach($datasearchlike as $key => $item)
		{
			if($item !="")
				$arr[] = " AND " . $key ." like '%".$item."%'";
		}
		
		foreach($datasearch as $key => $item)
		{
			if($item !="")
				$arr[] = " AND " . $key ." = '".$item."'";
		}
		
		$where = implode("",$arr);
		
		$rows = $this->model_quanlykho_khachhang->getList($where);
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
			
			/*$loaikhachhang = $this->document->loaikhachhang[$rows[$i]['loaikhachhang']];
			$this->data['datas'][$i]['loaikhachhang'] = $loaikhachhang;*/
			
			/*$khuvuc = $this->model_quanlykho_nhom->getItem($rows[$i]['khuvuc']);
			$this->data['datas'][$i]['khuvuc'] = $khuvuc['tennhom'];*/
		
			$this->data['datas'][$i]['link_edit'] = $this->url->http('quanlykho/khachhang/update&id='.$this->data['datas'][$i]['id']);
			$this->data['datas'][$i]['text_edit'] = "Sửa";
			
		}
		$this->data['refres']=$_SERVER['QUERY_STRING'];
		$this->id='content';
		$this->template="quanlykho/khachhang_list.tpl";
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
		$this->load->model("quanlykho/nhom");
		$this->data['loaikhachhang'] = $this->document->loaikhachhang;
		
		$this->data['khuvuc'] = array();
		$this->model_quanlykho_nhom->getTree("khuvuc",$this->data['khuvuc']);
		unset($this->data['khuvuc'][0]);
		
		$this->data['loaikhachhang'] = array();
		$this->model_quanlykho_nhom->getTree("loaikhachhang",$this->data['loaikhachhang']);
		unset($this->data['loaikhachhang'][0]);
		
		if ((isset($this->request->get['id'])) ) 
		{
      		$this->data['item'] = $this->model_quanlykho_khachhang->getItem($this->request->get['id']);
    	}
		
		$this->id='content';
		$this->template='quanlykho/khachhang_form.tpl';
		$this->layout="layout/center";
		
		$this->render();
	}
	
	public function save()
	{
		$data = $this->request->post;
		
		if($this->validateForm($data))
		{
			$this->load->model("quanlykho/khachhang");
			$item = $this->model_quanlykho_khachhang->getItem($data['id']);
			
			if(count($item)==0)
			{
				$data['id']=$this->model_quanlykho_khachhang->insert($data);
			}
			else
			{
				$this->model_quanlykho_khachhang->update($data);
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
	
	private function validateForm($data)
	{
    	if($data['makhachhang'] == "")
		{
      		$this->error['makhachhang'] = "Mã khách hàng không được rỗng";
    	}
		else
		{
			if($data['id'] == "")
			{
				$this->load->model("quanlykho/khachhang");
				$where = " AND makhachhang ='".$data['makhachhang']."'" ;
				$item = $this->model_quanlykho_khachhang->getList($where);
				if(count($item)>0)
					$this->error['makhachhang'] = "Mã khách hàng đã được sử dụng";
			}
		}
		if(strlen($data['makhachhang']) > 50)
		{
      		$this->error['makhachhang'] = "Mã nhà khách hàng không được vượt quá 50 ký tự";
    	}
		
		if(strlen($data['dienthoai']) > 50)
		{
      		$this->error['dienthoai'] = "Số ký tự điện thoại không được vượt quá 50 ký tự";
    	}
		
		if(strlen($data['fax']) > 50)
		{
      		$this->error['fax'] = "Số ký tự fax không được vượt quá 50 ký tự";
    	}
		
		if ($data['hoten'] == "") 
		{
      		$this->error['hoten'] = "Bạn chưa nhập tên khách hàng";
    	}
		
		if ($data['khuvuc'] == "") 
		{
      		$this->error['khuvuc'] = "Bạn chưa chọn loại khu vực";
    	}
		
		if ($data['loaikhachhang'] == "") 
		{
      		$this->error['loaikhachhang'] = "Bạn chưa chọn loại khách hàng";
    	}
		
		if (count($this->error)==0) 
		{
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
	
//Cac ham xu ly tren form
	public function getKhachHang()
	{
		$col = $this->request->get['col'];
		$val = $this->request->get['val'];
		$operator = $this->request->get['operator'];
		if($operator == "")
			$operator = "equal";
		$this->load->model("quanlykho/khachhang");
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
			
		
		$datas = $this->model_quanlykho_khachhang->getList($where);
		
		$this->data['output'] = json_encode(array('khachhangs' => $datas));
		$this->id="khachhang";
		$this->template="common/output.tpl";
		$this->render();
	}
}
?>