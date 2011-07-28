<?php
$this->load->model("quanlykho/phieu");
$this->load->model("quanlykho/khachhang");
class ModelQuanlykhoPhieuYeuCau extends ModelQuanlykhoPhieu
{ 
	public function getPhieuYeuCau($maphieu)
	{
		$item = $this->getItem($maphieu);
		
		//phieu yeu cau
		$data['maphieu'] = $item['maphieu'];
		$data['ngaylap'] = $item['ngaylap'];
		$data['loaiphieu'] = $item['loaiphieu'];
		$data['makhachhang'] = $item['makhachhang'];
		$data['nhanvientiepnhan'] = $item['nhanvientiepnhan'];
		$data['trangthai'] = $item['trangthai'];
		
		//chi tiet phieu yeu cau
		$maphieu = $data['maphieu'];
		if(strlen($data['makhachhang']) > 0)
		{
			$kh =  $this->model_quanlykho_khachhang->getItem($data['makhachhang']);
			$data['tenkhachhang'] = $kh['hoten'];
		}
		else
		{
			$data['tenkhachhang'] =  $this->getPhieuInfo($maphieu, 'tenkhachhang');
		}
		$data['nhanvienxuly'] =  $this->getPhieuInfo($maphieu, 'nhanvienxuly');
		$data['dienthoai'] =  $this->getPhieuInfo($maphieu, 'dienthoai');
		$data['hinhthuc'] = $this->getPhieuInfo($maphieu, 'hinhthuc');
		$data['noidungyeucau'] = $this->getPhieuInfo($maphieu, 'noidungyeucau');
		$data['ngayhen'] = $this->getPhieuInfo($maphieu, 'ngayhen');
		$data['noidungphanhoi'] = $this->getPhieuInfo($maphieu, 'noidungphanhoi');
		return $data;
	}
	
	public function getPhieuYeuCaus($where)
	{
		$datas = $this->getList(" AND loaiphieu='pyc' " . $where, " order by ngaylap desc");
		
		$objs = array();
		if(count($datas))
			foreach($datas as $item)
			{
				//phieu yeu cau
				$data['maphieu'] = $item['maphieu'];
				$data['ngaylap'] = $item['ngaylap'];
				$data['loaiphieu'] = $item['loaiphieu'];
				$data['makhachhang'] = $item['makhachhang'];
				$data['nhanvientiepnhan'] = $item['nhanvientiepnhan'];
				$data['trangthai'] = $item['trangthai'];
				
				//chi tiet phieu yeu cau
				$maphieu = $data['maphieu'];
				if(strlen($data['makhachhang']) > 0)
				{
					$kh =  $this->model_quanlykho_khachhang->getItem($data['makhachhang']);
					$data['tenkhachhang'] = $kh['hoten'];
				}
				else
				{
					$data['tenkhachhang'] =  $this->getPhieuInfo($maphieu, 'tenkhachhang');
				}
				$data['nhanvienxuly'] =  $this->getPhieuInfo($maphieu, 'nhanvienxuly');
				$data['dienthoai'] =  $this->getPhieuInfo($maphieu, 'dienthoai');
				$data['hinhthuc'] = $this->getPhieuInfo($maphieu, 'hinhthuc');
				$data['noidungyeucau'] = $this->getPhieuInfo($maphieu, 'noidungyeucau');
				$data['ngayhen'] = $this->getPhieuInfo($maphieu, 'ngayhen');
				$data['noidungphanhoi'] = $this->getPhieuInfo($maphieu, 'noidungphanhoi');
				$objs[] = $data;
			}
		
		return $objs;
	}
	
	public function savePhieuYeuCau($data)
	{
		$data["loaiphieu"] = "pyc";
		
		//kiem tra phieu co ton tai chua?
		$item = $this->getItem($data['maphieu']);
		if(count($item) == 0)
		{
			$data['maphieu'] = $this->nextID("phieu");
			$this->insert($data);
		}
		else
		{
			$this->update($data);
		}
			
		//save chi tiet phieu yeu cau	
		
		$this->savePhieuInfo($data['maphieu'], 'tenkhachhang', $data['tenkhachhang']);
		$this->savePhieuInfo($data['maphieu'], 'nhanvienxuly', $data['nhanvienxuly']);
		$this->savePhieuInfo($data['maphieu'], 'dienthoai', $data['dienthoai']);
		$this->savePhieuInfo($data['maphieu'], 'hinhthuc', $data['hinhthuc']);
		$this->savePhieuInfo($data['maphieu'], 'noidungyeucau', $data['noidungyeucau']);
		$this->savePhieuInfo($data['maphieu'], 'ngayhen', $data['ngayhen']);
		$this->savePhieuInfo($data['maphieu'], 'noidungphanhoi', $data['noidungphanhoi']);
		
		if($data['nhanvienxuly'] != "")
			$this->model_quanlykho_phieu->updateTrangThai($item['maphieu'], 'completed');
	}
	
	public function deletePhieuYeuCau($maphieu)
	{
		$this->updateTrangThai($maphieu, 'deleted');	
	}
	
	public function deleteListPhieuYeuCau($listmaphieu)
	{
		$this->deletedatas($listmaphieu);
	}
}
?>