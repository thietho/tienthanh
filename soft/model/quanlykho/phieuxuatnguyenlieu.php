<?php
$this->load->model("quanlykho/phieunhapxuat");
class ModelQuanlykhoPhieuxuatnguyenlieu extends ModelQuanlykhoPhieunhapxuat
{
	//phieuxuatnguyenlieu bao gom cac thuoc tinh
	/*
		id,
		maphieu,
		nguoinhan,
		makho,
		macongdoan,
		tinhtrang,
		loaiphieu,
		ngayxuat,
		mahopdong,
		ngaylapphieu,
		nguoilap,
		trangthai,
		loainhapxuat
		*/
	public $loainhapxuat = "phieuxuatnguyenlieu";

	public function getItem($id, $where="")
	{
		$where .= " AND loainhapxuat='". $this->loainhapxuat ."' ";
		return $this->getPhieuNhapXuat($id, $where);
	}

	public function getChiTietPhieuXuats($maphieu, $where="")
	{
		$where = " AND phieuxuat = '".$maphieu."'";
		return $this->getChiTietPhieuXuatNhap($where);
	}

	public function getList($where="", $from=0, $to=0, $order="")
	{
		$where .= " AND loainhapxuat='". $this->loainhapxuat ."' ";
		return $this->getPhieuNhapXuats($where, $from, $to, $order);
	}

}
?>