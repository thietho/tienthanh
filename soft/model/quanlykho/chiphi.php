<?php
$this->load->model("quanlykho/nhom");
class ModelQuanlykhoChiphi extends ModelQuanlykhoNhom
{ 
	private $root = "qlkchiphi";
	function __construct() 
	{
		
		$data = $this->getItem($this->root);
		if(count($data)==0)
		{
			$data['manhom'] = $this->root;
			$data['tennhom'] = "Chi phi";
			$data['thutu'] = 0;
			$data['ghichu'] = "";
			$this->insert($data);
		}
   	}
	
	public function getChiphi($machiphi)
	{
		$item = $this->getItem($machiphi);
		$data = array();
		if(count($item))
		{
			$data['machiphi'] = $item['manhom'];
			$data['tenchiphi'] = $item['tennhom'];
		}
		return $data;
	}
	
	public function getChiphis()
	{
		$datas = $this->getChild($this->root," Order by tennhom");
		
		$objs = array();
		if(count($datas))
			foreach($datas as $item)
			{
				$data['machiphi'] = $item['manhom'];
				$data['tenchiphi'] = $item['tennhom'];
				
				$objs[] = $data;
			}
		
		return $objs;
	}
	
	public function saveChiphi($chiphi)
	{
		$data['manhom'] = $chiphi['machiphi'];
		$data['tennhom'] = $chiphi['tenchiphi'];
		$data['nhomcha'] = $this->root;
		$data['thutu'] = 0;
		$data['ghichu'] = $chiphi['ghichu'];
		
		$item = $this->getItem($data['manhom']);
		if(count($item) == 0)
		{
			if($data['manhom'] == "")
				$data['manhom'] = $this->getnextid($this->root);
			$this->insert($data);
		}
		else
		{
			$this->update($data);
		}
	}
	
	public function delectChiphi($machiphi)
	{
		$this->delete($machiphi);	
	}
	
	public function deleteListChiphi($listkho)
	{
		$this->deletedatas($listkho);
	}
}
?>