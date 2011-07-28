<?php

class ModelQuanlykhoDonvitinh extends Model
{ 
	public function getItem($madonvi, $where="")
	{
		$query = $this->db->query("Select `qlkdonvitinh`.* 
									from `qlkdonvitinh` 
									where madonvi ='".$madonvi."' ".$where);
		return $query->row;
	}
	
	public function getList($where="", $from=0, $to=0)
	{
		
		$sql = "Select `qlkdonvitinh`.* 
									from `qlkdonvitinh` 
									where 1=1 " . $where . " Order by madonvi";
		if($to > 0)
		{
			$sql .= " Limit ".$from.",".$to;
		}
		
		$query = $this->db->query($sql);
		return $query->rows;
	}
	
	public function insert($data)
	{
		$madonvi= $this->db->escape(@$data['madonvi']);
		$tendonvitinh=$this->db->escape(@$data['tendonvitinh']);
		$quidoi=$this->db->escape(@$data['quidoi']);
		$madonviquydoi=$this->db->escape(@$data['madonviquydoi']);
		
		
		$field=array(
						'madonvi',
						'tendonvitinh',
						'quidoi',
						'madonviquydoi'
					);
		$value=array(
						$madonvi,
						$tendonvitinh,
						$quidoi,
						$madonviquydoi
					);
		$this->db->insertData("qlkdonvitinh",$field,$value);
		
		return $madonvi;
	}
	
	public function update($data)
	{
		$madonvi = $this->db->escape(@$data['madonvi']);
		$tendonvitinh=$this->db->escape(@$data['tendonvitinh']);
		$quidoi=$this->db->escape(@$data['quidoi']);
		$madonviquydoi=$this->db->escape(@$data['madonviquydoi']);
		
		$field=array(
						'tendonvitinh',
						'quidoi',
						'madonviquydoi'
						
					);
		$value=array(
						$tendonvitinh,
						$quidoi,
						$madonviquydoi
						
					);
		
		$where="madonvi = '".$madonvi."'";
		$this->db->updateData("qlkdonvitinh",$field,$value,$where);
		
		
		
		return true;
	}
	
	public function delete($madonvi)
	{
		$where="madonvi = '".$madonvi."'";
		$this->db->deleteData("qlkdonvitinh",$where);
	}
	
	public function deletedatas($data)
	{
		if(count($data)>0)
		{
			foreach($data as $item)	
				$this->delete($item);
		}
	}
}
?>