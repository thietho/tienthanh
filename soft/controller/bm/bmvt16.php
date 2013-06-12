<?php
class ControllerBmBmvt16 extends Controller
{
	private $error = array();
	function __construct() 
	{
		
		$this->load->model("quanlykho/donvitinh");
		$this->load->model("bm/bmtn13");
		$this->load->model("bm/bmvt16");
		$data_donvitinh = $this->model_quanlykho_donvitinh->getList();
		$this->data['cbDonViTinh'] = '<option value=""></option>';
		foreach($data_donvitinh as $val)
		{
			$this->data['cbDonViTinh'] .= '<option value="'.$val['madonvi'].'">'.$val['tendonvitinh'].'</option>';
		}
	}
	public function index()
	{
		$id = $this->request->get['bmvt16id'];
		
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
			$this->data['item'] = $this->model_bm_bmvt16->getItem($id);
			$where = " AND bmvt16id = '".$id."'";
			$this->data['data_ct'] = $this->model_bm_bmvt16->getBMVT16ChiTietList($where);
		}
		$this->id='content';
		$this->template='bm/bmvt16_form.tpl';
		$this->render();
	}
	
	public function view()
	{
		$id = $this->request->get['id'];
		$this->data['item'] = $this->model_bm_bmvt16->getItem($id);
		
		$where = " AND bmvt16id = '".$id."'";
		$this->data['data_ct'] = $this->model_bm_bmvt16->getBMVT16ChiTietList($where);
		
		$this->id='content';
		$this->template='bm/bmvt16.tpl';
		
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
				$data['id'] = $this->model_bm_bmvt16->insert($data);
				//$this->model_bm_bmtn13->updateCol($data['bmtn13id'],'bmvt17id',$data['id']);
			}
			else
			{
				$this->model_bm_bmvt16->update($data);
			}
			
			//Luu vao bang bnvt16_chitiet
			$bmvt16id = $data['id'];
			$arr_id = $data['ctid'];
			$arr_itemtype = $data['itemtype'];
			$arr_itemid = $data['itemid'];
			$arr_itemcode = $data['itemcode'];
			$arr_itemname = $data['itemname'];
			$arr_lothang = $data['lothang'];
			$arr_madonvi = $data['madonvi'];
			$arr_chungtu = $data['chungtu'];
			$arr_thucnhap = $data['thucnhap'];
			$arr_dongia = $data['dongia'];
			
			foreach($arr_id as $key=>$id)
			{
				$ct['id'] = $id;
				$ct['bmvt16id'] = $bmvt16id;
				$ct['itemtype'] = $arr_itemtype[$key];
				$ct['itemid'] = $arr_itemid[$key];
				$ct['itemcode'] = $arr_itemcode[$key];
				$ct['itemname'] = $arr_itemname[$key];
				$ct['lothang'] = $arr_lothang[$key];
				$ct['madonvi'] = $arr_madonvi[$key];
				$ct['chungtu'] = $arr_chungtu[$key];
				$ct['thucnhap'] = $arr_thucnhap[$key];
				$ct['dongia'] = $arr_dongia[$key];
				
				$this->model_bm_bmvt16->saveBMVT16ChiTiet($ct);
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
		$arr_thucnhap = $data['thucnhap'];
		foreach($arr_thucnhap as $soluong)
		{
			if($soluong == 0)
				$this->error['thucnhap'] = "Bạn chưa nhập đủ số lượng cân";
		}
    	

		if (count($this->error)==0) {
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
}
?>