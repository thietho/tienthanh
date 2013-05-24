<?php
class ControllerQuanlykhoTieuchikiemtra extends Controller
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
		
		$this->load->model("quanlykho/tieuchikiemtra");
		$this->load->model("quanlykho/nguyenlieu");
		$this->load->model("quanlykho/linhkien");
		$this->load->model("quanlykho/taisan");
		$this->load->model("quanlykho/donvitinh");
		
   	}
	public function index()
	{
		
		$this->data['insert'] = $this->url->http('quanlykho/tieuchikiemtra/insert');
		$this->data['delete'] = $this->url->http('quanlykho/tieuchikiemtra/delete');
		
		$this->id='content';
		$this->template="quanlykho/tieuchikiemtra_list.tpl";
		$this->layout="layout/center";
		
		if($this->request->get['opendialog']=='true')
		{
			$this->layout="";
			$this->data['dialog'] = true;
			
		}
		$this->render();
	}
	
	public function insert()
	{
    	$this->getForm();
	}
	public function insertlist()
	{		
    	$this->id='content';
		$this->template='quanlykho/tieuchikiemtra_form_list.tpl';
		$this->layout="layout/center";
		$this->render();
	}
	
	public function update()
	{
		$this->data['haspass'] = false;
		$this->data['readonly'] = 'readonly="readonly"';
		$this->getForm();		
  	}

	public function delete() 
	{
		$listid=$this->request->post['delete'];
		//$listmadonvi=$_POST['delete'];
		
		if(count($listid))
		{
			$this->model_quanlykho_nguyenlieu->deletedatas($listid);
			$this->data['output'] = "Xóa thành công";
		}
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
  	}
	
	public function getList() 
	{
		
		$this->data['bangbaogia'] = $this->url->http('quanlykho/tieuchikiemtra/bangbaogia');
		$this->data['insertlist'] = $this->url->http('quanlykho/tieuchikiemtra/insertlist');
		$this->data['insert'] = $this->url->http('quanlykho/tieuchikiemtra/insert');
		$this->data['delete'] = $this->url->http('quanlykho/tieuchikiemtra/delete');
		
		
		
		$this->data['datas'] = array();
		$where = "";
		
		$datasearchlike['manguyenlieu'] = urldecode($this->request->get['manguyenlieu']);
		$datasearchlike['tennguyenlieu'] = urldecode($this->request->get['tennguyenlieu']);
		$datasearch['manhom'] = $this->request->get['manhom'];
		$datasearch['loai'] = $this->request->get['loai'];
		$datasearch['makho'] = $this->request->get['makho'];
		
		$arr = array();
		foreach($datasearchlike as $key => $item)
		{
			if($item !="")
				$arr[] = " AND " . $key ." like '".$item."%'";
		}
		
		foreach($datasearch as $key => $item)
		{
			if($item !="")
				$arr[] = " AND " . $key ." = '".$item."'";
		}
		
		
		
		
		$where = implode("",$arr);
		//$where .= " AND loai IN ('".implode("','",$arrnhom)."')";
		
		$rows = $this->model_quanlykho_tieuchikiemtra->getList($where);
		//Page
		$page = $this->request->get['page'];		
		$x=$page;		
		$limit = 20;
		$total = count($rows); 
		// work out the pager values 
		$this->data['pager']  = $this->pager->pageLayoutAjax($total, $limit, $page,"#listnguyenlieu");
		
		$pager  = $this->pager->getPagerData($total, $limit, $page); 
		$offset = $pager->offset; 
		$limit  = $pager->limit; 
		$page   = $pager->page;
		for($i=$offset;$i < $offset + $limit && count($rows[$i])>0;$i++)
		//for($i=0; $i <= count($this->data['datas'])-1 ; $i++)
		{
			$this->data['datas'][$i] = $rows[$i];
			$this->data['datas'][$i]['link_edit'] = $this->url->http('quanlykho/tieuchikiemtra/update&id='.$this->data['datas'][$i]['id']);
			$this->data['datas'][$i]['text_edit'] = "Sửa";
			
			
			//
			
			
		}
		$this->data['refres']=$_SERVER['QUERY_STRING'];
		$this->id='content';
		$this->template="quanlykho/tieuchikiemtra_table.tpl";
		
		if($this->request->get['opendialog']=='true')
		{
			$this->layout="";
			$this->data['dialog'] = true;
			
		}
		$this->render();
	}
	
	
	private function getForm()
	{
		$this->data['DIR_UPLOADPHOTO'] = HTTP_SERVER."index.php?route=common/uploadpreview";
		
		if ((isset($this->request->get['id'])) ) 
		{
      		$this->data['item'] = $this->model_quanlykho_nguyenlieu->getItem($this->request->get['id']);
			$this->data['item']['imagethumbnail'] = HelperImage::resizePNG($this->data['item']['imagepath'], 200, 200);
			
    	}
		
		$this->id='content';
		$this->template='quanlykho/tieuchikiemtra_form.tpl';
		$this->layout="layout/center";
		
		$this->render();
	}
	
	public function save()
	{
		$data = $this->request->post;
		if($this->validateForm($data))
		{
			
			$item = $this->model_quanlykho_nguyenlieu->getItem($data['id']);
			if(count($item)==0)
			{
				$this->model_quanlykho_nguyenlieu->insert($data);
			}
			else
			{
				$this->model_quanlykho_nguyenlieu->update($data);
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
	
	public function savedinhluong()
	{
		$data = $this->request->post;
		
		if($this->validateDinhLuong($data))
		{
			
			//$this->model_quanlykho_nguyenlieu->saveNguyenLieuTrungGian($data);
			$this->model_quanlykho_nguyenlieu->updateNguyenLieuGoc($data);
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
	
	public function savebangbaogia()
	{
		$data = $this->request->post;
		
		if($this->validateBangBaoGia($data))
		{
			$data['loai'] = "nguyenlieu";
			$data['ngay'] = $this->date->formatViewDate($data['ngay']);
			
			//Luu thong tin bang bao gia
			$mabangbaogia = $this->model_quanlykho_nguyenlieu->saveBangBaoGia($data);
			
			//Luu chi tiet bang bao gia
			$arrid = $data['chitiet'];
			$arrmanguyenlieu = $data['itemid'];
			$arrdongia = $data['dongia'];
			foreach($arrmanguyenlieu as $key => $item)
			{
				$datagia['id'] = $arrid[$key] ;
				$datagia['mabangbaogia'] = $mabangbaogia;
				$datagia['manguyenlieu'] = $arrmanguyenlieu[$key];
				$datagia['manhacungung'] = $data['manhacungung'];
				$datagia['gia'] = $arrdongia[$key];
				$datagia['ngay'] = $data['ngay'];
				$this->model_quanlykho_nguyenlieu->saveCapNhatGia($datagia);
			}
			
			$list = trim( $data['delchitiet'],",");
			$arrdel = split(",", $list);
			
			if(count($arrdel))
			{
				foreach($arrdel as $val)
				{
					$this->model_quanlykho_nguyenlieu->deletedCapNhatGia($val)	;
				}
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
		
		
    	if($data['manguyenlieu'] == "")
		{
      		$this->error['manguyenlieu'] = "Mã nguyên liệu không được rỗng";
    	}
		else
		{
			if($data['id'] == "")
			{
				
				$where = " AND manguyenlieu ='".$data['manguyenlieu']."'" ;
				$item = $this->model_quanlykho_nguyenlieu->getList($where);
				if(count($item)>0)
					$this->error['manguyenlieu'] = "Mã nguyên liệu đã được sử dụng";
			}
		}
		if(strlen($data['manguyenlieu']) > 50)
		{
      		$this->error['manguyenlieu'] = "Mã nguyên liệu không được vượt quá 50 ký tự";
    	}
		
		if ($data['tennguyenlieu'] == "") 
		{
      		$this->error['tennguyenlieu'] = "Bạn chưa nhập tên nguyên liệu";
    	}
		
		
		
		if ($data['loai'] == "") 
		{
      		$this->error['loai'] = "Bạn chưa chọn loại";
    	}
		
		if ($data['makho'] == "") 
		{
      		$this->error['makho'] = "Bạn chưa chọn kho";
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
	
	private function validateDinhLuong($data)
	{
		if ($data['loai'] == "") 
		{
      		$this->error['loai'] = "Bạn chưa chọn nhóm";
    	}
		
		if ($data['nguyenlieugoc'] == "") 
		{
      		$this->error['nguyenlieugoc'] = "Bạn chưa chọn nguyên liệu gốc";
    	}
		
		if ($data['nguyenlieugoc'] == $data['manguyenlieu']) 
		{
      		$this->error['nguyenlieugoc'] = "Bạn chọn nguyên liệu gốc phải khác với nguyên liêu hiện hành";
    	}
		
		
		

		if (count($this->error)==0) {
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
	
	private function validateBangBaoGia($data)
	{
		if ($data['ngay'] == "") 
		{
      		$this->error['ngay'] = "Bạn chưa chọn ngày";
    	}
		
		if ($data['manhacungung'] == "") 
		{
      		$this->error['manhacungung'] = "Bạn chưa chọn nhà cung cấp";
    	}
		
		if (count($this->error)==0) {
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
	
	public function viewTonKho()
	{
		$id = $this->request->get['id'];
		
		
		$this->load->model("quanlykho/phieunhapvattuhanghoa");
		$this->data['item'] = $this->model_quanlykho_nguyenlieu->getItem($id);
		$this->data['item']['soluongton'] = $this->model_quanlykho_nguyenlieu->getTonKho($id);
		$where = " AND 	nguyenlieuid = '".$id."'";
		$this->data['datact'] = $this->model_quanlykho_phieunhapvattuhanghoa->getPhieuNhanVatTuHangHoaChiTietList($where);
		
		$this->id='content';
		$this->template="quanlykho/tieuchikiemtra_tonkho.tpl";
		//$this->layout="layout/dialog";
		$this->data['dialog'] = true;
		$this->render();
	}
	
	//Cac ham xu ly tren form
	public function getNguyenLieu()
	{
		$col = $this->request->get['col'];
		$val = $this->request->get['val'];
		$operator = $this->request->get['operator'];
		if($operator == "")
			$operator = "equal";
		
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
			
			
		$datas = $this->model_quanlykho_nguyenlieu->getList($where);
		foreach($datas as $key => $item)
		{
			$datas[$key]['tendonvitinh'] = $this->document->getDonViTinh($item['madonvi']);
		}
		
		$this->data['output'] = json_encode(array('nguyenlieus' => $datas));
		$this->id="nguyenlieu";
		$this->template="common/output.tpl";
		$this->render();
	}
	
}
?>