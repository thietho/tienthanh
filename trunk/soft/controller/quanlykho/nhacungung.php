<?php
class ControllerQuanlykhoNhacungung extends Controller
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
		//$this->load->language('quanlykho/nhacungung');
		//$this->data = array_merge($this->data, $this->language->getData());
		
		$this->document->title = $this->language->get('heading_title');
		
		$this->load->model("quanlykho/nhacungung");
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
			//$this->load->language('quanlykho/nhacungung');
			//$this->data = array_merge($this->data, $this->language->getData());
			
			
			$this->load->model("quanlykho/nhacungung");
			$this->data['haspass'] = false;
			$this->data['readonly'] = 'readonly="readonly"';
			
		
			$this->getForm();
		}
		
  	}
	
	
	
	
	public function delete() 
	{
		$listid=$this->request->post['delete'];
		//$listmadonvi=$_POST['delete'];
		$this->load->model("quanlykho/nhacungung");
		if(count($listid))
		{
			$this->model_quanlykho_nhacungung->deletedatas($listid);
			$this->data['output'] = "Xóa thành công";
		}
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
  	}
	
	private function getList() 
	{
		$this->load->model("quanlykho/nhom");
		$this->load->model("quanlykho/kho");
		$this->load->model("quanlykho/donvitinh");
		$this->data['nhomnhacungung'] = $this->model_quanlykho_nhom->getChild("nhomnhacungung");
		$this->data['khuvuc'] = array();
		$this->model_quanlykho_nhom->getTree("khuvuc",$this->data['khuvuc']);
		unset($this->data['khuvuc'][0]);
		
		$this->data['insert'] = $this->url->http('quanlykho/nhacungung/insert');
		$this->data['delete'] = $this->url->http('quanlykho/nhacungung/delete');		
		$this->data['list'] = $this->url->http('quanlykho/nhacungung');		
		
		
		$this->data['datas'] = array();
		$where = "";
		
		$datasearchlike['manhacungung'] = $this->request->get['manhacungung'];
		$datasearchlike['tennhacungung'] = $this->request->get['tennhacungung'];
		$datasearch['manhom'] = $this->request->get['manhom'];
		$datasearchlike['diachi'] = $this->request->get['diachi'];
		$datasearch['khuvuc'] = $this->request->get['khuvuc'];
		$datasearchlike['dienthoai'] = $this->request->get['dienthoai'];
		$datasearchlike['fax'] = $this->request->get['fax'];
		$datasearchlike['tennguoidungdau'] = $this->request->get['tennguoidungdau'];
		
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
		
		$rows = $this->model_quanlykho_nhacungung->getList($where);
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
			
			$this->data['datas'][$i]['link_edit'] = $this->url->http('quanlykho/nhacungung/update&id='.$this->data['datas'][$i]['id']);
			$this->data['datas'][$i]['text_edit'] = "Sửa";
			
			$this->data['datas'][$i]['link_lichsugiaodich'] = $this->url->http('quanlykho/phieunhanhang&id='.$this->data['datas'][$i]['id']);
			$this->data['datas'][$i]['text_lichsugiaodich'] = "Lịch sử giao dịch";
			
			$this->data['datas'][$i]['link_lichsudanhgia'] = $this->url->http('quanlykho/nhacungung/lichsudanhgia&id='.$this->data['datas'][$i]['id']);
			$this->data['datas'][$i]['text_lichsudanhgia'] = "Lịch sử đánh giá";
			
		}
		$this->data['refres']=$_SERVER['QUERY_STRING'];
		$this->id='content';
		$this->template="quanlykho/nhacungung_list.tpl";
		$this->layout="layout/center";
		if($this->request->get['opendialog']=='true')
		{
			$this->layout="layout/dialog";
			$this->data['dialog'] = true;
			
		}
		$this->render();
	}
	
	
	private function getForm()
	{
		
		$this->load->model("quanlykho/nhom");
		$this->load->model("quanlykho/kho");
		$this->load->model("quanlykho/donvitinh");
		//$this->data['nhomnhacungung'] = $this->model_quanlykho_nhom->getChild("nhomnhacungung");
		$this->data['nhomnhacungung'] = array();
		$this->model_quanlykho_nhom->getTree("dmvtccnl",$this->data['nhomnhacungung']);
		unset($this->data['nhomnhacungung'][0]);
		$this->data['khuvuc'] = array();
		$this->model_quanlykho_nhom->getTree("khuvuc",$this->data['khuvuc']);
		unset($this->data['khuvuc'][0]);
		$this->data['donvitinh'] = $this->model_quanlykho_donvitinh->getList();
		
		if ((isset($this->request->get['id'])) ) 
		{
      		$this->data['item'] = $this->model_quanlykho_nhacungung->getItem($this->request->get['id']);
			
			
    	}
		
		$this->id='content';
		$this->template='quanlykho/nhacungung_form.tpl';
		$this->layout="layout/center";
		
		$this->render();
	}
	
	public function save()
	{
		$data = $this->request->post;
		if($this->validateDanhGia($data))
		{
			$this->load->model("quanlykho/nhacungung");
			$item = $this->model_quanlykho_nhacungung->getItem($data['id']);
			$data['ngaybatdaugiaodich'] = $this->date->formatViewDate($data['ngaybatdaugiaodich']);
			$data['hieulucdenngay'] = $this->date->formatViewDate($data['hieulucdenngay']);
			$data['ngaydanhgialai'] = $this->date->formatViewDate($data['ngaydanhgialai']);
			if(count($item)==0)
			{
				$data['id']=$this->model_quanlykho_nhacungung->insert($data);
			}
			else
			{
				$this->model_quanlykho_nhacungung->update($data);
			}
			//Luu danh gia nha cung ung
			$where = " AND ngaydanhgia = '".$data['ngaydanhgialai']."'";
			$obj = $this->model_quanlykho_nhacungung->getDanhGiaNhaCungUngList($where);
			if(count($obj)==0)
			{
				$datadanhgia['manhacungung'] = $data['id'];
				$datadanhgia['ngaydanhgia'] = $data['ngaydanhgialai'];
				$datadanhgia['danhgiasoluong'] = $data['danhgiasoluong'];
				$datadanhgia['danhgiachatluong'] = $data['danhgiachatluong'];
				$datadanhgia['danhgiathoigian'] = $data['danhgiathoigian'];
				$datadanhgia['danhgiathanhtoan'] = $data['danhgiathanhtoan'];
				$this->model_quanlykho_nhacungung->saveDanhGiaNhaCungUng($datadanhgia);
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
		
		
    	if($data['manhacungung'] == "")
		{
      		$this->error['manhacungung'] = "Mã nhà cung ứng không được rỗng";
    	}
		else
		{
			if($data['id'] == "")
			{
				$this->load->model("quanlykho/nhacungung");
				$where = " AND manhacungung ='".$data['manhacungung']."'" ;
				$item = $this->model_quanlykho_nhacungung->getList($where);
				if(count($item)>0)
					$this->error['manhacungung'] = "Mã nhà cung ứng đã được sử dụng";
			}
		}
		if(strlen($data['manhacungung']) > 50)
		{
      		$this->error['manhacungung'] = "Mã nhà cung ứng không được vượt quá 50 ký tự";
    	}
		
		if ($data['tennhacungung'] == "") 
		{
      		$this->error['tennhacungung'] = "Bạn chưa nhập tên nhà cung ứng";
    	}
		
		if ($data['manhom'] == "") 
		{
      		$this->error['manhom'] = "Bạn chưa chọn nhóm";
    	}
		
		if ($data['khuvuc'] == "") 
		{
      		$this->error['khuvuc'] = "Bạn chưa chọn khu vực";
    	}
		
		

		if (count($this->error)==0) {
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
	//Danh gia
	public function lichsudanhgia()
	{
		$this->data['insert'] = $this->url->http('quanlykho/nhacungung/themlichsudanhgia&nhacungungid='.$this->request->get['id']);
		$this->load->model("quanlykho/nhacungung");
		if ((isset($this->request->get['id'])) ) 
		{
      		$this->data['item'] = $this->model_quanlykho_nhacungung->getItem($this->request->get['id']);
			$where = " AND manhacungung = '".$this->request->get['id']."'";
			$this->data['danhgia'] = $this->model_quanlykho_nhacungung->getDanhGiaNhaCungUngList($where);
    	}
		$this->id='content';
		$this->template='quanlykho/nhacungung_lichsudanhgia.tpl';
		$this->layout="layout/center";
		$this->render();
	}
	
	function themlichsudanhgia()
	{
		$this->load->model("quanlykho/nhacungung");
		$nhacungungid = $this->request->get['nhacungungid'];
		$this->data['item'] = $this->model_quanlykho_nhacungung->getItem($nhacungungid);
		$this->id='content';
		$this->template='quanlykho/nhacungung_lichsudanhgia_form.tpl';
		$this->layout="layout/center";
		$this->render();
	}
	
	
	public function savedanhgia()
	{
		$data = $this->request->post;
		
		if($this->validateDanhGia($data))
		{
			$this->load->model("quanlykho/nhacungung");
			
			$data['ngaydanhgia'] = $this->date->formatViewDate($data['ngaydanhgia']);
			$this->model_quanlykho_nhacungung->saveDanhGiaNhaCungUng($data);
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
	
	private function validateDanhGia($data)
	{
    	if($data['danhgiasoluong'] == "")
		{
      		$this->error['danhgiasoluong'] = "Bạn chưa đánh giá số lượng";
    	}
		
		if($data['danhgiachatluong'] == "")
		{
      		$this->error['danhgiachatluong'] = "Bạn chưa đánh giá chất lượng";
    	}
		
		if($data['danhgiathoigian'] == "")
		{
      		$this->error['danhgiathoigian'] = "Bạn chưa đánh giá thời gian";
    	}
		
		if($data['danhgiathanhtoan'] == "")
		{
      		$this->error['danhgiathanhtoan'] = "Bạn chưa đánh giá thanh toán";
    	}
		

		if (count($this->error)==0) {
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
	
	//Cac ham xu ly tren form
	public function getNhaCungUng()
	{
		$col = $this->request->get['col'];
		$val = $this->request->get['val'];
		$operator = $this->request->get['operator'];
		if($operator == "")
			$operator = "equal";
		$this->load->model("quanlykho/nhacungung");
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
			
		
		$datas = $this->model_quanlykho_nhacungung->getList($where);
		
		$this->data['output'] = json_encode(array('nhacungungs' => $datas));
		$this->id="nhacungung";
		$this->template="common/output.tpl";
		$this->render();
	}
	
}
?>