<?php
class ModelQuanlykhoKehoachnam extends Model
{
	public function getItem($nam, $where="")
	{
		$sql = "Select `qlkkehoachnam`.*
									from `qlkkehoachnam` 
									where nam ='".$nam."' ".$where;
		$query = $this->db->query($sql);
		return $query->row;
	}

	public function getList($where="", $from=0, $to=0,$order = "Order by nam")
	{

		$sql = "Select `qlkkehoachnam`.*
									from `qlkkehoachnam` 
									where trangthai <> 'deleted' " . $where;
		if($order == "")
			$sql .=$order;
		if($to > 0)
		{
			$sql .= " Limit ".$from.",".$to;
		}

		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function insert($data)
	{
		
		$nam=$this->db->escape(@$data['nam']);
		$ngaylap = $this->date->getToday();
		$nguoilap= $this->user->getUserName();
		$ghichu= $this->db->escape(@$data['ghichu']);


		$field=array(

						'nam',
						'ngaylap',
						'nguoilap',
						'ghichu',
						'trangthai'
						
						);
		$value=array(

						$nam,
						$ngaylap,
						$nguoilap,
						$ghichu,
						'active'
						);
						$this->db->insertData("qlkkehoachnam",$field,$value);

						return $id;
	}

	public function update($data)
	{

		$nam=$this->db->escape(@$data['nam']);
		$ngaylap= $this->db->escape(@$data['ngaylap']);
		$nguoilap= $this->db->escape(@$data['nguoilap']);
		$ghichu= $this->db->escape(@$data['ghichu']);

		$field=array(

						'nam',
						'ngaylap',
						'nguoilap',
						'ghichu',
						
						
						);
		$value=array(

						$nam,
						$ngaylap,
						$nguoilap,
						$ghichu,
						);

		$where="nam = '".$nam."'";
		$this->db->updateData("qlkkehoachnam",$field,$value,$where);

		return true;
	}

	public function updateCol($nam,$col,$val)
	{
		$nam= $this->db->escape(@$nam);
		$col= $this->db->escape(@$col);
		$val= $this->db->escape(@$val);
		$field=array(
						$col
						);
		$value=array(
						$val
						);

		$where="nam = '".$nam."'";
		$this->db->updateData("qlkkehoachnam",$field,$value,$where);
	}

	public function delete($nam)
	{
		$where="nam = '".$nam."'";
		$this->db->deleteData("qlkkehoachnam_sanpham",$where);
		$this->db->deleteData("qlkkehoachnam",$where);
		
	}

	//Ke hoach san pham
	public function getHeHoachNamSanPham($id)
	{
		$sql = "Select `qlkkehoachnam_sanpham`.*
									from `qlkkehoachnam_sanpham` 
									where id ='".$id."' ".$where;
		$query = $this->db->query($sql);
		return $query->row;
	}

	public function getHeHoachNamSanPhams($where="", $from=0, $to=0)
	{

		$sql = "Select `qlkkehoachnam_sanpham`.*
									from `qlkkehoachnam_sanpham` 
									where 1=1 " . $where;
		if($to > 0)
		{
			$sql .= " Limit ".$from.",".$to;
		}

		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function deleteHeHoachNamSanPham($id)
	{
		$where="id = '".$id."'";
		$this->db->deleteData("qlkkehoachnam_sanpham",$where);

	}

	public function saveKeHoachNamSanPham($data)
	{
		$id = (int)@$data['id'];
		$nam= $this->db->escape(@$data['nam']);
		$sanphamid= $this->db->escape(@$data['sanphamid']);
		$masanpham = $this->db->escape(@$data['masanpham']);
		$tensanpham = $this->db->escape(@$data['tensanpham']);
		$manhom = $this->db->escape(@$data['manhom']);
		$giacodinh = $this->string->toNumber($this->db->escape(@$data['giacodinh']));
		$sosanphamtrenlot = $this->string->toNumber($this->db->escape(@$data['sosanphamtrenlot']));
		$qui1 = $this->string->toNumber($this->db->escape(@$data['qui1']));
		$qui2 = $this->string->toNumber($this->db->escape(@$data['qui2']));
		$qui3 = $this->string->toNumber($this->db->escape(@$data['qui3']));
		$qui4 = $this->string->toNumber($this->db->escape(@$data['qui4']));
		
		
		$field=array(

						'nam',
						'sanphamid',
						'masanpham',
						'tensanpham',
						'manhom',
						'giacodinh',
						'sosanphamtrenlot',
						'qui1',
						'qui2',
						'qui3',
						'qui4'
						
						);
		$value=array(

						$nam,
						$sanphamid,
						$masanpham,
						$tensanpham,
						$manhom,
						$giacodinh,
						$sosanphamtrenlot,
						$qui1,
						$qui2,
						$qui3,
						$qui4
						);
		$where = " AND nam = '".$nam."' AND sanphamid = '".$sanphamid."'";
		$data_temp = $this->getHeHoachNamSanPhams($where);
		if(count($data_temp) == 0 )
		{
			//$value[0] = $id;
			$this->db->insertData("qlkkehoachnam_sanpham",$field,$value);
		}
		else
		{
			$where = " nam = '".$nam."' AND sanphamid = '".$sanphamid."'";
			$this->db->updateData("qlkkehoachnam_sanpham",$field,$value,$where);
		}

		return $id;
	}
	
	function updateKeHoachSanPham($id,$col,$val)
	{
		$id= (int)@$id;
		$col= $this->db->escape(@$col);
		$val= $this->db->escape(@$val);
		$field=array(
						$col	
						);
		$value=array(
						$val
						);
		$where="id = '".$id."'";
		$this->db->updateData("qlkkehoachnam_sanpham",$field,$value,$where);
	}
	
	
	

}
?>