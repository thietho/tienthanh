<?php
class ControllerQuanlykhoPhieuthuthap extends Controller
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
		
		$this->load->model("quanlykho/phieuthuthap");
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
			$this->load->model("quanlykho/phieuthuthap");
			$this->data['haspass'] = false;
			$this->data['readonly'] = 'readonly="readonly"';
			
			$this->getForm();
		//}
		
  	}
	
	public function delete() 
	{
		$listid=$this->request->post['delete'];
		//$listmadonvi=$_POST['delete'];
		$this->load->model("quanlykho/phieuthuthap");
		if(count($listid))
		{
			$this->model_quanlykho_phieuthuthap->deletedatas($listid);
			$this->data['output'] = "Xóa thành công";
		}
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
  	}
	
	private function getList() 
	{
		$this->load->model("quanlykho/phieuthuthap");
		$this->load->model("quanlykho/nhanvien");
		$this->load->model("quanlykho/kho");
		
		$this->data['insert'] = $this->url->http('quanlykho/phieuthuthap/insert');
		$this->data['delete'] = $this->url->http('quanlykho/phieuthuthap/delete');		
		
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
		$datasearchlike['maphieu'] = $this->request->get['maphieu'];
		$datasearch['soluongsanxuat'] = $this->string->toNumber($this->request->get['soluongsanxuat']);
		foreach($datasearchlike as $key => $item)
		{
			if($item !="")
				$arr[] = " AND " . $key ." like '%".$item."%'";
		}
		
		if($datasearch['tungay'] != "")
			$arr[] = " AND ngaylapphieu >= '".$datasearch['tungay']."'";
		
		if($datasearch['denngay'] != "")
			$arr[] = " AND ngaylapphieu <= '".$datasearch['denngay']."'";
		
		if($datasearch['soluongsanxuat'] != "")
			$arr[] = " AND soluongsanxuat = '".$datasearch['soluongsanxuat']."'";
		
		$where = implode("",$arr);
		
		
		
		$rows = $this->model_quanlykho_phieuthuthap->getList($where);
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
			
			$this->data['datas'][$i]['link_view'] = $this->url->http('quanlykho/phieuthuthap/view&id='.$this->data['datas'][$i]['id']);
			$this->data['datas'][$i]['text_view'] = "Xem";
			
			$this->data['datas'][$i]['link_edit'] = $this->url->http('quanlykho/phieuthuthap/update&id='.$this->data['datas'][$i]['id']);
			$this->data['datas'][$i]['text_edit'] = "Sửa";
			
			$this->data['datas'][$i]['link_nhapkho'] = $this->url->http('quanlykho/phieuthuthap/nhapkho&id='.$this->data['datas'][$i]['id']);
			$this->data['datas'][$i]['text_nhapkho'] = "Nhập kho";
			
		}
		
		$this->data['refres']=$_SERVER['QUERY_STRING'];
		$this->id='content';
		$this->template="quanlykho/phieuthuthap_list.tpl";
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
		$this->load->model("quanlykho/phieuthuthap");
		$this->load->model("quanlykho/nhanvien");
		$this->load->model("quanlykho/donvitinh");
		
		$this->load->model("quanlykho/kho");
		
		$username = $this->user->getId();
		$nguoilap = $this->model_quanlykho_nhanvien->getItemByUsername($username);
		
		
		$this->data['item'] = array();
		
		if ((isset($this->request->get['id'])) ) 
		{
			$this->data['readonly'] = 'readonly="readonly"';
			$this->data['disabled'] = 'disabled="disabled"';
      		$this->data['item'] = $this->model_quanlykho_phieuthuthap->getItem($this->request->get['id']);
			
			//get chi tiet phieu thu thap
			$where = " AND maphieu = '".$this->request->get['id']."'";
			$this->data['chitiet'] = $this->model_quanlykho_phieuthuthap->getChiTiets($where);
    	}
		
		$this->id='content';
		$this->template='quanlykho/phieuthuthap_form.tpl';
		$this->layout="layout/center";
		
		$this->render();
	}
	
	public function view()
	{
		$this->load->model("quanlykho/phieuthuthap");
		$this->load->model("quanlykho/nhanvien");
		$this->load->model("quanlykho/donvitinh");
		$this->load->model("quanlykho/linhkien");
		$this->load->model("quanlykho/kho");
		
		$username = $this->user->getId();
		$nguoilap = $this->model_quanlykho_nhanvien->getItemByUsername($username);
		
		
		$this->data['item'] = array();
		
		if ((isset($this->request->get['id'])) ) 
		{
			
      		$this->data['item'] = $this->model_quanlykho_phieuthuthap->getItem($this->request->get['id']);
			//get chi tiet phieu thu thap
			$where = " AND maphieu = '".$this->request->get['id']."'";
			$this->data['chitiet'] = $this->model_quanlykho_phieuthuthap->getChiTiets($where);
    	}
		
		$this->id='content';
		$this->template='quanlykho/phieuthuthap_view.tpl';
		$this->layout="layout/center";
		if($this->request->get['opendialog']=='true')
		{
			$this->template='quanlykho/phieuthuthap_print.tpl';
			$this->layout="layout/print";
			$this->data['dialog'] = true;
		}
		$this->render();
	}
	
	
	
	public function save()
	{
		$data = $this->request->post;
		
		if($this->validateForm($data))
		{
			$this->load->model("quanlykho/phieuthuthap");
			$item = $this->model_quanlykho_phieuthuthap->getItem($data['id']);
			
			$data['ngay'] = $this->date->formatViewDate($data['ngay']);
			$data['ngaylapphieu'] = $this->date->formatViewDate($data['ngaylapphieu']);
			
			if(count($item)==0)
			{
				/*$today = getdate();
				$prefix = $this->date->numberFormate($today['mon'])."/".$today['year']."PN".$this->document->getNhanVien($data['nguoilap'],"maphongban");
				$data['maphieu'] = $this->model_quanlykho_phieuthuthap->nextMaPhieu("-".$prefix);*/
				$data['id']=$this->model_quanlykho_phieuthuthap->insert($data);
			}
			else
			{
				$this->model_quanlykho_phieuthuthap->update($data);
			}
			
			$arrchitietid = $data['chitiet'];
			$arrgio = $data['gio'];
			$arrthanhpham = $data['thanhpham'];
			$arrphelieu = $data['phelieu'];
			$arrphepham = $data['phepham'];
			$arrhaohut =  $data['haohut'];
			$arrghichu = $data['ghichuchitiet'];
			
			$this->load->model("quanlykho/phieuthuthap");
			$list = trim( $data['delchitiet'],",");
			$arrdel = split(",", $list);
			
			if(count($arrdel))
			{
				foreach($arrdel as $val)
				{
					$this->model_quanlykho_phieuthuthap->deletechitiet($val)	;
				}
			}
			
			
			$datachitiet = array();
			if(count($arrchitietid)>0)
			{
				
				foreach($arrchitietid as $key => $val)
				{
					$datachitiet['id'] = $arrchitietid[$key];
					$datachitiet['maphieu'] = $data['id'];
					$datachitiet['gio'] = $arrgio[$key];
					$datachitiet['thanhpham'] = $arrthanhpham[$key];
					$datachitiet['phelieu'] = $arrphelieu[$key];
					$datachitiet['phepham'] = $arrphepham[$key];
					$datachitiet['haohut'] = $arrhaohut[$key];
					$datachitiet['ghichu'] = $arrghichu[$key];
					$this->model_quanlykho_phieuthuthap->saveChiTiet($datachitiet);
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
				$this->load->model("quanlykho/phieuthuthap");
				$where = " AND maphieu ='".$data['maphieu']."'" ;
				$item = $this->model_quanlykho_phieuthuthap->getList($where);
				if(count($item)>0)
					$this->error['maphieu'] = "Mã phiếu đã được đã được sử dụng";
			}
		}*/
		
    	if($data['macongdoan'] == "")
		{
      		$this->error['macongdoan'] = "Chưa chọn công đoạn";
    	}
		
		if ($data['ngay'] == "") 
		{
      		$this->error['ngay'] = "Bạn chưa nhập ngày";
    	}
		
		if ($data['ca'] == "") 
		{
      		$this->error['ca'] = "Bạn chưa nhập ca";
    	}
		
		if ($data['may'] == "") 
		{
      		$this->error['may'] = "Bạn chưa nhập máy sản xuất";
    	}
		
		if ($data['nhanviensanxuat'] == "") 
		{
      		$this->error['nhanviensanxuat'] = "Bạn chưa nhập nhân viên sản xuất";
    	}
		
		if ($data['ngaylapphieu'] == "") 
		{
      		$this->error['ngaylapphieu'] = "Bạn chưa nhập ngày lập phiếu";
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
		$this->load->model("quanlykho/phieuthuthap");
		$this->load->model("quanlykho/nguyenlieu");
		
		$chitiets = $this->model_quanlykho_phieuthuthap->getChiTietPhieuNhaps($id);
		
		/*foreach($chitiets as $val)
		{
			$this->model_quanlykho_nguyenlieu->nhap($val['itemid'], $val['soluong']);
		}*/
		
		$this->model_quanlykho_phieunhapxuat->updateTrangThai($id, "completed");
		
		foreach($chitiets as $val)
		{
			$this->model_quanlykho_phieunhapxuat->updateChitietTrangThai($val['id'],"completed");
			$soluongton = $this->model_quanlykho_phieunhapxuat->tinhSoLuongTon($val['itemid']);
			$this->model_quanlykho_nguyenlieu->updateSoLuongTon($val['itemid'],$soluongton);
		}
		
		
		
		$this->data['output'] = "Nhập kho thành công";
		$this->id="linhkien";
		$this->template="common/output.tpl";
		$this->render();
	}
	
	
	
	
}
?>