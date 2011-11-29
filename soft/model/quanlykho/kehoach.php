<?php
class ModelQuanlykhoKehoach extends Model
{ 
	public function getItem($id, $where="")
	{
		$sql = "Select `qlkkehoach`.* 
									from `qlkkehoach` 
									where id ='".$id."' ".$where;
		$query = $this->db->query($sql);
		return $query->row;
	}
	
	public function getList($where="", $from=0, $to=0)
	{
		
		$sql = "Select `qlkkehoach`.* 
									from `qlkkehoach` 
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
		return $this->db->getNextId('qlkkehoach','id');
	}
	
	public function insert($data)
	{
		$id= $this->nextID();
		$makehoach=$this->db->escape(@$data['makehoach']);
		$tenkehoach= $this->db->escape(@$data['tenkehoach']);
		$ngaybatdau= $this->db->escape(@$data['ngaybatdau']);
		$ngayketthuc= $this->db->escape(@$data['ngayketthuc']);
		$loai= $this->db->escape(@$data['loai']);
		$nam= $this->db->escape(@$data['nam']);
		$quy=$this->db->escape(@$data['quy']);
		$thang=$this->db->escape(@$data['thang']);
		
		$kehoachcha=$this->db->escape(@$data['kehoachcha']);
		$ghichu=$this->db->escape(@$data['ghichu']);
		
		
		$field=array(
						
						'makehoach',
						'tenkehoach',
						'ngaybatdau',
						'ngayketthuc',
						'loai',
						'nam',
						'quy',
						'thang',
						
						
						'kehoachcha',
						'ghichu',
						'trangthai'
						
					);
		$value=array(
						
						$makehoach,
						$tenkehoach,
						$ngaybatdau,
						$ngayketthuc,
						$loai,
						$nam,
						$quy,
						$thang,
						
						
						$kehoachcha,
						$ghichu,
						'active'
					);
		$this->db->insertData("qlkkehoach",$field,$value);
		
		return $id;
	}
	
	public function update($data)
	{
	
		$id= $this->db->escape(@$data['id']);
		$makehoach=$this->db->escape(@$data['makehoach']);
		$tenkehoach= $this->db->escape(@$data['tenkehoach']);
		$ngaybatdau= $this->db->escape(@$data['ngaybatdau']);
		$ngayketthuc= $this->db->escape(@$data['ngayketthuc']);
		$loai= $this->db->escape(@$data['loai']);
		$nam= $this->db->escape(@$data['nam']);
		$quy=$this->db->escape(@$data['quy']);
		$thang=$this->db->escape(@$data['thang']);
		
		$kehoachcha=$this->db->escape(@$data['kehoachcha']);
		$ghichu=$this->db->escape(@$data['ghichu']);
		$trangthai=$this->db->escape(@$data['trangthai']);
		
		$field=array(
						
						'makehoach',
						'tenkehoach',
						'ngaybatdau',
						'ngayketthuc',
						'loai',
						'nam',
						'quy',
						'thang',
						
						
						'kehoachcha',
						'ghichu',
						'trangthai'
						
					);
		$value=array(
						
						$makehoach,
						$tenkehoach,
						$ngaybatdau,
						$ngayketthuc,
						$loai,
						$nam,
						$quy,
						$thang,
						
						
						$kehoachcha,
						$ghichu,
						$trangthai
					);
		
		$where="id = '".$id."'";
		$this->db->updateData("qlkkehoach",$field,$value,$where);
		
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
		$this->db->updateData("qlkkehoach",$field,$value,$where);
	}
	
	public function delete($id)
	{
		/*$where="id = '".$id."'";
		$this->db->deleteData("qlkkehoach",$where);*/
		$this->updateStatus($id,'deleted');
	}
	
	public function deletedatas($listid)
	{
		foreach($listid as $item)
		{
			$this->delete($item);
		}
	}
	//Ke hoach san pham
	public function getKeKhoachSanPham($id)
	{
		$sql = "Select `qlkkehoach_sanpham`.* 
									from `qlkkehoach_sanpham` 
									where id ='".$id."' ".$where;
		$query = $this->db->query($sql);
		return $query->row;
	}
	
	public function getKeKhoachSanPhams($where="", $from=0, $to=0)
	{
		
		$sql = "Select `qlkkehoach_sanpham`.* 
									from `qlkkehoach_sanpham` 
									where 1=1 " . $where;
		if($to > 0)
		{
			$sql .= " Limit ".$from.",".$to;
		}
		
		$query = $this->db->query($sql);
		return $query->rows;
	}
	
	public function deleteKeKhoachSanPham($id)
	{
		$where="id = '".$id."'";
		$this->db->deleteData("qlkkehoach_sanpham",$where);
		
	}
	
	public function saveKeHoachSanPham($data)
	{
		$id= (int)@$data['id'];
		$makehoach= $this->db->escape(@$data['makehoach']);
		$masanpham= $this->db->escape(@$data['masanpham']);
		$tensanpham = $this->db->escape(@$data['tensanpham']);
		$soluongtonhientai = $this->string->toNumber($this->db->escape(@$data['soluongtonhientai']));
		$sosanphamtrenlot = $this->string->toNumber($this->db->escape(@$data['sosanphamtrenlot']));
		$soluong = $this->string->toNumber($this->db->escape(@$data['soluong']));
		$solot=$this->string->toNumber($this->db->escape(@$data['solot']));
		$dongia=$this->string->toNumber($this->db->escape(@$data['dongia']));
		$thanhtien= $soluong * $dongia;
		$pheduyet= @(int)$data['pheduyet'];
		$phuchu = $this->db->escape(@$data['phuchu']);
		$field=array(
						
						'makehoach',
						'masanpham',
						'tensanpham',
						'soluongtonhientai',
						'sosanphamtrenlot',
						'soluong',
						'solot',
						'dongia',
						'thanhtien',
						'pheduyet',
						'phuchu'
						
					);
		$value=array(
						
						$makehoach,
						$masanpham,
						$tensanpham,
						$soluongtonhientai,
						$sosanphamtrenlot,
						$soluong,
						$solot,
						$dongia,
						$thanhtien,
						$pheduyet,
						$phuchu
					);
		
		if($id == "" )
		{
			//$value[0] = $id;
			$this->db->insertData("qlkkehoach_sanpham",$field,$value);
		}
		else
		{
			$where="id = '".$id."'";
			$this->db->updateData("qlkkehoach_sanpham",$field,$value,$where);
		}
		
		return $id;
	}
	
}
?>