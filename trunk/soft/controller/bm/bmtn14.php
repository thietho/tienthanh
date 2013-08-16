<?php
class ControllerBmBMtn14 extends Controller
{
	private $error = array();
	function __construct() 
	{
		$this->load->model("core/module");
		$moduleid = $_GET['route'];
		$this->document->title = $this->model_core_module->getBreadcrumbs($moduleid);
		if($this->user->checkPermission($moduleid)==false)
		{
			$this->response->redirect('?route=page/home');
		}
		
		$this->data['cbChatLuong'] = '<option value=""></option>';
		foreach($this->document->chatluong as $key => $val)
		{
			$this->data['cbChatLuong'] .= '<option value="'.$key.'">'.$val.'</option>';
		}
		//echo $this->data['cbChatLuong'];
		$this->load->model("quanlykho/donvitinh");
		$this->load->model("quanlykho/tieuchikiemtra");
		$this->load->model("bm/bmtn14");
		$this->load->model("bm/bmvt17");
		$this->load->model("bm/bmvt16");
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
		$this->template='bm/bmtn14_form.tpl';
		$this->render();
	}
	public function edit()
	{
		$id = $this->request->get['id'];
		$this->data['item'] = $this->model_bm_bmtn14->getItem($id);
		
		$where = " AND bmtn14id = '".$id."'";
		$this->data['data_ct'] = $this->model_bm_bmtn14->getBMTN14ChiTietList($where);
		foreach($this->data['data_ct'] as $key => $ct)
		{
			$tieuchikiemtra = $this->model_quanlykho_tieuchikiemtra->getItem($ct['tieuchikiemtraid']);
			$this->data['data_ct'][$key]['tieuchikiemtra'] = $tieuchikiemtra['tieuchikiemtra'];
		}
		$this->id='content';
		$this->template='bm/bmtn14_form.tpl';
		$this->render();
	}
	public function view()
	{
		$id = $this->request->get['id'];
		$this->data['item'] = $this->model_bm_bmtn14->getItem($id);
		
		$where = " AND bmtn14id = '".$id."'";
		$this->data['data_ct'] = $this->model_bm_bmtn14->getBMTN14ChiTietList($where);
		foreach($this->data['data_ct'] as $key => $ct)
		{
			$tieuchikiemtra = $this->model_quanlykho_tieuchikiemtra->getItem($ct['tieuchikiemtraid']);
			$this->data['data_ct'][$key]['tieuchikiemtra'] = $tieuchikiemtra['tieuchikiemtra'];
		}
		
		$this->id='content';
		$this->template='bm/bmtn14.tpl';
		
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
		$this->data['data_bttn14']=$this->model_bm_bmtn14->getList($where);
		
		$this->id='content';
		$this->template='bm/bmtn14_list.tpl';
		$this->render();
	}
	
	public function save()
	{
		$data = $this->request->post;
		
		if($this->validateForm($data))
		{
			//Luu vao bang bmtn14
			$data['ngayycrakqcheptay'] = $this->date->formatViewDate($data['ngayycrakqcheptay']);
			$data['ngayycgiaokqcheptay'] = $this->date->formatViewDate($data['ngayycgiaokqcheptay']);
			$data['ngaythuchien'] = $this->date->formatViewDate($data['ngaythuchien']);
			if((int)$data['id']==0)
			{
				$data['id'] = $this->model_bm_bmtn14->insert($data);
			}
			else
			{
				$this->model_bm_bmtn14->update($data);
			}
			//Xóa chi tiet
			
			//Luu vao bang bntn14_chitiet
			$bmtn14id = $data['id'];
			$arr_id = $data['ctid'];
			$arr_tieuchikiemtraid = $data['tieuchikiemtraid'];
			$arr_madonvi = $data['madonvi'];
			$arr_ketqua = $data['ketqua'];
			$arr_mucchatluong = $data['mucchatluong'];
			
			foreach($arr_id as $key=>$id)
			{
				$ct['id'] = $id;
				$ct['bmtn14id'] = $bmtn14id;
				
				$ct['tieuchikiemtraid'] = $arr_tieuchikiemtraid[$key];
				$ct['madonvi'] = $arr_madonvi[$key];
				$ct['ketqua'] = $arr_ketqua[$key];
				$ct['mucchatluong'] = $arr_mucchatluong[$key];
				
				$this->model_bm_bmtn14->saveBMTN14ChiTiet($ct);
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
		
		
    	if($data['itemid'] == "")
		{
      		$this->error['itemid'] = "Bạn chưa chọn mẫu kiểm tra";
    	}
		if($data['tinhtrangmau'] == "")
		{
      		$this->error['tinhtrangmau'] = "Bạn chưa nhập tình trạng mẫu";
    	}
		if($data['moitruongthunghiem'] == "")
		{
      		$this->error['moitruongthunghiem'] = "Bạn chưa nhập môi trường kiểm nghiệm";
    	}
		

		if (count($this->error)==0) {
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
}
?>