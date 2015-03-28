<?php
class ControllerQuanlykhoSanpham extends Controller
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
		
		$this->load->model("quanlykho/sanpham");
		$this->load->model("quanlykho/kho");
		$this->load->model("quanlykho/donvitinh");
		$this->load->model("quanlykho/nhom");
		
		$this->data['nhomsanpham'] = array();
		$this->model_quanlykho_nhom->getTree("nhomsanpham",$this->data['nhomsanpham']);
		unset($this->data['nhomsanpham'][0]);
		
		$this->data['loaisanpham'] = array();
		$this->model_quanlykho_nhom->getTree("loaisanpham",$this->data['loaisanpham']);
		unset($this->data['loaisanpham'][0]);
		$this->data['kho'] = $this->model_quanlykho_kho->getKhosByModuel($this->getRoute());
		$this->data['donvitinh'] = $this->model_quanlykho_donvitinh->getList();
		$this->load->helper('image');
   	}
	public function index()
	{
		$this->data['insertlist'] = $this->url->http('quanlykho/sanpham/insertlist');
		$this->data['insert'] = $this->url->http('quanlykho/sanpham/insert');
		$this->data['delete'] = $this->url->http('quanlykho/sanpham/delete');	
		
		$this->id='content';
		$this->template="quanlykho/sanpham_list.tpl";
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
		$this->template='quanlykho/sanpham_form_list.tpl';
		$this->layout="layout/center";
		$this->render();
	}
	public function update()
	{			
		$this->load->model("quanlykho/sanpham");
		$this->data['haspass'] = false;
		$this->data['readonly'] = 'readonly="readonly"';
		$this->getForm();
  	}
	
	public function delete() 
	{
		$listid=$this->request->post['delete'];
		//$listmadonvi=$_POST['delete'];
		$this->load->model("quanlykho/sanpham");
		if(count($listid))
		{
			$this->model_quanlykho_sanpham->deletedatas($listid);
			$this->data['output'] = "Xóa thành công";
		}
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
  	}
	
	public function getList() 
	{
		
		$this->data['datas'] = array();
		$where = "";
		
		$datasearchlike['masanpham'] = urldecode($this->request->get['masanpham']);
		$datasearchlike['tensanpham'] = urldecode($this->request->get['tensanpham']);
		$datasearch['manhom'] = urldecode($this->request->get['manhom']);
		$datasearch['loai'] = urldecode($this->request->get['loai']);
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
		
		$rows = $this->model_quanlykho_sanpham->getList($where);
		//Page
		$page = $this->request->get['page'];		
		$x=$page;		
		$limit = 20;
		$total = count($rows); 
		// work out the pager values 
		$this->data['pager']  = $this->pager->pageLayoutAjax($total, $limit, $page,"#listsanpham"); 
		
		$pager  = $this->pager->getPagerData($total, $limit, $page); 
		$offset = $pager->offset; 
		$limit  = $pager->limit; 
		$page   = $pager->page;
		for($i=$offset;$i < $offset + $limit && count($rows[$i])>0;$i++)
		//for($i=0; $i <= count($this->data['datas'])-1 ; $i++)
		{
			$this->data['datas'][$i] = $rows[$i];
			$this->data['datas'][$i]['link_edit'] = $this->url->http('quanlykho/sanpham/update&id='.$this->data['datas'][$i]['id']);
			$this->data['datas'][$i]['text_edit'] = "Sửa";
			$this->data['datas'][$i]['link_dinhluong'] = $this->url->http('quanlykho/sanpham/dinhluong&id='.$this->data['datas'][$i]['id']);
			$this->data['datas'][$i]['text_dinhluong'] = "Định lượng";
			$this->data['datas'][$i]['link_congdoan'] = $this->url->http('quanlykho/sanpham/congdoan&id='.$this->data['datas'][$i]['id']);
			$this->data['datas'][$i]['text_congdoan'] = "Công đoạn";
			$this->data['datas'][$i]['link_lichsu'] = $this->url->http('quanlykho/sanpham/lichsu&masanpham='.$this->data['datas'][$i]['masanpham']);
			$this->data['datas'][$i]['text_lichsu'] = "Lịch sử";
			$this->data['datas'][$i]['link_caidatchiphi'] = $this->url->http('quanlykho/sanpham/catdatchiphi&id='.$this->data['datas'][$i]['id']);
			$this->data['datas'][$i]['text_caidatchiphi'] = "Cài đặt chi phí";
			$this->data['datas'][$i]['link_tinhtiencongtonghop'] = $this->url->http('quanlykho/sanpham/tinhtiencongtonghop&id='.$this->data['datas'][$i]['id']);
			$this->data['datas'][$i]['text_tinhtiencongtonghop'] = "Tính tiền công tổng hợp";
			//
			$nhom = $this->model_quanlykho_nhom->getItem($rows[$i]['manhom']);
			$this->data['datas'][$i]['tennhom'] = $nhom['tennhom'];
			$loai = $this->model_quanlykho_nhom->getItem($rows[$i]['loai']);
			$this->data['datas'][$i]['tenloai'] = $loai['tennhom'];
			$kho = $this->model_quanlykho_kho->getKho($rows[$i]['makho']);
			$this->data['datas'][$i]['tenkho'] = $kho['tenkho'];
			$this->data['datas'][$i]['imagethumbnail'] = HelperImage::resizePNG($this->data['datas'][$i]['imagepath'], 100, 0);
		}
		$this->data['refres']=$_SERVER['QUERY_STRING'];
		$this->id='content';
		$this->template="quanlykho/sanpham_table.tpl";
		if($this->request->get['opendialog']=='true')
		{
			$this->data['dialog'] = true;
			
		}
		$this->render();
	}
	
	
	private function getForm()
	{
		$this->data['DIR_UPLOADPHOTO'] = HTTP_SERVER."index.php?route=common/uploadpreview";
		$this->load->model("quanlykho/nhom");
		$this->load->model("quanlykho/kho");
		$this->load->model("quanlykho/donvitinh");
		
		
		
		$this->data['kho'] = $this->model_quanlykho_kho->getKhos();
		$this->data['donvitinh'] = $this->model_quanlykho_donvitinh->getList();
		
		if ((isset($this->request->get['id'])) ) 
		{
      		$this->data['item'] = $this->model_quanlykho_sanpham->getItem($this->request->get['id']);
			$this->data['item']['imagethumbnail'] = HelperImage::resizePNG($this->data['item']['imagepath'], 200, 200);
    	}
		
		$this->id='content';
		$this->template='quanlykho/sanpham_form.tpl';
		
		
		$this->render();
	}
	
	public function save()
	{
		$data = $this->request->post;
		if($this->validateForm($data))
		{
			$this->load->model("quanlykho/sanpham");
			$data['imagepath'] = str_replace(DIR_FILE,"",$data['imagepath']);
			$item = $this->model_quanlykho_sanpham->getItem($data['id']);
			if(count($item)==0)
			{
				$this->model_quanlykho_sanpham->insert($data);
			}
			else
			{
				$this->model_quanlykho_sanpham->update($data);
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
		
		
    	if($data['masanpham'] == "")
		{
      		$this->error['masanpham'] = "Mã sản phẩm không được rỗng";
    	}
		else
		{
			if($data['id'] == "")
			{
				$this->load->model("quanlykho/sanpham");
				$where = " AND masanpham ='".$data['masanpham']."'" ;
				$item = $this->model_quanlykho_sanpham->getList($where);
				if(count($item)>0)
					$this->error['masanpham'] = "Mã sản phẩm đã được sử dụng";
			}
		}
		if(strlen($data['masanpham']) > 50)
		{
      		$this->error['masanpham'] = "Mã sản phẩm không được vượt quá 50 ký tự";
    	}
		
		if ($data['tensanpham'] == "") 
		{
      		$this->error['tensanpham'] = "Bạn chưa nhập tên sản phẩm";
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
		
		/*if ($this->string->toNumber($data['sosanphamtrenlot']) <= 0) 
		{
      		$this->error['sosanphamtrenlot'] = "Số sản phẩm/Lot phải > 0";
    	}
		
		if ($this->string->toNumber($data['dongiabancai']) <= 0) 
		{
      		$this->error['dongiabancai'] = "Đơn giá bán theo cái phải > 0";
    	}
		
		if ($this->string->toNumber($data['dongiabanhop']) <= 0) 
		{
      		$this->error['dongiabanhop'] = "Đơn giá bán theo hộp phải > 0";
    	}
		
		if ($this->string->toNumber($data['dongiabanthung']) <= 0) 
		{
      		$this->error['dongiabanthung'] = "Đơn giá bán theo thùng phải > 0";
    	}
		
		if ($this->string->toNumber($data['dongiabanlot']) <= 0) 
		{
      		$this->error['dongiabanlot'] = "Đơn giá bán theo lot phải > 0";
    	}*/
		

		if (count($this->error)==0) {
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
	//Dinh luong
	public function dinhluong()
	{
		if(!$this->user->hasPermission($this->getRoute(), "edit"))
		{
			$this->response->redirect("?route=common/permission");
		}
		else
		{
			//$this->load->language('quanlykho/sanpham');
			//$this->data = array_merge($this->data, $this->language->getData());
			$this->load->model("quanlykho/nhom");
			
			$this->load->model("quanlykho/donvitinh");
			$this->data['nhomsanpham'] = $this->model_quanlykho_nhom->getChild("nhomsanpham");
			$this->data['donvitinh'] = $this->model_quanlykho_donvitinh->getList();
			$this->load->model("quanlykho/sanpham");
			$this->data['haspass'] = false;
			$this->data['readonly'] = 'readonly="readonly"';
			$this->data['item'] = $this->model_quanlykho_sanpham->getItem($this->request->get['id']);
			$this->data['dinhluong'] = $this->model_quanlykho_sanpham->getDinhLuong($this->request->get['id']);
			
			$this->id='content';
			$this->template='quanlykho/sanpham_dinhluong.tpl';
			$this->layout="layout/center";
			$this->render();
		}
		
  	}
	
	public function savedinhluong()
	{
		$data = $this->request->post;
		
		$masanpham = $data['masanpham'];
		
		$arrsoluong = $data['soluong'];
		$arrdinhluong = $data['dinhluong'];
		$malinhkien = $data['malinhkien'];
		
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
				$datadinhluong['masanpham'] = $masanpham;
				
				$datadinhluong['id'] = $arrdinhluong[$key];
				$datadinhluong['malinhkien'] = $malinhkien[$key];
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
	//Cong doan
	public function congdoan()
	{
		$this->load->model("quanlykho/sanpham");
		$this->load->model("quanlykho/linhkien");
		$this->data['item'] = $this->model_quanlykho_sanpham->getItem($this->request->get['id']);
		$this->data['dinhluong'] = $this->model_quanlykho_sanpham->getDinhLuong($this->request->get['id']);
		
		foreach($this->data['dinhluong'] as $key =>$item)
		{
			$linhkien = $this->model_quanlykho_linhkien->getItem($item['malinhkien']);
			$this->data['dinhluong'][$key]['tenlinhkien'] = $linhkien['tenlinhkien'];
		}
		
		$this->id='content';
		$this->template='quanlykho/sanpham_congdoan.tpl';
		$this->layout="layout/center";
		$this->render();
	}
	
	
	private function validateDinhLuong($data)
	{
		if ($data['manhom'] == "") 
		{
      		$this->error['manhom'] = "Bạn chưa chọn nhóm";
    	}
		
		if ($data['sanphamthanhphan'] == "") 
		{
      		$this->error['sanphamthanhphan'] = "Bạn chưa chọn sản phẩm thành phần";
    	}
		
		if ($data['sanphamthanhphan'] == $data['masanpham']) 
		{
      		$this->error['sanphamthanhphan'] = "Bạn chọn sản phẩm thành phần phải khác với sản phẩm gốc";
    	}
		
		
		

		if (count($this->error)==0) {
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
	//Lich su
	public function lichsu()
	{
		$masanpham = $this->request->get['masanpham'];
		$this->load->model("quanlykho/sanpham");
		
		$where = " AND detail like '%qlksanpham%' AND detail like '%\"masanpham\":\"".$masanpham."\"%' ";
		$data = $this->user->getLogs($where);
		
		$log = array();
		foreach($data as $key => $item)
		{
			$log[$key] = $this->json->decode($item['detail']);	
			$log[$key]->logdate = $item['logdate'];
		}
		
		foreach($log as $key => $item)
		{
			
			$this->data['logsanpham'][$key] = $item->data;
			$this->data['logsanpham'][$key]->logdate = $item->logdate;
		}
		//Lay lich su cua dinh luong
		$sanpham = $this->model_quanlykho_sanpham->getSanPham($masanpham);
		
		$where = " AND detail like '%qlksanpham_dinhluong%' AND detail like '%\"masanpham\":\"".$sanpham['id']."\"%' ";
		$data = $this->user->getLogs($where);
		
		$log = array();
		foreach($data as $key => $item)
		{
			$log[$key] = $this->json->decode($item['detail']);	
			$log[$key]->logdate = $item['logdate'];
		}
		
		foreach($log as $key => $item)
		{
			
			$this->data['logdinhluong'][$key] = $item->data;
			$this->data['logdinhluong'][$key]['logdate'] = $item->logdate;
		}
		
		$this->id="content";
		$this->template="quanlykho/sanpham_lichsu.tpl";
		$this->layout="layout/dialog";
		$this->render();
	}
	//Cai dat chi phi
	public function catdatchiphi()
	{
		$this->load->model("quanlykho/sanpham");
		
		$this->data['item'] = $this->model_quanlykho_sanpham->getItem($this->request->get['id']);
		$this->data['chiphis'] = $this->model_quanlykho_sanpham->getChiPhi($this->request->get['id']);
		
		$this->id='content';
		$this->template='quanlykho/sanpham_caidatchiphi.tpl';
		$this->layout="layout/center";
		$this->render();
	}
	
	public function savecaidatchiphi()
	{
		$data = $this->request->post;
		$arrid = $data['id'];
		$masanpham = $data['masanpham'];
		
		$arrmachiphi = $data['machiphi'];
		$arrchiphi = $data['chiphi'];
		
		
		$this->load->model("quanlykho/sanpham");
		$list = trim( $data['delchiphi'],",");
		$arrdel = split(",", $list);
		
		foreach($arrdel as $val)
		{
			$this->model_quanlykho_sanpham->deletedSanPhamChiPhi($val)	;
		}
		$logchiphi = array();
		if(count($arrchiphi)>0)
		{
			foreach($arrchiphi as $key => $val)
			{
				$datachiphi['masanpham'] = $masanpham;
				
				$datachiphi['id'] = $arrid[$key];
				$datachiphi['machiphi'] = $arrmachiphi[$key];
				$datachiphi['chiphi'] = $val;
				
				$this->model_quanlykho_sanpham->saveSanPhamChiPhi($datachiphi);
				$logchiphi[] = $datachiphi;
			}
		}
		$log['tablename'] = "qlksanpham_chiphi";
		$log['data'] = $logchiphi;
		$this->user->writeLog(json_encode($log));
		
		$this->data['output'] = "true";
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	//Tinh tien cong tong hop
	public function tinhtiencongtonghop()
	{
		$this->load->model("quanlykho/sanpham");
		$this->load->model("quanlykho/linhkien");
		$this->data['item'] = $this->model_quanlykho_sanpham->getItem($this->request->get['id']);
		$this->data['dinhluong'] = $this->model_quanlykho_sanpham->getDinhLuong($this->request->get['id']);
		//Chi phi tong hop tu san xuat linh kien
		foreach($this->data['dinhluong'] as $key =>$item)
		{
			$linhkien = $this->model_quanlykho_linhkien->getItem($item['malinhkien']);
			$arr = array($item['malinhkien']);
			$tiencong = $this->loadModule("quanlykho/linhkien","tinhTienCong", $arr);
			$this->data['dinhluong'][$key]['tiencong'] = $tiencong;
		}
		//Chi phi san xuat san pham
		$this->data['chiphis'] = $this->model_quanlykho_sanpham->getChiPhi($this->request->get['id']);
		$this->id='content';
		$this->template='quanlykho/sanpham_tinhtiencongtonghop.tpl';
		$this->layout="layout/center";
		$this->render();
	}
	//Cac ham xu ly tren form
	public function getSanPham()
	{
		$col = $this->request->get['col'];
		$val = $this->request->get['val'];
		$operator = $this->request->get['operator'];
		if($operator == "")
			$operator = "equal";
		$this->load->model("quanlykho/sanpham");
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
		
			
		$datas = $this->model_quanlykho_sanpham->getList($where);
		$this->data['output'] = json_encode(array('sanphams' => $datas));
		$this->id="sanpham";
		$this->template="common/output.tpl";
		$this->render();
	}
	public function getSanPham1()
	{
		$col = $this->request->get['col'];
		$val = $this->request->get['val'];
		$operator = $this->request->get['operator'];
		$maxrows = $this->request->get['maxrows'];
		if($operator == "")
			$operator = "equal";
		$this->load->model("quanlykho/sanpham");
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
		
		if($maxrows)
		{
			$datas = $this->model_quanlykho_sanpham->getList($where,0,$maxrows);
		}
		else
		{
			$datas = $this->model_quanlykho_sanpham->getList($where);
		}
		
		$this->data['output'] = json_encode(array('totalResultsCount'=>count($datas),'sanphams' => $datas));
		$this->id="sanpham";
		$this->template="common/output.tpl";
		$this->render();
	}
}
?>