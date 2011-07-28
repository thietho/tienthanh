<?php
class ControllerQuanlykhoCongdoan extends Controller
{
	public function index()
	{
		$this->getList();
	}
	
	private function getList() 
	{
		
		
		$this->data['insert'] = $this->url->http('quanlykho/linhkien/insert');
		$this->data['delete'] = $this->url->http('quanlykho/linhkien/delete');		
		
		$this->load->model("quanlykho/nhom");
		$this->load->model("quanlykho/kho");
		$this->load->model("quanlykho/donvitinh");
		$this->data['nhomlinhkien'] = $this->model_quanlykho_nhom->getChild("nhomsanpham");
		$this->data['loailinhkien'] = $this->model_quanlykho_nhom->getChild("loailinhkien");
		$this->data['kho'] = $this->model_quanlykho_kho->getKhos();
		$this->data['donvitinh'] = $this->model_quanlykho_donvitinh->getList();
		
		$this->data['datas'] = array();
		$where = "";
		
		$datasearchlike['malinhkien'] = $this->request->get['malinhkien'];
		$datasearchlike['tenlinhkien'] = $this->request->get['tenlinhkien'];
		$datasearch['manhom'] = $this->request->get['manhom'];
		$datasearch['loai'] = $this->request->get['loai'];
		$datasearch['makho'] = $this->request->get['makho'];
		
		$arr = array();
		foreach($datasearchlike as $key => $item)
		{
			if($item !="")
				$arr[] = " AND " . $key ." like '%".$item."%'";
		}
		
		foreach($datasearch as $key => $item)
		{
			if($item !="")
				$arr[] = " AND " . $key ." = '".$item."'";
		}
		
		$where = implode("",$arr);
		
		$rows = $this->model_quanlykho_congdoan->getList($where);
		//Page
		$page = $this->request->get['page'];		
		$x=$page;		
		$limit = 20;
		$total = count($rows); 
		// work out the pager values 
		$this->data['pager']  = $this->pager->pageLayout($total, $limit, $page); 
		
		$pager  = $this->pager->getPagerData($total, $limit, $page); 
		$offset = $pager->offset; 
		$limit  = $pager->limit; 
		$page   = $pager->page;
		for($i=$offset;$i < $offset + $limit && count($rows[$i])>0;$i++)
		//for($i=0; $i <= count($this->data['datas'])-1 ; $i++)
		{
			$this->data['datas'][$i] = $rows[$i];
			
		}
		$this->data['refres']=$_SERVER['QUERY_STRING'];
		$this->id='content';
		$this->template="quanlykho/congdoan_list.tpl";
		$this->layout="layout/center";
		if($this->request->get['opendialog']=='true')
		{
			$this->layout="layout/dialog";
			$this->data['dialog'] = true;
			
		}
		$this->render();
	}
	//Cac ham xu ly tren form
	public function getCongDoan()
	{
		$col = $this->request->get['col'];
		$val = $this->request->get['val'];
		$operator = $this->request->get['operator'];
		if($operator == "")
			$operator = "equal";
		$this->load->model("quanlykho/congdoan");
		$this->load->model("quanlykho/nguyenlieu");
		$this->load->model("quanlykho/taisan");
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
			
			
		$datas = $this->model_quanlykho_congdoan->getList($where);
		foreach($datas as $key => $item)
		{
			$nguyenlieu = $this->model_quanlykho_nguyenlieu->getItem($item['nguyenlieusanxuat']);
			$taisan = $this->model_quanlykho_taisan->getItem($item['thietbisanxuatchinh']);
			$datas[$key]['tennguyenlieusanxuat'] = $nguyenlieu['tennguyenlieu'];
			$datas[$key]['tenthietbisanxuatchinh'] = $taisan['tentaisan'];
		}
		$this->data['output'] = json_encode(array('congdoans' => $datas));
		$this->id="congdoan";
		$this->template="common/output.tpl";
		$this->render();
	}
	
	public function delete()
	{
		$id = $this->request->get['id'];
		$this->load->model("quanlykho/congdoan");
		$this->model_quanlykho_congdoan->delete($id);
		$this->data['output'] = "true";
		$this->id="congdoan";
		$this->template="common/output.tpl";
		$this->render();
	}
	
	public function viewCongDoan()
	{
		$macongdoan = $this->request->get['macongdoan'];
		$this->load->model("quanlykho/nguyenlieu");
		$this->load->model("quanlykho/taisan");
		$where = " AND detail like '%qlkcongdoan%' AND detail like '%\"macongdoan\":\"".$macongdoan."\"%' ";
		$data = $this->user->getLogs($where);
		$log = array();
		foreach($data as $key => $item)
		{
			$log[$key] = $this->json->decode($item['detail']);	
			$log[$key]->logdate = $item['logdate'];
		}
		
		foreach($log as $key => $item)
		{
			
			$this->data['logcongdoan'][$key] = $item->data;
			$nguyenlieu = $this->model_quanlykho_nguyenlieu->getItem($item->data->nguyenlieusanxuat);
			$taisan = $this->model_quanlykho_taisan->getItem($item->data->thietbisanxuatchinh);
			$this->data['logcongdoan'][$key]->tennguyenlieusanxuat = $nguyenlieu['tennguyenlieu'];
			$this->data['logcongdoan'][$key]->tenthietbisanxuatchinh = $taisan['tentaisan'];
			$this->data['logcongdoan'][$key]->logdate = $item->logdate;
		}
		
		
		
		$this->id="content";
		$this->template="quanlykho/linhkien_congdoanview.tpl";
		$this->layout="layout/dialog";
		$this->render();
	}
}
?>