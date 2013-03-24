<?php
$this->load->model("core/file");
class ModelQuanlykhoNguyenlieu extends ModelCoreFile
{
	public function getItem($id, $where="")
	{
		$sql = "Select `qlknguyenlieu`.*
									from `qlknguyenlieu` 
									where id ='".$id."' ".$where;
		$query = $this->db->query($sql);
		return $query->row;
	}

	public function getList($where="", $from=0, $to=0,$order="")
	{

		$sql = "Select `qlknguyenlieu`.*
									from `qlknguyenlieu` 
									where trangthai <> 'deleted' " . $where;
		if($order=="")
		{
			$order = " Order by tennguyenlieu";
			
		}
		$sql.=$order;
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
		$manguyenlieu=$this->db->escape(@$data['manguyenlieu']);
		$tennguyenlieu=$this->db->escape(@$data['tennguyenlieu']);
		$soluongtrenkg= $this->string->toNumber($this->db->escape(@$data['soluongtrenkg']));
		$tontoithieu= $this->string->toNumber($this->db->escape(@$data['tontoithieu']));
		$tontoida=$this->string->toNumber($this->db->escape(@$data['tontoida']));
		$soluongton=$this->string->toNumber($this->db->escape(@$data['soluongton']));
		$soluongmoilandathang=$this->string->toNumber($this->db->escape(@$data['soluongmoilandathang']));
		$dongia=$this->string->toNumber($this->db->escape(@$data['dongia']));
		$mucdichsudung=$this->db->escape(@$data['mucdichsudung']);
		$ghichu=$this->db->escape(@$data['ghichu']);
		$manhom=$this->db->escape(@$data['manhom']);
		$loai=$this->db->escape(@$data['loai']);
		$madonvi=$this->db->escape(@$data['madonvi']);
		$makho=$this->db->escape(@$data['makho']);
		$imageid=(int)@$data['imageid'];
		$imagepath=$this->db->escape(@$data['imagepath']);

		$field=array(

						'manguyenlieu',
						'tennguyenlieu',
						'soluongtrenkg',
						'tontoithieu',
						'tontoida',
						'soluongton',
						'soluongmoilandathang',
						'dongia',
						'mucdichsudung',
						'ghichu',
						'manhom',
						'loai',
						'madonvi',
						'makho',
						'trangthai',
						'imageid',
						'imagepath'
						);
						$value=array(

						$manguyenlieu,
						$tennguyenlieu,
						$soluongtrenkg,
						$tontoithieu,
						$tontoida,
						$soluongton,
						$soluongmoilandathang,
						$dongia,
						$mucdichsudung,
						$ghichu,
						$manhom,
						$loai,
						$madonvi,
						$makho,
						'active',
						$imageid,
						$imagepath
						);
						$this->db->insertData("qlknguyenlieu",$field,$value);
						$this->updateFileTemp($imageid);
						return $id;
	}

	public function update($data)
	{

		$id= $this->db->escape(@$data['id']);
		$manguyenlieu=$this->db->escape(@$data['manguyenlieu']);
		$tennguyenlieu=$this->db->escape(@$data['tennguyenlieu']);
		$soluongtrenkg= $this->string->toNumber($this->db->escape(@$data['soluongtrenkg']));
		$tontoithieu= $this->string->toNumber($this->db->escape(@$data['tontoithieu']));
		$tontoida=$this->string->toNumber($this->db->escape(@$data['tontoida']));
		$soluongton=$this->string->toNumber($this->db->escape(@$data['soluongton']));
		$soluongmoilandathang=$this->string->toNumber($this->db->escape(@$data['soluongmoilandathang']));
		$dongia=$this->string->toNumber($this->db->escape(@$data['dongia']));
		$mucdichsudung=$this->db->escape(@$data['mucdichsudung']);
		$ghichu=$this->db->escape(@$data['ghichu']);
		$manhom=$this->db->escape(@$data['manhom']);
		$loai=$this->db->escape(@$data['loai']);
		$madonvi=$this->db->escape(@$data['madonvi']);
		$makho=$this->db->escape(@$data['makho']);
		$imageid=(int)@$data['imageid'];
		$imagepath=$this->db->escape(@$data['imagepath']);
		$field=array(

						'manguyenlieu',
						'tennguyenlieu',
						'soluongtrenkg',
						'tontoithieu',
						'tontoida',
						'soluongton',
						'soluongmoilandathang',
						'dongia',
						'mucdichsudung',
						'ghichu',
						'manhom',
						'loai',
						'madonvi',
						'makho',
						'trangthai',
						'imageid',
						'imagepath'
						);
						$value=array(

						$manguyenlieu,
						$tennguyenlieu,
						$soluongtrenkg,
						$tontoithieu,
						$tontoida,
						$soluongton,
						$soluongmoilandathang,
						$dongia,
						$mucdichsudung,
						$ghichu,
						$manhom,
						$loai,
						$madonvi,
						$makho,
						'active',
						$imageid,
						$imagepath
						);

						$where="id = '".$id."'";
						$this->db->updateData("qlknguyenlieu",$field,$value,$where);
						$this->updateFileTemp($imageid);
						return true;
	}

