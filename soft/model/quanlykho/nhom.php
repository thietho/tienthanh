<?php
class ModelQuanlykhoNhom extends Model
{
	private $root = "qlknhom";
	function __construct()
	{

		$data = $this->getItem($this->root);
		if(count($data)==0)
		{
			$data['manhom'] = $this->root;
			$data['tennhom'] = "Danh muc phan loai";
			$data['thutu'] = 0;
			$data['ghichu'] = "";
			$this->insert($data);
		}
	}


	public function getItem($manhom, $where="")
	{
		$query = $this->db->query("Select `qlknhom`.*
									from `qlknhom` 
									where manhom ='".$manhom."' ".$where);
		return $query->row;
	}

	public function getList($where="", $from=0, $to=0,$order = " Order by thutu")
	{

		$sql = "Select `qlknhom`.*
									from `qlknhom` 
									where 1=1 " . $where . $order;
		if($to > 0)
		{
			$sql .= " Limit ".$from.",".$to;
		}

		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function getChild($manhom,$order = " Order by thutu")
	{
		$where = " AND nhomcha = '".$manhom."'";
		return $this->getList($where);
	}

	protected function getnextid($prefix)
	{
		$id=$this->db->getNextIdVarChar("qlknhom","manhom",$prefix);
		return $id;
	}

	public function nextthutu($nhomcha)
	{
		$sql = "Select max(thutu) as max From qlknhom where nhomcha='".$nhomcha."'";
		$query = $this->db->query($sql);
		return $query->rows[0]['max'] +1 ;
	}

	public function insert($data)
	{
		$manhom= $this->db->escape(@$data['manhom']);
		$tennhom=$this->db->escape(@$data['tennhom']);
		$nhomcha=$this->db->escape(@$data['nhomcha']);
		$thutu= (int)@$this->nextthutu($nhomcha);
		$ghichu=$this->db->escape(@$data['ghichu']);


		$field=array(
						'manhom',
						'tennhom',
						'nhomcha',
						'thutu',
						'ghichu'
						);
						$value=array(
						$manhom,
						$tennhom,
						$nhomcha,
						$thutu,
						$ghichu
						);
						$this->db->insertData("qlknhom",$field,$value);

						return $manhom;
	}

	public function update($data)
	{
		$manhom= $this->db->escape(@$data['manhom']);
		$tennhom=$this->db->escape(@$data['tennhom']);
		$nhomcha=$this->db->escape(@$data['nhomcha']);

		$ghichu=$this->db->escape(@$data['ghichu']);


		$field=array(
						'manhom',
						'tennhom',
						'nhomcha',

						'ghichu'
						);
						$value=array(
						$manhom,
						$tennhom,
						$nhomcha,

						$ghichu
						);

						$where="manhom = '".$manhom."'";
						$this->db->updateData("qlknhom",$field,$value,$where);



						return true;
	}

	public function updatethutu($data)
	{
		$manhom= $this->db->escape(@$data['manhom']);
		$thutu= (int)@$data['thutu'];

		$field=array(

						'thutu'
						);
						$value=array(

						$thutu
						);

						$where="manhom = '".$manhom."'";
						$this->db->updateData("qlknhom",$field,$value,$where);



						return true;
	}

	public function saveNhom($data)
	{
		$item = $this->getItem($data['manhom']);
		if(count($item) == 0)
		{
			$this->insert($data);
		}
		else
		{
			$this->update($data);
		}
	}

	public function delete($manhom)
	{
		$data = $this->getChild($manhom);
		if(count($data)==0)
		{
			$where="manhom = '".$manhom."'";
			$this->db->deleteData("qlknhom",$where);
			$this->db->deleteData("qlknhominfo",$where);
		}
	}

	public function deletedatas($data)
	{
		if(count($data)>0)
		{
			foreach($data as $item)
			$this->delete($item);
		}
	}

	public function getInfor($manhom, $fieldname)
	{
		$sql = "Select * from qlknhominfo where manhom = '".$manhom."' and `col` = '".$fieldname."'";
		$query = $this->db->query($sql);
		$info = $query->row;
		return $info['value'];
	}

	public function saveInfo($manhom, $fieldname, $fieldvalue)
	{
		$sql = "Select * from qlknhominfo where manhom = '".$manhom."' and `col` = '".$fieldname."'";
		$query = $this->db->query($sql);
		$info = $query->rows;

		$field=array(
					"manhom",
					"`col`",
					"`value`"
					);

					$value=array(
					$manhom,
					$fieldname,
					$fieldvalue,
					);

					if(count($info) > 0)
					{
						$where="manhom = '".$manhom."' and `col` = '".$fieldname."'";
						$this->db->updateData('qlknhominfo',$field,$value,$where);
					}
					else
					{
						$this->db->insertData("qlknhominfo",$field,$value);
					}
	}
	//Tree
	function getTree($id, &$data, $level=-1, $path="", $parentpath="")
	{
		$arr=$this->getItem($id);

		$rows = $this->getChild($id);

		$arr['countchild'] = count(rows);

		if($arr['nhomcha'] != "")
		$parentpath .= "-".$arr['nhomcha'];

		if($id!="" )
		{
			$level += 1;
			$path .= "-".$id;
				
			$arr['level'] = $level;
			$arr['path'] = $path;
			$arr['parentpath'] = $parentpath;
				
			array_push($data,$arr);
		}


		if(count($rows))
		foreach($rows as $row)
		{
			$this->getTree($row['manhom'], $data, $level, $path, $parentpath);
		}
	}

	public function getDanhMucPhanLoai()
	{
		$data = array();
		$this->getTree($this->root,$data);
		foreach($data as $key =>$item)
		{
			$data[$key]['parentpath'] = str_replace("-".$this->root,"",$data[$key]['parentpath']);
			$data[$key]['path'] = str_replace("-".$this->root,"",$data[$key]['path']);
		}
		return $data;
	}
}
?>