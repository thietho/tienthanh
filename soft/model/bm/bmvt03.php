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
		if(count($field))
		{		
			$where="id = '".$data['id']."'";
			$this->db->updateData("bmvt03",$field,$value,$where);
		}
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
		$this->db->deleteData('bmvt03_chitiet',$where);
		
		
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
		$obj = array();
		$obj['bmvt03id'] = $this->db->escape(@$data['bmvt03id']);
		$obj['itemtype'] = $this->db->escape(@$data['itemtype']);
		$obj['itemid'] = $this->db->escape(@$data['itemid']);
		$obj['itemcode'] = $this->db->escape(@$data['itemcode']);
		$obj['itemname'] = $this->db->escape(@$data['itemname']);
		$obj['madonvi'] = $this->db->escape(@$data['madonvi']);
		$obj['tonhientai']=$this->db->escape(@$this->string->toNumber($data['tonhientai']));
		$obj['tontonthieu']=$this->db->escape(@$this->string->toNumber($data['tontonthieu']));
		$obj['muatoithieu']=$this->db->escape(@$this->string->toNumber($data['muatoithieu']));
		$obj['pheduyet'] = $this->db->escape(@$this->string->toNumber($data['pheduyet']));
		$obj['thoigiayeucau']=$this->db->escape(@$this->date->formatViewDate($data['thoigiayeucau']));
		$obj['thoigianphanhoi']=$this->db->escape(@$this->date->formatViewDate($data['thoigianphanhoi']));
		$obj['ketquathuchien'] = $this->db->escape(@$data['ketquathuchien']);
		$obj['mucdichsudung'] = $this->db->escape(@$data['mucdichsudung']);
		
		foreach($obj as $key => $val)
		{	
			$field[] = $key;
			$value[] = $this->db->escape($val);		
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