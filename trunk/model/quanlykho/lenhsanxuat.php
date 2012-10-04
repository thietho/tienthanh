<?php
class ModelQuanlykhoLenhsanxuat extends Model 
{
	private $columns = array(
								'lenhsanxuatid',
								'solenhsanxuat',
								'phongbannhan',
								'nhanvien',
								'ktvien',
								'sanphamid',
								'masanpham',
								'tensanpham',
								'lotsp',
								'solotsx',
								'bmsx07',
								'nhomsx',
								'ngaysx',
								'ngayhoanthanh',
								'qdgiaso',
								'ngayqdg',
								'trongluongsx',
								'phutrachchinh',
								'phieucarso',
								'ngayphatlenh',
								'tinhtrang',
								'status',
								'createdate',
								'createby',
								'loaisx'
							);
	public function getList($where = "")
	{
		$sql = "Select `qlklenhsanxuat`.* from `qlklenhsanxuat` where `status` <> 'deleted' ".$where;
		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function getItem($lenhsanxuatid)
	{
		$sql = "Select * from `qlklenhsanxuat` where lenhsanxuatid = '".$lenhsanxuatid."'";
		$query = $this->db->query($sql);
		return $query->row;
	}
	
	private function creatsolenhsanxuat()
	{
		return $this->db->getNextId('qlklenhsanxuat','solenhsanxuat');
	}
	
	public function insert($data)
	{
		
		$data['solenhsanxuat']=$this->creatsolenhsanxuat();
		$data['ngayphatlenh']=$this->db->escape(@$this->date->formatViewDate($data['ngayphatlenh']));
		$data['ngaysx']=$this->db->escape(@$this->date->formatViewDate($data['ngaysx']));
		$data['ngayhoanthanh']=$this->db->escape(@$this->date->formatViewDate($data['ngayhoanthanh']));
		$data['ngayqdg']=$this->db->escape(@$this->date->formatViewDate($data['ngayqdg']));
		$data['trongluongsx']=$this->db->escape(@$this->string->toNumber($data['trongluongsx']));
		$data['createdate'] = $this->date->getToday();
		$data['createby'] = $this->user->getId();
		$data['status']='active';
		foreach($this->columns as $val)
		{			
			$field[] = $val;
			$value[] = $this->db->escape($data[$val]);	
			
		}
		$getLastId = $this->db->insertData("qlklenhsanxuat",$field,$value);
				
		return $getLastId;
	}
	
	
	public function update($data)
	{	
		$data['ngayphatlenh']=$this->db->escape(@$this->date->formatViewDate($data['ngayphatlenh']));
		$data['ngaysx']=$this->db->escape(@$this->date->formatViewDate($data['ngaysx']));
		$data['ngayhoanthanh']=$this->db->escape(@$this->date->formatViewDate($data['ngayhoanthanh']));
		$data['ngayqdg']=$this->db->escape(@$this->date->formatViewDate($data['ngayqdg']));
		$data['trongluongsx']=$this->db->escape(@$this->string->toNumber($data['trongluongsx']));
		
		foreach($this->columns as $val)
		{
	
			if($data[$val]!="")
			{
				$field[] = $val;
				$value[] = $this->db->escape($data[$val]);	
			}
		}
					
		$where="lenhsanxuatid = '".$data['lenhsanxuatid']."'";
		$this->db->updateData("qlklenhsanxuat",$field,$value,$where);
	}	
		
	public function updateCol($lenhsanxuatid,$col,$val)
	{
		$lenhsanxuatid=$this->db->escape(@$lenhsanxuatid);
		$col=$this->db->escape(@$col);
		$val=$this->db->escape(@$val);
		$field=array(
						$col
					);
		$value=array(
						$val
					);
					
		$where="lenhsanxuatid = '".$lenhsanxuatid."'";
		$this->db->updateData("qlklenhsanxuat",$field,$value,$where);
	}
	
	//Xóa phieu
	public function delete($lenhsanxuatid)
	{
		$lenhsanxuatid=$this->db->escape(@$lenhsanxuatid);
		$this->updateCol($lenhsanxuatid,"status",'deleted');
		
		$field=array(
						'status'
					);
		$value=array(
						'deleted'
					);
		$where="lenhsanxuatid = '".$lenhsanxuatid."'";
		$this->db->updateData('qlklenhsanxuat_congdoan',$field,$value,$where);
	}
	//Huy lenh
	public function destroy($lenhsanxuatid)
	{
		
		$where="lenhsanxuatid = '".$lenhsanxuatid."'";
		$this->db->updateData('qlklenhsanxuat_congdoan',$field,$value,$where);
		$this->db->deleteData('qlklenhsanxuat',$where);
	}
	//Lenh san xuat cong doan
	public function getLenhSanXuatCongDoan($id)
	{
		$sql = "Select * 
						from `qlklenhsanxuat_congdoan` 
						where id ='".$id."'";
		$query = $this->db->query($sql);
		return $query->row;	
	}
	
	public function getLenhSanXuatCongDoanList($where)
	{
		$sql = "Select `qlklenhsanxuat_congdoan`.* 
									from `qlklenhsanxuat_congdoan` 
									where status <> 'deleted' " . $where ;
		
		$query = $this->db->query($sql);
		return $query->rows;
	}
	
	public function saveLenhSanXuatCongDoan($data)
	{
		$data['id'] = $this->db->escape(@$data['id']);
		
		$data['soluong']=$this->db->escape(@$this->string->toNumber($data['soluong']));
		$data['dongia']=$this->db->escape(@$this->string->toNumber($data['dongia']));
		$data['chitieutp']=$this->db->escape(@$this->string->toNumber($data['chitieutp']));
		$data['chitieupl']=$this->db->escape(@$this->string->toNumber($data['chitieupl']));
		$data['chitieupp']=$this->db->escape(@$this->string->toNumber($data['chitieupp']));
		$data['nangsuat']=$this->db->escape(@$this->string->toNumber($data['nangsuat']));
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
			
			$this->db->insertData("qlklenhsanxuat_congdoan",$field,$value);
			$id = $this->db->getLastId();
		}
		else
		{			
			$where="id = '".$data['id']."'";
			$this->db->updateData('qlklenhsanxuat_congdoan',$field,$value,$where);
		}
		return $id;
	}
	
	public function updateLenhSanXuatCongDoan($id,$col,$val)
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
		$this->db->updateData('qlklenhsanxuat_congdoan',$field,$value,$where);
	}
		
	public function deleteLenhSanXuatCongDoan($id)
	{
		$id = $this->db->escape(@$id);		
		
		$where="id = '".$id."'";
		$this->db->deleteData('qlklenhsanxuat_congdoan',$where);
	}
}
?>