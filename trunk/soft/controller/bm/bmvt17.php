<?php
class ControllerBmBmvt17 extends Controller
{
	private $error = array();
	function __construct() 
	{
		
		$this->load->model("quanlykho/donvitinh");
		$this->load->model("bm/bmtn13");
		$this->load->model("bm/bmvt17");
		$data_donvitinh = $this->model_quanlykho_donvitinh->getList();
		$this->data['cbDonViTinh'] = '<option value=""></option>';
		foreach($data_donvitinh as $val)
		{
			$this->data['cbDonViTinh'] .= '<option value="'.$val['madonvi'].'">'.$val['tendonvitinh'].'</option>';
		}
	}
	public function index()
	{
		$id = $this->request->get['id'];
		
		$bmtn13id = $this->request->get['bmtn13id'];
		$this->data['item'] = $this->model_bm_bmtn13->getItem($bmtn13id);
		
		$where = " AND bmtn13id = '".$bmtn13id."'";
		$this->data['data_ct'] = $this->model_bm_bmtn13->getBMTN13ChiTietList($where);
		
		$this->id='content';
		$this->template='bm/bmtn17_form.tpl';
		$this->render();
	}
	
	public function view()
	{
		$id = $this->request->get['id'];
		$this->data['item'] = $this->model_bm_bmtn13->getItem($id);
		
		$where = " AND bmtn13id = '".$id."'";
		$this->data['data_ct'] = $this->model_bm_bmtn13->getBMTN13ChiTietList($where);
		
		$this->id='content';
		$this->template='bm/bmvt13.tpl';
		
		if($this->request->get['dialog']=='print')
		{
			
			$this->layout="layout/print";
			$this->data['dialog'] = "print";
		}
		$this->render();
	}
	public function getList()
	{
		
		$where = " Order by id desc";
		$this->data['data_bttn13']=$this->model_bm_bmtn13->getList($where);
		
		$this->id='content';
		$this->template='bm/bmtn13_list.tpl';
		$this->render();
	}
	
	public function save()
	{
		$data = $this->request->post;
		
		if($this->validateForm($data))
		{
			//Luu vao bang bmtn13
			if((int)$data['id']==0)
			{
				$data['id'] = $this->model_bm_bmtn13->insert($data);
			}
			else
			{
				$this->model_bm_bmtn13->update($data);
			}
			//Xóa chi tiet
			$arr_delid = split(",",$data['delid']);
			foreach($arr_delid as $id)
			{
				if($id)
				{
					$this->model_bm_bmtn13->deleteBMTN13ChiTiet($id);	
				}
			}
			//Luu vao bang bntn13_chitiet
			$bmtn13id = $data['id'];
			$arr_id = $data['ctid'];
			$arr_itemtype = $data['itemtype'];
			$arr_itemid = $data['itemid'];
			$arr_itemcode = $data['itemcode'];
			$arr_itemname = $data['itemname'];
			$arr_madonvi = $data['madonvi'];
			$arr_trongluong = $data['trongluong'];
			$arr_soluong = $data['soluong'];
			$arr_chatluong = $data['chatluong'];
			$arr_lothang = $data['lothang'];
			foreach($arr_id as $key=>$id)
			{
				$ct['id'] = $id;
				$ct['bmtn13id'] = $bmtn13id;
				$ct['itemtype'] = $arr_itemtype[$key];
				$ct['itemid'] = $arr_itemid[$key];
				$ct['itemcode'] = $arr_itemcode[$key];
				$ct['itemname'] = $arr_itemname[$key];
				$ct['madonvi'] = $arr_madonvi[$key];
				$ct['trongluong'] = $arr_trongluong[$key];
				$ct['soluong'] = $arr_soluong[$key];
				$ct['chatluong'] = $arr_chatluong[$key];
				$ct['lothang'] = $arr_lothang[$key];
				$this->model_bm_bmtn13->saveBMTN13ChiTiet($ct);
			}
			
			$data['error'] = "";
			
		}
		else
		{
			foreach($this->error as $item)
			{
				$data['error'] .= $item."<br>";
			}
		}
		$this->data['output'] = json_encode($data);
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	private function validateForm($data)
	{
		$arr_soluongcan = $data['soluongcan'];
		foreach($arr_soluongcan as $soluong)
		{
			if($soluong == 0)
				$this->error['soluongcan'] = "Bạn chưa nhập đủ số lượng cân";
		}
    	

		if (count($this->error)==0) {
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
}
?>