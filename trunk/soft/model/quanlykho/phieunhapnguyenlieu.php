<?php
$this->load->model("quanlykho/phieunhapxuat");
class ModelQuanlykhoPhieunhapnguyenlieu extends ModelQuanlykhoPhieunhapxuat
{
	//phieunhapnguyenlieu bao gom cac thuoc tinh
	/*
		id,
		maphieu,
		ngaynhap,
		nguoigiao,
		loainguon,
		maphieunguon,
		makho,
		tinhtrang,
		mahopdong,
		ngaylapphieu,
		nguoilap,
		trangthai,
		loainhapxuat
		*/

	public $loainhapxuat = "phieunhapnguyenlieu";

	public function getItem($id, $where="")
	{
		$where .= " AND loainhapxuat='". $this->loainhapxuat ."' ";
		return $this->getPhieuNhapXuat($id, $where);
	}

	public function getChiTietPhieuNhaps($maphieu, $where="")
	{
		return $this->getChiTiets($maphieu, $where="");
	}

	public function getList($where="", $from=0, $to=0, $order="")
	{
		$where .= " AND loainhapxuat='". $this->loainhapxuat ."' ";
		return $this->getPhieuNhapXuats($where, $from, $to, $order);
	}

}
?>
