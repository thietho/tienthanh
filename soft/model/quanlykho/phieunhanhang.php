<?php
class ModelQuanlykhoPhieunhanhang extends Model
{ 
	public function getItem($id, $where="")
	{
		$id= $this->db->escape(@$id);
		$query = $this->db->query("Select `qlkphieunhanhang`.* 
									from `qlkphieunhanhang` 
									where trangthai <> 'deleted' AND id ='".$id."' ".$where);
		return $query->row;
	}
	
	public function getItemByMaPhieu($maphieunhanhang, $where="")
	{
		$maphieunhanhang= $this->db->escape(@$maphieunhanhang);
		$query = $this->db->query("Select `qlkphieunhanhang`.* 
									from `qlkphieunhanhang` 
									where trangthai <> 'deleted' AND maphieunhanhang ='".$maphieunhanhang."' ".$where);
		return $query->row;
	}
	
	public function getChiTietPhieuNhanHangs($where="")
	{
		$sql = "Select `qlkchitietphieunhanhang`.* 
								from `qlkchitietphieunhanhang` 
								where 1=1 " . $where;
								
		$query = $this->db->query($sql);
		return $query->rows;
	}
	
	public function getList($where="", $from=0, $to=0, $order="")
	{
		$sql = "Select `qlkphieunhanhang`.* 
									from `qlkphieunhanhang` 
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
		return $this->db->getNextId('qlkphieunhanhang','id');
	}
	
	public function insert($data)
	{
		$id= $this->nextID();
		$maphieunhanhang= $this->db->escape(@$data['maphieunhanhang']);
		$manhacungung= $this->db->escape(@$data['manhacungung']);
		$mahopdong= $this->db->escape(@$data['mahopdong']);
		$langiao= $this->db->escape(@$data['langiao']);
		$manhanviennhanhang= $this->string->toNumber($this->db->escape(@$data['manhanviennhanhang']));
		
		$ngaylap= $this->db->escape(@$data['ngaylap']);
		$ngaygiao= $this->db->escape(@$data['ngaygiao']);
		
		$danhgiasoluong= $this->db->escape(@$data['danhgiasoluong']);
		$danhgiachatluong= $this->db->escape(@$data['danhgiachatluong']);
		$danhgiathoigian= $this->db->escape(@$data['danhgiathoigian']);
		$danhgiathanhtoan= $this->db->escape(@$data['danhgiathanhtoan']);
		$tinhtrangthanhtoan = $this->db->escape(@$data['tinhtrangthanhtoan']);
		$ghichu = $this->db->escape(@$data['ghichu']);
		$trangthai = $this->db->escape(@$data['trangthai']);
		
		$field=array(
						'id',
						'maphieunhanhang',
						'manhacungung',
						'mahopdong',
						'langiao',
						'manhanviennhanhang',
						'ngaylap',
						'ngaygiao',
						'danhgiasoluong',
						'danhgiachatluong',
						'danhgiathoigian',
						'danhgiathanhtoan',
						'tinhtrangthanhtoan',
						'ghichu',
						'trangthai'
					);
		$value=array(
						$id,
						$maphieunhanhang,
						$manhacungung,
						$mahopdong,
						$langiao,
						$manhanviennhanhang,
						$ngaylap,
						$ngaygiao,
						$danhgiasoluong,
						$danhgiachatluong,
						$danhgiathoigian,
						$danhgiathanhtoan,
						$tinhtrangthanhtoan,
						$ghichu,
						'pending'
					);
		$this->db->insertData("qlkphieunhanhang",$field,$value);
		
		return $id;
	}
	
	public function update($data)
	{
		$id = $this->db->escape(@$data['id']);
		$maphieunhanhang= $this->db->escape(@$data['maphieunhanhang']);
		$manhacungung= $this->db->escape(@$data['manhacungung']);
		$mahopdong= $this->db->escape(@$data['mahopdong']);
		$langiao= $this->db->escape(@$data['langiao']);
		$manhanviennhanhang= $this->string->toNumber($this->db->escape(@$data['manhanviennhanhang']));
		$ngaylap= $this->db->escape(@$data['ngaylap']);
		$ngaygiao= $this->db->escape(@$data['ngaygiao']);
		$danhgiasoluong= $this->db->escape(@$data['danhgiasoluong']);
		$danhgiachatluong= $this->db->escape(@$data['danhgiachatluong']);
		$danhgiathoigian= $this->db->escape(@$data['danhgiathoigian']);
		$danhgiathanhtoan= $this->db->escape(@$data['danhgiathanhtoan']);
		$tinhtrangthanhtoan = $this->db->escape(@$data['tinhtrangthanhtoan']);
		$ghichu = $this->db->escape(@$data['ghichu']);
		
		$field=array(
						'id',
						'maphieunhanhang',
						'manhacungung',
						'mahopdong',
						'langiao',
						'manhanviennhanhang',
						'ngaylap',
						'ngaygiao',
						'danhgiasoluong',
						'danhgiachatluong',
						'danhgiathoigian',
						'danhgiathanhtoan',
						'tinhtrangthanhtoan',
						'ghichu'
					);
		$value=array(
						$id,
						$maphieunhanhang,
						$manhacungung,
						$mahopdong,
						$langiao,
						$manhanviennhanhang,
						$ngaylap,
						$ngaygiao,
						$danhgiasoluong,
						$danhgiachatluong,
						$danhgiathoigian,
						$danhgiathanhtoan,
						$tinhtrangthanhtoan,
						$ghichu
					);
		
		$where="id = " .$id;
		$this->db->updateData("qlkphieunhanhang",$field,$value,$where);
		
		return true;
	}
	
	public function updateTrangThaiByMaPhieu($maphieunhanhang,$trangthai)
	{
		$maphieunhanhang= $this->db->escape(@$maphieunhanhang);
		$trangthai= $this->db->escape(@$trangthai);
		$field=array(
						
						'trangthai'
					);
		$value=array(
						$trangthai
					);
		
		$where="maphieunhanhang = '" .$maphieunhanhang."'";
		$this->db->updateData("qlkphieunhanhang",$field,$value,$where);
		
		return true;
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
	
	public function updateTrangThai($id,$trangthai)
	{		
		$field=array(
						'trangthai'
					);
		$value=array(
						$trangthai
					);
		
		$where="id = '".$id;
		$this->db->updateData("qlkphieunhanhang",$field,$value,$where);
	}
	
	
	public function delete($id)
	{		
		$field=array(
						'trangthai'
					);
		$value=array(
						'deleted'
					);
		
		$where="id = ".$id;
		$this->db->updateData("qlkphieunhanhang",$field,$value,$where);
	}
	
	public function deletedatas($data)
	{
		if(count($data)>0)
		{
			foreach($data as $item)	
				$this->delete($item);
		}
	}
	
	//chitiet phieu nhan hang
	public function saveChiTiet($data)
	{
		$id=(int)@$data['id'];
		$maphieunhanhang=$this->db->escape(@$data['maphieunhanhang']);
		$manguyenlieu=$this->db->escape(@$data['manguyenlieu']);
		$tennguyenlieu=$this->db->escape(@$data['tennguyenlieu']);
		$soluong=$this->string->toNumber($this->db->escape(@$data['soluong']));
		$dongia=$this->string->toNumber($this->db->escape(@$data['dongia']));
		$danhgiachatluong=$this->db->escape(@$data['danhgiachatluong']);
		$soluongnhan=$this->string->toNumber($this->db->escape(@$data['soluongnhan']));
		$soluongtralai=$this->string->toNumber($this->db->escape(@$data['soluongtralai']));
		
		$field=array(
						'id',
						'maphieunhanhang',
						'manguyenlieu',
						'tennguyenlieu',
						'soluong',
						'dongia',
						'danhgiachatluong',
						'soluongnhan',
						'soluongtralai'
					);
		$value=array(
						$id,
						$maphieunhanhang,
						$manguyenlieu,
						$tennguyenlieu,
						$soluong,
						$dongia,
						$danhgiachatluong,
						$soluongnhan,
						$soluongtralai
					);
		
		if($id == 0 )
		{
			$this->db->insertData("qlkchitietphieunhanhang",$field,$value);
		}
		else
		{
			$where="id = '".$id."'";
			$this->db->updateData("qlkchitietphieunhanhang",$field,$value,$where);
		}
	}
	
	public function deletechitiet($id)
	{
		$where="id = '".$id."'";
		$this->db->deleteData("qlkchitietphieunhanhang",$where);
	}
	
	
	
	
	
}
?>