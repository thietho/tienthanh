<?php
class ControllerBmBMtn13 extends Controller
{
	private $error = array();
	function __construct() 
	{
		$this->data['cbChatLuong'] = '<option value=""></option>';
		foreach($this->document->chatluong as $key => $val)
		{
			$this->data['cbChatLuong'] .= '<option value="'.$key.'">'.$val.'</option>';
		}
		//echo $this->data['cbChatLuong'];
		$this->load->model("quanlykho/donvitinh");
		$this->load->model("bm/bmtn13");
		$data_donvitinh = $this->model_quanlykho_donvitinh->getList();
		$this->data['cbDonViTinh'] = '<option value=""></option>';
		foreach($data_donvitinh as $val)
		{
			$this->data['cbDonViTinh'] .= '<option value="'.$val['madonvi'].'">'.$val['tendonvitinh'].'</option>';
		}
	}
	public function create()
	{
		$this->id='content';
		$this->template='bm/bmtn13_form.tpl';
		$this->render();
	}
	
	public function save()
	{
		$data = $this->request->post;
		print_r($data);
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
			
			
			$this->data['output'] = "true";
		}
		else
		{
			foreach($this->error as $item)
			{
				$this->data['output'] .= $item."<br>";
			}
		}
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	private function validateForm($data)
	{
		
		
    	if($data['sophieugiaohang'] == "")
		{
      		$this->error['sophieugiaohang'] = "Bạn chưa nhập số phiếu giao hàng";
    	}
		if($data['ngayphieugiaohang'] == "")
		{
      		$this->error['ngayphieugiaohang'] = "Bạn chưa nhập ngày phiếu giao hàng";
    	}
		if($data['nhacungungid'] == "")
		{
      		$this->error['nhacungungid'] = "Bạn chưa chọn nhà cung cấp";
    	}
		if($data['sokehoachdathang'] == "")
		{
      		$this->error['sokehoachdathang'] = "Bạn chưa nhập số kế hoạch đặt hàng";
    	}
		if($data['ngaykehoachdathang'] == "")
		{
      		$this->error['ngaykehoachdathang'] = "Bạn chưa nhập ngày kế hoạch đặt hàng";
    	}

		if (count($this->error)==0) {
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
}
?>