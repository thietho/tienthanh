<?php
class ModelBmBmtn14 extends Model 
{
	private $columns = array(
								'sophieu',
								'ngaylapphieu',
								'nhanvienlap',
								'itemtype',
								'itemid',
								'itemcode',
								'itemname',
								'kyhieu',
								'tinhtrangmau',
								'moitruongthunghiem',
								'ngayycrakqcheptay',
								'ngayycgiaokqcheptay',
								'nhanvienthuchien',
								'ngaythuchien',
								'danhgiakq'
								
							);
	public function getList($where = "")
	{
		$sql = "Select `bmtn14`.* from `bmtn14` where 1=1 ".$where;
		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function getItem($id)
	{
		$sql = "Select * from `bmtn14` where id = '".$id."'";
		$query = $this->db->query($sql);
		return $query->row;
	}
	
	private function creatsophieu($prefix)
	{
		$mun = $this->db->getNextIdVarCharNumber('bmtn14','sophieu',$prefix);
		return $mun.$prefix;
	}
	
	public function insert($data)
	{
		
		$data['sophieu']=$this->creatsophieu('-KN');
		
		$data['ngayphieugiaohang']=$this->db->escape(@$this->date->formatViewDate($data['ngayphieugiaohang']));
		$data['ngaykehoachdathang']=$this->db->escape(@$this->date->formatViewDate($data['ngaykehoachdathang']));
		$data['ngaylapphieu'] = $this->date->getToday();
		$nhanvien = $this->user->getNhanVien();
		$data['nhanvienlap'] = $nhanvien['id'];
		foreach($this->columns as $val)
		{			
			$field[] = $val;
			$value[] = $this->db->escape($data[$val]);	
			
		}
		
		$getLastId = $this->db->insertData("bmtn14",$field,$value);
		return $getLastId;
	}
	
	
	public function update($data)
	{	
		$data['ngayphieugiaohang']=$this->db->escape(@$this->date->formatViewDate($data['ngayphieugiaohang']));
		$data['ngaykehoachdathang']=$this->db->escape(@$this->date->formatViewDate($data['ngaykehoachdathang']));
		foreach($this->columns as $val)
		{
	
			if(isset($data[$val]))
			{
				$field[] = $val;
				$value[] = $this->db->escape($data[$val]);	
			}
		}
					
		$where="id = '".$data['id']."'";
		$this->db->updateData("bmtn14",$field,$value,$where);
	}	
		
	public function updateCol($id,$col,$val)
	{
		$id=$this->db->escape(@$id);
		$col=$this->db->escape(@$col);
		$val=$this->db->escape(@$val);
		$field=array(
						$col
					);
		$value=array(
						$val
					);
					
		$where="id = '".$id."'";
		$this->db->updateData("bmtn14",$field,$value,$where);
	}
	
	//Xóa phieu
	public function delete($id)
	{
		$where="id = '".$id."'";
		$this->db->deleteData('bmtn14',$where);
		$where="bmtn14id = '".$id."'";
		$this->db->updateData('bmtn14_chitiet',$field,$value,$where);
		
	}
	//chi tiet phieu
	public function getBMTN14ChiTiet($id)
	{
		$sql = "Select * 
						from `bmtn14_chitiet` 
						where id ='".$id."'";
		$query = $this->db->query($sql);
		return $query->row;	
	}
	
	public function getBMTN14ChiTietList($where)
	{
		$sql = "Select `bmtn14_chitiet`.* 
									from `bmtn14_chitiet` 
									where 1=1 " . $where ;
		
		$query = $this->db->query($sql);
		return $query->rows;
	}
	
	public function saveBMTN14ChiTiet($data)
	{
		$data['bmtn14id'] = $this->db->escape(@$data['bmtn14id']);
		$data['tieuchikiemtraid'] = $this->db->escape(@$data['tieuchikiemtraid']);
		$data['madonvi'] = $this->db->escape(@$data['madonvi']);
		$data['ketqua'] = $this->db->escape(@$data['ketqua']);
		$data['mucchatluong'] = $this->db->escape(@$data['mucchatluong']);
		
		foreach($data as $key => $val)
		{
			if($val!="")
			{
				$field[] = $key;
				$value[] = $this->db->escape($val);	
			}
		}		
		
		if((int)$data['id']==0)
		{
			
			$this->db->insertData("bmtn14_chitiet",$field,$value);
			$id = $this->db->getLastId();
		}
		else
		{			
			$where="id = '".$data['id']."'";
			$this->db->updateData('bmtn14_chitiet',$field,$value,$where);
		}
		return $id;
	}
	
	public function updateBMTN14ChiTiet($id,$col,$val)
	{
		$id = $this->db->escape(@$id);
		$col=$this->db->escape(@$col);
		$val=$this->db->escape(@$val);
		
		$field=array(
						$col
						
					);
		$value=array(
						$val
					);
		
		$where="id = '".$id."'";
		$this->db->updateData('bmtn14_chitiet',$field,$value,$where);
	}
		
	public function deleteBMTN14ChiTiet($id)
	{
		$id = $this->db->escape(@$id);		
		$where="id = '".$id."'";
		$this->db->deleteData('bmtn14_chitiet',$where);
	}
}
?>