<?php
class ModelCoreModule extends Model 
{
	public function getList($where = "")
	{
		$sql = "Select * from `module` where 1=1 ".$where;
		$query = $this->db->query($sql);
		return $query->rows;
	}
	
	
	public function getItem($id)
	{
		$sql = "Select * from `module` where id = '".$id."'";
		$query = $this->db->query($sql);
		return $query->row;
	}
		
	public function insert($data)
	{
		$moduleid=$this->db->escape(@$data['moduleid']);
		$modulename=$this->db->escape(@$data['modulename']);
		
		$moduleparent=$this->db->escape(@$data['moduleparent']);
		
		
				
		$field=array(
						'moduleid',
						'modulename',
						
						'moduleparent'
						
					);
		$value=array(
						$moduleid,
						$modulename,
						
						$moduleparent
					);
		$getLastId = $this->db->insertData("module",$field,$value);
		
		return $getLastId;
	}
	
	public function update($data)
	{
		$id=$this->db->escape(@$data['id']);
		$moduleid=$this->db->escape(@$data['moduleid']);
		$modulename=$this->db->escape(@$data['modulename']);
		
		$moduleparent=$this->db->escape(@$data['moduleparent']);
		
		
				
		$field=array(
						'moduleid',
						'modulename',
						
						'moduleparent'
					);
		$value=array(
						$moduleid,
						$modulename,
						
						$moduleparent
					);
					
		
					
		$where="id = '".$id."'";
		$this->db->updateData("module",$field,$value,$where);
	}	
	
	
	
	public function updateCol($id,$col,$val)
	{
		$moduleid=$this->db->escape(@$id);
		$col=$this->db->escape(@$col);
		$val=$this->db->escape(@$val);
		
		$field=array(
						$col
						
					);
		$value=array(
						$val
					);
		
		$where="id = '".$id."'";
		$this->db->updateData("module",$field,$value,$where);
	}
			
	public function delete($id)
	{
		$moduleid=$this->db->escape(@$id);
		$data_khuvuc = $this->getChild($id);
		if(count($data_khuvuc) == 0)
		{
			$where="id = '".$id."'";
			$this->db->deleteData('module',$where);
		}
		
	}
	
	public function getChild($id,$order = " Order by `id`")
	{
		$where = " AND `moduleparent` = '".$id."' ".$order;
		return $this->getList($where);
	}
	
	public function getPath($id,$col)
	{
		$path = array();
		$khuvuc = $this->getItem($id);
		while(count($khuvuc))
		{
			array_push($path,$khuvuc[$col]);
			$khuvuc = $this->getItem($khuvuc['moduleparent']);
		}
		return $path;
	}
	
	function getTree($id, &$data,$root=0,$notid = -1, $level=-1, $path="", $parentpath="")
	{
		
		$arr=$this->getItem($id);
		
		$rows = $this->getChild($id);
		if(count($rows))
		{
			$arrmodulename = $this->getPath($arr['id'],"modulename");
			$arr['modulename'] =  implode(" - ", $arrmodulename);	
		}
		
		$arr['countchild'] = count($rows);
		
		if($arr['moduleparent'] != 0 && $id!=$root) 
			$parentpath .= "-".$arr['moduleparent'];
		
		if($id!=0 && $id!=$notid)
		{
			$level += 1;
			$path .= "-".$id;
			
			$arr['level'] = $level;
			$arr['path'] = $path;
			$arr['parentpath'] = $parentpath;
			
			array_push($data,$arr);
		}
		
		
		if(count($rows) && $id!=$notid)
			foreach($rows as $row)
			{
				$this->getTree($row['id'], $data,$root,$notid, $level, $path, $parentpath);
			}
	}
}

?>
