<?php
class ControllerQuanlykhoPhieuxuatnguyenlieu extends Controller
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
		
		$this->load->model("quanlykho/phieuxuatnguyenlieu");
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
		$this->id='content';
		$this->template='quanlykho/phieuxuatnguyenlieu_form.tpl';
		$this->layout="layout/center";
		
		$this->render();
	}
	
	public function update()
	{
		//if(!$this->user->hasPermission($this->getRoute(), "edit"))
		//{
			//$this->response->redirect("?route=common/permission");
		//}
		//else
		//{
			$this->load->model("quanlykho/phieuxuatnguyenlieu");
			$this->data['haspass'] = false;
			$this->data['readonly'] = 'readonly="readonly"';
			$this->getForm();
			$this->id='content';
			$this->template='quanlykho/phieuxuatnguyenlieu_update.tpl';
			$this->layout="layout/center";
			$this->render();
		//}
		
  	}
	
	public function delete() 
	{
		$listid=$this->request->post['delete'];
		//$listmadonvi=$_POST['delete'];
		$this->load->model("quanlykho/phieuxuatnguyenlieu");
		$this->load->model("quanlykho/nguyenlieu");
		if(count($listid))
		{
			foreach($listid as $id)
			{
				$chitiets = $this->model_quanlykho_phieuxuatnguyenlieu->getChiTietPhieuXuats($id);
				
				$this->model_quanlykho_phieuxuatnguyenlieu->deletePhieuXuat($id);
				foreach($chitiets as $val)
				{
					$soluongton = $this->model_quanlykho_phieunhapxuat->tinhSoLuongTon($val['itemid']);
					$this->model_quanlykho_nguyenlieu->updateSoLuongTon($val['itemid'],$soluongton);
				}
			}
			
			$this->data['output'] = "Xóa thành công";
		}
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
  	}
	
	private function getList() 
	{
		$this->load->model("quanlykho/phieuxuatnguyenlieu");
		$this->load->model("quanlykho/nhanvien");
		$this->load->model("quanlykho/kho");
		
		$this->data['insert'] = $this->url->http('quanlykho/phieuxuatnguyenlieu/insert');
		$this->data['delete'] = $this->url->http('quanlykho/phieuxuatnguyenlieu/delete');		
		
		$this->data['datas'] = array();
		$where = "";
		
		$datasearch = array();
		
		$datasearch['loaiphieu'] = $this->request->get['loaiphieu'];
		$datasearch['trangthai'] = $this->request->get['trangthai'];
		
		$arr = array();
		foreach($datasearch as $key => $item)
		{
			if($item !="")
				$arr[] = " AND " . $key ." = '".$item."'";
		}
		
		$datasearch['tungay'] = $this->date->formatViewDate($this->request->get['tungay']);
		$datasearch['denngay'] = $this->date->formatViewDate($this->request->get['denngay']);
		
		if($datasearch['tungay'] != "")
			$arr[] = " AND ngaylapphieu >= '".$datasearch['tungay']."'";
		
		if($datasearch['denngay'] != "")
			$arr[] = " AND ngaylapphieu <= '".$datasearch['denngay']."'";
		
		
		
		$where = implode("",$arr);

		$rows = $this->model_quanlykho_phieuxuatnguyenlieu->getList($where);
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
			
			$this->data['datas'][$i]['link_view'] = $this->url->http('quanlykho/phieuxuatnguyenlieu/view&id='.$this->data['datas'][$i]['id']);
			$this->data['datas'][$i]['text_view'] = "Xem";
			
			$this->data['datas'][$i]['link_edit'] = $this->url->http('quanlykho/phieuxuatnguyenlieu/update&id='.$this->data['datas'][$i]['id']);
			$this->data['datas'][$i]['text_edit'] = "Sửa";
			
			$this->data['datas'][$i]['text_xuatkho'] = "Xuất kho";
			
		}
		
		$this->data['refres']=$_SERVER['QUERY_STRING'];
		$this->id='content';
		$this->template="quanlykho/phieuxuatnguyenlieu_list.tpl";
		$this->layout="layout/center";
		
		
		if($this->request->get['opendialog']=='true')
		{
			$this->layout="layout/dialog";
			$this->data['dialog'] = true;
			//$this->data['list'] = $this->url->http('quanlykho/nhacungung&opendialog=true');
		}
		$this->render();
	}
	
	public function view()
	{
		$this->getForm();
		$this->id='content';
		$this->template='quanlykho/phieuxuatnguyenlieu_view.tpl';
		$this->layout="layout/center";
		if($this->request->get['opendialog']=='true')
		{
			$this->template='quanlykho/phieuxuatnguyenlieu_print.tpl';
			$this->layout="layout/print";
			$this->data['dialog'] = true;
		}
		$this->render();
	}
	
	private function getForm()
	{
		$this->load->model("quanlykho/phieuxuatnguyenlieu");
		$this->load->model("quanlykho/nhanvien");
		$this->load->model("quanlykho/donvitinh");
		$this->load->model("quanlykho/linhkien");
		$this->load->model("quanlykho/kho");
		
		$username = $this->user->getId();
		$nguoilap = $this->model_quanlykho_nhanvien->getItemByUsername($username);
		
		
		$this->data['item'] = array();
		
		if ((isset($this->request->get['id'])) ) 
		{
      		$this->data['item'] = $this->model_quanlykho_phieuxuatnguyenlieu->getItem($this->request->get['id']);
			
			
			$kho = $this->model_quanlykho_kho->getKho($this->data['item']['makho']);
			$this->data['item']['tenkho'] = $kho['tenkho'];
			
			//get chi tiet phieu xuat
			$this->data['chitiet'] = $this->model_quanlykho_phieuxuatnguyenlieu->getChiTietPhieuXuats($this->request->get['id']);
			
			$nguoilap = $this->model_quanlykho_nhanvien->getItem($this->data['item']['nguoilap']);
			$this->data['tennguoilap'] = $nguoilap['hoten'];
    	}
		
		$this->data['item']['nguoilap'] = $nguoilap['id'];
		$this->data['item']['tennguoilap'] = $nguoilap['hoten'];
		
		$this->data['donvitinh'] = $this->model_quanlykho_donvitinh->getList();
		$this->data['linhkien'] = $this->model_quanlykho_linhkien->getList();
		
		
	}
	
	public function save()
	{
		$data = $this->request->post;
		$isupdate = false;
		if($this->validateForm($data))
		{
			$this->load->model("quanlykho/phieuxuatnguyenlieu");
			
			$item = $this->model_quanlykho_phieuxuatnguyenlieu->getItem($data['id']);
			
			
			
			
			$data['ngayxuat'] = $this->date->formatViewDate($data['ngayxuat']);
			$data['ngaylapphieu'] = $this->date->formatViewDate($data['ngaylapphieu']);
			$data['loainhapxuat'] = $this->model_quanlykho_phieuxuatnguyenlieu->loainhapxuat;
			if(count($item)==0)
			{
				$today = getdate();
				$prefix = $this->date->numberFormate($today['mon'])."/".$today['year']."PX".$this->document->getNhanVien($data['nguoilap'],"maphongban");
				$data['maphieu'] = $this->model_quanlykho_phieuxuatnguyenlieu->nextMaPhieu("-".$prefix);
				$data['id']=$this->model_quanlykho_phieuxuatnguyenlieu->insert($data);
			}
			else
			{
				$this->model_quanlykho_phieuxuatnguyenlieu->update($data);
				$isupdate = true;
				
				
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
			$arrthucxuat = $data['thucxuat'];
			
			$this->load->model("quanlykho/phieuxuatnguyenlieu");
			$list = trim( $data['delchitiet'],",");
			$arrdel = split(",", $list);
			
			if(count($arrdel))
			{
				foreach($arrdel as $val)
				{
					//$this->model_quanlykho_phieuxuatnguyenlieu->deletechitiet($val)	;
				}
			}
			
			
			$datachitiet = array();
			if(count($arrchitietid)>0)
			{
				
				foreach($arrchitietid as $key => $val)
				{
					$id = $arrchitietid[$key];
					$phieuxuat =  $data['id'];
					//$this->model_quanlykho_phieuxuatnguyenlieu->saveChiTiet($datachitiet);
					$this->model_quanlykho_phieuxuatnguyenlieu->updateChitietPhieuXuat($id,$phieuxuat);
				}
				
			}
			
			
			$this->load->model("quanlykho/nguyenlieu");
			$id = $data['id'];
			$chitiets = $this->model_quanlykho_phieuxuatnguyenlieu->getChiTietPhieuXuats($id);
			$this->model_quanlykho_phieunhapxuat->updateTrangThai($id, "completed");
			foreach($chitiets as $val)
			{
				$this->model_quanlykho_phieunhapxuat->updateChitietTrangThai($val['id'],"completed");
				$soluongton = $this->model_quanlykho_phieunhapxuat->tinhSoLuongTon($val['itemid']);
				$this->model_quanlykho_nguyenlieu->updateSoLuongTon($val['itemid'],$soluongton);
			}
			
			
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
				$this->load->model("quanlykho/phieuxuatnguyenlieu");
				$where = " AND maphieu ='".$data['maphieu']."'" ;
				$item = $this->model_quanlykho_phieuxuatnguyenlieu->getList($where);
				if(count($item)>0)
					$this->error['maphieu'] = "Mã phiếu đã được đã được sử dụng";
			}
		}
		*/
		
    	if($data['nguoinhan'] == "")
		{
      		$this->error['nguoinhan'] = "Chưa nhập họ tên người nhận";
    	}
		
		/*if ($data['ngayxuat'] == "") 
		{
      		$this->error['ngayxuat'] = "Bạn chưa nhập ngày xuất";
    	}*/
		
		if ($data['mahopdong'] == "") 
		{
      		$this->error['mahopdong'] = "Bạn chưa nhập hợp đồng";
    	}
		
		if ($data['ngaylapphieu'] == "") 
		{
      		$this->error['ngaylapphieu'] = "Bạn chưa nhập ngày lập phiếu";
    	}
		
		/*if ($data['loaiphieu'] == "xt" && $data['makho'] == "") 
		{
			$this->error['makho'] = "Bạn chưa nhập thông tin kho";
    	}
		
		if ($data['loaiphieu'] == "xtg" && $data['macongdoan'] == "") 
		{
			$this->error['macongdoan'] = "Bạn chưa nhập thông tin công đoạn";
    	}*/
		
		if (count($this->error)==0) 
		{
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
	
	//xulyxuat
	public function xuatkho()
	{
		$id = $this->request->get['id'];
		$this->load->model("quanlykho/phieuxuatnguyenlieu");
		$this->load->model("quanlykho/nguyenlieu");
		
		$chitiets = $this->model_quanlykho_phieuxuatnguyenlieu->getChiTietPhieuXuats($id);
		
		$flag = 0;
		$str = "";
		
		foreach($chitiets as $val)
		{
			$nguyenlieu = $this->model_quanlykho_nguyenlieu->getItem($val['itemid']);
			
			
			if($nguyenlieu['soluongton'] < $val['soluong'])
			{
				$flag = 1;
				$str .= $nguyenlieu['manguyenlieu'] . ", ";
			}
		}
		$str .= " không đủ số lượng";
		
		if($flag == 0)
		{
			foreach($chitiets as $val)
			{
				$this->model_quanlykho_nguyenlieu->nhap($val['itemid'], -$val['soluong']);
			}
			
			$this->model_quanlykho_phieunhapxuat->updateTrangThai($id, "completed");
			foreach($chitiets as $val)
			{
				$this->model_quanlykho_phieunhapxuat->updateChitietTrangThai($val['id'],"completed");
				/*$soluongton = $this->model_quanlykho_phieunhapxuat->tinhSoLuongTon($val['itemid']);
				$this->model_quanlykho_nguyenlieu->updateSoLuongTon($val['itemid'],$soluongton);*/
				$this->model_quanlykho_nguyenlieu->nhap($val['itemid'], -1 * $val['thucnhap']);
			}
			$this->data['output'] = "Xuất kho thành công";
			
		}
		else
		{
			$this->data['output'] = $str;
		}
		
		
		$this->id="linhkien";
		$this->template="common/output.tpl";
		$this->render();
	}
	
	//Cac ham xu ly tren form
	public function getPhieuXuatNguyenLieu()
	{
		$col = $this->request->get['col'];
		$val = $this->request->get['val'];
		$operator = $this->request->get['operator'];
		if($operator == "")
			$operator = "equal";
		$this->load->model("quanlykho/phieuxuatnguyenlieu");
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
			
		$datas = $this->model_quanlykho_phieuxuatnguyenlieu->getList($where);
		$this->data['output'] = json_encode(array('phieuxuatnguyenlieus' => $datas));
		$this->id="phieuxuatnguyenlieu";
		$this->template="common/output.tpl";
		$this->render();
	}
}
?>