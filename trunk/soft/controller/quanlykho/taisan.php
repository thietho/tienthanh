<?php
class ControllerQuanlykhoTaisan extends Controller
{
	private $error = array();
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
		
		$this->load->model("quanlykho/taisan");
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
			
		
			$this->getForm();
		}
		
  	}
	

	public function delete() 
	{
		$listid=$this->request->post['delete'];
		//$listmadonvi=$_POST['delete'];
		$this->load->model("quanlykho/taisan");
		if(count($listid))
		{
			$this->model_quanlykho_taisan->deletedatas($listid);
			$this->data['output'] = "Xóa thành công";
		}
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
  	}
	
	private function getList() 
	{
		
		$this->data['sotaisan'] = $this->url->http('quanlykho/taisan/sotaisan');
		$this->data['insert'] = $this->url->http('quanlykho/taisan/insert');
		$this->data['delete'] = $this->url->http('quanlykho/taisan/delete');		
		$this->data['list'] = $this->url->http('quanlykho/taisan');
		$this->load->model("quanlykho/taisan");
		$this->load->model("quanlykho/nhom");
		$this->load->model("quanlykho/kho");
		$this->load->model("quanlykho/donvitinh");
		$this->load->model("quanlykho/nhanvien");
		$this->data['nhomtaisan'] = $this->model_quanlykho_nhom->getChild("nhomtaisan");
		$this->data['loaitaisan'] = $this->model_quanlykho_nhom->getChild("loaitaisan");
		$this->data['kho'] = $this->model_quanlykho_kho->getKhos();
		$this->data['donvitinh'] = $this->model_quanlykho_donvitinh->getList();
		
		$this->data['datas'] = array();
		$where = "";
		
		$datasearchlike['mataisan'] = $this->request->get['mataisan'];
		$datasearchlike['tentaisan'] = $this->request->get['tentaisan'];
		$datasearch['manhom'] = $this->request->get['manhom'];
		$datasearch['loai'] = $this->request->get['loai'];
		$datasearch['makho'] = $this->request->get['makho'];
		
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
		
		$where .= implode("",$arr);
		
		$rows = $this->model_quanlykho_taisan->getList($where);
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
			$this->data['datas'][$i]['hienhanh'] = $this->model_quanlykho_taisan->kientraTaiSan($this->data['datas'][$i]['id']);
			$this->data['datas'][$i]['link_edit'] = $this->url->http('quanlykho/taisan/update&id='.$this->data['datas'][$i]['id']);
			$this->data['datas'][$i]['text_edit'] = "Sửa";
			$this->data['datas'][$i]['link_dinhluong'] = $this->url->http('quanlykho/taisan/dinhluong&id='.$this->data['datas'][$i]['id']);
			$this->data['datas'][$i]['text_dinhluong'] = "Định lượng";
			$this->data['datas'][$i]['link_capnhatgia'] = $this->url->http('quanlykho/taisan/capnhatgia&id='.$this->data['datas'][$i]['id']);
			$this->data['datas'][$i]['text_capnhatgia'] = "Cập nhật giá";
			//
			$nhom = $this->model_quanlykho_nhom->getItem($rows[$i]['manhom']);
			$this->data['datas'][$i]['tennhom'] = $nhom['tennhom'];
			$loai = $this->model_quanlykho_nhom->getItem($rows[$i]['loai']);
			$this->data['datas'][$i]['tenloai'] = $loai['tennhom'];
			$kho = $this->model_quanlykho_kho->getKho($rows[$i]['makho']);
			$this->data['datas'][$i]['tenkho'] = $kho['tenkho'];
			$nhanvien = $this->model_quanlykho_nhanvien->getItem($rows[$i]['nguoinhan']);
			
			$this->data['datas'][$i]['tennguoinhan'] = $nhanvien['hoten'];
			$this->data['datas'][$i]['imagethumbnail'] = HelperImage::resizePNG($this->data['datas'][$i]['imagepath'], 100, 0);
			
		}
		$this->data['refres']=$_SERVER['QUERY_STRING'];
		$this->id='content';
		$this->template="quanlykho/taisan_list.tpl";
		$this->layout="layout/center";
		if($this->request->get['opendialog']=='true')
		{
			$this->layout="layout/dialog";
			$this->data['dialog'] = true;
			
		}
		$this->render();
		$this->render();
	}
	
	private function getForm()
	{
		$this->data['DIR_UPLOADPHOTO'] = HTTP_SERVER."index.php?route=common/uploadpreview";
		$this->load->model("quanlykho/nhom");
		$this->load->model("quanlykho/kho");
		$this->load->model("quanlykho/donvitinh");
		$this->data['nhomtaisan'] = $this->model_quanlykho_nhom->getChild("nhomtaisan");
		$this->data['loaitaisan'] = $this->model_quanlykho_nhom->getChild("loaitaisan");
		$this->data['kho'] = $this->model_quanlykho_kho->getKhos();
		$this->data['donvitinh'] = $this->model_quanlykho_donvitinh->getList();
		
		if ((isset($this->request->get['id'])) ) 
		{
      		$this->data['item'] = $this->model_quanlykho_taisan->getItem($this->request->get['id']);
			$this->data['item']['imagethumbnail'] = HelperImage::resizePNG($this->data['item']['imagepath'], 200, 200);
    	}
		
		$this->id='content';
		$this->template='quanlykho/taisan_form.tpl';
		$this->layout="layout/center";
		
		$this->render();
	}
	
	public function save()
	{
		$data = $this->request->post;
		if($this->validateForm($data))
		{
			$this->load->model("quanlykho/taisan");
			$data['ngaymua'] = $this->date->formatViewDate($data['ngaymua']);
			if($data['id']=="")
			{
				$this->model_quanlykho_taisan->insert($data);
			}
			else
			{
				$this->model_quanlykho_taisan->update($data);
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
    	if($data['mataisan'] == "")
		{
      		$this->error['mataisan'] = "Mã tài sản không được rỗng";
    	}
		else
		{
			if($data['id'] == "")
			{
				$this->load->model("quanlykho/taisan");
				$where = " AND mataisan ='".$data['mataisan']."'" ;
				$item = $this->model_quanlykho_taisan->getList($where);
				if(count($item)>0)
					$this->error['mataisan'] = "Mã tài sản đã được sử dụng";
			}
		}
		if(strlen($data['mataisan']) > 50)
		{
      		$this->error['mataisan'] = "Mã tài sản không được vượt quá 50 ký tự";
    	}
		
		if ($data['tentaisan'] == "") 
		{
      		$this->error['tentaisan'] = "Bạn chưa nhập tên tài sản";
    	}
		
		if ($data['manhom'] == "") 
		{
      		$this->error['manhom'] = "Bạn chưa chọn nhóm";
    	}
		
		if ($data['loai'] == "") 
		{
      		$this->error['loai'] = "Bạn chưa chọn loại";
    	}
		
		if ($data['makho'] == "") 
		{
      		$this->error['makho'] = "Bạn chưa chọn kho";
    	}
		
		if ($data['ngaymua'] == "") 
		{
      		$this->error['ngaymua'] = "Bạn chưa nhập ngày mua";
    	}
		
		if ($data['khauhao'] == "") 
		{
      		$this->error['khauhao'] = "Bạn chưa nhập khấu hao";
    	}
		
		if ($data['madonvi'] == "") 
		{
      		$this->error['madonvi'] = "Bạn chưa nhập đơn vị tính";
    	}

		if (count($this->error)==0) {
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
	//Sổ tài sản
	public function sotaisan()
	{
		
		$this->data['insert'] = $this->url->http('quanlykho/taisan/captaisan');
			
		//$this->data['list'] = $this->url->http('quanlykho/taisan');
		$this->load->model("quanlykho/taisan");
		$this->load->model("quanlykho/phongban");
		$this->data['nhomtaisan'] = $this->model_quanlykho_nhom->getChild("nhomnguyenlieu");
		$this->data['loaitaisan'] = $this->model_quanlykho_nhom->getChild("loainguyenlieu");
		$this->data['phongban'] = $this->model_quanlykho_phongban->getPhongBans();
		
		$this->data['datas'] = array();
		$where = " AND `phongbannhan` <> ''";
		
		$datasearchlike['mataisan'] = $this->request->get['mataisan'];
		$datasearchlike['tentaisan'] = $this->request->get['tentaisan'];
		$datasearch['phongbannhan'] = $this->request->get['phongbannhan'];
		
		
		$arr = array();
		foreach($datasearchlike as $key => $item)
		{
			if($item !="")
				$arr[] = " AND mataisan in ( Select id from qlktaisan
												where " . $key ." like '%".$item."%')";
		}
		
		foreach($datasearch as $key => $item)
		{
			if($item !="")
				$arr[] = " AND " . $key ." = '".$item."'";
		}
		
		$where .= implode("",$arr);
		
		$rows = $this->model_quanlykho_taisan->getSoTaiSanList($where);
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
			
			$this->data['datas'][$i]['link_edit'] = $this->url->http('quanlykho/taisan/captaisan&id='.$this->data['datas'][$i]['id']);
			$this->data['datas'][$i]['text_edit'] = "Sửa";
			$this->data['datas'][$i]['link_tra'] = $this->url->http('quanlykho/taisan/trataisan&id='.$this->data['datas'][$i]['id']);
			$this->data['datas'][$i]['text_tra'] = "Trả";
			if($this->data['datas'][$i]['nguoitra'] == 0)
				$this->data['datas'][$i]['btnTra'] = '<input type="button" class="button" name="btnTra" value="'.$this->data['datas'][$i]['text_tra'].'" onclick="window.location=\''.$this->data['datas'][$i]['link_tra'].'\'"/>';
			//
			$taisan = $this->model_quanlykho_taisan->getItem($rows[$i]['mataisan']);
			$this->data['datas'][$i]['tentaisan'] = $taisan['tentaisan'];
			$this->data['datas'][$i]['maso'] = $taisan['mataisan'];
			$phongban = $this->model_quanlykho_phongban->getPhongBan($rows[$i]['phongbannhan']);
			$this->data['datas'][$i]['tenphongban'] = $phongban['tenphongban'];
			
		}
		$this->data['refres']=$_SERVER['QUERY_STRING'];
		$this->id='content';
		$this->template="quanlykho/taisan_sotaisan.tpl";
		$this->layout="layout/center";
		
		$this->render();
	}
	
	public function captaisan()
	{
		$this->load->model("quanlykho/phongban");
		$this->load->model("quanlykho/taisan");
		$this->data['phongban'] = $this->model_quanlykho_phongban->getPhongBans();
		if ((isset($this->request->get['id'])) ) 
		{
      		$this->data['item'] = $this->model_quanlykho_taisan->getSoTaiSan($this->request->get['id']);
			
    	}
		
		$this->id='content';
		$this->template='quanlykho/taisan_captaisan.tpl';
		$this->layout="layout/center";
		
		$this->render();
	}
	
	public function savecaptaisan()
	{
		$data = $this->request->post;
		if($this->validateFormCapTaiSan($data))
		{
			$this->load->model("quanlykho/taisan");
			$data['ngaynhan'] = $this->date->formatViewDate($data['ngaynhan']);
			$this->model_quanlykho_taisan->saveSoTaiSan($data);
			
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
	
	private function validateFormCapTaiSan($data)
	{
    	if($data['mataisan'] == "")
		{
      		$this->error['mataisan'] = "Bạn chưa chọn tài sản";
    	}
		else
		{
			$this->load->model("quanlykho/taisan");
			if($this->model_quanlykho_taisan->kientraTaiSan($this->error['mataisan']) == false)
				$this->error['mataisan'] = "Tài sản này chưa được trả";
			
			
		}
		
		if ($data['phongbannhan'] == "") 
		{
      		$this->error['phongbannhan'] = "Bạn chưa chọn phong ban nhận";
    	}
		
		if ($data['ngaynhan'] == "") 
		{
      		$this->error['ngaynhan'] = "Bạn chưa nhập ngày cấp";
    	}
		
		if ($data['nguoidexuat'] == "") 
		{
      		$this->error['nguoidexuat'] = "Bạn chưa chọn ngưới đề xuất";
    	}
		
		if ($data['nguoinhan'] == "") 
		{
      		$this->error['nguoinhan'] = "Bạn chưa chọn người nhận";
    	}
		
		
		
		

		if (count($this->error)==0) {
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
	
	public function trataisan()
	{
		$this->load->model("quanlykho/phongban");
		$this->load->model("quanlykho/taisan");
		$this->load->model("quanlykho/nhanvien");
		$this->data['phongban'] = $this->model_quanlykho_phongban->getPhongBans();
		if ((isset($this->request->get['id'])) ) 
		{
      		$this->data['item'] = $this->model_quanlykho_taisan->getSoTaiSan($this->request->get['id']);
			
			$taisan = $this->model_quanlykho_taisan->getItem($this->data['item']['mataisan']);
			$this->data['item']['tentaisan'] = $taisan['tentaisan'];
			$phongban = $this->model_quanlykho_phongban->getPhongBan($this->data['item']['phongbannhan']);
			$this->data['item']['tenphongbannhan'] = $phongban['tenphongban'];
			$nhanvien = $this->model_quanlykho_nhanvien->getItem($this->data['item']['nguoidexuat']);
			$this->data['item']['tennguoidexuat'] = $nhanvien['hoten'];
			$nhanvien = $this->model_quanlykho_nhanvien->getItem($this->data['item']['nguoinhan']);
			$this->data['item']['tennguoinhan'] = $nhanvien['hoten'];
    	}
		
		$this->id='content';
		$this->template='quanlykho/taisan_trataisan.tpl';
		$this->layout="layout/center";
		
		$this->render();	
	}
	
	public function savetrataisan()
	{
		$data = $this->request->post;
		if($this->validateFormTraTaiSan($data))
		{
			$this->load->model("quanlykho/taisan");
			$data['ngaytra'] = $this->date->formatViewDate($data['ngaytra']);
			
			$this->model_quanlykho_taisan->saveTraTaiSan($data);
			
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
	
	private function validateFormTraTaiSan($data)
	{
    	if($data['ngaytra'] == "")
		{
      		$this->error['ngaytra'] = "Bạn chưa chọn ngày trả";
    	}
		
		if ($data['nguoitra'] == 0) 
		{
      		$this->error['nguoitra'] = "Bạn chưa chọn ngưới trả";
    	}

		if (count($this->error)==0) {
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
	
	//Cac ham xu ly tren form
	public function getTaiSan()
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
		
			
		$datas = $this->model_quanlykho_taisan->getList($where);
		$this->data['output'] = json_encode(array('taisans' => $datas));
		$this->id="taisan";
		$this->template="common/output.tpl";
		$this->render();
	}
	
}
?>