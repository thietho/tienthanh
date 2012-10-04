<?php
class ModelQuanlykhoQuyetdinhgia extends Model
{
	public function getItem($id, $where="")
	{
		$sql = "Select `qlkquyetdinhgia`.*
									from `qlkquyetdinhgia` 
									where id ='".$id."' ".$where;
		$query = $this->db->query($sql);
		return $query->row;
	}

	public function getList($where="", $from=0, $to=0)
	{

		$sql = "Select `qlkquyetdinhgia`.*
									from `qlkquyetdinhgia` 
									where trangthai <> 'deleted' " . $where ;
		if($to > 0)
		{
			$sql .= " Limit ".$from.",".$to;
		}

		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function insert($data)
	{
		$id= $this->db->getNextId("qlkquyetdinhgia","id");
		$maquyetdinhgia=$this->db->escape(@$data['maquyetdinhgia']);
		$ngayraquyetdinh =$this->db->escape(@$data['ngayraquyetdinh']);
		$nguoiraquyetdinh=$this->db->escape(@$data['nguoiraquyetdinh']);
		$ghichu=$this->db->escape(@$data['ghichu']);
		
		$field=array(

						'maquyetdinhgia',
						'ngayraquyetdinh',
						'nguoiraquyetdinh',
						'ghichu',
						'trangthai'
						);
		$value=array(

						$maquyetdinhgia,
						$ngayraquyetdinh,
						$nguoiraquyetdinh,
						$ghichu,
						'active'
						);
		$this->db->insertData("qlkquyetdinhgia",$field,$value);
		$log['tablename'] = "qlkquyetdinhgia";
		$log['data'] = $data;
		$this->user->writeLog(json_encode($log));
		
		return $id;
	}

	public function update($data)
	{

		$id= $this->db->escape(@$data['id']);
		$maquyetdinhgia=$this->db->escape(@$data['maquyetdinhgia']);
		$ngayraquyetdinh =$this->db->escape(@$data['ngayraquyetdinh']);
		$nguoiraquyetdinh=$this->db->escape(@$data['nguoiraquyetdinh']);
		$ghichu=$this->db->escape(@$data['ghichu']);
		
		$field=array(

						'maquyetdinhgia',
						'ngayraquyetdinh',
						'nguoiraquyetdinh',
						'ghichu'
						);
		$value=array(

						$maquyetdinhgia,
						$ngayraquyetdinh,
						$nguoiraquyetdinh,
						$ghichu
						);

		$where="id = '".$id."'";
		$this->db->updateData("qlkquyetdinhgia",$field,$value,$where);
		$log['tablename'] = "qlkquyetdinhgia";
		$log['data'] = $data;
		$this->user->writeLog(json_encode($log));
		
		return $id;
	}

	public function delete($id)
	{
		/*$where="id = '".$id."'";
		 $this->db->deleteData("qlkquyetdinhgia",$where);*/
		$field=array(

						'trangthai'
						);
						$value=array(


						'deleted'
						);

		$where="id = '".$id."'";
		$this->db->updateData("qlkquyetdinhgia",$field,$value,$where);
	}

	public function deletedatas($listid)
	{
		foreach($listid as $item)
		{
			$this->delete($item);
		}
	}
	

	//Chi tiet quyet dinh gia

	public function getQuyetDinhGiaChiTietList($where)
	{
		$sql = "Select `qlkquyetdinhgia_chitiet`.*
									from `qlkquyetdinhgia_chitiet` 
									where 1=1 ".$where;

		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function getQuyetDinhGiaChiTiet($id)
	{
		$sql = "Select `qlkquyetdinhgia_chitiet`.*
									from `qlkquyetdinhgia_chitiet` 
									where id ='".$id."' ";
		$query = $this->db->query($sql);
		return $query->row;
	}

	public function saveQuyetDinhGiaChiTiet($data)
	{
		$id=(int)@$data['id'];
		$maquyetdinhgia=$this->db->escape(@$data['maquyetdinhgia']);
		$itemid=$this->db->escape(@$data['itemid']);
		$itemname=$this->db->escape(@$data['itemname']);
		$loai=$this->db->escape(@$data['loai']);
		$giagiacong=$this->string->toNumber($this->db->escape(@$data['giagiacong']));
		$donvi=$this->db->escape(@$data['donvi']);
		
		$field=array(
						'id',
						'maquyetdinhgia',
						'malinhkien',
						'soluong'
						
						);
		$value=array(
						$id,
						$maquyetdinhgia,
						$malinhkien,
						$soluong

						);

		if($id == 0 )
		{
			$value[0] =  $this->db->getNextId("qlkquyetdinhgia_chitiet","id");
			$this->db->insertData("qlkquyetdinhgia_chitiet",$field,$value);
		}
		else
		{
			$where="id = '".$id."'";
			$this->db->updateData("qlkquyetdinhgia_chitiet",$field,$value,$where);
		}
	}

	public function deletedQuyetDinhGiaChiTiet($id)
	{
		$where="id = '".$id."'";
		$this->db->deleteData("qlkquyetdinhgia_chitiet",$where);
	}
}
?>