<?php
class ModelBmBmTn13 extends Model 
{
	private $columns = array(
								'sophieu',
								'nghiemthu',
								'sophieugiaohang',
								'ngayphieugiaohang',
								'tenvattu',
								'nhacungungid',
								'manhacungung',
								'tennhacungung',
								'sokehoachdathang',
								'ngaykehoachdathang',
								'ngaylapphieu',
								'nhanvienlap',
								'tinhtrang'
							);
	public function getList($where = "")
	{
		$sql = "Select `bmtn13`.* from `bmtn13` where 1=1 ".$where;
		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function getItem($id)
	{
		$sql = "Select * from `bmtn13` where id = '".$id."'";
		$query = $this->db->query($sql);
		return $query->row;
	}
	
	private function creatsophieu($prefix)
	{
		$mun = $this->db->getNextIdVarCharNumber('bmtn13','sophieu',$prefix);
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
		
		$getLastId = $this->db->insertData("bmtn13",$field,$value);
		return $getLastId;
	}
	
	
	public function update($data)
	{	
		$data['ngayphieugiaohang']=$this->db->escape(@$this->date->formatViewDate($data['ngayphieugiaohang']));
		$data['ngaykehoachdathang']=$this->db->escape(@$this->date->formatViewDate($data['ngaykehoachdathang']));
		foreach($this->columns as $val)
		{
	
			if($data[$val]!="")
			{
				$field[] = $val;
				$value[] = $this->db->escape($data[$val]);	
			}
		}
					
		$where="id = '".$data['id']."'";
		$this->db->updateData("bmtn13",$field,$value,$where);
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
		$this->db->updateData("bmtn13",$field,$value,$where);
	}
	
	//Xóa phieu
	public function delete($id)
	{
		$where="id = '".$id."'";
		$this->db->deleteData('bmtn13',$where);
		$where="bmtn13id = '".$id."'";
		$this->db->updateData('bmtn13_chitiet',$field,$value,$where);
		
	}
	//chi tiet phieu
	public function getBMTN13ChiTiet($id)
	{
		$sql = "Select * 
						from `bmtn13_chitiet` 
						where id ='".$id."'";
		$query = $this->db->query($sql);
		return $query->row;	
	}
	
	public function getBMTN13ChiTietList($where)
	{
		$sql = "Select `bmtn13_chitiet`.* 
									from `bmtn13_chitiet` 
									where 1=1 " . $where ;
		
		$query = $this->db->query($sql);
		return $query->rows;
	}
	
	public function saveBMTN13ChiTiet($data)
	{
		$data['bmtn13id'] = $this->db->escape(@$data['bmtn13id']);
		$data['itemtype'] = $this->db->escape(@$data['itemtype']);
		$data['itemid'] = $this->db->escape(@$data['itemid']);
		$data['itemcode'] = $this->db->escape(@$data['itemcode']);
		$data['itemname'] = $this->db->escape(@$data['itemname']);
		$data['madonvi'] = $this->db->escape(@$data['madonvi']);
		$data['trongluong']=$this->db->escape(@$this->string->toNumber($data['trongluong']));
		$data['soluong']=$this->db->escape(@$this->string->toNumber($data['soluong']));
		$data['chatluong'] = $this->db->escape(@$data['chatluong']);
		$data['lothang'] = $this->db->escape(@$data['lothang']);
		
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
			
			$this->db->insertData("bmtn13_chitiet",$field,$value);
			$id = $this->db->getLastId();
		}
		else
		{			
			$where="id = '".$data['id']."'";
			$this->db->updateData('bmtn13_chitiet',$field,$value,$where);
		}
		return $id;
	}
	
	public function updateBMTN13ChiTiet($id,$col,$val)
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
		$this->db->updateData('bmtn13_chitiet',$field,$value,$where);
	}
		
	public function deleteBMTN13ChiTiet($id)
	{
		$id = $this->db->escape(@$id);		
		$where="id = '".$id."'";
		$this->db->deleteData('bmtn13_chitiet',$where);
	}
}
?>