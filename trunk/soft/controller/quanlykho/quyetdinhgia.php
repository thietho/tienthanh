<?php
class ControllerQuanlykhoQuyetdinhgia extends Controller
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
		
		$this->load->model("quanlykho/quyetdinhgia");
		$this->load->model("quanlykho/linhkien");
		$this->load->helper('image');
		
		$this->load->model("quanlykho/donvitinh");
		
		$this->load->model("quanlykho/nhom");
		$this->load->model("quanlykho/kho");
		$this->load->model("quanlykho/donvitinh");
		$this->load->model("quanlykho/sanpham");
		$this->data['nhomquyetdinhgia'] = $this->model_quanlykho_nhom->getChild("nhomsanpham");
		$this->data['loaiquyetdinhgia'] = $this->model_quanlykho_nhom->getChild("loaiquyetdinhgia");
		$this->data['kho'] = $this->model_quanlykho_kho->getKhos();
		$this->data['donvitinh'] = $this->model_quanlykho_donvitinh->getList();
		$this->data['donvitinh'] = $this->model_quanlykho_donvitinh->getList();
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
		$this->load->model("quanlykho/quyetdinhgia");
		$this->data['haspass'] = false;
		$this->data['readonly'] = 'readonly="readonly"';
		
	
		$this->getForm();
		
		
  	}
	
	public function delete() 
	{
		$listid=$this->request->post['delete'];
		//$listmadonvi=$_POST['delete'];
		$this->load->model("quanlykho/quyetdinhgia");
		if(count($listid))
		{
			$this->model_quanlykho_quyetdinhgia->deletedatas($listid);
			$this->data['output'] = "Xóa thành công";
		}
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
  	}
	
	private function getList() 
	{
		
		
		$this->data['insert'] = $this->url->http('quanlykho/quyetdinhgia/insert');
		$this->data['delete'] = $this->url->http('quanlykho/quyetdinhgia/delete');		
		
		
		
		
		$this->data['datas'] = array();
		$where = "";
		
		$datasearchlike['maquyetdinhgia'] = $this->request->get['maquyetdinhgia'];
		$datasearchlike['tenquyetdinhgia'] = $this->request->get['tenquyetdinhgia'];
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
		
		$where = implode("",$arr);
		
		$rows = $this->model_quanlykho_quyetdinhgia->getList($where);
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
			$this->data['datas'][$i]['link_edit'] = $this->url->http('quanlykho/quyetdinhgia/update&id='.$this->data['datas'][$i]['id']);
			$this->data['datas'][$i]['text_edit'] = "Sửa";
			
		}
		$this->data['refres']=$_SERVER['QUERY_STRING'];
		$this->id='content';
		$this->template="quanlykho/quyetdinhgia_list.tpl";
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
		$this->data['DIR_UPLOADPHOTO'] = HTTP_SERVER."index.php?route=common/uploadpreview";
		
		
		if ((isset($this->request->get['id'])) ) 
		{
      		$this->data['item'] = $this->model_quanlykho_quyetdinhgia->getItem($this->request->get['id']);
			$this->data['item']['arrmanhom'] = $this->string->referSiteMapToArray($this->data['item']['manhom']);
			
			$this->data['dinhluong'] = $this->model_quanlykho_sanpham->getDinhLuongLinhKien($this->request->get['id']);
			$this->data['item']['imagethumbnail'] = HelperImage::resizePNG($this->data['item']['imagepath'], 200, 200);
    	}
		
		$this->id='content';
		$this->template='quanlykho/quyetdinhgia_form.tpl';
		$this->layout="layout/center";
		
		$this->render();
	}
	
	public function save()
	{
		$data = $this->request->post;
		if($this->validateForm($data))
		{
			$this->load->model("quanlykho/quyetdinhgia");
			
			$item = $this->model_quanlykho_quyetdinhgia->getItem($data['id']);
			if(count($item)==0)
			{
				$this->model_quanlykho_quyetdinhgia->insert($data);
			}
			else
			{
				$this->model_quanlykho_quyetdinhgia->update($data);
			}
			$this->savedinhluongsanpham($data);
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
	
	public function savedinhluongsanpham($data)
	{
		$where = "AND maquyetdinhgia = '".$data['maquyetdinhgia']."'";
		$item = $this->model_quanlykho_quyetdinhgia->getList($where);
		
		$maquyetdinhgia = $item[0]['id'];
		
		$arrsoluong = $data['soluong'];
		$arrdinhluong = $data['dinhluong'];
		$masanpham = $data['masanpham'];
		
		$this->load->model("quanlykho/sanpham");
		$list = trim( $data['deldinhluong'],",");
		$arrdel = split(",", $list);
		
		foreach($arrdel as $val)
		{
			$this->model_quanlykho_sanpham->deletedSanPhamDinhLuong($val)	;
		}
		$logdinhluong = array();
		if(count($arrsoluong)>0)
		{
			foreach($arrsoluong as $key => $val)
			{
				$datadinhluong['maquyetdinhgia'] = $maquyetdinhgia;
				
				$datadinhluong['id'] = $arrdinhluong[$key];
				$datadinhluong['masanpham'] = $masanpham[$key];
				$datadinhluong['soluong'] = $val;
				
				$this->model_quanlykho_sanpham->saveSanPhamDinhLuong($datadinhluong);
				$logdinhluong[] = $datadinhluong;
			}
		}
		$log['tablename'] = "qlksanpham_dinhluong";
		$log['data'] = $logdinhluong;
		$this->user->writeLog(json_encode($log));
		
		$this->data['output'] = "true";
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	
	public function savedinhluong()
	{
		$data = $this->request->post;
		$maquyetdinhgia = $data['maquyetdinhgia'];
		
		$arrsoluong = $data['soluong'];
		$arrdinhluong = $data['dinhluong'];
		$arrquyetdinhgiathanhphan = $data['quyetdinhgiathanhphan'];
		
		$this->load->model("quanlykho/quyetdinhgia");
		$list = trim( $data['deldinhluong'],",");
		$arrdel = split(",", $list);
		
		foreach($arrdel as $val)
		{
			$this->model_quanlykho_quyetdinhgia->deletedLinhKienTrungGian($val)	;
		}
		
		if(count($arrsoluong)>0)
		{
			foreach($arrsoluong as $key => $val)
			{
				$datadinhluong['id'] = $arrdinhluong[$key];
				$datadinhluong['maquyetdinhgia'] = $maquyetdinhgia;
				$datadinhluong['quyetdinhgiathanhphan'] = $arrquyetdinhgiathanhphan[$key];
				$datadinhluong['soluong'] = $val;
				$this->model_quanlykho_quyetdinhgia->saveLinhKienTrungGian($datadinhluong);
			}
		}
		
		
		$this->data['output'] = "true";
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	
	private function validateForm($data)
	{
		
		
    	if($data['maquyetdinhgia'] == "")
		{
      		$this->error['maquyetdinhgia'] = "Mã linh kiện không được rỗng";
    	}
		else
		{
			if($data['id'] == "")
			{
				$this->load->model("quanlykho/quyetdinhgia");
				$where = " AND maquyetdinhgia ='".$data['maquyetdinhgia']."'" ;
				$item = $this->model_quanlykho_quyetdinhgia->getList($where);
				if(count($item)>0)
					$this->error['maquyetdinhgia'] = "Mã linh kiện đã được sử dụng";
			}
		}
		if(strlen($data['maquyetdinhgia']) > 50)
		{
      		$this->error['maquyetdinhgia'] = "Mã linh kiện không được vượt quá 50 ký tự";
    	}
		
		if ($data['tenquyetdinhgia'] == "") 
		{
      		$this->error['tenquyetdinhgia'] = "Bạn chưa nhập tên linh kiện";
    	}

		if ($data['makho'] == "") 
		{
      		$this->error['makho'] = "Bạn chưa chọn kho";
    	}
		
		if ($data['madonvi'] == "") 
		{
      		$this->error['madonvi'] = "Bạn chưa nhập đơn vị tính";
    	}
		
		if ($data['nguyenlieusudung'] == "") 
		{
      		$this->error['nguyenlieusudung'] = "Bạn chọn nguyên liệu sử dụng";
    	}
		
		if ($data['soluongnguyenlieu'] == "") 
		{
      		$this->error['soluongnguyenlieu'] = "Bạn nhập số lượng nguyên liệu cần cho linh kiện";
    	}
		
		if ($data['madonvinguyenlieu'] == "") 
		{
      		$this->error['madonvinguyenlieu'] = "Bạn chưa chọn đơn vị tính cho nguyên liệu";
    	}

		if (count($this->error)==0) {
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
	
	//Cac ham xu ly tren form
	public function getQuyetDinhGia()
	{
		$col = $this->request->get['col'];
		$val = $this->request->get['val'];
		$operator = $this->request->get['operator'];
		if($operator == "")
			$operator = "equal";
		$this->load->model("quanlykho/quyetdinhgia");
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
			
			
		$datas = $this->model_quanlykho_quyetdinhgia->getList($where);
		$this->data['output'] = json_encode(array('quyetdinhgias' => $datas));
		$this->id="quyetdinhgia";
		$this->template="common/output.tpl";
		$this->render();
	}
}
?>