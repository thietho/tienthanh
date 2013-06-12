<?php
class ModelBmBmVt17 extends Model 
{
	private $columns = array(
								'sophieu',
								'ngaylap',
								'nhanvienlap',
								'bmtn13id',
								'nhacungungid',
								'manhacungung',
								'tennhacungung'
								
							);
	public function getList($where = "")
	{
		$sql = "Select `bmvt17`.* from `bmvt17` where 1=1 ".$where;
		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function getItem($id)
	{
		$sql = "Select * from `bmvt17` where id = '".$id."'";
		$query = $this->db->query($sql);
		return $query->row;
	}
	
	private function creatsophieu($prefix)
	{
		$mun = $this->db->getNextIdVarCharNumber('bmvt17','sophieu',$prefix);
		return $mun.$prefix;
	}
	
	public function insert($data)
	{
		
		$data['sophieu']=$this->creatsophieu('');
		
		$data['ngaylap'] = $this->date->getToday();
		$nhanvien = $this->user->getNhanVien();
		$data['nhanvienlap'] = $nhanvien['id'];
		foreach($this->columns as $val)
		{			
			$field[] = $val;
			$value[] = $this->db->escape($data[$val]);	
			
		}
		
		$getLastId = $this->db->insertData("bmvt17",$field,$value);
		return $getLastId;
	}
	
	
	public function update($data)
	{	
		$data['ngayphieugiaohang']=$this->db->escape(@$this->date->formatViewDate($data['ngayphieugiaohang']));
		$data['ngaykehoachdathang']=$this->db->escape(@$this->date->formatViewDate($data['ngaykehoachdathang']));
		foreach($this->columns as $val)
		{
	
			//if($data[$val]!="")
			{
				$field[] = $val;
				$value[] = $this->db->escape($data[$val]);	
			}
		}
					
		$where="id = '".$data['id']."'";
		$this->db->updateData("bmvt17",$field,$value,$where);
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
		$this->db->updateData("bmvt17",$field,$value,$where);
	}
	
	//Xóa phieu
	public function delete($id)
	{
		$where="id = '".$id."'";
		$this->db->deleteData('bmvt17',$where);
		$where="bmvt17id = '".$id."'";
		$this->db->updateData('bmvt17_chitiet',$field,$value,$where);
		
	}
	//chi tiet phieu
	public function getBMVT17ChiTiet($id)
	{
		$sql = "Select * 
						from `bmvt17_chitiet` 
						where id ='".$id."'";
		$query = $this->db->query($sql);
		return $query->row;	
	}
	
	public function getBMVT17ChiTietList($where)
	{
		$sql = "Select `bmvt17_chitiet`.* 
									from `bmvt17_chitiet` 
									where 1=1 " . $where ;
		
		$query = $this->db->query($sql);
		return $query->rows;
	}
	
	public function saveBMVT17ChiTiet($data)
	{
		$data['bmvt17id'] = $this->db->escape(@$data['bmvt17id']);
		$data['itemtype'] = $this->db->escape(@$data['itemtype']);
		$data['itemid'] = $this->db->escape(@$data['itemid']);
		$data['itemcode'] = $this->db->escape(@$data['itemcode']);
		$data['itemname'] = $this->db->escape(@$data['itemname']);
		$data['baobi'] = $this->db->escape(@$data['baobi']);
		$data['loaibao'] = $this->db->escape(@$data['loaibao']);
		$data['soluongcan']=$this->db->escape(@$this->string->toNumber($data['soluongcan']));
		$data['madonvi'] = $this->db->escape(@$data['madonvi']);
		$data['ghichu'] = $this->db->escape(@$data['ghichu']);
		
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
			
			$this->db->insertData("bmvt17_chitiet",$field,$value);
			$id = $this->db->getLastId();
		}
		else
		{			
			$where="id = '".$data['id']."'";
			$this->db->updateData('bmvt17_chitiet',$field,$value,$where);
		}
		return $id;
	}
	
	public function updateBMVT17ChiTiet($id,$col,$val)
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
		$this->db->updateData('bmvt17_chitiet',$field,$value,$where);
	}
		
	public function deleteBMVT17ChiTiet($id)
	{
		$id = $this->db->escape(@$id);		
		$where="id = '".$id."'";
		$this->db->deleteData('bmvt17_chitiet',$where);
	}
}
?>