	public function updateNguyenLieuGoc($data)
	{

		$id= $this->db->escape(@$data['id']);
		$nguyenlieugoc=$this->db->escape(@$data['nguyenlieugoc']);

		$field=array(


						'nguyenlieugoc'
						);
						$value=array(


						$nguyenlieugoc

						);

						$where="id = '".$id."'";
						$this->db->updateData("qlknguyenlieu",$field,$value,$where);
						return true;
	}

	public function updateSoLuongTon($id,$soluongton)
	{

		$id= $this->db->escape(@$id);
		$soluongton=$this->db->escape(@$soluongton);

		$field=array(


						'soluongton'
						);
						$value=array(


						$soluongton

						);

						$where="id = '".$id."'";
						$this->db->updateData("qlknguyenlieu",$field,$value,$where);
						return true;
	}

	public function delete($id)
	{
		/*$where="id = '".$id."'";
		 $this->db->deleteData("qlknguyenlieu",$where);*/
		$field=array(

						'trangthai'
						);
						$value=array(


						'deleted'
						);

						$where="id = '".$id."'";
						$this->db->updateData("qlknguyenlieu",$field,$value,$where);
	}

	public function deletedatas($listid)
	{
		foreach($listid as $item)
		{
			$this->delete($item);
		}
	}

