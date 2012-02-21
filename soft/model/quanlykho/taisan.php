<?php
$this->load->model("core/file");
class ModelQuanlykhoTaisan extends ModelCoreFile
{
	public function getItem($id, $where="")
	{
		$sql = "Select `qlktaisan`.*
									from `qlktaisan` 
									where id ='".$id."' ".$where;
		$query = $this->db->query($sql);
		return $query->row;
	}

	public function getList($where="", $from=0, $to=0)
	{

		$sql = "Select `qlktaisan`.*
									from `qlktaisan` 
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
		$mataisan=$this->db->escape(@$data['mataisan']);
		$tentaisan= $this->db->escape(@$data['tentaisan']);
		$ngaymua= $this->db->escape(@$data['ngaymua']);
		$soseri= $this->db->escape(@$data['soseri']);
		$thoihanbaohanh= $this->string->toNumber($this->db->escape(@$data['thoihanbaohanh']));
		$nuocsanxuat= $this->db->escape(@$data['nuocsanxuat']);
		$namsanxuat= $this->db->escape(@$data['namsanxuat']);
		$nguoinhan=$this->db->escape(@$data['nguoinhan']);
		$ngaynhan=$this->db->escape(@$data['ngaynhan']);
		$nguoitra=$this->db->escape(@$data['nguoitra']);
		$ngaytra=$this->db->escape(@$data['ngaytra']);
		$phongbannhan=$this->db->escape(@$data['phongbannhan']);
		$madonvi=$this->db->escape(@$data['madonvi']);
		$dongia=$this->string->toNumber($this->db->escape(@$data['dongia']));
		$khauhao=$this->string->toNumber($this->db->escape(@$data['khauhao']));
		$makho=$this->db->escape(@$data['makho']);
		$manhom=$this->db->escape(@$data['manhom']);
		$loai=$this->db->escape(@$data['loai']);
		$mucdichsudung=$this->db->escape(@$data['mucdichsudung']);
		$ghichu=$this->db->escape(@$data['ghichu']);
		$imageid=(int)@$data['imageid'];
		$imagepath=$this->db->escape(@$data['imagepath']);

		$field=array(

						'mataisan',
						'tentaisan',
						'ngaymua',
						'soseri',
						'thoihanbaohanh',
						'nuocsanxuat',
						'namsanxuat',
						'nguoinhan',
						'ngaynhan',
						'nguoitra',
						'ngaytra',
						'phongbannhan',
						'madonvi',
						'dongia',
						'khauhao',
						'makho',
						'manhom',
						'loai',
						'mucdichsudung',
						'ghichu',
						'trangthai',
						'imageid',
						'imagepath'
						);
						$value=array(

						$mataisan,
						$tentaisan,
						$ngaymua,
						$soseri,
						$thoihanbaohanh,
						$nuocsanxuat,
						$namsanxuat,
						$nguoinhan,
						$ngaynhan,
						$nguoitra,
						$ngaytra,
						$phongbannhan,
						$madonvi,
						$dongia,
						$khauhao,
						$makho,
						$manhom,
						$loai,
						$mucdichsudung,
						$ghichu,
						'active',
						$imageid,
						$imagepath
						);
						$this->db->insertData("qlktaisan",$field,$value);
						$this->updateFileTemp($imageid);
						return $id;
	}

	public function update($data)
	{

		$id= $this->db->escape(@$data['id']);
		$mataisan=$this->db->escape(@$data['mataisan']);
		$tentaisan= $this->db->escape(@$data['tentaisan']);
		$ngaymua= $this->db->escape(@$data['ngaymua']);
		$soseri= $this->db->escape(@$data['soseri']);
		$thoihanbaohanh= $this->string->toNumber($this->db->escape(@$data['thoihanbaohanh']));
		$nuocsanxuat= $this->db->escape(@$data['nuocsanxuat']);
		$namsanxuat= $this->db->escape(@$data['namsanxuat']);
		$madonvi=$this->db->escape(@$data['madonvi']);
		$dongia=$this->string->toNumber($this->db->escape(@$data['dongia']));
		$khauhao=$this->string->toNumber($this->db->escape(@$data['khauhao']));
		$makho=$this->db->escape(@$data['makho']);
		$manhom=$this->db->escape(@$data['manhom']);
		$loai=$this->db->escape(@$data['loai']);
		$mucdichsudung=$this->db->escape(@$data['mucdichsudung']);
		$ghichu=$this->db->escape(@$data['ghichu']);
		$imageid=(int)@$data['imageid'];
		$imagepath=$this->db->escape(@$data['imagepath']);

		$field=array(

						'mataisan',
						'tentaisan',
						'ngaymua',
						'soseri',
						'thoihanbaohanh',
						'nuocsanxuat',
						'namsanxuat',
		//'nguoinhan',
						'madonvi',
						'dongia',
						'khauhao',
						'makho',
						'manhom',
						'loai',
						'mucdichsudung',
						'ghichu',
						'trangthai',
						'imageid',
						'imagepath'
						);
						$value=array(

						$mataisan,
						$tentaisan,
						$ngaymua,
						$soseri,
						$thoihanbaohanh,
						$nuocsanxuat,
						$namsanxuat,
						//$nguoinhan,
						$madonvi,
						$dongia,
						$khauhao,
						$makho,
						$manhom,
						$loai,
						$mucdichsudung,
						$ghichu,
						'active',
						$imageid,
						$imagepath
						);

						$where="id = '".$id."'";
						$this->db->updateData("qlktaisan",$field,$value,$where);
						$this->updateFileTemp($imageid);
						return true;
	}



