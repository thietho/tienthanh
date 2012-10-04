<?php
class ModelQuanlykhoPhieunhanhang extends Model
{
	public function getItem($id, $where="")
	{
		$query = $this->db->query("Select `qlkchitietphieunhanhang`.*
									from `qlkchitietphieunhanhang` 
									where id ='".$id."' ".$where);
		return $query->row;
	}

	public function getList($where="", $from=0, $to=0, $order="")
	{
		$sql = "Select `qlkchitietphieunhanhang`.*
									from `qlkchitietphieunhanhang` 
									where 1=1" . $where . $order;
		if($to > 0)
		{
			$sql .= " Limit ".$from.",".$to;
		}

		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function nextID()
	{
		return $this->db->getNextId('qlkchitietphieunhanhang','id');
	}

	public function insert($data)
	{
		$id= $this->nextID();
		$maphieunhanhang= $this->string->toNumber($this->db->escape(@$data['maphieunhanhang']));
		$manguyenlieu= $this->string->toNumber($this->db->escape(@$data['manguyenlieu']));
		$tennguyenlieu= $this->db->escape(@$data['tennguyenlieu']);
		$soluong= $this->string->toNumber($this->db->escape(@$data['soluong']));
		$dongia= $this->string->toNumber($this->db->escape(@$data['dongia']));
		$danhgiachatluong= $this->db->escape(@$data['danhgiachatluong']);
		$soluongnhan= $this->string->toNumber($this->db->escape(@$data['soluongnhan']));
		$soluongtralai= $this->string->toNumber($this->db->escape(@$data['soluongtralai']));

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
						$this->db->insertData("qlkchitietphieunhanhang",$field,$value);

						return $id;
	}

	public function update($data)
	{
		$id= $this->nextID();
		$maphieunhanhang= $this->string->toNumber($this->db->escape(@$data['maphieunhanhang']));
		$manguyenlieu= $this->string->toNumber($this->db->escape(@$data['manguyenlieu']));
		$tennguyenlieu= $this->db->escape(@$data['tennguyenlieu']);
		$soluong= $this->string->toNumber($this->db->escape(@$data['soluong']));
		$dongia= $this->string->toNumber($this->db->escape(@$data['dongia']));
		$danhgiachatluong= $this->db->escape(@$data['danhgiachatluong']);
		$soluongnhan= $this->string->toNumber($this->db->escape(@$data['soluongnhan']));
		$soluongtralai= $this->string->toNumber($this->db->escape(@$data['soluongtralai']));

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

						$where="id = " .$id;
						$this->db->updateData("qlkchitietphieunhanhang",$field,$value,$where);

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

	public function delete($id)
	{

		$data = $this->getItem($id);
		if(count($data)==0)
		{
			$where="id= ".$id;
			$this->db->deleteData("qlkchitietphieunhanhang",$where);
		}
	}

	public function deletedatas($data)
	{
		if(count($data)>0)
		{
			foreach($data as $item)
			$this->delete($item);
		}
	}


}
?>