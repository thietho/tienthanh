<?php
class ControllerQuanlykhoPhieunhapxuat extends Controller
{	
	public function getChiTiet()
	{
		$maphieu = $this->request->get['maphieu'];
		$this->load->model("quanlykho/phieunhapxuat");
		$datas = $this->model_quanlykho_phieunhapxuat->getChiTiets($maphieu);
		$this->data['output'] = json_encode(array('chitietphieunhapxuats' => $datas));
		$this->id="chitietphieunhanhang";
		$this->template="common/output.tpl";
		$this->render();
	}
	
	public function getChiTiets()
	{
		$col = $this->request->get['col'];
		$val = $this->request->get['val'];
		$operator = $this->request->get['operator'];
		if($operator == "")
			$operator = "equal";
		$this->load->model("quanlykho/phieunhapxuat");
		$where = "";
		switch($operator)
		{
			case "equal":
				$where = " AND ".$col." = '".$val."'";
				break;
			case "like":
				$where = " AND ".$col." like '%".$val."%'";
				break;
			case "other":
				$where = " AND ".$col." <> '".$val."'";
				break;
			case "in":
				$where = " AND ".$col." in  (".$val.")";
				break;
			
		}
			
			
		$datas = $this->model_quanlykho_phieunhapxuat->getChiTietPhieuXuatNhap($where);
		foreach($datas as $key => $item)
		{
			$datas[$key]['tendonvitinh'] = $this->document->getDonViTinh($item['madonvi']);
		}
		
		$this->data['output'] = json_encode(array('chitietphieunhapxuats' => $datas));
		$this->id="nguyenlieu";
		$this->template="common/output.tpl";
		$this->render();
	}
	
	public function getTonKho()
	{
		$makho = $this->request->get['makho'];
		$col = $this->request->get['col'];
		$val = $this->request->get['val'];
		$operator = $this->request->get['operator'];
		if($operator == "")
			$operator = "equal";
		$this->load->model("quanlykho/phieunhapxuat");
		$where = "";
		switch($operator)
		{
			case "equal":
				$where = " AND ".$col." = '".$val."'";
				break;
			case "like":
				$where = " AND ".$col." like '%".$val."%'";
				break;
			case "other":
				$where = " AND ".$col." <> '".$val."'";
				break;
			case "in":
				$where = " AND ".$col." in  (".$val.")";
				break;
			
		}
		
		if($makho != "")
			$where .= " AND makho = '".$makho."'";
		$where .= " AND phieuxuat = 0";
		$datas = $this->model_quanlykho_phieunhapxuat->getChiTietPhieuXuatNhap($where);
		foreach($datas as $key => $item)
		{
			$datas[$key]['tendonvitinh'] = $this->document->getDonViTinh($item['madonvi']);
		}
		
		$this->data['output'] = json_encode(array('chitietphieunhapxuats' => $datas));
		$this->id="nguyenlieu";
		$this->template="common/output.tpl";
		$this->render();
	}
	
	public function updateChiTietPhieuXuat()
	{
		$id = $this->request->get['id'];
		$phieuxuat = $this->request->get['phieuxuat'];
		$this->load->model("quanlykho/phieunhapxuat");
		$this->model_quanlykho_phieunhapxuat->updateChitietPhieuXuat($id,$phieuxuat);
		$this->data['output'] = "true";
		$this->id="chitietphieunhanhang";
		$this->template="common/output.tpl";
		$this->render();
	}
	
	public function thanhtoan()
	{
		$id = $this->request->get['id'];
		$this->load->model("quanlykho/phieunhapnguyenlieu");
		$this->load->model("quanlykho/nguyenlieu");
		
		//$chitiets = $this->model_quanlykho_phieunhapnguyenlieu->getChiTietPhieuNhaps($id);
		
		/*foreach($chitiets as $val)
		{
			$this->model_quanlykho_nguyenlieu->nhap($val['itemid'], $val['soluong']);
		}*/
		
		$this->model_quanlykho_phieunhapxuat->updatePhieuNhapXuat($id,"tinhtrang" ,"dathanhtoan");
		
		
		$this->data['output'] = "Thanh toán thành công";
		$this->id="linhkien";
		$this->template="common/output.tpl";
		$this->render();
	}
}
?>