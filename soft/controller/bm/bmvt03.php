<?php
class ControllerBmBMvt03 extends Controller
{
	private $error = array();
	function __construct() 
	{
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
	
	public function getList()
	{
		
		$where = " Order by id desc";
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
}
?>