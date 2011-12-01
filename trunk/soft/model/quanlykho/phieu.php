<?php
class ModelQuanlykhoPhieu extends Model
{
	public function getItem($maphieu, $where="")
	{
		$query = $this->db->query("Select `qlkphieu`.*
									from `qlkphieu` 
									where trangthai <> 'deleted' AND maphieu ='".$maphieu."' ".$where);
		return $query->row;
	}

	public function getList($where="", $from=0, $to=0, $order="")
	{
		$sql = "Select `qlkphieu`.*
									from `qlkphieu` 
									where trangthai <> 'deleted' " . $where . $order;
		if($to > 0)
		{
			$sql .= " Limit ".$from.",".$to;
		}

		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function nextID($prefix)
	{
		return $this->db->getNextIdVarChar('qlkphieu','maphieu',$prefix);
	}

	public function insert($data)
	{
		$maphieu= $this->nextID("phieu");
		$ngaylap= $this->date->formatViewDate($this->db->escape(@$data['ngaylap']));
		$makhachhang=$this->db->escape(@$data['makhachhang']);
		$loaiphieu=$this->db->escape(@$data['loaiphieu']);
		$nhanvientiepnhan= $this->string->toNumber($this->db->escape(@$data['nhanvientiepnhan']));

		$field=array(
						'maphieu',
						'ngaylap',
						'makhachhang',
						'loaiphieu',
						'nhanvientiepnhan',
						'trangthai'
						);
						$value=array(
						$maphieu,
						$ngaylap,
						$makhachhang,
						$loaiphieu,
						$nhanvientiepnhan,
						"pending"
						);
						$this->db->insertData("qlkphieu",$field,$value);

						return $manhom;
	}

	public function update($data)
	{
		$id= $this->db->escape(@$data['id']);
		$maphieu= $this->db->escape(@$data['maphieu']);
		$ngaylap= $this->date->formatViewDate($this->db->escape(@$data['ngaylap']));
		$makhachhang=$this->db->escape(@$data['makhachhang']);
		$loaiphieu=$this->db->escape(@$data['loaiphieu']);
		$nhanvientiepnhan= $this->db->escape(@$data['nhanvientiepnhan']);
		$trangthai = $this->db->escape(@$data['trangthai']);

		$field=array(
						'maphieu',
						'ngaylap',
						'makhachhang',
						'loaiphieu',
						'nhanvientiepnhan',
						'trangthai'
						);
						$value=array(
						$maphieu,
						$ngaylap,
						$makhachhang,
						$loaiphieu,
						$nhanvientiepnhan,
						$trangthai
						);

						$where="maphieu = '".$maphieu."'";
						$this->db->updateData("qlkphieu",$field,$value,$where);

						return true;
	}

	public function savePhieu($data)
	{
		$item = $this->getItem($data['maphieu']);
		if(count($item) == 0)
		{
			$this->insert($data);
		}
		else
		{
			$this->update($data);
		}
	}

	public function updateTrangThai($maphieu, $trangthai)
	{
		$field=array(
						'trangthai'
						);
						$value=array(
						$trangthai
						);

						$where="maphieu = '".$maphieu."'";
						$this->db->updateData("qlkphieu",$field,$value,$where);
	}

	public function deletedatas($data)
	{
		if(count($data)>0)
		{
			foreach($data as $item)
			$this->updateTrangThai($item, 'deleted');
		}
	}

	public function getPhieuInfo($maphieu, $fieldname)
	{
		$sql = "Select * from qlkphieuinfo where maphieu = '".$maphieu."' and `col` = '".$fieldname."'";
		$query = $this->db->query($sql);
		$info = $query->row;
		return $info['value'];
	}

	public function savePhieuInfo($maphieu, $fieldname, $fieldvalue)
	{
		$sql = "Select * from qlkphieuinfo where maphieu = '".$maphieu."' and `col` = '".$fieldname."'";
		$query = $this->db->query($sql);
		$info = $query->rows;

		$field=array(
					"maphieu",
					"`col`",
					"`value`"
					);

					$value=array(
					$maphieu,
					$fieldname,
					$fieldvalue,
					);

					if(count($info) > 0)
					{
						$where="maphieu = '".$maphieu."' and `col` = '".$fieldname."'";
						$this->db->updateData('qlkphieuinfo',$field,$value,$where);
					}
					else
					{
						$this->db->insertData("qlkphieuinfo",$field,$value);
					}
	}



}
?>