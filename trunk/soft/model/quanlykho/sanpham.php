<?php

class ModelQuanlykhoSanpham extends Model
{ 
	public function getItem($id, $where="")
	{
		$sql = "Select `qlksanpham`.* 
									from `qlksanpham` 
									where id ='".$id."' ".$where;
		$query = $this->db->query($sql);
		return $query->row;
	}
	
	public function getSanPham($masanpham, $where="")
	{
		$sql = "Select `qlksanpham`.* 
									from `qlksanpham` 
									where masanpham ='".$masanpham."' ".$where;
		$query = $this->db->query($sql);
		return $query->row;
	}
	
	public function getList($where="", $from=0, $to=0)
	{
		
		$sql = "Select `qlksanpham`.* 
									from `qlksanpham` 
									where trangthai <> 'deleted' " . $where . " Order by id";
		if($to > 0)
		{
			$sql .= " Limit ".$from.",".$to;
		}
		
		$query = $this->db->query($sql);
		return $query->rows;
	}
	
	public function insert($data)
	{
		$id= $this->db->escape(@$data['id']);
		$masanpham=$this->db->escape(@$data['masanpham']);
		$tensanpham=$this->db->escape(@$data['tensanpham']);
		$mavach=$this->db->escape(@$data['mavach']);
		$sosanphamtrenlot= $this->string->toNumber($this->db->escape(@$data['sosanphamtrenlot']));
		$dongiaban= $this->string->toNumber($this->db->escape(@$data['dongiaban']));
		$soluongton= $this->string->toNumber($this->db->escape(@$data['soluongton']));
		$donggoi=$this->string->toNumber($this->db->escape(@$data['donggoi']));
		$khuvuc=$this->string->toNumber($this->db->escape(@$data['khuvuc']));
		$phancap=$this->string->toNumber($this->db->escape(@$data['phancap']));
		$hienhanh=$this->string->toNumber($this->db->escape(@$data['hienhanh']));
		$ghichu=$this->db->escape(@$data['ghichu']);
		$manhom=$this->db->escape(@$data['manhom']);
		$loai=$this->db->escape(@$data['loai']);
		$madonvi=$this->db->escape(@$data['madonvi']);
		$makho=$this->db->escape(@$data['makho']);
		
		$field=array(
						
						'masanpham',
						'tensanpham',
						'mavach',
						'sosanphamtrenlot',
						'dongiaban',
						'soluongton',
						'donggoi',
						'khuvuc',
						'phancap',
						'hienhanh',
						'ghichu',
						'loai',
						'manhom',
						'madonvi',
						'makho',
						'trangthai'
					);
		$value=array(
						
						$masanpham,
						$tensanpham,
						$mavach,
						$sosanphamtrenlot,
						$dongiaban,
						$soluongton,
						$donggoi,
						$khuvuc,
						$phancap,
						$hienhanh,
						$ghichu,
						$loai,
						$manhom,
						$madonvi,
						$makho,
						'active'
					);
		$this->db->insertData("qlksanpham",$field,$value);
		$log['tablename'] = "qlksanpham";
		$log['data'] = $data;
		$this->user->writeLog(json_encode($log));
		return $id;
	}
	
	public function update($data)
	{
	
		$id= $this->db->escape(@$data['id']);
		$masanpham=$this->db->escape(@$data['masanpham']);
		$tensanpham=$this->db->escape(@$data['tensanpham']);
		$mavach=$this->db->escape(@$data['mavach']);
		$sosanphamtrenlot= $this->string->toNumber($this->db->escape(@$data['sosanphamtrenlot']));
		$dongiaban= $this->string->toNumber($this->db->escape(@$data['dongiaban']));
		$soluongton= $this->string->toNumber($this->db->escape(@$data['soluongton']));
		$donggoi=$this->string->toNumber($this->db->escape(@$data['donggoi']));
		$khuvuc=$this->string->toNumber($this->db->escape(@$data['khuvuc']));
		$phancap=$this->string->toNumber($this->db->escape(@$data['phancap']));
		$hienhanh=$this->string->toNumber($this->db->escape(@$data['hienhanh']));
		$ghichu=$this->db->escape(@$data['ghichu']);
		$manhom=$this->db->escape(@$data['manhom']);
		$loai=$this->db->escape(@$data['loai']);
		$madonvi=$this->db->escape(@$data['madonvi']);
		$makho=$this->db->escape(@$data['makho']);
		
		$field=array(
						
						'masanpham',
						'tensanpham',
						'mavach',
						'sosanphamtrenlot',
						'dongiaban',
						'soluongton',
						'donggoi',
						'khuvuc',
						'phancap',
						'hienhanh',
						'ghichu',
						'loai',
						'manhom',
						'madonvi',
						'makho',
						'trangthai'
					);
		$value=array(
						
						$masanpham,
						$tensanpham,
						$mavach,
						$sosanphamtrenlot,
						$dongiaban,
						$soluongton,
						$donggoi,
						$khuvuc,
						$phancap,
						$hienhanh,
						$ghichu,
						$loai,
						$manhom,
						$madonvi,
						$makho,
						'active'
					);
		
		$where="id = '".$id."'";
		$this->db->updateData("qlksanpham",$field,$value,$where);
		$log['tablename'] = "qlksanpham";
		$log['data'] = $data;
		$this->user->writeLog(json_encode($log));
		return true;
	}
	
