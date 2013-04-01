<?php
class ModelQuanlykhoKehoach extends Model
{
	public function getItem($id, $where="")
	{
		$sql = "Select `qlkkehoach`.*
									from `qlkkehoach` 
									where id ='".$id."' ".$where;
		$query = $this->db->query($sql);
		return $query->row;
	}

	public function getList($where="", $from=0, $to=0,$order = "Order by id")
	{

		$sql = "Select `qlkkehoach`.*
									from `qlkkehoach` 
									where trangthai <> 'deleted' " . $where;
		if($order == "")
			$sql .=$order;
		if($to > 0)
		{
			$sql .= " Limit ".$from.",".$to;
		}

		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function getChild($kehoachcha,$order = " Order by nam,quy,thang ")
	{
		$where = " AND kehoachcha = '".$kehoachcha."' ". $order;
		return $this->getList($where);
	}

	function getTree($id, &$data,$loai ='', $level=-1, $path="", $parentpath="")
	{
		$where = " AND loai = '".$loai."'";
		$arr=$this->getItem($id,$where);
		if(count($arr)==0 && (int)@$id!=0)
			return;
		$rows = $this->getChild($id);

		$arr['countchild'] = count(rows);

		if($arr['kehoachcha'] != 0)
			$parentpath .= "-".$arr['kehoachcha'];

		if($id!="" )
		{
			$level += 1;
			$path .= "-".$id;
				
			$arr['level'] = $level;
			$arr['path'] = $path;
			$arr['parentpath'] = $parentpath;
				
			array_push($data,$arr);
		}


		if(count($rows))
			foreach($rows as $row)
			{
				$this->getTree($row['id'], $data,$loai, $level, $path, $parentpath);
			}
	}

	public function nextID()
	{
		return $this->db->getNextId('qlkkehoach','id');
	}

	public function insert($data)
	{
		$id= $this->nextID();
		$makehoach=$this->db->escape(@$data['makehoach']);
		$tenkehoach= $this->db->escape(@$data['tenkehoach']);
		$ngaybatdau= $this->db->escape(@$data['ngaybatdau']);
		$ngayketthuc= $this->db->escape(@$data['ngayketthuc']);
		$loai= $this->db->escape(@$data['loai']);
		$nam= $this->db->escape(@$data['nam']);
		$quy=$this->db->escape(@$data['quy']);
		$thang=$this->db->escape(@$data['thang']);

		$kehoachcha=$this->db->escape(@$data['kehoachcha']);
		$ghichu=$this->db->escape(@$data['ghichu']);


		$field=array(

						'makehoach',
						'tenkehoach',
						'ngaybatdau',
						'ngayketthuc',
						'loai',
						'nam',
						'quy',
						'thang',


						'kehoachcha',
						'ghichu',
						'trangthai'
						
						);
						$value=array(

						$makehoach,
						$tenkehoach,
						$ngaybatdau,
						$ngayketthuc,
						$loai,
						$nam,
						$quy,
						$thang,


						$kehoachcha,
						$ghichu,
						'active'
						);
						$this->db->insertData("qlkkehoach",$field,$value);

						return $id;
	}

	public function update($data)
	{

		$id= $this->db->escape(@$data['id']);
		$makehoach=$this->db->escape(@$data['makehoach']);
		$tenkehoach= $this->db->escape(@$data['tenkehoach']);
		$ngaybatdau= $this->db->escape(@$data['ngaybatdau']);
		$ngayketthuc= $this->db->escape(@$data['ngayketthuc']);
		$loai= $this->db->escape(@$data['loai']);
		$nam= $this->db->escape(@$data['nam']);
		$quy=$this->db->escape(@$data['quy']);
		$thang=$this->db->escape(@$data['thang']);

		$kehoachcha=$this->db->escape(@$data['kehoachcha']);
		$ghichu=$this->db->escape(@$data['ghichu']);
		$trangthai=$this->db->escape(@$data['trangthai']);

		$field=array(

						'makehoach',
						'tenkehoach',
						'ngaybatdau',
						'ngayketthuc',
						'loai',
						'nam',
						'quy',
						'thang',


						'kehoachcha',
						'ghichu',
						'trangthai'
						
						);
						$value=array(

						$makehoach,
						$tenkehoach,
						$ngaybatdau,
						$ngayketthuc,
						$loai,
						$nam,
						$quy,
						$thang,


						$kehoachcha,
						$ghichu,
						$trangthai
						);

						$where="id = '".$id."'";
						$this->db->updateData("qlkkehoach",$field,$value,$where);

						return true;
	}

	public function updateStatus($id,$status)
	{
		$id= $this->db->escape(@$id);
		$status= $this->db->escape(@$status);
		$field=array(

						'trangthai'
						);
						$value=array(


						$status
						);

						$where="id = '".$id."'";
						$this->db->updateData("qlkkehoach",$field,$value,$where);
	}

	public function delete($id)
	{
		/*$where="id = '".$id."'";
		 $this->db->deleteData("qlkkehoach",$where);*/
		$this->updateStatus($id,'deleted');
		$child = $this->getChild($id);
		if(count($child))
		foreach($child as $item)
		{
			$this->delete($item['id']);
		}
	}

	public function deletedatas($listid)
	{
		foreach($listid as $item)
		{
			$this->delete($item);
		}
	}
	//Ke hoach san pham
	public function getKeKhoachSanPham($id)
	{
		$sql = "Select `qlkkehoach_sanpham`.*
									from `qlkkehoach_sanpham` 
									where id ='".$id."' ".$where;
		$query = $this->db->query($sql);
		return $query->row;
	}

	public function getKeKhoachSanPhams($where="", $from=0, $to=0)
	{

		$sql = "Select `qlkkehoach_sanpham`.*
									from `qlkkehoach_sanpham` 
									where 1=1 " . $where;
		if($to > 0)
		{
			$sql .= " Limit ".$from.",".$to;
		}

		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function deleteKeKhoachSanPham($id)
	{
		$where="id = '".$id."'";
		$this->db->deleteData("qlkkehoach_sanpham",$where);

	}

	public function saveKeHoachSanPham($data)
	{
		$id= (int)@$data['id'];
		$kehoachid= $this->db->escape(@$data['kehoachid']);
		$sanphamid= $this->db->escape(@$data['sanphamid']);
		$masanpham = $this->db->escape(@$data['masanpham']);
		$tensanpham = $this->db->escape(@$data['tensanpham']);
		$soluongtonhientai = $this->string->toNumber($this->db->escape(@$data['soluongtonhientai']));
		$sosanphamtrenlot = $this->string->toNumber($this->db->escape(@$data['sosanphamtrenlot']));
		$soluong = $this->string->toNumber($this->db->escape(@$data['soluong']));
		if($sosanphamtrenlot)
			$solot=$soluong / $sosanphamtrenlot;
		else
			$solot = $soluong; 
		$dongia=$this->string->toNumber($this->db->escape(@$data['dongia']));
		$thanhtien = $soluong * $dongia;
		$pheduyet= @(int)$data['pheduyet'];
		$phuchu = $this->db->escape(@$data['phuchu']);
		
		$field=array(

						'kehoachid',
						'sanphamid',
						'masanpham',
						'tensanpham',
						'soluongtonhientai',
						'sosanphamtrenlot',
						'soluong',
						'solot',
						'dongia',
						'thanhtien',
						'pheduyet',
						'phuchu'
						
						);
		$value=array(

						$kehoachid,
						$sanphamid,
						$masanpham,
						$tensanpham,
						$soluongtonhientai,
						$sosanphamtrenlot,
						$soluong,
						$solot,
						$dongia,
						$thanhtien,
						$pheduyet,
						$phuchu
						);

						if($id == "" )
						{
							//$value[0] = $id;
							$this->db->insertData("qlkkehoach_sanpham",$field,$value);
						}
						else
						{
							$where="id = '".$id."'";
							$this->db->updateData("qlkkehoach_sanpham",$field,$value,$where);
						}

						return $id;
	}
	
	function updateKeHoachSanPham($id,$col,$val)
	{
		$id= (int)@$id;
		$col= $this->db->escape(@$col);
		$val= $this->db->escape(@$val);
		$field=array(
						$col	
						);
		$value=array(
						$val
						);
		$where="id = '".$id."'";
		$this->db->updateData("qlkkehoach_sanpham",$field,$value,$where);
	}
	
	function kehoacnamtruoc($id)
	{
		$kehoach = $this->getItem($id);
		$nam = $kehoach['nam'];
		$namtruoc = $nam -1;
		$quy = $kehoach['quy'];
		$thang = $kehoach['thang'];
		$where .= " AND nam = '". $namtruoc ."'";
		$where .= " AND quy = '". $quy ."'";
		$where .= " AND thang = '". $thang ."'";
		$kehoachtruoc = $this->getList($where);
		return $kehoachtruoc[0];
	}
	function kehoachkytruoc($id)
	{
		$kehoach = $this->getItem($id);
		$nam = $kehoach['nam'];
		$quy = $kehoach['quy'];
		$thang = $kehoach['thang'];
		if($thang > 0)
		{
			$thang--;
			if($thang == 0)
			{
				$thang = 3;
				$quy--;
			}
			
		}
		if($quy>0)
		{
			$quy--;
			if($quy==0)
			{
				$quy= 4;
				$nam--;
			}	
		}
		$where .= " AND nam = '". $nam ."'";
		$where .= " AND quy = '". $quy ."'";
		$where .= " AND thang = '". $thang ."'";
		
		$kehoachtruoc = $this->getList($where);
		return $kehoachtruoc[0];
	}

}
?>