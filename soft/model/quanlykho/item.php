<?php
$this->load->model("quanlykho/donvitinh");
class ModelQuanlykhoItem extends ModelQuanlykhoDonvitinh
{
	public function getNhapKho($itemid,$itemtype)
	{

		$sql = "SELECT SUM( thucnhap ) AS tongnhap, madonvi
					FROM  `bmvt16_chitiet` 
					WHERE itemid =  '".$itemid."' AND itemtype = '".$itemtype."'
					GROUP BY itemid, madonvi";
		
		$query = $this->db->query($sql);
		return $query->rows;
	}
	
	public function getTonKho($itemid,$itemtype,$madonvi)
	{
		$data_nhap = $this->getNhapKho($itemid,$itemtype);
		$arr = array();
		foreach($data_nhap as $item)
		{
			$arr[$item['madonvi']] = $item['tongnhap'];
		}
		//print_r($arr);
		$data_nhapdv = $this->model_quanlykho_donvitinh->toDonViTinh($arr,$madonvi);
		//echo $this->model_quanlykho_donvitinh->toInt($data_nhapdv);
		//print_r($data_nhapdv);
		return $data_nhapdv;
		//echo "<br>";
	}
}
