<?php

class ModelQuanlykhoNhacungung extends Model
{
	public function getItem($id, $where="")
	{
		$sql = "Select `qlknhacungung`.*
									from `qlknhacungung` 
									where id ='".$id."' ".$where;
		$query = $this->db->query($sql);
		return $query->row;
	}

	public function getList($where="", $from=0, $to=0)
	{

		$sql = "Select `qlknhacungung`.*
									from `qlknhacungung` 
									where trangthai <> 'deleted' " . $where . " Order by id";
		if($to > 0)
		{
			$sql .= " Limit ".$from.",".$to;
		}

		$query = $this->db->query($sql);
		return $query->rows;
	}

	private function nextID()
	{
		return $this->db->getNextId('qlknhacungung','id');
	}

	public function insert($data)
	{
		$id= $this->nextID();
		$manhacungung=$this->db->escape(@$data['manhacungung']);
		$tennhacungung=$this->db->escape(@$data['tennhacungung']);
		$diachi= $this->db->escape(@$data['diachi']);
		$dienthoai= $this->db->escape(@$data['dienthoai']);
		$fax=$this->db->escape(@$data['fax']);
		$ngaybatdaugiaodich=$this->db->escape(@$data['ngaybatdaugiaodich']);
		$manhom=$this->db->escape(@$data['manhom']);
		$nganhnghe=$this->db->escape(@$data['nganhnghe']);
		$khuvuc=$this->db->escape(@$data['khuvuc']);
		$tennguoidungdau=$this->db->escape(@$data['tennguoidungdau']);
		$hieulucdenngay=$this->db->escape(@$data['hieulucdenngay']);
		$ngaydanhgialai=$this->db->escape(@$data['ngaydanhgialai']);
		$danhgiasoluong=$this->db->escape(@$data['danhgiasoluong']);
		$danhgiachatluong=$this->db->escape(@$data['danhgiachatluong']);
		$danhgiathoigian=$this->db->escape(@$data['danhgiathoigian']);
		$danhgiathanhtoan=$this->db->escape(@$data['danhgiathanhtoan']);
		$ghichu=$this->db->escape(@$data['ghichu']);


		$field=array(

						'manhacungung',
						'tennhacungung',
						'diachi',
						'dienthoai',
						'fax',
						'ngaybatdaugiaodich',
						'manhom',
						'nganhnghe',
						'khuvuc',
						'tennguoidungdau',
						'hieulucdenngay',
						'ngaydanhgialai',
						'danhgiasoluong',
						'danhgiachatluong',
						'danhgiathoigian',
						'danhgiathanhtoan',
						'ghichu',
						'trangthai'
						);
						$value=array(

						$manhacungung,
						$tennhacungung,
						$diachi,
						$dienthoai,
						$fax,
						$ngaybatdaugiaodich,
						$manhom,
						$nganhnghe,
						$khuvuc,
						$tennguoidungdau,
						$hieulucdenngay,
						$ngaydanhgialai,
						$danhgiasoluong,
						$danhgiachatluong,
						$danhgiathoigian,
						$danhgiathanhtoan,
						$ghichu,
						"active"
						);
						$this->db->insertData("qlknhacungung",$field,$value);

						return $id;
	}

	public function update($data)
	{

		$id= $this->db->escape(@$data['id']);
		$manhacungung=$this->db->escape(@$data['manhacungung']);
		$tennhacungung=$this->db->escape(@$data['tennhacungung']);
		$diachi= $this->db->escape(@$data['diachi']);
		$dienthoai= $this->db->escape(@$data['dienthoai']);
		$fax=$this->db->escape(@$data['fax']);
		$ngaybatdaugiaodich=$this->db->escape(@$data['ngaybatdaugiaodich']);
		$manhom=$this->db->escape(@$data['manhom']);
		$nganhnghe=$this->db->escape(@$data['nganhnghe']);
		$khuvuc=$this->db->escape(@$data['khuvuc']);
		$tennguoidungdau=$this->db->escape(@$data['tennguoidungdau']);
		$hieulucdenngay=$this->db->escape(@$data['hieulucdenngay']);
		$ngaydanhgialai=$this->db->escape(@$data['ngaydanhgialai']);
		$danhgiasoluong=$this->db->escape(@$data['danhgiasoluong']);
		$danhgiachatluong=$this->db->escape(@$data['danhgiachatluong']);
		$danhgiathoigian=$this->db->escape(@$data['danhgiathoigian']);
		$danhgiathanhtoan=$this->db->escape(@$data['danhgiathanhtoan']);
		$ghichu=$this->db->escape(@$data['ghichu']);


		$field=array(

						'manhacungung',
						'tennhacungung',
						'diachi',
						'dienthoai',
						'fax',
						'ngaybatdaugiaodich',
						'manhom',
						'nganhnghe',
						'khuvuc',
						'tennguoidungdau',
						'hieulucdenngay',
						'ngaydanhgialai',
						'danhgiasoluong',
						'danhgiachatluong',
						'danhgiathoigian',
						'danhgiathanhtoan',
						'ghichu',
						'trangthai'
						);
						$value=array(

						$manhacungung,
						$tennhacungung,
						$diachi,
						$dienthoai,
						$fax,
						$ngaybatdaugiaodich,
						$manhom,
						$nganhnghe,
						$khuvuc,
						$tennguoidungdau,
						$hieulucdenngay,
						$ngaydanhgialai,
						$danhgiasoluong,
						$danhgiachatluong,
						$danhgiathoigian,
						$danhgiathanhtoan,
						$ghichu,
						"active"
						);

						$where="id = '".$id."'";
						$this->db->updateData("qlknhacungung",$field,$value,$where);
						return true;
	}

