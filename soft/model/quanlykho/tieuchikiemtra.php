<?php
class ModelQuanlykhoTieuchikiemtra extends Model 
{
	private $columns = array(
								'itemtype',
								'itemid',
								'itemcode',
								'itemname',
								'tieuchikiemtra',
								'madonvi'
							);
	public function getList($where = "")
	{
		$sql = "Select `qlktieuchikiemtra`.* from `qlktieuchikiemtra` where 1=1 ".$where;
		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function getItem($id)
	{
		$sql = "Select * from `qlktieuchikiemtra` where id = '".$id."'";
		$query = $this->db->query($sql);
		return $query->row;
	}
	
	public function insert($data)
	{
		foreach($this->columns as $val)
		{			
			$field[] = $val;
			$value[] = $this->db->escape($data[$val]);	
			
		}
		
		$getLastId = $this->db->insertData("qlktieuchikiemtra",$field,$value);
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
		$this->db->updateData("qlktieuchikiemtra",$field,$value,$where);
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
		$this->db->updateData("qlktieuchikiemtra",$field,$value,$where);
	}
	
	//Xóa
	public function delete($id)
	{
		$where="id = '".$id."'";
		$this->db->deleteData('qlktieuchikiemtra',$where);
		
		
	}
}
?>