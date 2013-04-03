<?php
$this->load->model("quanlykho/nhom");
class ModelQuanlykhoKho extends ModelQuanlykhoNhom
{
	private $root = "qlkkho";
	function __construct()
	{
		
		$data = $this->getItem($this->root);
		if(count($data)==0)
		{
			$data['manhom'] = $this->root;
			$data['tennhom'] = "Kho";
			$data['thutu'] = 0;
			$data['ghichu'] = "";
			$this->insert($data);
		}
	}

	public function getKho($makho)
	{
		$item = $this->getItem($makho);
		$data = array();
		if(count($item))
		{
			$data['makho'] = $item['manhom'];
			$data['tenkho'] = $item['tennhom'];
			$data['diachi'] = $this->getInfor($makho, 'diachi');
			$data['dienthoai'] =  $this->getInfor($makho, 'dienthoai');
			$data['modules'] =  $this->getInfor($makho, 'modules');
			$data['ghichu'] = $item['ghichu'];
		}
		return $data;
	}

	public function getKhos()
	{
		$datas = $this->getChild($this->root," Order by tennhom");

		$objs = array();
		if(count($datas))
		foreach($datas as $item)
		{
			$data['makho'] = $item['manhom'];
			$data['tenkho'] = $item['tennhom'];
			$data['diachi'] = $this->getInfor($data['makho'], 'diachi');
			$data['dienthoai'] =  $this->getInfor($data['makho'], 'dienthoai');
			$data['modules'] =  $this->getInfor($data['makho'], 'modules');
			$data['ghichu'] = $item['ghichu'];
			$objs[] = $data;
		}

		return $objs;
	}
	
	public function getKhosByModuel($moduleid)
	{
		$data_kho = $this->getKhos();
		$arr_makho = $this->string->matrixToArray($data_kho,"makho");
		
	 	$where = " AND value like '%[".$moduleid."]%' AND manhom in ('". implode("','",$arr_makho)."')";
		$data_infor = $this->getInforData($where);
		$arr_manhom = $this->string->matrixToArray($data_infor,"manhom");
		
		$data = array();
		foreach($data_kho as $kho)
		{
			if(in_array($kho['makho'],$arr_manhom))
			{
				$data[] = $kho;
			}
		}
		
		return $data;
	}

	public function saveKho($kho)
	{
		$data['manhom'] = $kho['makho'];
		$data['tennhom'] = $kho['tenkho'];
		$data['nhomcha'] = $this->root;
		$data['thutu'] = 0;
		$data['ghichu'] = $kho['ghichu'];

		$item = $this->getItem($data['manhom']);
		if(count($item) == 0)
		{
			if($data['manhom'] == "")
			$data['manhom'] = $this->getnextid($this->root);
			$this->insert($data);
		}
		else
		$this->update($data);
		$this->saveInfo($data['manhom'], 'diachi', $kho['diachi']);
		$this->saveInfo($data['manhom'], 'dienthoai', $kho['dienthoai']);
		$this->saveInfo($data['manhom'], 'modules', $kho['modules']);
	}

	public function deleteKho($makho)
	{
		$this->delete($makho);
	}

	public function deleteListKho($listkho)
	{
		$this->deletedatas($listkho);
	}
}
?>