<?php
class ControllerBmBMvt03 extends Controller
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
		$this->data['arr_pheduyet'] = array(
										'' => 'Chưa phê duyệt',
										'dangxemxet' => 'Đang xem xét',
										'dapheduyet' => 'Đã phê duyệt'
										);
		$this->data['pheduyet_color'] = array(
										'' => '#fff',
										'dangxemxet' => '#FFFF00',
										'dapheduyet' => '#009F6B'
										);
		//echo $this->data['cbChatLuong'];
		$this->load->model("quanlykho/donvitinh");
		$this->load->model("bm/bmvt03");
		$this->load->model("bm/bmtn13");
		$this->load->model("bm/bmvt17");
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
		
		
		
		$this->id='content';
		$this->template="bm/bmvt03_main.tpl";
		$this->layout="layout/center";
		if($this->request->get['opendialog']=='true')
		{
			$this->layout="";
			$this->data['dialog'] = true;
			
		}
		$this->render();
	}
	
	public function create()
	{
		$this->id='content';
		$this->template='bm/bmvt03_form.tpl';
		$this->render();
	}
	public function edit()
	{
		$id = $this->request->get['id'];
		$this->data['item'] = $this->model_bm_bmvt03->getItem($id);
		
		$where = " AND bmvt03id = '".$id."'";
		$this->data['data_ct'] = $this->model_bm_bmvt03->getBMVT03ChiTietList($where);
		
		$this->id='content';
		$this->template='bm/bmvt03_form.tpl';
		$this->render();
	}
	public function view()
	{
		$id = $this->request->get['id'];
		$this->data['item'] = $this->model_bm_bmvt03->getItem($id);
		
		$where = " AND bmvt03id = '".$id."'";
		$this->data['data_ct'] = $this->model_bm_bmvt03->getBMVT03ChiTietList($where);
		
		$this->id='content';
		$this->template='bm/bmvt03.tpl';
		
		if($this->request->get['dialog']=='print')
		{
			
			$this->layout="layout/print";
			$this->data['dialog'] = "print";
		}
		$this->render();
	}
	
	public function getList()
	{
		$where = "";
		$sophieu = $this->request->get['sophieu'];
		if($sophieu!='')
			$where .= " AND `sophieu` LIKE  '%".$sophieu."%'";
		$where .= " Order by id desc";
		$this->data['data_btvt03']=$this->model_bm_bmvt03->getList($where);
				
		$this->id='content';
		$this->template='bm/bmvt03_list.tpl';
		$this->render();
	}
	
	public function save()
	{
		$data = $this->request->post;
		
		if($this->validateForm($data))
		{
			//Luu vao bang bmvt03
			if((int)$data['id']==0)
			{
				$data['id'] = $this->model_bm_bmvt03->insert($data);
			}
			else
			{
				$this->model_bm_bmvt03->update($data);
			}
			//Xóa chi tiet
			$arr_delid = split(",",$data['delid']);
			foreach($arr_delid as $id)
			{
				if($id)
				{
					$this->model_bm_bmvt03->deleteBMVT03ChiTiet($id);	
				}
			}
			//Luu vao bang bntn13_chitiet
			$bmvt03id = $data['id'];
			$arr_id = $data['ctid'];
			$arr_itemtype = $data['itemtype'];
			$arr_itemid = $data['itemid'];
			$arr_itemcode = $data['itemcode'];
			$arr_itemname = $data['itemname'];
			$arr_madonvi = $data['madonvi'];
			$arr_tonhientai = $data['tonhientai'];
			$arr_tontonthieu = $data['tontonthieu'];
			$arr_muatoithieu = $data['muatoithieu'];
			$arr_pheduyet = $data['pheduyet'];
			$arr_thoigiayeucau = $data['thoigiayeucau'];
			$arr_thoigianphanhoi = $data['thoigianphanhoi'];
			$arr_ketquathuchien = $data['ketquathuchien'];
			$arr_mucdichsudung = $data['mucdichsudung'];
			
			foreach($arr_id as $key=>$id)
			{
				$ct['id'] = $id;
				$ct['bmvt03id'] = $bmvt03id;
				$ct['itemtype'] = $arr_itemtype[$key];
				$ct['itemid'] = $arr_itemid[$key];
				$ct['itemcode'] = $arr_itemcode[$key];
				$ct['itemname'] = $arr_itemname[$key];
				$ct['madonvi'] = $arr_madonvi[$key];
				$ct['tonhientai'] = $arr_tonhientai[$key];
				$ct['tontonthieu'] = $arr_tontonthieu[$key];
				$ct['muatoithieu'] = $arr_muatoithieu[$key];
				$ct['pheduyet'] = $arr_pheduyet[$key];
				$ct['thoigiayeucau'] = $arr_thoigiayeucau[$key];
				$ct['thoigianphanhoi'] = $arr_thoigianphanhoi[$key];
				$ct['ketquathuchien'] = $arr_ketquathuchien[$key];
				$ct['mucdichsudung'] = $arr_mucdichsudung[$key];
				$this->model_bm_bmvt03->saveBMVT03ChiTiet($ct);
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
		
		if (count($this->error)==0) {
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
	
	public function delete()
	{
		$id = $this->request->get['id'];
		$this->model_bm_bmvt03->delete($id);		
		$this->data['output'] = 'true';
		
		
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	
	public function pheduyet()
	{
		$id = $this->request->get['id'];
		$this->data['item'] = $this->model_bm_bmvt03->getItem($id);
		
		$where = " AND bmvt03id = '".$id."'";
		$this->data['data_ct'] = $this->model_bm_bmvt03->getBMVT03ChiTietList($where);
		
		$this->id='content';
		$this->template='bm/bmvt03_pheduyet.tpl';
		$this->render();
	}
	
	public function savePheDuyet()
	{
		$data = $this->request->post;
		$this->model_bm_bmvt03->updateCol($data['id'],'tinhtrang',$data['tinhtrang']);
		if(count($data['pheduyet']))
			foreach($data['pheduyet'] as $id => $pheduyet)
			{
				$this->model_bm_bmvt03->updateBMVT03ChiTiet($id,'pheduyet',$this->string->toNumber($pheduyet));
			}
		$data['error'] = "";
		$this->data['output'] = json_encode($data);
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	//
	public function phanHoiThoiGianCungUng()
	{
		$id = $this->request->get['id'];
		$this->data['item'] = $this->model_bm_bmvt03->getItem($id);
		
		$where = " AND bmvt03id = '".$id."'";
		$this->data['data_ct'] = $this->model_bm_bmvt03->getBMVT03ChiTietList($where);
		
		$this->id='content';
		$this->template='bm/bmvt03_phanhoithoigiancungung.tpl';
		$this->render();
	}
	public function savePhanHoiThoiGianCungUng()
	{
		$data = $this->request->post;
		//$this->model_bm_bmvt03->updateCol($data['id'],'tinhtrang',$data['tinhtrang']);
		if(count($data['thoigianphanhoi']))
			foreach($data['thoigianphanhoi'] as $id => $thoigianphanhoi)
			{
				$this->model_bm_bmvt03->updateBMVT03ChiTiet($id,'thoigianphanhoi',$this->date->formatViewDate($thoigianphanhoi));
			}
		$data['error'] = "";
		$this->data['output'] = json_encode($data);
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	//Dot giao hang
	public function dotGiaoHang()
	{
		$bmvt03id = $this->request->get['bmvt03id'];
		$this->data['item'] = $this->model_bm_bmvt03->getItem($bmvt03id);
		
		$where = " AND bmvt03id = '".$bmvt03id."'";
		$this->data['data_ct'] = $this->model_bm_bmvt03->getBMVT03ChiTietList($where);
		//List dot giao hang
		$where = " AND bmvt03id = '".$bmvt03id."'";
		$this->data['data_dotgiaohang'] = $this->model_bm_bmvt03->getDotGiaHangList($where);
		foreach($this->data['data_ct'] as $key => $ct)
		{
			//Lay cac dot giao hang cua bmvt03
			$data_dotgiaohang = $this->data['data_dotgiaohang'];
			$itemid = $ct['itemid'];
			$itemtype = $ct['itemtype'];
			$sumdagiao = $this->getSoLuongDaGiao($bmvt03id,$itemid,$itemtype);
			$this->data['data_ct'][$key]['dagiao'] = $sumdagiao;
			$this->data['data_ct'][$key]['conlai'] = $ct['pheduyet'] - $sumdagiao;
		}
		
		
		
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
		$this->template='bm/bmvt03_dotgiaohang.tpl';
		$this->render();
	}
	public function createDotGiaoHang()
	{
		$id = $this->request->get['id'];
		$bmvt03id = $this->request->get['bmvt03id'];
		
		$this->data['item'] = $this->model_bm_bmvt03->getItem($bmvt03id);
		$where = " AND bmvt03id = '".$bmvt03id."'";
		$this->data['data_ct'] = $this->model_bm_bmvt03->getBMVT03ChiTietList($where);		
		foreach($this->data['data_ct'] as $key => $ct)
		{
			//Lay cac dot giao hang cua bmvt03
			$data_dotgiaohang = $this->data['data_dotgiaohang'];
			$itemid = $ct['itemid'];
			$itemtype = $ct['itemtype'];
			$sumdagiao = $this->getSoLuongDaGiao($bmvt03id,$itemid,$itemtype);
			$this->data['data_ct'][$key]['dagiao'] = $sumdagiao;
			$this->data['data_ct'][$key]['conlai'] = $ct['pheduyet'] - $sumdagiao;
		}
		
		$this->id='content';
		$this->template='bm/bmvt03_dotgiaohang_form.tpl';
		$this->render();
	}
	
	private function getSoLuongDaGiao($bmvt03id,$itemid,$itemtype)
	{
		$where = " AND bmvt03id = '".$bmvt03id."'";
		$data_dotgiaohang = $this->model_bm_bmvt03->getDotGiaHangList($where);
		//List bmvt16id
		$arr_bmvt16id = $this->string->matrixToArray($data_dotgiaohang,'bmvt16id');
		//Lay so luong da giao
		$where = " AND itemid='".$itemid."' AND itemtype='".$itemtype."' AND bmvt16id IN ('".implode("','",$arr_bmvt16id)."')";
		$data_dagiao = $this->model_bm_bmvt16->getBMVT16ChiTietList($where);
		
		$sumdagiao = 0;
		foreach($data_dagiao as $dagiao)
		{
			$sumdagiao += $dagiao['thucnhap'];
		}
		return $sumdagiao;
	}
	
	public function viewDotGiaoHang()
	{
		$id = $this->request->get['id'];
		$this->data['item'] = $this->model_bm_bmvt03->getDotGiaHang($id);
		$where = " AND dotgiaohangid = '".$id."'";
		$this->data['data_ct'] = $this->model_bm_bmvt03->getDotGiaHangChiTietList($where);
		
		
		$this->id='content';
		$this->template='bm/bmvt03_dotgiaohang_view.tpl';
		$this->render();
	}
	
	public function saveDotGiaoHang()
	{
		$data = $this->request->post;
		if($this->validateFormDotGiaoHang($data))
		{
			$data['id'] = $this->model_bm_bmvt03->insertDotGiaoHang($data);	
			//Luu vao chi tiet dot dat hang
			$dotgiaohangid = $data['id'];
			$arr_id = $data['ctid'];
			$arr_itemtype = $data['itemtype'];
			$arr_itemid = $data['itemid'];
			$arr_itemcode = $data['itemcode'];
			$arr_itemname = $data['itemname'];
			$arr_madonvi = $data['madonvi'];
			$arr_soluong = $data['soluong'];
			foreach($arr_itemid as $key =>$itemid)
			{
				$ct['dotgiaohangid'] = $dotgiaohangid;
				$ct['bmvt03id'] = $data['bmvt03id'];
				$ct['itemtype'] = $arr_itemtype[$key];
				$ct['itemid'] = $arr_itemid[$key];
				$ct['itemcode'] = $arr_itemcode[$key];
				$ct['itemname'] = $arr_itemname[$key];
				$ct['madonvi'] = $arr_madonvi[$key];
				$ct['soluong'] = $arr_soluong[$key];
				if($ct['soluong']>0)
					$this->model_bm_bmvt03->saveDotGiaoHangChiTiet($ct);
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
	public function delDotGiaoHang()
	{
		$id = $this->request->get['id'];
		$this->model_bm_bmvt03->deleteDotGiaHang($id);
		$this->data['output'] = "true";
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	
	private function validateFormDotGiaoHang($data)
	{
		if($data['sophieugiaohang']=="")
		{
			$this->error['sophieugiaohang'] = "Bạn chưa nhập số phiếu giao hàng";
		}
		if($data['ngayphieugiaohang']=="")
		{
			$this->error['ngayphieugiaohang'] = "Bạn chưa nhập ngày ngày phiếu giao hàng";
		}
		if($data['manhacungung']=="")
		{
			$this->error['manguyenlieu'] = "Bạn chưa chọn nhà cung ứng";
		}
		if($data['sokehoachdathang']=="")
		{
			$this->error['sokehoachdathang'] = "Bạn chưa nhập số kế hoạch đặt hàng";
		}
		if($data['ngaykehoachdathang']=="")
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