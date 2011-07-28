<?php
class ModelQuanlykhoPhieunhapxuat extends Model
{ 
	//phieuxuatnguyenlieu bao gom cac thuoc tinh
	/*
		id,
		maphieu,
		nguoinhan,
		makho,
		macongdoan,
		tinhtrang,
		loaiphieu,
		ngayxuat,
		mahopdong,
		ngaylapphieu,
		nguoilap,
		trangthai,
		loainhapxuat,
		ghichu
	*/
	
	protected function getPhieuNhapXuat($id, $where="")
	{
		$query = $this->db->query("Select `qlkphieunhapxuat`.* 
									from `qlkphieunhapxuat` 
									where trangthai <> 'deleted' AND id ='".$id."' ".$where);
		return $query->row;
	}
	
	public function getItemMaPhieu($maphieu, $where="")
	{
		$query = $this->db->query("Select `qlkphieunhapxuat`.* 
									from `qlkphieunhapxuat` 
									where trangthai <> 'deleted' AND maphieu ='".$maphieu."' ".$where);
		return $query->row;
	}
	
	public function getChiTiet($id)
	{
		$sql = "Select `qlkchitietphieunhapxuat`.* 
								from `qlkchitietphieunhapxuat` 
								where  id='". $id ."' ORDER BY `vitri` ASC" ;
								
		$query = $this->db->query($sql);
		return $query->row;
	}
	
	public function getChiTiets($maphieu, $where="")
	{
		$sql = "Select `qlkchitietphieunhapxuat`.* 
								from `qlkchitietphieunhapxuat` 
								where  maphieu=". $maphieu . $where;
								
		$query = $this->db->query($sql);
		return $query->rows;
	}
	
	public function getChiTietPhieuXuatNhap( $where="")
	{
		$sql = "Select `qlkchitietphieunhapxuat`.* 
								from `qlkchitietphieunhapxuat` 
								where 1=1 ". $where;
								
		$query = $this->db->query($sql);
		return $query->rows;
	}
	
	public function getPhieuNhapXuats($where="", $from=0, $to=0, $order="")
	{
		$sql = "Select `qlkphieunhapxuat`.* 
									from `qlkphieunhapxuat` 
									where trangthai <> 'deleted'" . $where . $order;
		if($to > 0)
		{
			$sql .= " Limit ".$from.",".$to;
		}
		
		$query = $this->db->query($sql);
		return $query->rows;
	}
	
	public function nextID()
	{
		return $this->db->getNextId('qlkphieunhapxuat','id');
	}
	
	public function nextMaPhieu($prefix)
	{
		$stt = $this->db->getNextIdVarCharNumber("qlkphieunhapxuat","maphieu",$prefix);
		return $stt.$prefix;
	}
	
	public function insert($data)
	{
		/*
		id,
		maphieu,
		ngaynhap,
		nguoigiao,
		nguoinhan,
		loainguon,
		maphieunguon,
		makho,
		macongdoan,
		tinhtrang,
		loaiphieu,
		ngayxuat,
		mahopdong,
		ngaylapphieu,
		nguoilap,
		trangthai,
		loainhapxuat
		ghichu
		*/
	
		$id= $this->nextID();
		$maphieu= $this->db->escape(@$data['maphieu']);
		$ngaynhap= $this->db->escape(@$data['ngaynhap']);
		if($ngaynhap == "")
			$ngaynhap = $this->date->getToday();
		$nguoigiao= $this->db->escape(@$data['nguoigiao']);
		$nguoinhan= $this->db->escape(@$data['nguoinhan']);
		$loainguon= $this->db->escape(@$data['loainguon']);
		$maphieunguon= $this->db->escape(@$data['maphieunguon']);
		$makho= $this->db->escape(@$data['makho']);
		$macongdoan= $this->db->escape(@$data['macongdoan']);
		$tinhtrang= $this->db->escape(@$data['tinhtrang']);
		$loaiphieu = $this->db->escape(@$data['loaiphieu']);
		$ngayxuat= $this->db->escape(@$data['ngayxuat']);
		if($ngayxuat == "")
			$ngayxuat = $this->date->getToday();
		$mahopdong= $this->db->escape(@$data['mahopdong']);
		$ngaylapphieu= $this->db->escape(@$data['ngaylapphieu']);
		$nguoilap= $this->db->escape(@$data['nguoilap']);
		$ghichu= $this->db->escape(@$data['ghichu']);
		$trangthai= "pending";
		$loainhapxuat = $this->db->escape(@$data['loainhapxuat']);
		$lenhxuat = $this->db->escape(@$data['lenhxuat']);
		$lydoxuat = $this->db->escape(@$data['lydoxuat']);
		$field=array(
						'id',
						'maphieu',
						'ngaynhap',
						'nguoigiao',
						'nguoinhan',
						'loainguon',
						'maphieunguon',
						'makho',
						'macongdoan',
						'tinhtrang',
						'loaiphieu',
						'ngayxuat',
						'mahopdong',
						'ngaylapphieu',
						'nguoilap',
						'trangthai',
						'loainhapxuat',
						'lenhxuat',
						'lydoxuat',
						'ghichu'
					);
		$value=array(
						$id,

						$maphieu,
						$ngaynhap,
						$nguoigiao,
						$nguoinhan,
						$loainguon,
						$maphieunguon,
						$makho,
						$macongdoan,
						$tinhtrang,
						$loaiphieu,
						$ngayxuat,
						$mahopdong,
						$ngaylapphieu,
						$nguoilap,
						$trangthai,
						$loainhapxuat,
						$lenhxuat,
						$lydoxuat,
						$ghichu
					);
		$this->db->insertData("qlkphieunhapxuat",$field,$value);
		
		return $id;
	}
	
	public function update($data)
	{
		$id = $this->db->escape(@$data['id']);
		$maphieu= $this->db->escape(@$data['maphieu']);
		$ngaynhap= $this->db->escape(@$data['ngaynhap']);
		if($ngaynhap == "")
			$ngaynhap = $this->date->getToday();
		$nguoigiao= $this->db->escape(@$data['nguoigiao']);
		$nguoinhan= $this->db->escape(@$data['nguoinhan']);
		$loainguon= $this->db->escape(@$data['loainguon']);
		$maphieunguon= $this->db->escape(@$data['maphieunguon']);
		$makho= $this->db->escape(@$data['makho']);
		$macongdoan= $this->db->escape(@$data['macongdoan']);
		$tinhtrang= $this->db->escape(@$data['tinhtrang']);
		$loaiphieu = $this->db->escape(@$data['loaiphieu']);
		$ngayxuat= $this->db->escape(@$data['ngayxuat']);
		if($ngayxuat == "")
			$ngayxuat = $this->date->getToday();
		$mahopdong= $this->db->escape(@$data['mahopdong']);
		$ngaylapphieu= $this->db->escape(@$data['ngaylapphieu']);
		$nguoilap= $this->db->escape(@$data['nguoilap']);
		$ghichu= $this->db->escape(@$data['ghichu']);
		//$trangthai= "pending";
		$loainhapxuat = $this->db->escape(@$data['loainhapxuat']);
		$lenhxuat = $this->db->escape(@$data['lenhxuat']);
		$lydoxuat = $this->db->escape(@$data['lydoxuat']);
		
		$field=array(
						'id',
						'maphieu',
						//'ngaynhap',
						'nguoigiao',
						'nguoinhan',
						'loainguon',
						'maphieunguon',
						'makho',
						'macongdoan',
						'tinhtrang',
						'loaiphieu',
						//'ngayxuat',
						'mahopdong',
						'ngaylapphieu',
						'nguoilap',
						//'trangthai',
						'loainhapxuat',
						'lenhxuat',
						'lydoxuat',
						'ghichu'
					);
		$value=array(
						$id,
						$maphieu,
						//$ngaynhap,
						$nguoigiao,
						$nguoinhan,
						$loainguon,
						$maphieunguon,
						$makho,
						$macongdoan,
						$tinhtrang,
						$loaiphieu,
						//$ngayxuat,
						$mahopdong,
						$ngaylapphieu,
						$nguoilap,
						//$trangthai,
						$loainhapxuat,
						$lenhxuat,
						$lydoxuat,
						$ghichu
					);
		
		$where="id = " .$id;
		$this->db->updateData("qlkphieunhapxuat",$field,$value,$where);
		
		return true;
	}
	
	public function updatePhieuNhapXuat($id,$col,$val)
	{
		$id= $this->db->escape(@$id);
		$val= $this->db->escape(@$val);
		$field=array(
						$col
					);
		$value=array(
						$val
					);
		
		$where="id = '".$id. "'";
		$this->db->updateData("qlkphieunhapxuat",$field,$value,$where);
	}
	
	public function save($data)
	{
		$item = $this->getItem($data['id']);
		if(count($item) == 0)
		{
			$this->insert($data);
		}
		else
		{
			$this->update($data);
		}
	}
	
	public function updateTrangThaiByMaPhieu($maphieu,$trangthai)
	{
		$maphieu= $this->db->escape(@$maphieu);
		$trangthai= $this->db->escape(@$trangthai);
		$field=array(
						
						'trangthai'
					);
		$value=array(
						$trangthai
					);
		
		$where="maphieu = '" .$maphieu."'";
		$this->db->updateData("qlkphieunhapxuat",$field,$value,$where);
		
		return true;
	}
	
	public function updateTrangThai($id,$trangthai)
	{		
		$field=array(
						'trangthai'
					);
		$value=array(
						$trangthai
					);
		
		$where="id = '".$id. "'";
		$this->db->updateData("qlkphieunhapxuat",$field,$value,$where);
	}
	
	
	public function delete($id)
	{		
		/*$field=array(
						'trangthai'
					);
		$value=array(
						'deleted'
					);
		
		$where="id = ".$id;
		$this->db->updateData("qlkphieunhapxuat",$field,$value,$where);*/
		
		$where="maphieu = '".$id. "'";
		$this->db->deleteData("qlkchitietphieunhapxuat",$where);
		
		$where="id = '".$id. "'";
		$this->db->deleteData("qlkphieunhapxuat",$where);
		
	}
	
	public function deletePhieuXuat($id)
	{		
		$where = " AND phieuxuat = '".$id."'";
		$chitiets = $this->getChiTietPhieuXuatNhap($where);
		foreach($chitiets as $val)
		{
			$this->updateChitietPhieuXuat($val['id'],0);
		}
		
		$where="id = '".$id. "'";
		$this->db->deleteData("qlkphieunhapxuat",$where);
		
	}
	
	public function deletedatas($data)
	{
		if(count($data)>0)
		{
			foreach($data as $item)	
				$this->delete($item);
		}
	}
	
	//chitiet phieu nhap xuat
	/*
		cac cot trong phieu nhap xuat
		id
		maphieu
		itemid
		itemname
		lot
		soluong
		dongia
		madonvi
		trongluong
		socongtrenky
		thucxuat
		thucnhap
		thanhtien
	*/
	
	private function createTemID($prefix)
	{
		$stt = $this->db->getNextIdVarCharNumber("qlkchitietphieunhapxuat","id",$prefix);
		return $prefix.$stt;
	}
	
	public function saveChiTiet($data)
	{
		$id= $this->db->escape(@$data['id']);
		$prefix= $this->db->escape(@$data['prefix']);
		
		$maphieu= $this->db->escape(@$data['maphieu']);
		$itemid= $this->db->escape(@$data['itemid']);
		$itemname = $this->db->escape(@$data['itemname']);
		$makho = $this->db->escape(@$data['makho']);
		$lot = $this->string->toNumber($this->db->escape(@$data['lot']));
		$soluong = $this->string->toNumber($this->db->escape(@$data['soluong']));
		$dongia = $this->string->toNumber($this->db->escape(@$data['dongia']));
		$madonvi = $this->db->escape(@$data['madonvi']);
		$trongluong=$this->string->toNumber($this->db->escape(@$data['soluong']));
		$socongtrenky=$this->string->toNumber($this->db->escape(@$data['socongtrenky']));
		$thucxuat=$this->string->toNumber($this->db->escape(@$data['thucxuat']));
		$thucnhap=$this->string->toNumber($this->db->escape(@$data['thucnhap']));
		$baobi=$this->string->toNumber($this->db->escape(@$data['baobi']));
		$thanhtien= $soluong * $dongia;
		$ghichu=$this->string->toNumber($this->db->escape(@$data['ghichu']));
		$vitri=$this->string->toNumber($this->db->escape(@$data['vitri']));
		$field=array(
						'id',
						'maphieu',
						'itemid',
						'itemname',
						'makho',
						'lot',
						'soluong',
						'dongia',
						'madonvi',
						'trongluong',
						'socongtrenky',
						'thucxuat',
						'thucnhap',
						'baobi',
						'thanhtien',
						'ghichu',
						'vitri'
						
					);
		$value=array(
						$id,
						$maphieu,
						$itemid,
						$itemname,
						$makho,
						$lot,
						$soluong,
						$dongia,
						$madonvi,
						$trongluong,
						$socongtrenky,
						$thucxuat,
						$thucnhap,
						$baobi,
						$thanhtien,
						$ghichu,
						$vitri
					);
		
		if($id == "" )
		{
			$id = $this->createTemID($prefix."-".$this->document->getNguyenLieu($itemid,'manguyenlieu')."-");
			$value[0] = $id;
			$this->db->insertData("qlkchitietphieunhapxuat",$field,$value);
		}
		else
		{
			$where="id = '".$id."'";
			$this->db->updateData("qlkchitietphieunhapxuat",$field,$value,$where);
		}
		
		return $id;
	}
	
	public function updateChitietPhieuXuat($id,$phieuxuat)
	{
		$id= $this->db->escape(@$id);
		$phieuxuat= $this->db->escape(@$phieuxuat);
		$field=array(
						'phieuxuat'
					);
		$value=array(
						$phieuxuat
					);
		
		$where="id = '".$id. "'";
		$this->db->updateData("qlkchitietphieunhapxuat",$field,$value,$where);
	}
	
	public function updateChitietTrangThai($id,$trangthai)
	{
		$id= $this->db->escape(@$id);
		$phieuxuat= $this->db->escape(@$trangthai);
		$field=array(
						'trangthai'
					);
		$value=array(
						$trangthai
					);
		
		$where="id = '".$id. "'";
		$this->db->updateData("qlkchitietphieunhapxuat",$field,$value,$where);
	}
	
	public function updateChitiet($id,$col,$val)
	{
		$id= $this->db->escape(@$id);
		$val= $this->db->escape(@$val);
		$field=array(
						$col
					);
		$value=array(
						$val
					);
		
		$where="id = '".$id. "'";
		$this->db->updateData("qlkchitietphieunhapxuat",$field,$value,$where);
	}
	
	public function deletechitiet($id)
	{
		$where="id = '".$id. "'";
		$this->db->deleteData("qlkchitietphieunhapxuat",$where);
	}
	
	public function tinhSoLuongTon($manguyenlieu)
	{
		//Lay tat ca tem co phieu xuat = 0 and trangthai = 'complete'
		$manguyenlieu= $this->db->escape(@$manguyenlieu);
		$where = " AND itemid ='".$manguyenlieu."' ";
		$where .= " AND phieuxuat = 0 AND trangthai = 'completed'";
		$chitiets = $this->getChiTietPhieuXuatNhap($where);
		//Tinh tong so luong cac tem duoc lay
		$sum = 0;
		foreach($chitiets as $val)
		{
			$sum += $val['thucnhap'];	
		}
		return $sum;
	}
}
?>