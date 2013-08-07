<?php
class ControllerQuanlykhoVattu extends Controller
{
	private $error = array();
	function __construct() 
	{
		$this->load->model("quanlykho/nguyenlieu");
		$this->load->model("quanlykho/linhkien");
		$this->load->model("quanlykho/donvitinh");	
		
   	}
	
	public function getListDuoiTonToiThieu()
	{
		$where = " AND ";
		
		$this->id='content';
		$this->template="quanlykho/item_duoitontoithieu.tpl";
		$this->render();
	}
	
	
}
?>