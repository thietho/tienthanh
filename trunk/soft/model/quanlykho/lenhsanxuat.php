<?php
class ModelQuanlykhoLenhsanxuat extends Model
{
	public function getItem($id, $where="")
	{
		$sql = "Select `qlklenhsanxuat`.*
									from `qlklenhsanxuat` 
									where id ='".$id."' ".$where;
		$query = $this->db->query($sql);
		return $query->row;
	}

	public function getList($where="", $from=0, $to=0)
	{

		$sql = "Select `qlklenhsanxuat`.*
									from `qlklenhsanxuat` 
									where trangthai <> 'deleted' " . $where . " Order by id";
		if($to > 0)
		{
			$sql .= " Limit ".$from.",".$to;
		}

		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function nextID()
	{
		return $this->db->getNextId('qlklenhsanxuat','id');
	}

	public function insert($data)
	{
		$id= $this->nextID();
		$malenhsanxuat=$this->db->escape(@$data['malenhsanxuat']);
		$nhanvien= $this->db->escape(@$data['nhanvien']);
		$ktvien= $this->db->escape(@$data['ktvien']);
		$lanhdaophong= $this->db->escape(@$data['lanhdaophong']);
		$masanpham= $this->db->escape(@$data['masanpham']);
		$tensanpham= $this->db->escape(@$data['tensanpham']);
		$bmsx07=$this->db->escape(@$data['bmsx07']);
		$nhomsx=$this->db->escape(@$data['nhomsx']);
		$ngaysx=$this->db->escape(@$data['ngaysx']);
		$ngayhoanthanh=$this->db->escape(@$data['ngayhoanthanh']);
		$qdgiaso=$this->db->escape(@$data['qdgiaso']);
		$ngay=$this->db->escape(@$data['ngay']);
		$trongluongsx=$this->db->escape(@$data['trongluongsx']);
		$phutrachchinh=$this->db->escape(@$data['phutrachchinh']);
		$phieucarso=$this->db->escape(@$data['phieucarso']);
		$kcs=$this->db->escape(@$data['kcs']);
		$donggoi=$this->db->escape(@$data['donggoi']);
		$hop=$this->db->escape(@$data['hop']);
		$thung=$this->db->escape(@$data['thung']);
		$nhan=$this->db->escape(@$data['nhan']);
		$xulybavia=$this->db->escape(@$data['xulybavia']);
		$phelieu=$this->db->escape(@$data['phelieu']);
		$phepham=$this->db->escape(@$data['phepham']);
		$thuky=$this->db->escape(@$data['thuky']);
		$truongphong=$this->db->escape(@$data['truongphong']);
		$ngayphatlenh=$this->db->escape(@$data['ngayphatlenh']);
		$nguoitao=$this->db->escape(@$data['nguoitao']);
		$trangthai=$this->db->escape(@$data['trangthai']);
		
		$field=array(

						'malenhsanxuat',
						'nhanvien',
						'ktvien',
						'lanhdaophong',
						'masanpham',
						'tensanpham',
						'bmsx07',
						'nhomsx',
						'ngaysx',
						'ngayhoanthanh',
						'qdgiaso',
						'qdgiaso',
						'ngay',
						'trongluongsx',
						'phutrachchinh',
						'phieucarso',
						'kcs',
						'donggoi',
						'hop',
						'thung',
						'nhan',
						'xulybavia',
						'phelieu',
						'phepham',
						'thuky',
						'truongphong',
						'ngayphatlenh',
						'nguoitao',
						'trangthai'
						);
		$value=array(

						$malenhsanxuat,
						$nhanvien,
						$ktvien,
						$lanhdaophong,
						$masanpham,
						$tensanpham,
						$bmsx07,
						$nhomsx,
						$ngaysx,
						$ngayhoanthanh,
						$qdgiaso,
						$ngay,
						$trongluongsx,
						$phutrachchinh,
						$phieucarso,
						$kcs,
						$donggoi,
						$hop,
						$thung,
						$nhan,
						$xulybavia,
						$phelieu,
						$phepham,
						$thuky,
						$truongphong,
						$ngayphatlenh,
						$nguoitao,
						$trangthai
						);
		$this->db->insertData("qlklenhsanxuat",$field,$value);

		return $id;
	}

	public function update($data)
	{

		$id= $this->db->escape(@$data['id']);
		$malenhsanxuat=$this->db->escape(@$data['malenhsanxuat']);
		$nhanvien= $this->db->escape(@$data['nhanvien']);
		$ktvien= $this->db->escape(@$data['ktvien']);
		$lanhdaophong= $this->db->escape(@$data['lanhdaophong']);
		$masanpham= $this->db->escape(@$data['masanpham']);
		$tensanpham= $this->db->escape(@$data['tensanpham']);
		$bmsx07=$this->db->escape(@$data['bmsx07']);
		$nhomsx=$this->db->escape(@$data['nhomsx']);
		$ngaysx=$this->db->escape(@$data['ngaysx']);
		$ngayhoanthanh=$this->db->escape(@$data['ngayhoanthanh']);
		$qdgiaso=$this->db->escape(@$data['qdgiaso']);
		$ngay=$this->db->escape(@$data['ngay']);
		$trongluongsx=$this->db->escape(@$data['trongluongsx']);
		$phutrachchinh=$this->db->escape(@$data['phutrachchinh']);
		$phieucarso=$this->db->escape(@$data['phieucarso']);
		$kcs=$this->db->escape(@$data['kcs']);
		$donggoi=$this->db->escape(@$data['donggoi']);
		$hop=$this->db->escape(@$data['hop']);
		$thung=$this->db->escape(@$data['thung']);
		$nhan=$this->db->escape(@$data['nhan']);
		$xulybavia=$this->db->escape(@$data['xulybavia']);
		$phelieu=$this->db->escape(@$data['phelieu']);
		$phepham=$this->db->escape(@$data['phepham']);
		$thuky=$this->db->escape(@$data['thuky']);
		$truongphong=$this->db->escape(@$data['truongphong']);
		$ngayphatlenh=$this->db->escape(@$data['ngayphatlenh']);
		$nguoitao=$this->db->escape(@$data['nguoitao']);
		$trangthai=$this->db->escape(@$data['trangthai']);
		$field=array(

						'malenhsanxuat',
						'nhanvien',
						'ktvien',
						'lanhdaophong',
						'masanpham',
						'tensanpham',
						'bmsx07',
						'nhomsx',
						'ngaysx',
						'ngayhoanthanh',
						'qdgiaso',
						'qdgiaso',
						'ngay',
						'trongluongsx',
						'phutrachchinh',
						'phieucarso',
						'kcs',
						'donggoi',
						'hop',
						'thung',
						'nhan',
						'xulybavia',
						'phelieu',
						'phepham',
						'thuky',
						'truongphong',
						'ngayphatlenh',
						'nguoitao',
						'trangthai'
						);
		$value=array(
						
						$malenhsanxuat,
						$nhanvien,
						$ktvien,
						$lanhdaophong,
						$masanpham,
						$tensanpham,
						$bmsx07,
						$nhomsx,
						$ngaysx,
						$ngayhoanthanh,
						$qdgiaso,
						$ngay,
						$trongluongsx,
						$phutrachchinh,
						$phieucarso,
						$kcs,
						$donggoi,
						$hop,
						$thung,
						$nhan,
						$xulybavia,
						$phelieu,
						$phepham,
						$thuky,
						$truongphong,
						$ngayphatlenh,
						$nguoitao,
						$trangthai
						);

		$where="id = '".$id."'";
		$this->db->updateData("qlklenhsanxuat",$field,$value,$where);

		return true;
	}

	public function updateStatus($id,$status)
	{
		$id= $this->db->escape(@$id);
		$status= $this->db->escape(@$status);
		$field=array(

						'trangthai'
						);
						$value=array(


						$status
						);

						$where="id = '".$id."'";
						$this->db->updateData("qlklenhsanxuat",$field,$value,$where);
	}

	public function delete($id)
	{
		/*$where="id = '".$id."'";
		 $this->db->deleteData("qlklenhsanxuat",$where);*/
		$this->updateStatus($id,'deleted');
		$child = $this->getChild($id);
		if(count($child))
		foreach($child as $item)
		{
			$this->delete($item['id']);
		}
	}

	public function deletedatas($listid)
	{
		foreach($listid as $item)
		{
			$this->delete($item);
		}
	}
	//Lenh san xuat cong dong
	public function getLenhSanXuatCongDoan($id)
	{
		$sql = "Select `qlklenhsanxuat_congdoan`.*
									from `qlklenhsanxuat_congdoan` 
									where id ='".$id."' ".$where;
		$query = $this->db->query($sql);
		return $query->row;
	}

	public function getLenhSanXuatCongDoans($where="", $from=0, $to=0)
	{

		$sql = "Select `qlklenhsanxuat_congdoan`.*
									from `qlklenhsanxuat_congdoan` 
									where 1=1 " . $where;
		if($to > 0)
		{
			$sql .= " Limit ".$from.",".$to;
		}

		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function deleteLenhSanXuatCongDoan($id)
	{
		$where="id = '".$id."'";
		$this->db->deleteData("qlklenhsanxuat_congdoan",$where);

	}

	public function saveLenhSanXuatCongDoan($data)
	{
		$id= (int)@$data['id'];
		$lenhsanxuatid= $this->db->escape(@$data['lenhsanxuatid']);
		$congdoanid= $this->db->escape(@$data['congdoanid']);
		$lotnl = $this->db->escape(@$data['lotnl']);
		$bmsx01so = $this->db->escape(@$data['bmsx01so']);
		$soluong = $this->string->toNumber($this->db->escape(@$data['soluong']));
		$dongia = $this->string->toNumber($this->db->escape(@$data['dongia']));
		$chitieutp = $this->string->toNumber($this->db->escape(@$data['chitieutp']));
		$chitieupl = $this->string->toNumber($this->db->escape(@$data['chitieupl']));
		$chitieupp = $this->string->toNumber($this->db->escape(@$data['chitieupp']));
		
		$field=array(

						'lenhsanxuatid',
						'congdoanid',
						'lotnl',
						'bmsx01so',
						'soluong',
						'dongia',
						'chitieutp',
						'chitieupl',
						'chitieupp'
						
						);
		$value=array(

						$lenhsanxuatid,
						$congdoanid,
						$lotnl,
						$bmsx01so,
						$soluong,
						$dongia,
						$chitieutp,
						$chitieupl,
						$chitieupp
						);

						if($id == "" )
						{
							//$value[0] = $id;
							$this->db->insertData("qlklenhsanxuat_congdoan",$field,$value);
						}
						else
						{
							$where="id = '".$id."'";
							$this->db->updateData("qlklenhsanxuat_congdoan",$field,$value,$where);
						}

						return $id;
	}
	
	function updateLenhSanXuatCongDoan($id,$col,$val)
	{
		$id= (int)@$id;
		$col= $this->db->escape(@$col);
		$val= $this->db->escape(@$val);
		$field=array(
						$col	
						);
		$value=array(
						$val
						);
		$where="id = '".$id."'";
		$this->db->updateData("qlklenhsanxuat_congdoan",$field,$value,$where);
	}

}
?>