<?php
class ControllerQuanlykhoLinhkien extends Controller
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
		
		$this->load->model("quanlykho/nguyenlieu");
		$this->load->model("quanlykho/linhkien");
		$this->load->model("quanlykho/phongban");
		$this->load->model("common/control");
		$this->load->model("quanlykho/kho");
		$this->load->model("quanlykho/donvitinh");
		$this->load->model("quanlykho/item");
		$data_phongban = $this->model_quanlykho_phongban->getPhongBans();
		
		$this->data['data_nguyenlieu'] = $this->model_quanlykho_nguyenlieu->getList();
		$this->data['cbphongban'] = $this->model_common_control->getDataCombobox($data_phongban, 'tenphongban', 'maphongban');
		$this->data['kho'] = $this->model_quanlykho_kho->getKhosByModuel($this->getRoute());
		$this->data['donvitinh'] = $this->model_quanlykho_donvitinh->getList();
		$this->load->helper('image');
		
		$this->load->model("quanlykho/nhom");
		$this->load->model("quanlykho/kho");
		$this->load->model("quanlykho/donvitinh");
		$this->load->model("quanlykho/sanpham");
		$this->data['nhomlinhkien'] = $this->model_quanlykho_nhom->getChild("nhomsanpham");
		$this->data['loailinhkien'] = $this->model_quanlykho_nhom->getChild("loailinhkien");
		
	}
	
	public function index()
	{
		$this->data['insertlist'] = $this->url->http('quanlykho/linhkien/insertlist');
		$this->data['insert'] = $this->url->http('quanlykho/linhkien/insert');
		$this->data['delete'] = $this->url->http('quanlykho/linhkien/delete');
		
		$this->id='content';
		$this->template="quanlykho/linhkien_list.tpl";
		$this->layout="layout/center";
		if($this->request->get['opendialog']=='true')
		{
			//$this->layout="layout/dialog";
			$this->layout = "";
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
		$this->template='quanlykho/linhkien_form_list.tpl';
		$this->layout="layout/center";
		$this->render();
	}
	public function update()
	{		
		$this->load->model("quanlykho/linhkien");
		$this->data['haspass'] = false;
		$this->data['readonly'] = 'readonly="readonly"';
		$this->getForm();
  	}
	
	public function dinhluong()
	{			
		$this->load->model("quanlykho/nhom");	
		$this->load->model("quanlykho/donvitinh");
		$this->data['nhomlinhkien'] = $this->model_quanlykho_nhom->getChild("nhomsanpham");
		$this->data['donvitinh'] = $this->model_quanlykho_donvitinh->getList();
		$this->load->model("quanlykho/linhkien");
		$this->data['haspass'] = false;
		$this->data['readonly'] = 'readonly="readonly"';
		$this->data['item'] = $this->model_quanlykho_linhkien->getItem($this->request->get['id']);
		$this->data['dinhluong'] = $this->model_quanlykho_linhkien->getDinhLuong($this->request->get['id']);
		$this->id='content';
		$this->template='quanlykho/linhkien_dinhluong.tpl';
		$this->layout="layout/center";
		$this->render();
  	}
	
	
	
	public function delete() 
	{
		$listid=$this->request->post['delete'];
		//$listmadonvi=$_POST['delete'];
		$this->load->model("quanlykho/linhkien");
		if(count($listid))
		{
			$this->model_quanlykho_linhkien->deletedatas($listid);
			$this->data['output'] = "Xóa thành công";
		}
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
  	}
	
	public function getList() 
	{
		
		
		
		$this->load->model("quanlykho/nhom");
		$this->load->model("quanlykho/kho");
		$this->load->model("quanlykho/donvitinh");
		
		$this->data['kho'] = $this->model_quanlykho_kho->getKhos();
		$this->data['donvitinh'] = $this->model_quanlykho_donvitinh->getList();
		
		$this->data['datas'] = array();
		$where = "";
		
		$datasearchlike['malinhkien'] = urldecode($this->request->get['malinhkien']);
		$datasearchlike['tenlinhkien'] = urldecode($this->request->get['tenlinhkien']);
		$datasearch['manhom'] = urldecode($this->request->get['manhom']);
		$datasearch['loai'] = urldecode($this->request->get['loai']);
		$datasearch['makho'] = urldecode($this->request->get['makho']);
		
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
		
		$rows = $this->model_quanlykho_linhkien->getList($where);
		//Page
		$page = $this->request->get['page'];		
		$x=$page;		
		$limit = 20;
		$total = count($rows); 
		// work out the pager values 
		$this->data['pager']  = $this->pager->pageLayoutAjax($total, $limit, $page,"#listlinhkien"); 
		
		$pager  = $this->pager->getPagerData($total, $limit, $page); 
		$offset = $pager->offset; 
		$limit  = $pager->limit; 
		$page   = $pager->page;
		for($i=$offset;$i < $offset + $limit && count($rows[$i])>0;$i++)
		//for($i=0; $i <= count($this->data['datas'])-1 ; $i++)
		{
			$this->data['datas'][$i] = $rows[$i];
			$this->data['datas'][$i]['link_edit'] = $this->url->http('quanlykho/linhkien/update&id='.$this->data['datas'][$i]['id']);
			$this->data['datas'][$i]['text_edit'] = "Sửa";
			$this->data['datas'][$i]['link_dinhluong'] = $this->url->http('quanlykho/linhkien/dinhluong&id='.$this->data['datas'][$i]['id']);
			$this->data['datas'][$i]['text_dinhluong'] = "Định lượng";
			$this->data['datas'][$i]['link_caidatcongdoan'] = $this->url->http('quanlykho/linhkien/caidatcongdoan&id='.$this->data['datas'][$i]['id']);
			$this->data['datas'][$i]['text_caidatcongdoan'] = "Cài đặt công đoạn";
			//
			$nhom = $this->model_quanlykho_nhom->getItem($rows[$i]['manhom']);
			$this->data['datas'][$i]['tennhom'] = $nhom['tennhom'];
			$loai = $this->model_quanlykho_nhom->getItem($rows[$i]['loai']);
			$this->data['datas'][$i]['tenloai'] = $loai['tennhom'];
			$kho = $this->model_quanlykho_kho->getKho($rows[$i]['makho']);
			$this->data['datas'][$i]['tenkho'] = $kho['tenkho'];
			$this->data['datas'][$i]['imagethumbnail'] = HelperImage::resizePNG($this->data['datas'][$i]['imagepath'], 100, 0);
			$data_nhapdv = $this->model_quanlykho_item->getTonKho($this->data['datas'][$i]['id'],'linhkien',$this->data['datas'][$i]['madonvi']);
			
			$this->data['datas'][$i]['soluongton'] = $this->model_quanlykho_donvitinh->toText($data_nhapdv);
		}
		$this->data['refres']=$_SERVER['QUERY_STRING'];
		if($this->request->get['opendialog']=='true')
		{
			$this->data['dialog'] = true;
			
		}
		$this->id='content';
		$this->template="quanlykho/linhkien_table.tpl";
		$this->render();
	}
	
	
	private function getForm()
	{
		$this->data['DIR_UPLOADPHOTO'] = HTTP_SERVER."index.php?route=common/uploadpreview";
		
		
		if ((isset($this->request->get['id'])) ) 
		{
      		$this->data['item'] = $this->model_quanlykho_linhkien->getItem($this->request->get['id']);
			$this->data['item']['arrmanhom'] = $this->string->referSiteMapToArray($this->data['item']['manhom']);
			
			$this->data['dinhluong'] = $this->model_quanlykho_sanpham->getDinhLuongLinhKien($this->request->get['id']);
			$this->data['item']['imagethumbnail'] = HelperImage::resizePNG($this->data['item']['imagepath'], 200, 200);
			
    	}
		
		$this->id='content';
		$this->template='quanlykho/linhkien_form.tpl';
		$this->layout="layout/center";
		
		$this->render();
	}
	
	public function save()
	{
		$data = $this->request->post;
		
		if($this->validateForm($data))
		{
			$this->load->model("quanlykho/linhkien");
			
			$item = $this->model_quanlykho_linhkien->getItem($data['id']);
			if(count($item)==0)
			{
				$this->model_quanlykho_linhkien->insert($data);
			}
			else
			{
				$this->model_quanlykho_linhkien->update($data);
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
		$where = "AND malinhkien = '".$data['malinhkien']."'";
		$item = $this->model_quanlykho_linhkien->getList($where);
		
		$malinhkien = $item[0]['id'];
		
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
				$datadinhluong['malinhkien'] = $malinhkien;
				
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
		$malinhkien = $data['malinhkien'];
		
		$arrsoluong = $data['soluong'];
		$arrdinhluong = $data['dinhluong'];
		$arrlinhkienthanhphan = $data['linhkienthanhphan'];
		
		$this->load->model("quanlykho/linhkien");
		$list = trim( $data['deldinhluong'],",");
		$arrdel = split(",", $list);
		
		foreach($arrdel as $val)
		{
			$this->model_quanlykho_linhkien->deletedLinhKienTrungGian($val)	;
		}
		
		if(count($arrsoluong)>0)
		{
			foreach($arrsoluong as $key => $val)
			{
				$datadinhluong['id'] = $arrdinhluong[$key];
				$datadinhluong['malinhkien'] = $malinhkien;
				$datadinhluong['linhkienthanhphan'] = $arrlinhkienthanhphan[$key];
				$datadinhluong['soluong'] = $val;
				$this->model_quanlykho_linhkien->saveLinhKienTrungGian($datadinhluong);
			}
		}
		
		
		$this->data['output'] = "true";
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	
	private function validateForm($data)
	{
		
		
    	if($data['malinhkien'] == "")
		{
      		$this->error['malinhkien'] = "Mã linh kiện không được rỗng";
    	}
		else
		{
			if($data['id'] == "")
			{
				$this->load->model("quanlykho/linhkien");
				$where = " AND malinhkien ='".$data['malinhkien']."'" ;
				$item = $this->model_quanlykho_linhkien->getList($where);
				if(count($item)>0)
					$this->error['malinhkien'] = "Mã linh kiện đã được sử dụng";
			}
		}
		if(strlen($data['malinhkien']) > 50)
		{
      		$this->error['malinhkien'] = "Mã linh kiện không được vượt quá 50 ký tự";
    	}
		
		if ($data['tenlinhkien'] == "") 
		{
      		$this->error['tenlinhkien'] = "Bạn chưa nhập tên linh kiện";
    	}

		if ($data['makho'] == "") 
		{
      		$this->error['makho'] = "Bạn chưa chọn kho";
    	}
		
		if ($data['madonvi'] == "") 
		{
      		$this->error['madonvi'] = "Bạn chưa nhập đơn vị tính";
    	}
		
		//if ($data['nguyenlieusudung'] == "") 
//		{
//      		$this->error['nguyenlieusudung'] = "Bạn chọn nguyên liệu sử dụng";
//    	}
//		
//		if ($data['soluongnguyenlieu'] == "") 
//		{
//      		$this->error['soluongnguyenlieu'] = "Bạn nhập số lượng nguyên liệu cần cho 1 linh kiện";
//    	}
//		
//		if ($data['madonvinguyenlieu'] == "") 
//		{
//      		$this->error['madonvinguyenlieu'] = "Bạn chưa chọn đơn vị tính cho nguyên liệu";
//    	}

		if (count($this->error)==0) {
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
	//Cong doan
	public function caidatcongdoan()
	{
		
		$this->load->model("quanlykho/linhkien");
		$this->data['haspass'] = false;
		
		$this->data['item'] = $this->model_quanlykho_linhkien->getItem($this->request->get['id']);
		
		$this->id='content';
		$this->template='quanlykho/linhkien_congdoan.tpl';
		$this->layout="layout/center";
		$this->render();
	}
	
	public function savecongdoan()
	{
		$data = $this->request->post;
		//print_r($data);
		$this->load->model("quanlykho/congdoan");
		$listdel = split(',',$data['delcongdoans']);
		if(count($listdel))
			foreach($listdel as $id)
			{
				$this->model_quanlykho_congdoan->delete($id);
			}
		foreach($data['macongdoan'] as $key => $val)
		{
			$congdoan['id'] = (int)$data['id'][$key];
			$congdoan['malinhkien'] = $data['malinhkien'];
			$congdoan['macongdoan'] = $data['macongdoan'][$key];
			$congdoan['tencongdoan'] = $data['tencongdoan'][$key];
			$congdoan['thututhuchien'] = $this->string->toNumber($data['thututhuchien'][$key]);
			$congdoan['nguyenlieusanxuat'] = $data['nguyenlieusanxuat'][$key];
			$congdoan['thietbisanxuatchinh'] = $data['thietbisanxuatchinh'][$key];
			$congdoan['dinhmucchitieu'] = $data['dinhmucchitieu'][$key];
			$congdoan['giagiacong'] = $this->string->toNumber($data['giagiacong'][$key]);
			$congdoan['dinhmucphelieu'] = $this->string->toNumber($data['dinhmucphelieu'][$key]);
			$congdoan['dinhmucphepham'] = $this->string->toNumber($data['dinhmucphepham'][$key]);
			$congdoan['dinhmuchaohut'] = $this->string->toNumber($data['dinhmuchaohut'][$key]);
			$congdoan['dinhmucnangxuat'] = $this->string->toNumber($data['dinhmucnangxuat'][$key]);
			
			$congdoan['dinhmucphulieu'] = $this->string->toNumber($data['dinhmucphulieu'][$key]);
			$congdoan['soluongtrenkg'] = $this->string->toNumber($data['soluongtrenkg'][$key]);
			$congdoan['phongbansanxuat'] = $data['phongbansanxuat'][$key];
			$congdoan['ghichu'] = $data['ghichu'][$key];
			$congdoan['status'] = $data['status'][$key];
			
			//if($congdoan['status']=='update')
			{
				if((int)$congdoan['id'] == 0)
					$this->model_quanlykho_congdoan->insert($congdoan);
				else
					$this->model_quanlykho_congdoan->update($congdoan);
			}
			
		}
		$this->data['output'] = "true";
		/*if($this->validateFormCongDoan($data))
		{
			$this->load->model("quanlykho/congdoan");
			$item = $this->model_quanlykho_congdoan->getItem($data['id']);
			if(count($item)==0)
			{
				$this->model_quanlykho_congdoan->insert($data);
			}
			else
			{
				$this->model_quanlykho_congdoan->update($data);
			}
			$this->data['output'] = "true";
		}
		else
		{
			foreach($this->error as $item)
			{
				$this->data['output'] .= $item."<br>";
			}
		}*/
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	
	private function validateFormCongDoan($data)
	{
		
		
    	if($data['macongdoan'] == "")
		{
      		$this->error['macongdoan'] = "Mã công đoạn không được rỗng";
    	}
		else
		{
			if($data['id'] == "")
			{
				$this->load->model("quanlykho/congdoan");
				$where = " AND macongdoan ='".$data['macongdoan']."'" ;
				$item = $this->model_quanlykho_congdoan->getList($where);
				if(count($item)>0)
					$this->error['malinhkien'] = "Mã công đoạn đã được sử dụng";
			}
		}
		if(strlen($data['macongdoan']) > 50)
		{
      		$this->error['macongdoan'] = "Mã công đoạn không được vượt quá 50 ký tự";
    	}
		
		if ($data['tencongdoan'] == "") 
		{
      		$this->error['tencongdoan'] = "Bạn chưa nhập tên công đoạn";
    	}
		
		if ($data['thututhuchien'] == "") 
		{
      		$this->error['thututhuchien'] = "Bạn nhập thứ tự thực hiện";
    	}
		
		if ($data['dinhmucchitieu'] == "") 
		{
      		$this->error['dinhmucchitieu'] = "Bạn nhập định mức chỉ tiêu";
    	}
		
		if ($data['giagiacong'] == "") 
		{
      		$this->error['giagiacong'] = "Bạn nhập giá gia công";
    	}
		
		if ($data['dinhmucphelieu'] == "") 
		{
      		$this->error['dinhmucphelieu'] = "Bạn nhập định mức phế liệu";
    	}
		
		if ($data['dinhmucphepham'] == "") 
		{
      		$this->error['dinhmucphepham'] = "Bạn nhập định mức phế phẩm";
    	}
		
		if ($data['dinhmuchaohut'] == "") 
		{
      		$this->error['dinhmuchaohut'] = "Bạn nhập định mức hao hụt";
    	}

		if (count($this->error)==0) {
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
	
	
	
	//Cac ham xu ly tren form
	public function getLinhKien()
	{
		$col = $this->request->get['col'];
		$val = $this->request->get['val'];
		$operator = $this->request->get['operator'];
		if($operator == "")
			$operator = "equal";
		$this->load->model("quanlykho/linhkien");
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
		
		$datas = $this->model_quanlykho_linhkien->getList($where);
		
		$this->data['output'] = json_encode(array('linhkiens' => $datas));
		$this->id="linhkien";
		$this->template="common/output.tpl";
		$this->render();
	}
	
	function tinhTienCong($id = "")
	{
		if($id == "")
			$id = @(int)$this->request->get['id'];
		
		$this->load->model("quanlykho/linhkien");
		$this->load->model("quanlykho/congdoan");
		$where = " AND malinhkien = '".$id."'";
		$datacongdoan = $this->model_quanlykho_congdoan->getList($where);
		//print_r($datacongdoan);
		$tiencong = 0;
		foreach($datacongdoan as $item)
		{
			$tiencong += $item['giagiacong'];	
		}
		$this->data['output'] = $tiencong;
		$this->id="linhkien";
		$this->template="common/output.tpl";
		$this->render();
		
	}
}
?>