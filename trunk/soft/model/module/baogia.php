<?php
class ModelModuleBaogia extends ModelCoreFile 
{ 
	private $arr_col = array(
							'ngaybaogia',
							'ghichu',
							);
	
	public function getItem($id)
	{
		$query = $this->db->query("Select `baogia`.* 
									from `baogia` 
									where id ='".$id."'");
		return $query->row;
	}
	
	
	
	public function getList($where="", $from=0, $to=0)
	{
		
		$sql = "Select `baogia`.* 
									from `baogia` 
									where 1=1 " . $where ;
		if($to > 0)
		{
			$sql .= " Limit ".$from.",".$to;
		}
		//echo $sql;
		$query = $this->db->query($sql);
		return $query->rows;
	}
	
	public function save($data)
	{
		$obj = $this->getItem($data['id']);
		$value = array();
		if(count($obj))
		{
			foreach($obj as $col => $val)
			{
				if(isset($data[$col]))
					$obj[$col] = $data[$col];
			}
			$data = $obj;
		}
		
		
		foreach($this->arr_col as $col)
		{
			$value[] = $this->db->escape(@$data[$col]);
		}
		

		$field=$this->arr_col;
		
		if(count($obj) == 0)
		{
			$data['id'] = $this->db->insertData("baogia",$field,$value);
		}
		else
		{
			$where="id = '".$data['id']."'";
			$this->db->updateData("baogia",$field,$value,$where);
		}
		
		return $data['id'];
	}
	public function delete($id)
	{
		$where="id = '".$id."'";
		$this->db->deleteData("baogia",$where);
		$where="baogiaid = '".$id."'";
		$this->db->deleteData("baogia_media",$where);
	}
	//Detail
	private $arr_coldetail = array(
							
							'baogiaid',
							'mediaid',
							'gia',
							'ghichu'
							);
	public function getBaoGiaMedia($id)
	{
		$query = $this->db->query("Select `baogia_media`.* 
									from `baogia_media` 
									where id ='".$id."'");
		return $query->row;
	}
	
	
	
	public function getBaoGiaMediaList($where="", $from=0, $to=0)
	{
		
		$sql = "Select `baogia_media`.* 
									from `baogia_media` 
									where 1=1 " . $where ;
		if($to > 0)
		{
			$sql .= " Limit ".$from.",".$to;
		}
		//echo $sql;
		$query = $this->db->query($sql);
		return $query->rows;
	}
	
	public function saveBaoGiaMedia($data)
	{
		$obj = $this->getBaoGiaMedia($data['id']);
		$value = array();
		if(count($obj))
		{
			foreach($obj as $col => $val)
			{
				if(isset($data[$col]))
					$obj[$col] = $data[$col];
			}
			$data = $obj;
		}
		
		
		foreach($this->arr_coldetail as $col)
		{
			$value[] = $this->db->escape(@$data[$col]);
		}
		

		$field=$this->arr_coldetail;
		
		if(count($obj) == 0)
		{
			$data['id'] = $this->db->insertData("baogia_media",$field,$value);
		}
		else
		{
			$where="id = '".$data['id']."'";
			$this->db->updateData("baogia_media",$field,$value,$where);
		}
		
		return $data['id'];
	}
	public function deleteBaoGiaMedia($id)
	{
		$where="id = '".$id."'";
		$this->db->deleteData("baogia_media",$where);
	}
	
}
?>