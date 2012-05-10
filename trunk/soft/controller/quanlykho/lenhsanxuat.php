<?php
class ControllerQuanlykhoLenhsanxuat extends Controller
{
	private $error = array();
   	function __construct() 
	{
		if(!$this->user->hasPermission($this->getRoute(), "access"))
		{
			$this->response->redirect("?route=common/permission");
		}
		$this->data['permissionAdd'] = true;
		$this->data['permissionEdit'] = true;
		$this->data['permissionDelete'] = true;
		if(!$this->user->hasPermission($this->getRoute(), "add"))
		{
			$this->data['permissionAdd'] = false;
		}
		if(!$this->user->hasPermission($this->getRoute(), "edit"))
		{
			$this->data['permissionEdit'] = false;
		}
		if(!$this->user->hasPermission($this->getRoute(), "delete"))
		{
			$this->data['permissionDelete'] = false;
		}
		
		$this->load->model("quanlykho/lenhsanxuat");
		$this->load->model("quanlykho/phongban");
		$this->load->model("common/control");
		$this->data['data_phongbang'] = $this->model_quanlykho_phongban->getPhongBans();
		$this->data['cbPhongBang'] = $this->model_common_control->getDataCombobox($this->data['data_phongbang'], "tenphongban", "maphongban");
		
   	}
	
	public function index()
	{
		$this->getList();
	}
	
	public function insert()
	{
    	$this->getForm();
	}
	
	public function update()
	{
		$this->data['haspass'] = false;
		$this->data['readonly'] = 'readonly="readonly"';
		$this->data['class'] = 'readonly';	
		$this->getForm();
  	}
	
	
	
	public function delete() 
	{
		$listphieuid=$this->request->post['delete'];
		
		if(count($listphieuid))
		{
			foreach($listphieuid as $phieuid)
			{
				$this->model_quanlykho_lenhsanxuat->delete($phieuid);	
			}
			$this->data['output'] = "true";
		}
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
  	}
	
	private function getList() 
	{
		$this->data['insert'] = $this->url->http('quanlykho/lenhsanxuat/insert');
		$this->data['delete'] = $this->url->http('quanlykho/lenhsanxuat/delete');		
		
		$this->data['datas'] = array();
		$where = "";
		
		$data = $this->request->get;
		if($data['sophieu'])
		{
			$where .= " AND sophieu = '".$data['sophieu']."'";
		}
		if($data['tungay'])
		{
			$where .= " AND ngaylap >= '". $this->date->formatViewDate($data['tungay']) ."'";
		}
		if($data['denngay'])
		{
			$where .= " AND ngaylap <= '". $this->date->formatViewDate($data['denngay']) ."'";
		}
		if($data['kehoachngay'])
		{
			$where .= " AND kehoachngay = '".$data['kehoachngay']."'";
		}
		if($data['nhacungungid'])
		{
			$where .= " AND nhacungungid = '".$data['nhacungungid']."'";
		}
		if($data['tinhtrang'])
		{
			$where .= " AND tinhtrang = '".$data['tinhtrang']."'";
		}
		if($data['sotientu'])
		{
			$where .= " AND tongsotien >= '".$this->string->toNumber($data['sotientu'])."'";
		}
		if($data['sotienden'])
		{
			$where .= " AND tongsotien <= '".$this->string->toNumber($data['sotienden'])."'";
		}
		
		
		
		$where .= " Order by createdate DESC";
		$rows = $this->model_quanlykho_lenhsanxuat->getList($where);
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
		{
			$this->data['datas'][$i] = $rows[$i];
			$this->data['datas'][$i]['link_edit'] = $this->url->http('quanlykho/lenhsanxuat/update&lenhsanxuatid='.$this->data['datas'][$i]['lenhsanxuatid']);
			$this->data['datas'][$i]['text_edit'] = "Edit";
			
			
			
		}
		
		$this->id='content';
		$this->template="quanlykho/lenhsanxuat_list.tpl";
		$this->layout='layout/center';
		
		$this->render();
	}
	
	
	private function getForm()
	{		
		
		if ((isset($this->request->get['lenhsanxuatid'])) ) 
		{
      		$this->data['item'] = $this->model_quanlykho_lenhsanxuat->getItem($this->request->get['lenhsanxuatid']);
			$where = " AND lenhsanxuatid = '".$this->request->get['lenhsanxuatid']."'";
			$this->data['data_chitiet'] = $this->model_quanlykho_lenhsanxuat->getPhieuNhanVatTuHangHoaChiTietList($where);
			foreach($this->data['data_chitiet'] as $key =>$ct)
			{
				$this->data['data_chitiet'][$key]['tendonvi'] = $this->document->getDonViTinh($ct['donvi']);
			}
    	}
		else
		{
			$this->data['item']['ngaylap'] = $this->date->getToday();
		}
		
		$this->id='content';
		$this->template='quanlykho/lenhsanxuat_form.tpl';
		$this->layout='layout/center';
		$this->render();
	}
	