	//Nguyen lieu trung gian
	public function getDinhLuong($manguyenlieu)
	{
		$sql = "Select `qlknguyenlieutrunggian`.*
									from `qlknguyenlieutrunggian` 
									where manguyenlieu = '".$manguyenlieu."' Order by id";

		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function getNguenLieuTrungGian($id)
	{
		$sql = "Select `qlknguyenlieutrunggian`.*
									from `qlknguyenlieutrunggian` 
									where id ='".$id."' ";
		$query = $this->db->query($sql);
		return $query->row;
	}

	public function saveNguyenLieuTrungGian($data)
	{
		$id=(int)@$data['id'];
		$manguyenlieu=$this->db->escape(@$data['manguyenlieu']);
		$nguyenlieuthanhphan=$this->db->escape(@$data['nguyenlieuthanhphan']);
		$soluong=$this->string->toNumber($this->db->escape(@$data['soluong']));
		$madonvi=$this->db->escape(@$data['madonvi']);

		$field=array(

						'manguyenlieu',
						'nguyenlieuthanhphan',
						'soluong',
						'madonvi'
						);
						$value=array(

						$manguyenlieu,
						$nguyenlieuthanhphan,
						$soluong,
						$madonvi

						);

						if($id == 0 )
						{
							$this->db->insertData("qlknguyenlieutrunggian",$field,$value);
						}
						else
						{
							$where="id = '".$id."'";
							$this->db->updateData("qlknguyenlieutrunggian",$field,$value,$where);
						}
	}

	public function deletedNguyenLieuTrungGian($id)
	{
		$where="id = '".$id."'";
		$this->db->deleteData("qlknguyenlieutrunggian",$where);
	}

	//Cap nhat gia
	public function getCapNhatGia($manguyenlieu)
	{
		$sql = "Select `qlknguyenlieutrunggian`.*
									from `qlknguyenlieugia` 
									where manguyenlieu = '".$manguyenlieu."' Order by id";

		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function getCapNhatGias($where,$from=0, $to=0)
	{
		$sql = "Select `qlknguyenlieugia`.*
									from `qlknguyenlieugia` 
									where 1=1 " . $where;
		if($to > 0)
		{
			$sql .= " Limit ".$from.",".$to;
		}

		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function saveCapNhatGia($data)
	{
		$id=(int)@$data['id'];
		$mabangbaogia=$this->db->escape(@$data['mabangbaogia']);
		$manguyenlieu=$this->db->escape(@$data['manguyenlieu']);
		$manhacungung=$this->db->escape(@$data['manhacungung']);
		$gia=$this->string->toNumber($this->db->escape(@$data['gia']));
		$ngay=$this->db->escape(@$data['ngay']);

		$field=array(
						'mabangbaogia',
						'manguyenlieu',
						'manhacungung',
						'gia',
						'ngay'
						);
						$value=array(
						$mabangbaogia,
						$manguyenlieu,
						$manhacungung,
						$gia,
						$ngay

						);

						if($id == 0 )
						{
							$this->db->insertData("qlknguyenlieugia",$field,$value);
								
						}
						else
						{
							$where="id = '".$manguyenlieu."'";
							$this->db->updateData("qlknguyenlieugia",$field,$value,$where);
						}
	}

	public function deletedCapNhatGia($id)
	{
		$where="id = '".$id."'";
		$this->db->deleteData("qlknguyenlieugia",$where);
	}

	public function nhap($id, $soluong)
	{
		$id=$this->db->escape(@$id);
		$soluong=$this->db->escape(@$soluong);

		//lay doi tuong
		$data = $this->getItem($id);
		$data['soluongton'] += $soluong;

		$this->update($data);
	}




	//Bang bao gia
	public function getBangBaoGia($id)
	{
		$sql = "Select `qlkbangbaogia`.*
									from `qlkbangbaogia` 
									where id ='".$id."' ";
		$query = $this->db->query($sql);
		return $query->row;
	}

	public function getBangBaoGias($where="", $from=0, $to=0)
	{

		$sql = "Select `qlkbangbaogia`.*
									from `qlkbangbaogia` 
									where 1=1 " . $where . " ORDER BY `ngay` DESC";
		if($to > 0)
		{
			$sql .= " Limit ".$from.",".$to;
		}

		$query = $this->db->query($sql);
		return $query->rows;
	}

	private function nextBangBaoGiaID()
	{
		return $this->db->getNextId('qlkbangbaogia','id');
	}

	public function saveBangBaoGia($data)
	{
		$id=(int)@$data['id'];
		if($id == 0 )
		{
			$id = $this->nextBangBaoGiaID();
		}
		$ngay=$this->db->escape(@$data['ngay']);
		$manhacungung=$this->db->escape(@$data['manhacungung']);

		$field=array(
					 	'id',
						'ngay',
						'manhacungung'
						);
						$value=array(
						$id,
						$ngay,
						$manhacungung

						);

						if((int)@$data['id'] == 0 )
						{
								
							$this->db->insertData("qlkbangbaogia",$field,$value);
								
						}
						else
						{
							$where="id = '".$id."'";
							$this->db->updateData("qlkbangbaogia",$field,$value,$where);
						}
						return $id;
	}

	public function deletedBangBaoGia($id)
	{
		$where="id = '".$id."'";
		$this->db->deleteData("qlkbangbaogia",$where);

		$where="mabangbaogia = '".$id."'";
		$this->db->deleteData("qlknguyenlieugia",$where);
	}
	
	//
	public function getTonKho($nguyenlieuid)
	{
		$sql = "SELECT sum(thucnhap) as soluongton
				FROM  `qlkphieunhapvattuhanghoa_chitiet` 
				WHERE nguyenlieuid = '".$nguyenlieuid."'
						
						AND status <> 'deleted'
				";
		$query = $this->db->query($sql);
		return $query->row['soluongton'];
		
	}
}
?>