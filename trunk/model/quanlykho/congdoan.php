<?php

class ModelQuanlykhoCongdoan extends Model
{
	public function getItem($id, $where="")
	{
		$sql = "Select `qlkcongdoan`.*
									from `qlkcongdoan` 
									where id ='".$id."' ".$where;
		$query = $this->db->query($sql);
		return $query->row;
	}

	public function getList($where="", $from=0, $to=0)
	{

		$sql = "Select `qlkcongdoan`.*
									from `qlkcongdoan` 
									where 1=1 " . $where . " Order by thututhuchien";
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
		$macongdoan=$this->db->escape(@$data['macongdoan']);
		$tencongdoan=$this->db->escape(@$data['tencongdoan']);
		$thututhuchien= $this->string->toNumber($this->db->escape(@$data['thututhuchien']));
		$malinhkien= $this->db->escape(@$data['malinhkien']);
		$dinhmucchitieu=$this->string->toNumber($this->db->escape(@$data['dinhmucchitieu']));
		$giagiacong=$this->string->toNumber($this->db->escape(@$data['giagiacong']));
		$dinhmucphelieu=$this->string->toNumber($this->db->escape(@$data['dinhmucphelieu']));
		$dinhmucphepham=$this->string->toNumber($this->db->escape(@$data['dinhmucphepham']));
		$dinhmuchaohut=$this->string->toNumber($this->db->escape(@$data['dinhmuchaohut']));
		$dinhmucnangxuat=$this->string->toNumber($this->db->escape(@$data['dinhmucnangxuat']));
		$dinhmucphulieu=$this->string->toNumber($this->db->escape(@$data['dinhmucphulieu']));
		$soluongtrenkg=$this->string->toNumber($this->db->escape(@$data['soluongtrenkg']));
		$nguyenlieusanxuat=$this->db->escape(@$data['nguyenlieusanxuat']);
		$thietbisanxuatchinh=$this->db->escape(@$data['thietbisanxuatchinh']);
		$phongbansanxuat=$this->db->escape(@$data['phongbansanxuat']);
		$ghichu=$this->db->escape(@$data['ghichu']);

		$field=array(

						'macongdoan',
						'tencongdoan',
						'thututhuchien',
						'malinhkien',
						'dinhmucchitieu',
						'giagiacong',
						'dinhmucphelieu',
						'dinhmucphepham',
						'dinhmuchaohut',
						'dinhmucnangxuat',
						'dinhmucphulieu',
						'soluongtrenkg',
						'nguyenlieusanxuat',
						'thietbisanxuatchinh',
						'phongbansanxuat',
						'ghichu'
						);
						$value=array(

						$macongdoan,
						$tencongdoan,
						$thututhuchien,
						$malinhkien,
						$dinhmucchitieu,
						$giagiacong,
						$dinhmucphelieu,
						$dinhmucphepham,
						$dinhmuchaohut,
						$dinhmucnangxuat,
						$dinhmucphulieu,
						$soluongtrenkg,
						$nguyenlieusanxuat,
						$thietbisanxuatchinh,
						$phongbansanxuat,
						$ghichu
						);
						$this->db->insertData("qlkcongdoan",$field,$value);

						$log['tablename'] = "qlkcongdoan";
						$log['data'] = $data;
						$this->user->writeLog(json_encode($log));
						return $id;
	}

	public function update($data)
	{
		$id= $this->db->escape(@$data['id']);
		$macongdoan=$this->db->escape(@$data['macongdoan']);
		$tencongdoan=$this->db->escape(@$data['tencongdoan']);
		$thututhuchien= $this->string->toNumber($this->db->escape(@$data['thututhuchien']));
		$malinhkien= $this->db->escape(@$data['malinhkien']);
		$dinhmucchitieu=$this->string->toNumber($this->db->escape(@$data['dinhmucchitieu']));
		$giagiacong=$this->string->toNumber($this->db->escape(@$data['giagiacong']));
		$dinhmucphelieu=$this->string->toNumber($this->db->escape(@$data['dinhmucphelieu']));
		$dinhmucphepham=$this->string->toNumber($this->db->escape(@$data['dinhmucphepham']));
		$dinhmuchaohut=$this->string->toNumber($this->db->escape(@$data['dinhmuchaohut']));
		$dinhmucnangxuat=$this->string->toNumber($this->db->escape(@$data['dinhmucnangxuat']));
		$dinhmucphulieu=$this->string->toNumber($this->db->escape(@$data['dinhmucphulieu']));
		$soluongtrenkg=$this->string->toNumber($this->db->escape(@$data['soluongtrenkg']));
		$nguyenlieusanxuat=$this->db->escape(@$data['nguyenlieusanxuat']);
		$thietbisanxuatchinh=$this->db->escape(@$data['thietbisanxuatchinh']);
		$phongbansanxuat=$this->db->escape(@$data['phongbansanxuat']);
		$ghichu=$this->db->escape(@$data['ghichu']);

		$field=array(

						'macongdoan',
						'tencongdoan',
						'thututhuchien',
						'malinhkien',
						'dinhmucchitieu',
						'giagiacong',
						'dinhmucphelieu',
						'dinhmucphepham',
						'dinhmuchaohut',
						'dinhmucnangxuat',
						'dinhmucphulieu',
						'soluongtrenkg',
						'nguyenlieusanxuat',
						'thietbisanxuatchinh',
						'phongbansanxuat',
						'ghichu'
						);
						$value=array(

						$macongdoan,
						$tencongdoan,
						$thututhuchien,
						$malinhkien,
						$dinhmucchitieu,
						$giagiacong,
						$dinhmucphelieu,
						$dinhmucphepham,
						$dinhmuchaohut,
						$dinhmucnangxuat,
						$dinhmucphulieu,
						$soluongtrenkg,
						$nguyenlieusanxuat,
						$thietbisanxuatchinh,
						$phongbansanxuat,
						$ghichu
						);

						$where="id = '".$id."'";
						$this->db->updateData("qlkcongdoan",$field,$value,$where);
						$log['tablename'] = "qlkcongdoan";
						$log['data'] = $data;
						$this->user->writeLog(json_encode($log));
						return true;
	}

	public function delete($id)
	{
		$where="id = '".$id."'";
		$this->db->deleteData("qlkcongdoan",$where);

	}

	public function deletedatas($listid)
	{
		foreach($listid as $item)
		{
			$this->delete($item);
		}
	}
}
?>