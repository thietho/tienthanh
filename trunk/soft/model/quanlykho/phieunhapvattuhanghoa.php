<?php
class ModelQuanlykhoPhieunhapvattuhanghoa extends Model 
{
	private $columns = array(
								'phieunhapvattuhanghoaid',
								'sophieu',
								'ngaylap',
								'createdate',
								'createby',
								'kehoachdathang',
								'kehoachngay',
								
								'tinhtrang',
								'status'
							);
	public function getList($where = "")
	{
		$sql = "Select `qlkphieunhanvattuhanghoa`.* from `qlkphieunhanvattuhanghoa` where `status` <> 'deleted' ".$where;
		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function getItem($phieunhapvattuhanghoaid)
	{
		$sql = "Select * from `qlkphieunhanvattuhanghoa` where phieunhapvattuhanghoaid = '".$phieunhapvattuhanghoaid."'";
		$query = $this->db->query($sql);
		return $query->row;
	}
	
	private function creatsophieu()
	{
		return $this->db->getNextId('qlkphieunhanvattuhanghoa','sophieu');
	}
	
	public function insert($data)
	{
		
		$data['sophieu']=$this->creatsophieu();
		$data['ngaylap']=$this->db->escape(@$this->date->formatViewDate($data['ngaylap']));
		$data['kehoachngay']=$this->db->escape(@$this->date->formatViewDate($data['kehoachngay']));
		$data['createdate'] = $this->date->getToday();
		$data['createby'] = $this->user->getId();
		$data['status']='active';
		foreach($this->columns as $val)
		{			
			$field[] = $val;
			$value[] = $this->db->escape($data[$val]);	
			
		}
		$getLastId = $this->db->insertData("qlkphieunhanvattuhanghoa",$field,$value);
				
		return $getLastId;
	}
	
	
	public function update($data)
	{	
		$data['ngaylap']=$this->db->escape(@$this->date->formatViewDate($data['ngaylap']));
		$data['kehoachngay']=$this->db->escape(@$this->date->formatViewDate($data['kehoachngay']));
		foreach($this->columns as $val)
		{
	
			if($data[$val]!="")
			{
				$field[] = $val;
				$value[] = $this->db->escape($data[$val]);	
			}
		}
					
		$where="phieunhapvattuhanghoaid = '".$data['phieunhapvattuhanghoaid']."'";
		$this->db->updateData("qlkphieunhanvattuhanghoa",$field,$value,$where);
	}	
		
	public function updateCol($phieunhapvattuhanghoaid,$col,$val)
	{
		$phieunhapvattuhanghoaid=$this->db->escape(@$phieunhapvattuhanghoaid);
		$col=$this->db->escape(@$col);
		$val=$this->db->escape(@$val);
		$field=array(
						$col
					);
		$value=array(
						$val
					);
					
		$where="phieunhapvattuhanghoaid = '".$phieunhapvattuhanghoaid."'";
		$this->db->updateData("qlkphieunhanvattuhanghoa",$field,$value,$where);
	}
	
	//Xóa phieu
	public function delete($phieunhapvattuhanghoaid)
	{
		$phieunhapvattuhanghoaid=$this->db->escape(@$phieunhapvattuhanghoaid);
		$this->updateCol($phieunhapvattuhanghoaid,"status",'deleted');
		
		$field=array(
						'status'
					);
		$value=array(
						'deleted'
					);
		$where="phieunhapvattuhanghoaid = '".$phieunhapvattuhanghoaid."'";
		$this->db->updateData('qlkphieunhapvattuhanghoa_chitiet',$field,$value,$where);
	}
	//Huy phieu
	public function destroy($lenhsanxuatid)
	{
		
		$where="lenhsanxuatid = '".$lenhsanxuatid."'";
		$this->db->updateData('qlkphieunhapvattuhanghoa_chitiet',$field,$value,$where);
		$this->db->deleteData('qlkphieunhanvattuhanghoa',$where);
	}
	//chi tiet phieu
	public function getPhieuNhanVatTuHangHoaChiTiet($id)
	{
		$sql = "Select * 
						from `qlkphieunhapvattuhanghoa_chitiet` 
						where id ='".$id."'";
		$query = $this->db->query($sql);
		return $query->row;	
	}
	
	public function getPhieuNhanVatTuHangHoaChiTietList($where)
	{
		$sql = "Select `qlkphieunhapvattuhanghoa_chitiet`.* 
									from `qlkphieunhapvattuhanghoa_chitiet` 
									where status <> 'deleted' " . $where ;
		
		$query = $this->db->query($sql);
		return $query->rows;
	}
	
	public function savePhieuNhanVatTuHangHoaChiTiet($data)
	{
		$data['lotnguyenlieu'] = $this->db->escape(@$data['lotnguyenlieu']);
		if($data['lotnguyenlieu'] == "")
			$data['lotnguyenlieu'] = $this->createLotNguyenLieu($data['manguyenlieu']);
		$data['chungtu']=$this->db->escape(@$this->string->toNumber($data['chungtu']));
		$data['thucnhap']=$this->db->escape(@$this->string->toNumber($data['thucnhap']));
		$data['dongia']=$this->db->escape(@$this->string->toNumber($data['dongia']));
		//$data['thanhtien'] = $data['thucnhap'] * $data['dongia'];
		$data['status']='active';
		
		foreach($data as $key => $val)
		{
			if($val!="")
			{
				$field[] = $key;
				$value[] = $this->db->escape($val);	
			}
		}		
		
		if((int)$data['id']==0)
		{
			
			$this->db->insertData("qlkphieunhapvattuhanghoa_chitiet",$field,$value);
			$id = $this->db->getLastId();
		}
		else
		{			
			$where="id = '".$data['id']."'";
			$this->db->updateData('qlkphieunhapvattuhanghoa_chitiet',$field,$value,$where);
		}
		return $id;
	}
	
	public function updatePhieuNhanVatTuHangHoaChiTiet($id,$col,$val)
	{
		$id = $this->db->escape(@$id);
		$col=$this->db->escape(@$col);
		$val=$this->db->escape(@$val);
		
		$field=array(
						$col
						
					);
		$value=array(
						$val
					);
		
		$where="id = '".$id."'";
		$this->db->updateData('qlkphieunhapvattuhanghoa_chitiet',$field,$value,$where);
	}
		
	public function deletePhieuNhanVatTuHangHoaChiTiet($id)
	{
		$id = $this->db->escape(@$id);		
		
		$where="id = '".$id."'";
		$this->db->deleteData('qlkphieunhapvattuhanghoa_chitiet',$where);
	}
	
	private function createLotNguyenLieu($manguyenlieu)
	{
		$prefix = $manguyenlieu;
		$now = $this->date->getToday();
		$year = $this->date->getYear($now);
		$month = $this->date->getMonth($now);
		$prefix.="-".$year.$month;
		return $this->db->getNextIdVarChar('qlkphieunhapvattuhanghoa_chitiet','lotnguyenlieu',$prefix);
	}
	
	
}
?>