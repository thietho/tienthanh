<?php
class ControllerBmBmvt17 extends Controller
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
		
		$this->load->model("quanlykho/donvitinh");
		$this->load->model("bm/bmvt03");
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
		$where .= " AND tinhtrang = 'dapheduyet' Order by id desc";
		$this->data['data_bmvt03']=$this->model_bm_bmvt03->getList($where);	
		
		$this->id='content';
		$this->template="bm/bmvt17_main.tpl";
		$this->layout="layout/center";
		if($this->request->get['opendialog']=='true')
		{
			$this->layout="";
			$this->data['dialog'] = true;
			
		}
		$this->render();
	}
	//Dot giao hang
	public function dotGiaoHang()
	{
		$bmvt03id = $this->request->get['bmvt03id'];
		$where = " AND bmvt03id = '".$bmvt03id."'";
		$this->data['data_dotgiaohang'] = $this->model_bm_bmvt03->getDotGiaHangList($where);
		foreach($this->data['data_dotgiaohang'] as $key => $ct)
		{
			$bmtn13 = $this->model_bm_bmtn13->getItem($ct['bmtn13id']);
			$this->data['data_dotgiaohang'][$key]['sophieubmtn13']= $bmtn13['sophieu'];
			
			$bmvt17 = $this->model_bm_bmvt17->getItem($ct['bmvt17id']);
			$this->data['data_dotgiaohang'][$key]['sophieubmvt17']= $bmvt17['sophieu'];
			
			$bmvt16 = $this->model_bm_bmvt17->getItem($ct['bmvt16id']);
			$this->data['data_dotgiaohang'][$key]['sophieubmvt16']= $bmvt16['sophieu'];
		}
		
		$this->id='content';
		$this->template='bm/bmvt17_dotgiaohang.tpl';
		$this->render();
	}
	public function create()
	{
		$dotgiaohangid = $this->request->get['dotgiaohangid'];
		$this->data['item'] = $this->model_bm_bmvt03->getDotGiaHang($dotgiaohangid);
		$this->data['item']['id'] = "";
		$this->data['dotgiaohangid'] = $dotgiaohangid;
		$where = " AND dotgiaohangid = '".$dotgiaohangid."'";
		$this->data['data_ct'] = $this->model_bm_bmvt03->getDotGiaHangChiTietList($where);
		foreach($this->data['data_ct'] as $key => $ct)
		{
			$this->data['data_ct'][$key]['id'] = '';
		}
		
		$this->id='content';
		$this->template='bm/bmvt17_form.tpl';
		$this->render();
	}
	public function edit()
	{
		$id = $this->request->get['id'];
		$dotgiaohangid = $this->request->get['dotgiaohangid'];
		$this->data['dotgiaohangid'] = $dotgiaohangid;
		$this->data['item'] = $this->model_bm_bmvt17->getItem($id);
		
		$where = " AND dotgiaohangid = '".$dotgiaohangid."'";
		$this->data['data_ct'] = $this->model_bm_bmvt03->getDotGiaHangChiTietList($where);
		
		$where = " AND bmvt17id = '".$id."'";
		$this->data['data_ctcan'] = $this->model_bm_bmvt17->getBMVT17ChiTietList($where);
		
		$this->id='content';
		$this->template='bm/bmvt17_form.tpl';
		$this->render();
	}
	public function view()
	{
		$id = $this->request->get['id'];
		$this->data['item'] = $this->model_bm_bmvt17->getItem($id);
		
		$where = " AND bmvt17id = '".$id."'";
		$this->data['data_ct'] = $this->model_bm_bmvt17->getBMVT17ChiTietList($where);
		$this->data['groupct'] = array();
		foreach($this->data['data_ct'] as $ct)
		{
			$this->data['groupct'][$ct['itemname']][] = $ct;
		}
		
		
		$this->id='content';
		$this->template='bm/bmvt17.tpl';
		
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
				$this->model_bm_bmvt03->updateDotGiaoHang($data['dotgiaohangid'],'bmvt17id',$data['id']);
			}
			else
			{
				$this->model_bm_bmvt17->update($data);
			}
			//Xóa chi tiet
			$arr_delid = split(",",$data['delid']);
			foreach($arr_delid as $id)
			{
				if($id)
				{
					$this->model_bm_bmvt17->deleteBMVT17ChiTiet($id);	
				}
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
			$dotgiaohang = $this->model_bm_bmvt03->getDotGiaHang($data['dotgiaohangid']);
			$data['bmvt03id'] = $dotgiaohang['bmvt03id'];
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