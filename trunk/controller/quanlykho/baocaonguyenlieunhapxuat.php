<?php
class ControllerQuanlykhoBaocaonguyenlieunhapxuat extends Controller
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
		//$this->load->language('quanlykho/nguyenlieu');
		//$this->data = array_merge($this->data, $this->language->getData());
		
		$this->load->model("quanlykho/kho");
		$this->data['kho'] = $this->model_quanlykho_kho->getKhos();
		$this->load->model('quanlykho/phieunhapvattuhanghoa');
		$this->data['data_year'] = $this->model_quanlykho_phieunhapvattuhanghoa->getYear();
		
		$this->id='content';
		$this->template='quanlykho/baocaonguyenlieunhapxuat.tpl';
		$this->layout="layout/center";
		
		$this->render();
	}
	
	private function validateForm($data)
	{	
    	if($data['makho'] == "")
		{
      		$this->error['macongdoan'] = "Chưa chọn kho";
    	}
		
		if (count($this->error)==0) 
		{
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
	
	private function getNhapKho($makho,$tungay,$denngay)
	{
		$this->load->model('quanlykho/phieunhapvattuhanghoa');
		$where = "";
		if($makho !="")
		{
			$where .= " AND makho = '".$makho."'";	
		}
		if($tungay!="")
		{
			$where .= " AND ngaynhap >= '".$tungay."'";	
		}
		
		if($denngay!="")
		{
			$where .= " AND ngaynhap <= '".$denngay."'";	
		}
		
		$datas = $this->model_quanlykho_phieunhapvattuhanghoa->getPhieuNhanVatTuHangHoaChiTietList($where);
		return $datas;
	}
	
	public function showReport()
	{
		$data = $this->request->post;
		
		if($this->validateForm($data))
		{
			$this->load->model('quanlykho/nguyenlieu');
			
			$tungay = $this->date->formatViewDate($data['tungay']);
			$denngay = $this->date->formatViewDate($data['denngay']);
			$this->data['data_nhapkhodauky'] = $this->getNhapKho($data['makho'],'',$this->date->addday($tungay,-1));
			$this->data['data_nhapkhotrongky'] = $this->getNhapKho($data['makho'],$tungay,$denngay);
			
			$where = " AND makho = '".$data['makho']."'";
			$this->data['data_nguyenlieu'] = $this->model_quanlykho_nguyenlieu->getList($where);
			foreach($this->data['data_nguyenlieu'] as $key => $item)
			{
				//Dau ky
				$data_nguyenlieunhapdauky = $this->string->array_Filter($this->data['data_nhapkhodauky'],'nguyenlieuid',$item['id']);
				$nhapdauky = 0;
				foreach($data_nguyenlieunhapdauky as $val)
				{
					$nhapdauky += $val['thucnhap'];
				}
				$this->data['data_nguyenlieu'][$key]['nhapdauky'] = $nhapdauky;
				
				//Nhap Trong ky
				$data_nguyenlieunhaptrongky = $this->string->array_Filter($this->data['data_nhapkhotrongky'],'nguyenlieuid',$item['id']);
				$nhanptrongky = 0;
				foreach($data_nguyenlieunhaptrongky as $val)
				{
					$nhanptrongky += $val['thucnhap'];
				}
				$this->data['data_nguyenlieu'][$key]['nhaptrongky'] = $nhanptrongky;
				
				//Cuoi ky
				$this->data['data_nguyenlieu'][$key]['soducuoiky'] = $nhapdauky + $nhanptrongky;
			}
			
			$this->id='content';
			$this->template='quanlykho/baocaotonkho_nguyenlieu.tpl';
			$this->render();	
		}
		else
		{
			foreach($this->error as $item)
			{
				$this->data['output'] .= $item."<br>";
			}
			$this->id='content';
			$this->template='common/output.tpl';
			$this->render();
		}
	}
	/*public function getPhieuNhapXuatNguyenLieu()
	{
		$data = $this->request->post;
		
		if($this->validateForm($data))
		{
			$makho = $data['makho'];
			$loainhapxuat = $_GET['loainhapxuat'];
			$tungay = $this->date->formatViewDate($data['tungay']);
			$dengay = $this->date->formatViewDate($data['dengay']);
			$chitiets = $this->loadData($makho,$loainhapxuat,$tungay,$dengay);
			$this->data['output'] = $this->showReport($chitiets,$loainhapxuat);
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
    	if($data['makho'] == "")
		{
      		$this->error['macongdoan'] = "Chưa chọn kho";
    	}
		
		if (count($this->error)==0) 
		{
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
	
	private function loadData($makho,$loainhapxuat,$tungay,$dengay)
	{
		
		$where = "";
		if($makho!="")
		{
			$where .= " AND makho = '".$makho."'";	
		}
		
		if($loainhapxuat!="")
		{
			$where .= " AND loainhapxuat = '".$loainhapxuat."'";	
		}
		
		if($tungay!="")
		{
			$where .= " AND ngaylapphieu >= '".$tungay."'";	
		}
		
		if($dengay!="")
		{
			$where .= " AND ngaylapphieu <= '".$dengay."'";	
		}
		$this->load->model("quanlykho/phieunhapxuat");
		
		$data = $this->model_quanlykho_phieunhapxuat->getPhieuNhapXuats($where);
		$chitiets = array();
		foreach($data as $item)
		{
			$dk = " AND maphieu = '".$item['id']."'";
			if($loainhapxuat == "phieuxuatnguyenlieu")
				$dk = " AND phieuxuat = '".$item['id']."'";
			$arr = $this->model_quanlykho_phieunhapxuat->getChiTietPhieuXuatNhap($dk);
			foreach($arr as $val)
			{
				$chitiets[] = $val;	
			}
		}
		return $chitiets;
	}
	
	private function showReport($chitiets,$loainhapxuat)
	{
		$rows = "";
		foreach($chitiets as $item)
		{
			
			$row = '<td>'.$this->document->getPhieuNhapXuat($item['maphieu'],"ngaylapphieu").'</td>';
			if($loainhapxuat == "phieunhapnguyenlieu")
				$row .= '<td>'.$this->document->getPhieuNhapXuat($item['maphieu']).'</td>';	
			else
				$row .= '<td>'.$this->document->getPhieuNhapXuat($item['phieuxuat']).'</td>';	
			$row .= '<td>'.$this->document->getNguyenLieu($item['itemid']).'</td>';	
			$row .= '<td>'.$item['itemname'].'</td>';
			
			$row .= '<td class="number">'.$this->string->numberFormate($item['thucnhap'],0).'</td>';
			$row .= '<td>'.$this->document->getDonViTinh($item['madonvi']).'</td>';
			$row .= '<td class="number">'.$this->string->numberFormate($item['dongia'],0).'</td>';
			$row .= '<td class="number">'.$this->string->numberFormate($item['dongia']*$item['thucnhap'],0).'</td>';
			$rows .= '<tr>'.$row.'</tr>';
		}
		
		return $rows;
	}*/
}
?>