<?php

class ModelQuanlykhoKhachHang extends Model
{ 
	public function getItem($id, $where="")
	{
		$sql = "Select `qlkkhachhang`.* 
									from `qlkkhachhang` 
									where id ='".$id."' ".$where;
		$query = $this->db->query($sql);
		return $query->row;
	}
	
	public function getList($where="", $from=0, $to=5)
	{
		
		$sql = "Select `qlkkhachhang`.* 
									from `qlkkhachhang` 
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
		return $this->db->getNextId('qlkkhachhang','id');
	}
	
	public function insert($data)
	{
		$id= $this->nextID();
		$makhachhang=$this->db->escape(@$data['makhachhang']);
		$hoten=$this->db->escape(@$data['hoten']);
		$diachi= $this->db->escape(@$data['diachi']);
		$khuvuc= $this->db->escape(@$data['khuvuc']);
		
		$dienthoai=$this->db->escape(@$data['dienthoai']);
		$fax=$this->db->escape(@$data['fax']);
		$nguoidaidien=$this->db->escape(@$data['nguoidaidien']);
		$loaikhachhang=$this->db->escape(@$data['loaikhachhang']);
		//$trangthai=$this->db->escape(@$data['trangthai']);
		
		$field=array(
						'makhachhang',
						'hoten',
						'diachi',
						'khuvuc',
						
						'dienthoai',
						'fax',
						'nguoidaidien',
						'loaikhachhang',
						'trangthai'
					);
		
		$value=array(
						
						$makhachhang,
						$hoten,
						$diachi,
						$khuvuc,
						
						$dienthoai,
						$fax,
						$nguoidaidien,
						$loaikhachhang,
						"active"
					);
		$this->db->insertData("qlkkhachhang",$field,$value);
		
		return $id;
	}
	
	public function update($data)
	{
	
		$id= (int)@$data['id'];
		$makhachhang=$this->db->escape(@$data['makhachhang']);
		$hoten=$this->db->escape(@$data['hoten']);
		$diachi= $this->db->escape(@$data['diachi']);
		$khuvuc= $this->db->escape(@$data['khuvuc']);
		
		$dienthoai=$this->db->escape(@$data['dienthoai']);
		$fax=$this->db->escape(@$data['fax']);
		$nguoidaidien=$this->db->escape(@$data['nguoidaidien']);
		$loaikhachhang=$this->db->escape(@$data['loaikhachhang']);
		
		$field=array(
						'makhachhang',
						'hoten',
						'diachi',
						'khuvuc',
						
						'dienthoai',
						'fax',
						'nguoidaidien',
						'loaikhachhang',
						'trangthai'
					);
		
		$value=array(
						
						$makhachhang,
						$hoten,
						$diachi,
						$khuvuc,
						
						$dienthoai,
						$fax,
						$nguoidaidien,
						$loaikhachhang,
						"active"
					);
		
		$where="id = '".$id."'";
		$this->db->updateData("qlkkhachhang",$field,$value,$where);
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
		$this->db->updateData("qlkkhachhang",$field,$value,$where);
	}
	
	public function deletedatas($listid)
	{
		foreach($listid as $item)
		{
			$this->delete($item);
		}
	}
}
?>