	public function delete($id)
	{

		$field=array(

						'trangthai'
						);
						$value=array(


						'deleted'
						);

						$where="id = '".$id."'";
						$this->db->updateData("qlknhacungung",$field,$value,$where);
	}

	public function deletedatas($listid)
	{
		foreach($listid as $item)
		{
			$this->delete($item);
		}
	}
	//Danh gia nha cung ung
	public function getDanhGiaNhaCungUng($id)
	{
		$sql = "Select `qlkdanhgianhacungung`.*
									from `qlkdanhgianhacungung` 
									where id ='".$id."' ".$where;
		$query = $this->db->query($sql);
		return $query->row;
	}

	public function getDanhGiaNhaCungUngList($where="", $from=0, $to=0)
	{

		$sql = "Select `qlkdanhgianhacungung`.*
									from `qlkdanhgianhacungung` 
									where 1=1 " . $where . " Order by id";
		if($to > 0)
		{
			$sql .= " Limit ".$from.",".$to;
		}

		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function saveDanhGiaNhaCungUng($data)
	{

		$id=(int)@$data['id'];
		$manhacungung=$this->db->escape(@$data['manhacungung']);
		$ngaydanhgia=$this->db->escape(@$data['ngaydanhgia']);
		$danhgiasoluong=$this->db->escape(@$data['danhgiasoluong']);
		$danhgiachatluong=$this->db->escape(@$data['danhgiachatluong']);
		$danhgiathoigian=$this->db->escape(@$data['danhgiathoigian']);
		$danhgiathanhtoan=$this->db->escape(@$data['danhgiathanhtoan']);

		$field=array(

						'manhacungung',
						'ngaydanhgia',
						'danhgiasoluong',
						'danhgiachatluong',
						'danhgiathoigian',
						'danhgiathanhtoan'
						);
						$value=array(

						$manhacungung,
						$ngaydanhgia,
						$danhgiasoluong,
						$danhgiachatluong,
						$danhgiathoigian,
						$danhgiathanhtoan

						);

						if($id == 0 )
						{
							$this->db->insertData("qlkdanhgianhacungung",$field,$value);
							//Cap nhat danh gia cho nha cung ung
							$ngaydanhgialai = $ngaydanhgia;
								
							$field=array(
								
								
							'ngaydanhgialai',
							'danhgiasoluong',
							'danhgiachatluong',
							'danhgiathoigian',
							'danhgiathanhtoan'
							
							);
							$value=array(
								
								
							$ngaydanhgialai,
							$danhgiasoluong,
							$danhgiachatluong,
							$danhgiathoigian,
							$danhgiathanhtoan
								
							);
								
							$where=" id = '".$manhacungung."'";
							$this->db->updateData("qlknhacungung",$field,$value,$where);
								
						}
						else
						{
							$where="id = '".$id."'";
							$this->db->updateData("qlkdanhgianhacungung",$field,$value,$where);
						}
	}

	public function deleteDanhGiaNhaCungUng($id)
	{
		$where="id = '".$id."'";
		$this->db->deleteData("qlkdanhgianhacungung",$where);
	}
	//Phieu nhan hang
	public function getPhieuNhanHang($id)
	{
		$sql = "Select `qlkphieunhanhang`.*
									from `qlkphieunhanhang` 
									where id ='".$id."' ".$where;
		$query = $this->db->query($sql);
		return $query->row;
	}

	public function getPhieuNhanHangList($where="", $from=0, $to=0)
	{

		$sql = "Select `qlkphieunhanhang`.*
									from `qlkphieunhanhang` 
									where trangthai <> 'deleted' " . $where . " Order by id";
		if($to > 0)
		{
			$sql .= " Limit ".$from.",".$to;
		}

		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function savePhieuNhanHang($data)
	{
		$id=(int)@$data['id'];
		$maphieunhanhang=$this->db->escape(@$data['maphieunhanhang']);
		$manhacungung=$this->db->escape(@$data['manhacungung']);
		$mahopdong=$this->db->escape(@$data['mahopdong']);
		$langiao=$this->db->escape(@$data['langiao']);
		$manhanviennhanhang=$this->db->escape(@$data['manhanviennhanhang']);
		$ngaygiao=$this->db->escape(@$data['ngaygiao']);
		$danhgiasoluong=$this->db->escape(@$data['danhgiasoluong']);
		$danhgiachatluong=$this->db->escape(@$data['danhgiachatluong']);
		$danhgiathoigian=$this->db->escape(@$data['danhgiathoigian']);
		$danhgiathanhtoan=$this->db->escape(@$data['danhgiathanhtoan']);
		$tinhtrangthanhtoan=$this->db->escape(@$data['tinhtrangthanhtoan']);
		$ghichu=$this->db->escape(@$data['ghichu']);

		$field=array(

						'maphieunhanhang',
						'manhacungung',
						'mahopdong',
						'langiao',
						'manhanviennhanhang',
						'ngaygiao',
						'danhgiasoluong',
						'danhgiachatluong',
						'danhgiathoigian',
						'danhgiathanhtoan',
						'tinhtrangthanhtoan',
						'ghichu',
						'trangthai'
						);
						$value=array(

						$maphieunhanhang,
						$manhacungung,
						$mahopdong,
						$langiao,
						$manhanviennhanhang,
						$ngaygiao,
						$danhgiasoluong,
						$danhgiachatluong,
						$danhgiathoigian,
						$danhgiathanhtoan,
						$ghichu,
						'active'
						
						);

						if($id == 0 )
						{
							$this->db->insertData("qlkphieunhanhang",$field,$value);
						}
						else
						{
							$where="id = '".$id."'";
							$this->db->updateData("qlkphieunhanhang",$field,$value,$where);
						}
	}

	public function deletePhieuNhanHang($id)
	{
		$field=array(

						'trangthai'
						);
						$value=array(


						'deleted'
						);

						$where="id = '".$id."'";
						$this->db->updateData("qlknhacungung",$field,$value,$where);

	}
	//Chi tiet phieu nhan hang
	public function getChiTietPhieuNhanHang($id)
	{
		$sql = "Select `qlkphieunhanhang_chitiet`.*
									from `qlkphieunhanhang_chitiet` 
									where id ='".$id."' ".$where;
		$query = $this->db->query($sql);
		return $query->row;
	}

	public function getChiTietPhieuNhanHangList($where="", $from=0, $to=0)
	{

		$sql = "Select `qlkphieunhanhang_chitiet`.*
									from `qlkphieunhanhang_chitiet` 
									where 1=1 " . $where . " Order by id";
		if($to > 0)
		{
			$sql .= " Limit ".$from.",".$to;
		}

		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function saveChiTietPhieuNhanHang($data)
	{
		$id=(int)@$data['id'];
		$maphieunhanhang=$this->db->escape(@$data['maphieunhanhang']);
		$manguyenlieu=$this->db->escape(@$data['manguyenlieu']);
		$tennguyenlieu=$this->db->escape(@$data['tennguyenlieu']);
		$soluong=$this->db->escape(@$data['soluong']);
		$dongia=$this->db->escape(@$data['dongia']);
		$danhgiachatluong=$this->db->escape(@$data['danhgiachatluong']);
		$soluongnhan=$this->db->escape(@$data['soluongnhan']);
		$soluongtralai=$this->db->escape(@$data['soluongtralai']);

		$field=array(

						'maphieunhanhang',
						'manhacungung',
						'mahopdong',
						'langiao',
						'manhanviennhanhang',
						'ngaygiao',
						'danhgiasoluong',
						'danhgiachatluong',
						'danhgiathoigian',
						'danhgiathanhtoan',
						'tinhtrangthanhtoan',
						'ghichu',
						'trangthai'
						);
						$value=array(

						$maphieunhanhang,
						$manhacungung,
						$mahopdong,
						$langiao,
						$manhanviennhanhang,
						$ngaygiao,
						$danhgiasoluong,
						$danhgiachatluong,
						$danhgiathoigian,
						$danhgiathanhtoan,
						$ghichu,
						'active'
						
						);

						if($id == 0 )
						{
							$this->db->insertData("qlkphieunhanhang_chitiet",$field,$value);
						}
						else
						{
							$where="id = '".$id."'";
							$this->db->updateData("qlkphieunhanhang_chitiet",$field,$value,$where);
						}
	}

	public function deleteChiTietPhieuNhanHang($id)
	{
		$where="id = '".$id."'";
		$this->db->deleteData("qlkphieunhanhang_chitiet",$where);

	}

}
?>