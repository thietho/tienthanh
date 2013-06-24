<?php
class ModelBmBmvt03 extends Model 
{
	private $columns = array(
								'sophieu',
								'ngaylapphieu',
								'nhanvienlap',
								'tinhtrang'
							);
	public function getList($where = "")
	{
		$sql = "Select `bmvt03`.* from `bmvt03` where 1=1 ".$where;
		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function getItem($id)
	{
		$sql = "Select * from `bmvt03` where id = '".$id."'";
		$query = $this->db->query($sql);
		return $query->row;
	}
	
	private function creatsophieu($prefix)
	{
		$mun = $this->db->getNextIdVarCharNumber('bmvt03','sophieu',$prefix);
		return $mun.$prefix;
	}
	
	public function insert($data)
	{
		$data['sophieu']=$this->creatsophieu('-VTKV');
		
		$data['ngaylapphieu'] = $this->date->getToday();
		$nhanvien = $this->user->getNhanVien();
		$data['nhanvienlap'] = $nhanvien['id'];
		foreach($this->columns as $val)
		{			
			$field[] = $val;
			$value[] = $this->db->escape($data[$val]);	
			
		}
		
		$getLastId = $this->db->insertData("bmvt03",$field,$value);
		return $getLastId;
	}
	
	
	public function update($data)
	{	
		
		foreach($this->columns as $val)
		{
	
			if(isset($data[$val]))
			{
				$field[] = $val;
				$value[] = $this->db->escape($data[$val]);	
			}
		}
					
		$where="id = '".$data['id']."'";
		$this->db->updateData("bmvt03",$field,$value,$where);
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
		$this->db->updateData("bmvt03",$field,$value,$where);
	}
	
	//Xóa phieu
	public function delete($id)
	{
		$where="id = '".$id."'";
		$this->db->deleteData('bmvt03',$where);
		$where="bmvt03id = '".$id."'";
		$this->db->updateData('bmvt03_chitiet',$field,$value,$where);
		
	}
	//chi tiet phieu
	public function getBMVT03ChiTiet($id)
	{
		$sql = "Select * 
						from `bmvt03_chitiet` 
						where id ='".$id."'";
		$query = $this->db->query($sql);
		return $query->row;	
	}
	
	public function getBMVT03ChiTietList($where)
	{
		$sql = "Select `bmvt03_chitiet`.* 
									from `bmvt03_chitiet` 
									where 1=1 " . $where ;
		
		$query = $this->db->query($sql);
		return $query->rows;
	}
	
	public function saveBMVT03ChiTiet($data)
	{
		$data['bmvt03id'] = $this->db->escape(@$data['bmvt03id']);
		$data['itemtype'] = $this->db->escape(@$data['itemtype']);
		$data['itemid'] = $this->db->escape(@$data['itemid']);
		$data['itemcode'] = $this->db->escape(@$data['itemcode']);
		$data['itemname'] = $this->db->escape(@$data['itemname']);
		$data['madonvi'] = $this->db->escape(@$data['madonvi']);
		$data['tonhientai']=$this->db->escape(@$this->string->toNumber($data['tonhientai']));
		$data['tontonthieu']=$this->db->escape(@$this->string->toNumber($data['tontonthieu']));
		$data['muatoithieu']=$this->db->escape(@$this->string->toNumber($data['muatoithieu']));
		$data['pheduyet'] = $this->db->escape(@$data['pheduyet']);
		$data['thoigiayeucau']=$this->db->escape(@$this->date->formatViewDate($data['thoigiayeucau']));
		$data['thoigianphanhoi']=$this->db->escape(@$this->date->formatViewDate($data['thoigianphanhoi']));
		$data['ketquathuchien'] = $this->db->escape(@$data['ketquathuchien']);
		$data['mucdichsudung'] = $this->db->escape(@$data['mucdichsudung']);
		
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
			
			$this->db->insertData("bmvt03_chitiet",$field,$value);
			$id = $this->db->getLastId();
		}
		else
		{			
			$where="id = '".$data['id']."'";
			$this->db->updateData('bmvt03_chitiet',$field,$value,$where);
		}
		return $id;
	}
	
	public function updateBMVT03ChiTiet($id,$col,$val)
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
		$this->db->updateData('bmvt03_chitiet',$field,$value,$where);
	}
		
	public function deleteBMVT03ChiTiet($id)
	{
		$id = $this->db->escape(@$id);		
		$where="id = '".$id."'";
		$this->db->deleteData('bmvt03_chitiet',$where);
	}
}
?>