	public function delete($id)
	{
		/*$where="id = '".$id."'";
		$this->db->deleteData("qlksanpham",$where);*/
		$field=array(
						
						'trangthai'
					);
		$value=array(
						
						
						'deleted'
					);
		
		$where="id = '".$id."'";
		$this->db->updateData("qlksanpham",$field,$value,$where);
	}
	
	public function deletedatas($listid)
	{
		foreach($listid as $item)
		{
			$this->delete($item);
		}
	}
	//Dinh luong linh kien
	public function getDinhLuongLinhKien($malinhkien)
	{
		$where = "AND malinhkien = '".$malinhkien."'";
		return $this->getDinhLuongs($where);
	}
	
	//Dinh luong san pham
	public function getDinhLuong($masanpham)
	{
		$where = "AND masanpham = '".$masanpham."'";
		return $this->getDinhLuongs($where);
	}
	
	
	
	public function getDinhLuongs($where)
	{
		$sql = "Select `qlksanpham_dinhluong`.* 
									from `qlksanpham_dinhluong` 
									where 1=1 ".$where." Order by id";
		
		$query = $this->db->query($sql);
		return $query->rows;
	}
	
	public function getSanPhamDinhLuong($id)
	{
		$sql = "Select `qlksanpham_dinhluong`.* 
									from `qlksanpham_dinhluong` 
									where id ='".$id."' ";
		$query = $this->db->query($sql);
		return $query->row;	
	}
	
	public function saveSanPhamDinhLuong($data)
	{
		$id=(int)@$data['id'];
		$masanpham=$this->db->escape(@$data['masanpham']);
		$malinhkien=$this->db->escape(@$data['malinhkien']);
		$soluong=$this->string->toNumber($this->db->escape(@$data['soluong']));
		
		$field=array(
						
						'masanpham',
						'malinhkien',
						'soluong'
						
					);
		$value=array(
						
						$masanpham,
						$malinhkien,
						$soluong
						
					);
		
		if($id == 0 )
		{
			$this->db->insertData("qlksanpham_dinhluong",$field,$value);
		}
		else
		{
			$where="id = '".$id."'";
			$this->db->updateData("qlksanpham_dinhluong",$field,$value,$where);
		}
		
		
	}
	
	public function deletedSanPhamDinhLuong($id)
	{
		$where="id = '".$id."'";
		$this->db->deleteData("qlksanpham_dinhluong",$where);
	}
	//Chi phi san pham
	public function getChiPhi($masanpham)
	{
		$sql = "Select `sanpham_chiphi`.* 
									from `sanpham_chiphi` 
									where masanpham = '".$masanpham."' Order by id";
		
		$query = $this->db->query($sql);
		return $query->rows;
	}
	
	public function getSanPhamChiPhi($id)
	{
		$sql = "Select `sanpham_chiphi`.* 
									from `sanpham_chiphi` 
									where id ='".$id."' ";
		$query = $this->db->query($sql);
		return $query->row;	
	}
	
	public function saveSanPhamChiPhi($data)
	{
		$id=(int)@$data['id'];
		$masanpham=$this->db->escape(@$data['masanpham']);
		$machiphi=$this->db->escape(@$data['machiphi']);
		$chiphi=$this->string->toNumber($this->db->escape(@$data['chiphi']));
		
		$field=array(
						
						'masanpham',
						'machiphi',
						'chiphi'
						
					);
		$value=array(
						
						$masanpham,
						$machiphi,
						$chiphi
						
					);
		
		if($id == 0 )
		{
			$this->db->insertData("sanpham_chiphi",$field,$value);
		}
		else
		{
			$where="id = '".$id."'";
			$this->db->updateData("sanpham_chiphi",$field,$value,$where);
		}
		
		
	}
	
	public function deletedSanPhamChiPhi($id)
	{
		$where="id = '".$id."'";
		$this->db->deleteData("sanpham_chiphi",$where);
	}
}
?>