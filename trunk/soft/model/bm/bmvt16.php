<?php
class ModelBmBmVt16 extends Model 
{
	private $columns = array(
								'sophieu',
								'ngaylapphieu',
								'nhanvienlap',
								
								'sokehoachdathang',
								'ngaykehoachdathang',
								'mathang',
								'soluong'
								
							);
	public function getList($where = "")
	{
		$sql = "Select `bmvt16`.* from `bmvt16` where 1=1 ".$where;
		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function getItem($id)
	{
		$sql = "Select * from `bmvt16` where id = '".$id."'";
		$query = $this->db->query($sql);
		return $query->row;
	}
	
	private function creatsophieu($prefix)
	{
		$mun = $this->db->getNextIdVarCharNumber('bmvt16','sophieu',$prefix);
		return $mun.$prefix;
	}
	
	public function insert($data)
	{
		
		$data['sophieu']=$this->creatsophieu('KV');
		$data['ngaylapphieu'] = $this->date->getToday();
		$nhanvien = $this->user->getNhanVien();
		$data['nhanvienlap'] = $nhanvien['id'];
		$data['ngaykhdathang']=$this->db->escape(@$this->date->formatViewDate($data['ngaykhdathang']));
		
		
		foreach($this->columns as $val)
		{			
			$field[] = $val;
			$value[] = $this->db->escape($data[$val]);	
			
		}
		
		$getLastId = $this->db->insertData("bmvt16",$field,$value);
		return $getLastId;
	}
	
	
	public function update($data)
	{	
		$data['ngaykhdathang']=$this->db->escape(@$this->date->formatViewDate($data['ngaykhdathang']));
		foreach($this->columns as $val)
		{
	
			if(isset($data[$val]))
			{
				$field[] = $val;
				$value[] = $this->db->escape($data[$val]);	
			}
		}
					
		$where="id = '".$data['id']."'";
		$this->db->updateData("bmvt16",$field,$value,$where);
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
		$this->db->updateData("bmvt16",$field,$value,$where);
	}
	
	//Xóa phieu
	public function delete($id)
	{
		$where="id = '".$id."'";
		$this->db->deleteData('bmvt16',$where);
		$where="bmvt16id = '".$id."'";
		$this->db->updateData('bmvt16_chitiet',$field,$value,$where);
		
	}
	//chi tiet phieu
	public function getBMVT16ChiTiet($id)
	{
		$sql = "Select * 
						from `bmvt16_chitiet` 
						where id ='".$id."'";
		$query = $this->db->query($sql);
		return $query->row;	
	}
	
	public function getBMVT16ChiTietList($where)
	{
		$sql = "Select `bmvt16_chitiet`.* 
									from `bmvt16_chitiet` 
									where 1=1 " . $where ;
		
		$query = $this->db->query($sql);
		return $query->rows;
	}
	
	public function saveBMVT16ChiTiet($data)
	{
		$data['bmvt16id'] = $this->db->escape(@$data['bmvt16id']);
		$data['itemtype'] = $this->db->escape(@$data['itemtype']);
		$data['itemid'] = $this->db->escape(@$data['itemid']);
		$data['itemcode'] = $this->db->escape(@$data['itemcode']);
		$data['itemname'] = $this->db->escape(@$data['itemname']);
		$data['lothang'] = $this->db->escape(@$data['lothang']);
		$data['madonvi'] = $this->db->escape(@$data['madonvi']);
		$data['chungtu']=$this->db->escape(@$this->string->toNumber($data['chungtu']));
		$data['thucnhap']=$this->db->escape(@$this->string->toNumber($data['thucnhap']));
		$data['dongia']=$this->db->escape(@$this->string->toNumber($data['dongia']));
		$data['thanhtien'] = $data['thucnhap'] * $data['dongia'];
		
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
			
			$this->db->insertData("bmvt16_chitiet",$field,$value);
			$id = $this->db->getLastId();
		}
		else
		{			
			$where="id = '".$data['id']."'";
			$this->db->updateData('bmvt16_chitiet',$field,$value,$where);
		}
		return $id;
	}
	
	public function updateBMVT16ChiTiet($id,$col,$val)
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
		$this->db->updateData('bmvt16_chitiet',$field,$value,$where);
	}
		
	public function deleteBMVT16ChiTiet($id)
	{
		$id = $this->db->escape(@$id);		
		$where="id = '".$id."'";
		$this->db->deleteData('bmvt16_chitiet',$where);
	}
}
?>