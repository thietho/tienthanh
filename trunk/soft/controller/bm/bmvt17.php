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
		$id = $this->request->get['bmvt17id'];
		
		if($id == "")
		{		
			$bmtn13id = $this->request->get['bmtn13id'];
			$this->data['item'] = $this->model_bm_bmtn13->getItem($bmtn13id);
			$this->data['item']['bmtn13id'] = $this->data['item']['id'];
			$this->data['item']['id'] = "";
			$where = " AND bmtn13id = '".$bmtn13id."'";
			$this->data['data_ct'] = $this->model_bm_bmtn13->getBMTN13ChiTietList($where);
			foreach($this->data['data_ct'] as $key => $ct)
			{
				$this->data['data_ct'][$key]['id'] = "";
			}
		}
		else
		{
			$this->data['item'] = $this->model_bm_bmvt17->getItem($id);
			$where = " AND bmvt17id = '".$id."'";
			$this->data['data_ct'] = $this->model_bm_bmvt17->getBMVT17ChiTietList($where);
		}
		$this->id='content';
		$this->template='bm/bmvt17_form.tpl';
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
			//Luu vao bang bmvt17
			if((int)$data['id']==0)
			{
				$data['id'] = $this->model_bm_bmvt17->insert($data);
				$this->model_bm_bmtn13->updateCol($data['bmtn13id'],'bmvt17id',$data['id']);
			}
			else
			{
				$this->model_bm_bmvt17->update($data);
			}
			
			//Luu vao bang bnvt17_chitiet
			$bmvt17id = $data['id'];
			$arr_id = $data['ctid'];
			$arr_itemtype = $data['itemtype'];
			$arr_itemid = $data['itemid'];
			$arr_itemcode = $data['itemcode'];
			$arr_itemname = $data['itemname'];
			$arr_baobi = $data['baobi'];
			$arr_loaibao = $data['loaibao'];
			$arr_soluongcan = $data['soluongcan'];
			$arr_madonvi = $data['madonvi'];
			$arr_ghichu = $data['ghichu'];
			foreach($arr_id as $key=>$id)
			{
				$ct['id'] = $id;
				$ct['bmvt17id'] = $bmvt17id;
				$ct['itemtype'] = $arr_itemtype[$key];
				$ct['itemid'] = $arr_itemid[$key];
				$ct['itemcode'] = $arr_itemcode[$key];
				$ct['itemname'] = $arr_itemname[$key];
				$ct['baobi'] = $arr_baobi[$key];
				$ct['loaibao'] = $arr_loaibao[$key];
				$ct['soluongcan'] = $arr_soluongcan[$key];
				$ct['madonvi'] = $arr_madonvi[$key];
				$ct['ghichu'] = $arr_ghichu[$key];
				$this->model_bm_bmvt17->saveBMVT17ChiTiet($ct);
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