	public function view()
	{
		$this->data['item'] = $this->model_quanlykho_lenhsanxuat->getItem($this->request->get['lenhsanxuatid']);
		$where = " AND lenhsanxuatid = '".$this->request->get['lenhsanxuatid']."'";
		$this->data['data_chitiet'] = $this->model_quanlykho_lenhsanxuat->getPhieuNhanVatTuHangHoaChiTietList($where);
		foreach($this->data['data_chitiet'] as $key =>$ct)
		{
			$this->data['data_chitiet'][$key]['tendonvi'] = $this->document->getDonViTinh($ct['donvi']);
		}
		$this->id='content';
		$this->template='bieumau/bm_vt_16.tpl';
		$this->layout="layout/center";
		if($this->request->get['dialog']=='print')
		{
			
			
			$this->layout="layout/print";
			$this->data['dialog'] = "print";
		}
		$this->render();
	}
	
	public function save()
	{
		$data = $this->request->post;
		
		if($this->validateForm($data))
		{
			
			if($data['lenhsanxuatid']=="")
			{
				
				$data['lenhsanxuatid'] = $this->model_quanlykho_lenhsanxuat->insert($data);	
			}
			else
			{
				$this->model_quanlykho_lenhsanxuat->update($data);	
			}
			//Xoa chi tiet bien nhan
			if($data['delchitietid']!="")
			{
				$arr_idct = split(',',$data['delchitietid']);
				foreach($arr_idct as $id)
				{
					$this->model_quanlykho_lenhsanxuat->deletePhieuNhanVatTuHangHoaChiTiet($id);	
				}
			}
			
			//Luu chi tiet
			$arr_id = $data['id'];
			$arr_nguyenlieuid = $data['nguyenlieuid'];
			$arr_manguyenlieu = $data['manguyenlieu'];
			$arr_tennguyenlieu = $data['tennguyenlieu'];
			$arr_lotnguyenlieu = $data['lotnguyenlieu'];
			$arr_makho = $data['makho'];
			$arr_chungtu = $data['chungtu'];
			$arr_thucnhap = $data['thucnhap'];
			$arr_dongia = $data['dongia'];
			
			$sum = 0;
			foreach($arr_nguyenlieuid as $key => $dichvuid)
			{
				$ct['id'] = $arr_id[$key];
				$ct['lenhsanxuatid']= $data['lenhsanxuatid'];
				$ct['ngaynhap']= $this->date->formatViewDate($data['ngaylap']);
				$ct['nguyenlieuid'] = $arr_nguyenlieuid[$key];
				$ct['manguyenlieu'] = $arr_manguyenlieu[$key];
				$ct['tennguyenlieu'] = $arr_tennguyenlieu[$key];
				$ct['lotnguyenlieu'] = $arr_lotnguyenlieu[$key];
				$ct['nhacungungid'] = $data['nhacungungid'];
				$ct['makho'] = $arr_makho[$key];
				$ct['donvi'] = $this->document->getNguyenLieu($ct['nguyenlieuid'],'madonvi');
				$ct['chungtu'] = $arr_chungtu[$key];
				$ct['thucnhap'] = $arr_thucnhap[$key];
				$ct['dongia'] = $arr_dongia[$key];
				$ct['thanhtien'] = $this->string->toNumber($ct['thucnhap'])*$this->string->toNumber($ct['dongia']);
				
				$this->model_quanlykho_lenhsanxuat->savePhieuNhanVatTuHangHoaChiTiet($ct);
				$sum +=$this->string->toNumber($ct['thanhtien']);
			}
			
			$this->model_quanlykho_lenhsanxuat->updateCol($data['lenhsanxuatid'],'tongsotien',$sum);
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
		
		if (trim($data['kehoachdathang']) == "") 
		{
      		$this->error['kehoachdathang'] = "Bạn chưa nhập kế hoạch đăt hàng";
    	}
		
		if (count($this->error)==0) {
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
	
}
?>