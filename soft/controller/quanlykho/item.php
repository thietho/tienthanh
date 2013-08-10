<?php
class ControllerQuanlykhoItem extends Controller
{
	private $error = array();
	function __construct() 
	{
		$this->load->model("quanlykho/nguyenlieu");
		$this->load->model("quanlykho/linhkien");
		$this->load->model("quanlykho/donvitinh");
		$this->load->model("quanlykho/nhom");
		$this->load->model("quanlykho/item");
		$this->load->helper('image');
		
   	}
	
	public function getListDuoiTonToiThieu()
	{
		//Nguyen Lieu 
		$loainguyenlieu = array();
		$this->model_quanlykho_nhom->getTree("NL",$loainguyenlieu);
		$arrnhom = $this->string->matrixToArray($loainguyenlieu,'manhom');
		$where = " AND loai IN ('".implode("','",$arrnhom)."')";
		$data_nguyenlieu = $this->model_quanlykho_nguyenlieu->getList($where);
		
		$this->data['data_nguyenlieu'] = array();
		foreach($data_nguyenlieu as $nguyenlieu)
		{
			$data_nhapdv = $this->model_quanlykho_item->getTonKho($nguyenlieu['id'],'nguyenlieu',$nguyenlieu['madonvi']);
			$tonkho = $this->model_quanlykho_donvitinh->toDouble($data_nhapdv);
			
			if($tonkho < $nguyenlieu['tontoithieu'])
			{
				$nguyenlieu['imagethumbnail'] = HelperImage::resizePNG($nguyenlieu['imagepath'], 100, 0);
				$this->data['data_nguyenlieu'][] = $nguyenlieu;
			}
		}
		//Vat tu
		$loainguyenlieu = array();
		$this->model_quanlykho_nhom->getTree("dmvtccnl",$loainguyenlieu);
		$arrnhom = $this->string->matrixToArray($loainguyenlieu,'manhom');
		$where = " AND loai IN ('".implode("','",$arrnhom)."')";
		$data_vattu = $this->model_quanlykho_nguyenlieu->getList($where);
		
		$this->data['data_vattu'] = array();
		foreach($data_vattu as $vattu)
		{
			$data_nhapdv = $this->model_quanlykho_item->getTonKho($vattu['id'],'vattu',$vattu['madonvi']);
			$tonkho = $this->model_quanlykho_donvitinh->toDouble($data_nhapdv);
			
			if($tonkho < $vattu['tontoithieu'])
			{
				$vattu['imagethumbnail'] = HelperImage::resizePNG($vattu['imagepath'], 100, 0);
				$this->data['data_vattu'][] = $vattu;
			}
		}
		
		$this->id='content';
		$this->template="quanlykho/item_duoitontoithieu.tpl";
		$this->render();
	}
	
	
}
?>