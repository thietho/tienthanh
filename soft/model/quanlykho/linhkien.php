<?php
$this->load->model("core/file");
class ModelQuanlykhoLinhkien extends ModelCoreFile
{
	public function getItem($id, $where="")
	{
		$sql = "Select `qlklinhkien`.*
									from `qlklinhkien` 
									where id ='".$id."' ".$where;
		$query = $this->db->query($sql);
		return $query->row;
	}

	public function getList($where="", $from=0, $to=0)
	{

		$sql = "Select `qlklinhkien`.*
									from `qlklinhkien` 
									where trangthai <> 'deleted' " . $where . " Order by id";
		if($to > 0)
		{
			$sql .= " Limit ".$from.",".$to;
		}

		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function insert($data)
	{
		$id= $this->db->escape(@$data['id']);
		$malinhkien=$this->db->escape(@$data['malinhkien']);
		$tenlinhkien=$this->db->escape(@$data['tenlinhkien']);
		$solinhkientrenlot= $this->string->toNumber($this->db->escape(@$data['solinhkientrenlot']));
		$soluongton=$this->string->toNumber($this->db->escape(@$data['soluongton']));
		$soluongcontrenkg= $this->string->toNumber($this->db->escape(@$data['soluongcontrenkg']));
		$tiencong=$this->string->toNumber($this->db->escape(@$data['tiencong']));
		$dinhmuc=$this->string->toNumber($this->db->escape(@$data['dinhmuc']));
		$ghichu=$this->db->escape(@$data['ghichu']);
		$nguyenlieusudung=$this->db->escape(@$data['nguyenlieusudung']);
		$soluongnguyenlieu=$this->string->toNumber($this->db->escape(@$data['soluongnguyenlieu']));
		$madonvinguyenlieu=$this->db->escape(@$data['madonvinguyenlieu']);
		$manhom=$this->db->escape(@$data['manhom']);
		$madonvi=$this->db->escape(@$data['madonvi']);
		$makho=$this->db->escape(@$data['makho']);
		$imageid=(int)@$data['imageid'];
		$imagepath=$this->db->escape(@$data['imagepath']);
		$field=array(

						'malinhkien',
						'tenlinhkien',
						'solinhkientrenlot',
						'soluongton',
						'soluongcontrenkg',
						'tiencong',
						'dinhmuc',
						'ghichu',
						'nguyenlieusudung',
						'soluongnguyenlieu',
						'madonvinguyenlieu',
						'madonvi',
						'manhom',
						'makho',
						'trangthai',
						'imageid',
						'imagepath'
						);
						$value=array(

						$malinhkien,
						$tenlinhkien,
						$solinhkientrenlot,
						$soluongton,
						$soluongcontrenkg,
						$tiencong,
						$dinhmuc,
						$ghichu,
						$nguyenlieusudung,
						$soluongnguyenlieu,
						$madonvinguyenlieu,
						$madonvi,
						$manhom,
						$makho,
						'active',
						$imageid,
						$imagepath
						);
						$this->db->insertData("qlklinhkien",$field,$value);
						$this->updateFileTemp($imageid);
						return $id;
	}

	public function update($data)
	{

		$id= $this->db->escape(@$data['id']);
		$malinhkien=$this->db->escape(@$data['malinhkien']);
		$tenlinhkien=$this->db->escape(@$data['tenlinhkien']);
		$solinhkientrenlot= $this->string->toNumber($this->db->escape(@$data['solinhkientrenlot']));
		$soluongton=$this->string->toNumber($this->db->escape(@$data['soluongton']));
		$soluongcontrenkg= $this->string->toNumber($this->db->escape(@$data['soluongcontrenkg']));
		$tiencong=$this->string->toNumber($this->db->escape(@$data['tiencong']));
		$dinhmuc=$this->string->toNumber($this->db->escape(@$data['dinhmuc']));
		$ghichu=$this->db->escape(@$data['ghichu']);
		$nguyenlieusudung=$this->db->escape(@$data['nguyenlieusudung']);
		$soluongnguyenlieu=$this->string->toNumber($this->db->escape(@$data['soluongnguyenlieu']));
		$madonvinguyenlieu=$this->db->escape(@$data['madonvinguyenlieu']);
		$manhom=$this->db->escape(@$data['manhom']);
		$madonvi=$this->db->escape(@$data['madonvi']);
		$makho=$this->db->escape(@$data['makho']);
		$imageid=(int)@$data['imageid'];
		$imagepath=$this->db->escape(@$data['imagepath']);

		$field=array(

						'malinhkien',
						'tenlinhkien',
						'solinhkientrenlot',
						'soluongton',
						'soluongcontrenkg',
						'tiencong',
						'dinhmuc',
						'ghichu',
						'nguyenlieusudung',
						'soluongnguyenlieu',
						'madonvinguyenlieu',
						'manhom',
						'madonvi',
						'makho',
						'imageid',
						'imagepath'
						);
						$value=array(

						$malinhkien,
						$tenlinhkien,
						$solinhkientrenlot,
						$soluongton,
						$soluongcontrenkg,
						$tiencong,
						$dinhmuc,
						$ghichu,
						$nguyenlieusudung,
						$soluongnguyenlieu,
						$madonvinguyenlieu,
						$manhom,
						$madonvi,
						$makho,
						$imageid,
						$imagepath
						);
						$where="id = '".$id."'";
						$this->db->updateData("qlklinhkien",$field,$value,$where);
						$this->updateFileTemp($imageid);
						return true;
	}

	public function delete($id)
	{
		/*$where="id = '".$id."'";
		 $this->db->deleteData("qlklinhkien",$where);*/
		$field=array(

						'trangthai'
						);
						$value=array(


						'deleted'
						);

						$where="id = '".$id."'";
						$this->db->updateData("qlklinhkien",$field,$value,$where);
	}

	public function deletedatas($listid)
	{
		foreach($listid as $item)
		{
			$this->delete($item);
		}
	}

	//Linh kien trung gian
	public function getDinhLuong($malinhkien)
	{
		$sql = "Select `qlklinhkientrunggian`.*
									from `qlklinhkientrunggian` 
									where malinhkien = '".$malinhkien."' Order by id";

		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function getLinhKienTrungGian($id)
	{
		$sql = "Select `qlklinhkientrunggian`.*
									from `qlklinhkientrunggian` 
									where id ='".$id."' ";
		$query = $this->db->query($sql);
		return $query->row;
	}

	public function saveLinhKienTrungGian($data)
	{
		$id=(int)@$data['id'];
		$malinhkien=$this->db->escape(@$data['malinhkien']);
		$linhkienthanhphan=$this->db->escape(@$data['linhkienthanhphan']);
		$soluong=$this->string->toNumber($this->db->escape(@$data['soluong']));


		$field=array(

						'malinhkien',
						'linhkienthanhphan',
						'soluong'
						
						);
						$value=array(

						$malinhkien,
						$linhkienthanhphan,
						$soluong


						);

						if($id == 0 )
						{
							$this->db->insertData("qlklinhkientrunggian",$field,$value);
						}
						else
						{
							$where="id = '".$id."'";
							$this->db->updateData("qlklinhkientrunggian",$field,$value,$where);
						}
	}

	public function deletedLinhKienTrungGian($id)
	{
		$where="id = '".$id."'";
		$this->db->deleteData("qlklinhkientrunggian",$where);
	}


}
?>