<?php
$this->load->model("quanlykho/nhom");
class ModelQuanlykhoPhongBan extends ModelQuanlykhoNhom
{ 
	public $root = "qlkphongban";
	function __construct() 
	{
		$data = $this->getItem($this->root);
		if(count($data)==0)
		{
			$data['manhom'] = $this->root;
			$data['tennhom'] = "PhongBan";
			$data['thutu'] = 0;
			$data['ghichu'] = "";
			$this->insert($data);
		}
   	}
	
	public function getPhongBan($maphongban)
	{
		$item = $this->getItem($maphongban);
		$data = array();
		if(count($item))
		{
			$data['maphongban'] = $item['manhom'];
			$data['tenphongban'] = $item['tennhom'];
			$data['ghichu'] = $item['ghichu'];
			$data['permission'] =  $this->getInfor($maphongban, 'permission');
		}
		return $data;
	}
	
	public function getPhongBans()
	{
		$datas = $this->getChild($this->root," Order by tennhom");
		
		$objs = array();
		if(count($datas))
			foreach($datas as $item)
			{
				$data['maphongban'] = $item['manhom'];
				$data['tenphongban'] = $item['tennhom'];
				$data['ghichu'] = $item['ghichu'];
				$data['permission'] =  $this->getInfor($item['manhom'], 'permission');
				$objs[] = $data;
			}
		
		return $objs;
	}
	
	public function savePhongBan($phongban)
	{
		$data['manhom'] = $phongban['maphongban'];
		$data['tennhom'] = $phongban['tenphongban'];
		$data['nhomcha'] = $this->root;
		$data['thutu'] = 0;
		$data['ghichu'] = $phongban['ghichu'];
		
		$item = $this->getItem($data['manhom']);
		if(count($item) == 0)
		{
			//$data['manhom'] = $this->getnextid($this->root);
			$this->insert($data);
		}
		else
			$this->update($data);
	}
	
	public function savePermission($maphongbang,$permission)
	{
		$this->saveInfo($maphongbang, 'permission', $permission);
	}
	
	public function deletePhongBan($maphongban)
	{
		$this->delete($maphongban);	
		
	}
	
	public function deleteListPhongBan($listphongban)
	{
		$this->deletedatas($listphongban);
	}
	
	public function getTreePhongBan($id, $level=-1, $path="", $parentpath="")
	{
		$datas = array();
		$this->getTree($id, $datas, $level, $path, $parentpath);
		//unset($datas[0]);
		$objs = array();
		if(count($datas))
			foreach($datas as $item)
			{
				$data['maphongban'] = $item['manhom'];
				$data['tenphongban'] = $item['tennhom'];
				$data['ghichu'] = $item['ghichu'];
				$objs[] = $data;
			}
		
		return $objs;
	}
}
?>