	public function delete($id)
	{
		/*$where="id = '".$id."'";
		 $this->db->deleteData("qlktaisan",$where);*/
		$field=array(

						'trangthai'
						);
						$value=array(


						'deleted'
						);

						$where="id = '".$id."'";
						$this->db->updateData("qlktaisan",$field,$value,$where);
	}

	public function deletedatas($listid)
	{
		foreach($listid as $item)
		{
			$this->delete($item);
		}
	}



	//Sổ tai san
	public function getSoTaiSan($id)
	{
		$sql = "Select `qlktaisan_phongban`.*
									from `qlktaisan_phongban` 
									where id ='".$id."' ".$where;
		$query = $this->db->query($sql);
		return $query->row;
	}

	public function getSoTaiSanList($where="", $from=0, $to=0)
	{

		$sql = "Select `qlktaisan_phongban`.*
									from `qlktaisan_phongban` 
									where 1=1 " . $where . " Order by id";
		if($to > 0)
		{
			$sql .= " Limit ".$from.",".$to;
		}

		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function saveSoTaiSan($data)
	{

		$id=(int)@$data['id'];
		$mataisan=$this->db->escape(@$data['mataisan']);
		$phongbannhan=$this->db->escape(@$data['phongbannhan']);
		$nguoidexuat=$this->db->escape(@$data['nguoidexuat']);
		$nguoinhan=$this->db->escape(@$data['nguoinhan']);
		$ngaynhan=$this->db->escape(@$data['ngaynhan']);
		$nguoitra=$this->db->escape(@$data['nguoitra']);
		$ngaytra=$this->db->escape(@$data['ngaytra']);
		$ghichu=$this->db->escape(@$data['ghichu']);
		$ghichutra=$this->db->escape(@$data['ghichutra']);

		$field=array(

						'mataisan',
						'phongbannhan',
						'nguoidexuat',
						'nguoinhan',
						'ngaynhan',
						'nguoitra',
						'ngaytra',
						'ghichu',
						'ghichutra'
						);
						$value=array(

						$mataisan,
						$phongbannhan,
						$nguoidexuat,
						$nguoinhan,
						$ngaynhan,
						$nguoitra,
						$ngaytra,
						$ghichu,
						$ghichutra

						);

						if($id == 0 )
						{
							$this->db->insertData("qlktaisan_phongban",$field,$value);
								
								
						}
						else
						{
							$where="id = '".$id."'";
							$this->db->updateData("qlktaisan_phongban",$field,$value,$where);
						}

						//Cap nhat vao tai san
						$field=array(


						'phongbannhan',
						'nguoinhan',
						'ngaynhan',
						'nguoitra',
						'ngaytra'
						
						);
						$value=array(


						$phongbannhan,
						$nguoinhan,
						$ngaynhan,
						$nguoitra,
						$ngaytra


						);

						$where=" id = '".$mataisan."'";
						$this->db->updateData("qlktaisan",$field,$value,$where);
	}

	function saveTraTaiSan($data)
	{

		$sotaisan = $this->getSoTaiSan($data['id']);

		$sotaisan['ngaytra'] = $data['ngaytra'];
		$sotaisan['nguoitra'] = $data['nguoitra'];
		$sotaisan['ghichutra'] = $data['ghichutra'];
		$this->saveSoTaiSan($sotaisan);


	}

	public function deleteSoTaiSan($id)
	{
		$where="id = '".$id."'";
		$this->db->deleteData("qlktaisan_phongban",$where);
	}

	public function kientraTaiSan($mataisan)
	{
		$hienhanh = true;
		$where = " AND mataisan = '".$mataisan."'";
		$sotaisans = $this->getSoTaiSanList($where);
		if(count($sotaisans))
		{
			foreach($sotaisans as $sotaisan)
			{
				if($sotaisan['nguoitra'] == 0)
				{
					$hienhanh = false;
				}
			}
		}

		return $hienhanh;
	}
	
	//Lich su tai san
	public function getLichSu($id)
	{
		$sql = "Select `qlktaisan_lichsu`.*
									from `qlktaisan_lichsu` 
									where id ='".$id."' ".$where;
		$query = $this->db->query($sql);
		return $query->row;
	}

	public function getLichSuList($where="", $from=0, $to=0)
	{

		$sql = "Select `qlktaisan_lichsu`.*
									from `qlktaisan_lichsu` 
									where 1=1 " . $where . " Order by id";
		if($to > 0)
		{
			$sql .= " Limit ".$from.",".$to;
		}

		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function saveLichSu($data)
	{
		$id=(int)@$data['id'];
		$mataisan=$this->db->escape(@$data['mataisan']);
		$ngaysuachua=$this->db->escape(@$data['ngaysuachua']);
		$noidung=$this->db->escape(@$data['noidung']);
		$chungtu=$this->db->escape(@$data['chungtu']);
		$ngaytao=$this->date->getToday();
		

		$field=array(

						'mataisan',
						'ngaysuachua',
						'noidung',
						'chungtu',
						'ngaytao'
						);
						$value=array(

						$mataisan,
						$ngaysuachua,
						$noidung,
						$chungtu,
						$ngaytao
						

						);

		if($id == 0 )
		{
			
			$this->db->insertData("qlktaisan_lichsu",$field,$value);
				
				
		}
		else
		{
			$where="id = '".$id."'";
			$this->db->updateData("qlktaisan_lichsu",$field,$value,$where);
		}

						
	}

	public function deleteLichSu($id)
	{
		$where="id = '".$id."'";
		$this->db->deleteData("qlktaisan_lichsu",$where);
	}
}
?>