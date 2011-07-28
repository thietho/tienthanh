<?php
class ModelQuanlykhoPhieuthuthap extends Model
{ 
	//qlkphieuthuthap bao gom cac thuoc tinh
	/*
		id,
		maphieu,
		macongdoan,
		ngay,
		ca,
		may,
		nhanviensanxuat,
		soluongsanxuat,
		trangthai
	*/
	public function getItem($id, $where="")
	{
		$sql = "Select `qlkphieuthuthap`.* 
									from `qlkphieuthuthap` 
									where trangthai <> 'deleted' AND id ='".$id."' ".$where;
		$query = $this->db->query($sql);
		return $query->row;
	}
	
	public function getList($where="", $from=0, $to=0, $order="")
	{
		$sql = "Select `qlkphieuthuthap`.* 
									from `qlkphieuthuthap` 
									where trangthai <> 'deleted' " . $where . $order;
		if($to > 0)
		{
			$sql .= " Limit ".$from.",".$to;
		}
		
		$query = $this->db->query($sql);
		return $query->rows;
	}
	
	public function nextID()
	{
		return $this->db->getNextId('qlkphieuthuthap','id');
	}
	
	public function nextMaPhieu($prefix)
	{
		return $this->db->getNextIdVarChar('qlkphieuthuthap','maphieu',$prefix);
	}
	
	public function insert($data)
	{
		$id= $this->nextID();
		$maphieu= $this->nextMaPhieu("phieuthuthap");
		$macongdoan= $this->db->escape(@$data['macongdoan']);
		$ngay=$this->db->escape(@$data['ngay']);
		$ca=$this->db->escape(@$data['ca']);
		$may=$this->db->escape(@$data['may']);
		$nhanviensanxuat=$this->db->escape(@$data['nhanviensanxuat']);
		$soluongsanxuat= $this->string->toNumber($this->db->escape(@$data['soluongsanxuat']));
		$ngaylapphieu= $this->db->escape(@$data['ngaylapphieu']);
		$nguoilap = $this->user->nhanvien['id'];
		$ghichu= $this->string->toNumber($this->db->escape(@$data['ghichu']));
		$trangthai= "active";
		$field=array(
					 	'id',
						'maphieu',
						'macongdoan',
						'ngay',
						'ca',
						'may',
						'nhanviensanxuat',
						'soluongsanxuat',
						'ngaylapphieu',
						'nguoilap',
						'ghichu',
						'trangthai'
					);
		$value=array(
					 	$id,
						$maphieu,
						$macongdoan,
						$ngay,
						$ca,
						$may,
						$nhanviensanxuat,
						$soluongsanxuat,
						$ngaylapphieu,
						$nguoilap,
						$ghichu,
						$trangthai
					);
		$this->db->insertData("qlkphieuthuthap",$field,$value);
		
		return $id;
	}
	
	public function update($data)
	{
		$id= $this->db->escape(@$data['id']);
		$maphieu= $this->db->escape(@$data['maphieu']);
		$macongdoan= $this->db->escape(@$data['macongdoan']);
		$ngay=$this->db->escape(@$data['ngay']);
		$ca=$this->db->escape(@$data['ca']);
		$may=$this->db->escape(@$data['may']);
		$nhanviensanxuat=$this->db->escape(@$data['nhanviensanxuat']);
		$soluongsanxuat= $this->string->toNumber($this->db->escape(@$data['soluongsanxuat']));
		$ngaylapphieu= $this->db->escape(@$data['ngaylapphieu']);
		$nguoilap = $this->user->nhanvien['id'];
		$ghichu= $this->string->toNumber($this->db->escape(@$data['ghichu']));
		$trangthai= "active";
		
		$field=array(
						'maphieu',
						'macongdoan',
						'ngay',
						'ca',
						'may',
						'nhanviensanxuat',
						'soluongsanxuat',
						'ngaylapphieu',
						'nguoilap',
						'ghichu'
						
					);
		$value=array(
						$maphieu,
						$macongdoan,
						$ngay,
						$ca,
						$may,
						$nhanviensanxuat,
						$soluongsanxuat,
						$ngaylapphieu,
						$nguoilap,
						$ghichu
						
					);
		
		$where="id = '".$id."'";
		$this->db->updateData("qlkphieuthuthap",$field,$value,$where);
		
		return $id;
	}
	
	/*public function savePhieu($data)
	{
		$item = $this->getItem($data['id']);
		
		if(count($item) == 0)
		{
			return $this->insert($data);
		}
		else
		{
			return $this->update($data);
		}
	}*/
	
	public function updateTrangThai($maphieu, $trangthai)
	{		
		$field=array(
						'trangthai'
					);
		$value=array(
						$trangthai
					);
		
		$where="id = '".$id."'";
		$this->db->updateData("qlkphieuthuthap",$field,$value,$where);
	}
	
	public function deletedatas($data)
	{
		if(count($data)>0)
		{
			foreach($data as $item)	
				$this->updateTrangThai($item, 'deleted');
		}
	}
	
	//qlkchitietphieuthuthap
	/*
		id,
		maphieu,
		gio,
		thanhpham,
		phelieu,
		phepham,
		haohut,
		ghichu
	*/
	
	public function getChiTiet($id)
	{
		$sql = "Select `qlkchitietphieuthuthap`.* 
									from `qlkchitietphieuthuthap` 
									where id ='".$id."' ";
		$query = $this->db->query($sql);
		return $query->row;
	}
	
	public function getChiTiets($where = "")
	{
		$sql = "Select `qlkchitietphieuthuthap`.* 
									from `qlkchitietphieuthuthap` 
									where 1=1 ".$where;
		$query = $this->db->query($sql);
		return $query->rows;
	}
	
	public function saveChiTiet($data)
	{
		$id= (int)@$data['id'];
		
		
		$maphieu= $this->db->escape(@$data['maphieu']);
		$gio= $this->db->escape(@$data['gio']);
		$thanhpham = $this->string->toNumber($this->db->escape(@$data['thanhpham']));
		$phelieu = $this->string->toNumber($this->db->escape(@$data['phelieu']));
		$phepham = $this->string->toNumber($this->db->escape(@$data['phepham']));
		$haohut = $this->string->toNumber($this->db->escape(@$data['haohut']));
		$ghichu = $this->db->escape(@$data['ghichu']);
		
		$field=array(
						'id',
						'maphieu',
						'gio',
						'thanhpham',
						'phelieu',
						'phepham',
						'haohut',
						'ghichu'
						
					);
		$value=array(
						$id,
						$maphieu,
						$gio,
						$thanhpham,
						$phelieu,
						$phepham,
						$haohut,
						$ghichu
					);
		
		if($id == 0 )
		{
			
			$this->db->insertData("qlkchitietphieuthuthap",$field,$value);
		}
		else
		{
			$where="id = '".$id."'";
			$this->db->updateData("qlkchitietphieuthuthap",$field,$value,$where);
		}
		
		return $id;
	}
	
	public function deletechitiet($id)
	{
		$where="id = '".$id. "'";
		$this->db->deleteData("qlkchitietphieuthuthap",$where);
	}
}
?>