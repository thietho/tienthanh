<?php
class ControllerQuanlykhoPhieunhapnguyenlieu extends Controller
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
		
		$this->load->model("quanlykho/phieunhapnguyenlieu");
		$this->getList();
	}
	
	public function insert()
	{
		/*
		if(!$this->user->hasPermission($this->getRoute(), "add"))
		{
			$this->response->redirect("?route=common/permission");
		}
		*/
		
    	$this->getForm();
	}
	
	public function update()
	{
		//if(!$this->user->hasPermission($this->getRoute(), "edit"))
		//{
			//$this->response->redirect("?route=common/permission");
		//}
		//else
		//{
			$this->load->model("quanlykho/phieunhapnguyenlieu");
			$this->data['haspass'] = false;
			$this->data['readonly'] = 'readonly="readonly"';
			
			$this->getForm();
		//}
		
  	}
	
	public function delete() 
	{
		$listid=$this->request->post['delete'];
		//$listmadonvi=$_POST['delete'];
		$this->load->model("quanlykho/phieunhapnguyenlieu");
		if(count($listid))
		{
			$this->model_quanlykho_phieunhapnguyenlieu->deletedatas($listid);
			$this->data['output'] = "Xóa thành công";
		}
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
  	}
	
	private function getList() 
	{
		$this->load->model("quanlykho/phieunhapnguyenlieu");
		$this->load->model("quanlykho/nhanvien");
		$this->load->model("quanlykho/kho");
		
		$this->data['insert'] = $this->url->http('quanlykho/phieunhapnguyenlieu/insert');
		$this->data['delete'] = $this->url->http('quanlykho/phieunhapnguyenlieu/delete');		
		
		$this->data['datas'] = array();
		$where = "";
		
		$datasearch = array();
		if($this->request->get['tungay'] != "")
			$datasearch['tungay'] = $this->date->formatViewDate($this->request->get['tungay']);
		
		if($this->request->get['denngay'] != "")
			$datasearch['denngay'] = $this->date->formatViewDate($this->request->get['denngay']);
		
		if($this->request->get['trangthai'] != "")
			$datasearch['trangthai'] = $this->request->get['trangthai'];
			
		$arr = array();
		
		if($datasearch['tungay'] != "")
			$arr[] = " AND ngaylapphieu >= '".$datasearch['tungay']."'";
		
		if($datasearch['denngay'] != "")
			$arr[] = " AND ngaylapphieu <= '".$datasearch['denngay']."'";
		
		if($datasearch['trangthai'] != "")
			$arr[] = " AND trangthai= '".$datasearch['trangthai']."'";
		
		$where = implode("",$arr);
		
		$rows = $this->model_quanlykho_phieunhapnguyenlieu->getList($where);
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
			
			$nguoilap = $this->model_quanlykho_nhanvien->getItem($rows[$i]['nguoilap']);
			$this->data['datas'][$i]['nguoilap'] = $nguoilap['hoten'];
			
			$kho = $this->model_quanlykho_kho->getKho($rows[$i]['makho']);
			$this->data['datas'][$i]['tenkho'] = $kho['tenkho'];
			
			$this->data['datas'][$i]['link_view'] = $this->url->http('quanlykho/phieunhapnguyenlieu/view&id='.$this->data['datas'][$i]['id']);
			$this->data['datas'][$i]['text_view'] = "Xem";
			
			$this->data['datas'][$i]['link_edit'] = $this->url->http('quanlykho/phieunhapnguyenlieu/update&id='.$this->data['datas'][$i]['id']);
			$this->data['datas'][$i]['text_edit'] = "Sửa";
			
			$this->data['datas'][$i]['link_nhapkho'] = $this->url->http('quanlykho/phieunhapnguyenlieu/nhapkho&id='.$this->data['datas'][$i]['id']);
			$this->data['datas'][$i]['text_nhapkho'] = "Nhập kho";
			
		}
		
		$this->data['refres']=$_SERVER['QUERY_STRING'];
		$this->id='content';
		$this->template="quanlykho/phieunhapnguyenlieu_list.tpl";
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
		$this->load->model("quanlykho/phieunhapnguyenlieu");
		$this->load->model("quanlykho/nhanvien");
		$this->load->model("quanlykho/donvitinh");
		$this->load->model("quanlykho/linhkien");
		$this->load->model("quanlykho/kho");
		
		$username = $this->user->getId();
		$nguoilap = $this->model_quanlykho_nhanvien->getItemByUsername($username);
		
		
		$this->data['item'] = array();
		
		if ((isset($this->request->get['id'])) ) 
		{
			$this->data['readonly'] = 'readonly="readonly"';
			$this->data['disabled'] = 'disabled="disabled"';
      		$this->data['item'] = $this->model_quanlykho_phieunhapnguyenlieu->getItem($this->request->get['id']);
			
			
			$kho = $this->model_quanlykho_kho->getKho($this->data['item']['makho']);
			$this->data['item']['tenkho'] = $kho['tenkho'];
			
			//get chi tiet phieu xuat
			$this->data['chitiet'] = $this->model_quanlykho_phieunhapnguyenlieu->getChiTietPhieuNhaps($this->request->get['id']);
		
			$nguoilap = $this->model_quanlykho_nhanvien->getItem($this->data['item']['nguoilap']);
			$this->data['tennguoilap'] = $nguoilap['hoten'];
    	}
		
		$this->data['item']['nguoilap'] = $nguoilap['id'];
		$this->data['item']['tennguoilap'] = $nguoilap['hoten'];
		
		$this->data['donvitinh'] = $this->model_quanlykho_donvitinh->getList();
		$this->data['linhkien'] = $this->model_quanlykho_linhkien->getList();
		
		$this->id='content';
		$this->template='quanlykho/phieunhapnguyenlieu_form.tpl';
		$this->layout="layout/center";
		
		$this->render();
	}
	
	public function view()
	{
		$this->load->model("quanlykho/phieunhapnguyenlieu");
		$this->load->model("quanlykho/nhanvien");
		$this->load->model("quanlykho/donvitinh");
		$this->load->model("quanlykho/linhkien");
		$this->load->model("quanlykho/kho");
		
		$username = $this->user->getId();
		$nguoilap = $this->model_quanlykho_nhanvien->getItemByUsername($username);
		
		
		$this->data['item'] = array();
		
		if ((isset($this->request->get['id'])) ) 
		{
			
      		$this->data['item'] = $this->model_quanlykho_phieunhapnguyenlieu->getItem($this->request->get['id']);
			//get chi tiet phieu xuat
			$this->data['chitiet'] = $this->model_quanlykho_phieunhapnguyenlieu->getChiTietPhieuNhaps($this->request->get['id']);
		
			$nguoilap = $this->model_quanlykho_nhanvien->getItem($this->data['item']['nguoilap']);
			$this->data['tennguoilap'] = $nguoilap['hoten'];
    	}
		
		$this->data['item']['nguoilap'] = $nguoilap['id'];
		$this->data['item']['tennguoilap'] = $nguoilap['hoten'];
		
		$this->data['donvitinh'] = $this->model_quanlykho_donvitinh->getList();
		$this->data['linhkien'] = $this->model_quanlykho_linhkien->getList();
		
		$this->id='content';
		$this->template='quanlykho/phieunhapnguyenlieu_view.tpl';
		$this->layout="layout/center";
		if($this->request->get['opendialog']=='true')
		{
			$this->template='quanlykho/phieunhapnguyenlieu_print.tpl';
			$this->layout="layout/print";
			$this->data['dialog'] = true;
		}
		$this->render();
	}
	
	public function intem()
	{
		$this->load->model("quanlykho/phieunhapnguyenlieu");
		
		$tem = $this->request->get['id'];
		$maphieu = $this->request->get['maphieu'];
		$this->data['item'] = array();
		$this->data['datas'] = array();
		$where = "";
		if($tem !="")
			$where = " AND id = '".$tem."'";
		if($maphieu !="")
			$where = " AND maphieu = '".$maphieu."'";
      	$this->data['datas'] = $this->model_quanlykho_phieunhapnguyenlieu->getChiTietPhieuXuatNhap($where);
			
		
    	
		
		
		
		$this->id='content';
		$this->template='quanlykho/phieunhapnguyenlieu_printtem.tpl';
		$this->layout="layout/print";
		
		$this->render();
	}
	
	public function save()
	{
		$data = $this->request->post;
		
		if($this->validateForm($data))
		{
			$this->load->model("quanlykho/phieunhapnguyenlieu");
			$item = $this->model_quanlykho_phieunhapnguyenlieu->getItem($data['id']);
			
			$data['ngaynhap'] = $this->date->formatViewDate($data['ngaynhap']);
			$data['ngaylapphieu'] = $this->date->formatViewDate($data['ngaylapphieu']);
			$data['loainhapxuat'] = $this->model_quanlykho_phieunhapnguyenlieu->loainhapxuat;
			if(count($item)==0)
			{
				$today = getdate();
				$prefix = $this->date->numberFormate($today['mon'])."/".$today['year']."PN".$this->document->getNhanVien($data['nguoilap'],"maphongban");
				$data['maphieu'] = $this->model_quanlykho_phieunhapnguyenlieu->nextMaPhieu("-".$prefix);
				$data['id']=$this->model_quanlykho_phieunhapnguyenlieu->insert($data);
			}
			else
			{
				$this->model_quanlykho_phieunhapnguyenlieu->update($data);
			}
			
			$arrchitietid = $data['chitiet'];
			$arritemid = $data['itemid'];
			$arritemname = $data['tennguyenlieu'];
			$arrlot = $data['lot'];
			$arrsoluong = $data['soluong'];
			$arrdongia =  $data['dongia'];
			$arrmadonvi =  $data['madonvi'];
			$arrtrongluong =  $data['trongluong'];
			$arrsocongtrenky = $data['socongtrenky'];
			$arrthucnhap = $data['thucnhap'];
			$arrbaobi = $data['baobi'];
			$arrghichu = $data['ghichuchitiet'];
			
			$this->load->model("quanlykho/phieunhapnguyenlieu");
			$list = trim( $data['delchitiet'],",");
			$arrdel = split(",", $list);
			
			if(count($arrdel))
			{
				foreach($arrdel as $val)
				{
					$this->model_quanlykho_phieunhapnguyenlieu->deletechitiet($val)	;
				}
			}
			
			
			$datachitiet = array();
			if(count($arrchitietid)>0)
			{
				
				foreach($arrchitietid as $key => $val)
				{
					$datachitiet['id'] = $arrchitietid[$key];
					$datachitiet['prefix'] = $data['maphieu'];
					$datachitiet['maphieu'] = $data['id'];
					$datachitiet['itemid'] = $arritemid[$key];
					$datachitiet['itemname'] = $arritemname[$key];
					$datachitiet['makho'] = $data['makho'];
					$datachitiet['lot'] = $arrlot[$key];
					$datachitiet['soluong'] = $arrsoluong[$key];
					$datachitiet['dongia'] = $arrdongia[$key];
					$datachitiet['madonvi'] = $arrmadonvi[$key];
					$datachitiet['trongluong'] = $arrtrongluong[$key];
					$datachitiet['socongtrenky'] = $arrsocongtrenky[$key];
					$datachitiet['thucnhap'] = $arrthucnhap[$key];
					$datachitiet['baobi'] = $arrbaobi[$key];
					$datachitiet['ghichu'] = $arrghichu[$key];
					$datachitiet['vitri'] = $key;
					$this->model_quanlykho_phieunhapnguyenlieu->saveChiTiet($datachitiet);
				}
				
			}
			/*//Cap nhat phieu nhan hang
			if($data['loainguon'] == "nh")
			{
				//Cap nhat trang thai phieu nhan hang thanh complete
				$this->load->model("quanlykho/phieunhanhang");
				$this->model_quanlykho_phieunhanhang->updateTrangThaiByMaPhieu($data['maphieunguon'],"completed");
			}
			
			//Cap nhat phieu xuat
			if($data['loainguon'] == "nt" || $data['loainguon'] == "ncd")
			{
				$this->model_quanlykho_phieunhapxuat->updateTrangThaiByMaPhieu($data['maphieunguon'],"closed");
			}*/
			$this->data['output'] = "true";
			$this->id='content';
			$this->template='common/output.tpl';
			$this->render();
			
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
		/*if($data['maphieu'] == "")
		{
      		$this->error['maphieu'] = "Bạn chưa nhập mã phiếu";
    	}
		else
		{
			if($data['id'] == "")
			{
				$this->load->model("quanlykho/phieunhapnguyenlieu");
				$where = " AND maphieu ='".$data['maphieu']."'" ;
				$item = $this->model_quanlykho_phieunhapnguyenlieu->getList($where);
				if(count($item)>0)
					$this->error['maphieu'] = "Mã phiếu đã được đã được sử dụng";
			}
		}*/
		
    	if($data['nguoigiao'] == "")
		{
      		$this->error['nguoigiao'] = "Chưa nhập họ tên người giao";
    	}
		
		/*if ($data['ngaynhap'] == "") 
		{
      		$this->error['ngaynhap'] = "Bạn chưa nhập ngày nhập";
    	}*/
		
		if ($data['mahopdong'] == "") 
		{
      		$this->error['mahopdong'] = "Bạn chưa nhập hợp đồng";
    	}
		
		if ($data['ngaylapphieu'] == "") 
		{
      		$this->error['ngaylapphieu'] = "Bạn chưa nhập ngày lập phiếu";
    	}
		if($data['id'] == "")
		{
			if($data['loainguon'] == "nh")
			{
				//Kiem tra phieu nhan hang phai la pending
				$this->load->model("quanlykho/phieunhanhang");
				$phieunhanhang = $this->model_quanlykho_phieunhanhang->getItemByMaPhieu($data['maphieunguon']);
				if($phieunhanhang['trangthai'] == "completed")
				{
					$this->error['maphieunguon'] = "Phiếu nhận hàng này đã được nhập kho rồi";
				}
			}
			
			if($data['loainguon'] == "nt" || $data['loainguon'] == "ncd")
			{
				//Kiem tra phieu xuat co ai nhap kho truoc do ko
				$this->load->model("quanlykho/phieuxuatnguyenlieu");
				$phieuxuat = $this->model_quanlykho_phieuxuatnguyenlieu->getItemMaPhieu($data['maphieunguon']);
				if(count($phieuxuat)==0)
				{
					$this->error['maphieunguon'] = "Phiếu xuất không tồn tại";
				}
				else
				{
					if($phieuxuat['trangthai']=="pending")
					{
						$this->error['maphieunguon'] = "Phiếu xuất này chưa được duyệt";
					}
					if($phieuxuat['trangthai']=="closed")
					{
						$this->error['maphieunguon'] = "Phiếu xuất này đã được sử lý";
					}
				}
				//$this->model_quanlykho_phieunhapxuat->updateTrangThaiByMaPhieu($data['maphieunguon'],"closed");
			}

		}
		if (count($this->error)==0) 
		{
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
	
	//xu ly nhap kho
	public function nhapkho()
	{
		$id = $this->request->get['id'];
		$this->load->model("quanlykho/phieunhapnguyenlieu");
		$this->load->model("quanlykho/nguyenlieu");
		
		$chitiets = $this->model_quanlykho_phieunhapnguyenlieu->getChiTietPhieuNhaps($id);
		
		/*foreach($chitiets as $val)
		{
			$this->model_quanlykho_nguyenlieu->nhap($val['itemid'], $val['soluong']);
		}*/
		
		$this->model_quanlykho_phieunhapxuat->updateTrangThai($id, "completed");
		
		foreach($chitiets as $val)
		{
			$this->model_quanlykho_phieunhapxuat->updateChitietTrangThai($val['id'],"completed");
			/*$soluongton = $this->model_quanlykho_phieunhapxuat->tinhSoLuongTon($val['itemid']);
			$this->model_quanlykho_nguyenlieu->updateSoLuongTon($val['itemid'],$soluongton);*/
			$this->model_quanlykho_nguyenlieu->nhap($val['itemid'],$val['thucnhap']);
		}
		
		
		
		$this->data['output'] = "Nhập kho thành công";
		$this->id="linhkien";
		$this->template="common/output.tpl";
		$this->render();
	}
	
	
	
	
}
?>