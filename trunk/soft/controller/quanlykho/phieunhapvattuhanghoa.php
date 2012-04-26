<?php
class ControllerQuanlykhoPhieunhapvattuhanghoa extends Controller
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
		
	 	$this->load->model("quanlykho/phieunhapvattuhanghoa");
		$this->load->model("quanlykho/kho");
		$this->load->model("common/control");
		$this->data['data_kho'] = $this->model_quanlykho_kho->getKhos();
		$this->data['cbKhos'] = $this->model_common_control->getDataCombobox($this->data['data_kho'], "tenkho", "makho");
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
				$this->model_quanlykho_phieunhapvattuhanghoa->delete($phieuid);	
			}
			$this->data['output'] = "true";
		}
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
  	}
	
	private function getList() 
	{
		$this->data['insert'] = $this->url->http('quanlykho/phieunhapvattuhanghoa/insert');
		$this->data['delete'] = $this->url->http('quanlykho/phieunhapvattuhanghoa/delete');		
		
		
		
		$this->data['datas'] = array();
		$where = "";
		
		$where .= " Order by sophieu DESC";
		$rows = $this->model_quanlykho_phieunhapvattuhanghoa->getList($where);
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
			$this->data['datas'][$i]['link_edit'] = $this->url->http('quanlykho/phieunhapvattuhanghoa/update&phieunhapvattuhanghoaid='.$this->data['datas'][$i]['phieunhapvattuhanghoaid']);
			$this->data['datas'][$i]['text_edit'] = "Edit";
			
			
			
		}
		
		$this->id='content';
		$this->template="quanlykho/phieunhapvattuhanghoa_list.tpl";
		$this->layout='layout/center';
		
		$this->render();
	}
	
	
	private function getForm()
	{		
		
		if ((isset($this->request->get['phieunhapvattuhanghoaid'])) ) 
		{
      		$this->data['item'] = $this->model_quanlykho_phieunhapvattuhanghoa->getItem($this->request->get['phieunhapvattuhanghoaid']);
			$where = " AND phieunhapvattuhanghoaid = '".$this->request->get['phieunhapvattuhanghoaid']."'";
			$this->data['data_chitiet'] = $this->model_quanlykho_phieunhapvattuhanghoa->getPhieuNhanVatTuHangHoaChiTietList($where);
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
		$this->template='quanlykho/phieunhapvattuhanghoa_form.tpl';
		$this->layout='layout/center';
		$this->render();
	}
	
	public function view()
	{
		$this->data['item'] = $this->model_quanlykho_phieunhapvattuhanghoa->getItem($this->request->get['phieunhapvattuhanghoaid']);
		$where = " AND phieunhapvattuhanghoaid = '".$this->request->get['phieunhapvattuhanghoaid']."'";
		$this->data['data_chitiet'] = $this->model_quanlykho_phieunhapvattuhanghoa->getPhieuNhanVatTuHangHoaChiTietList($where);
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
			
			if($data['phieunhapvattuhanghoaid']=="")
			{
				
				$data['phieunhapvattuhanghoaid'] = $this->model_quanlykho_phieunhapvattuhanghoa->insert($data);	
			}
			else
			{
				$this->model_quanlykho_phieunhapvattuhanghoa->update($data);	
			}
			//Xoa chi tiet bien nhan
			if($data['delchitietid']!="")
			{
				$arr_idct = split(',',$data['delchitietid']);
				foreach($arr_idct as $id)
				{
					$this->model_quanlykho_phieunhapvattuhanghoa->deletePhieuNhanVatTuHangHoaChiTiet($id);	
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
				$ct['phieunhapvattuhanghoaid']= $data['phieunhapvattuhanghoaid'];
				$ct['ngaynhap']= $this->date->formatViewDate($data['ngaylap']);
				$ct['nguyenlieuid'] = $arr_nguyenlieuid[$key];
				$ct['manguyenlieu'] = $arr_manguyenlieu[$key];
				$ct['tennguyenlieu'] = $arr_tennguyenlieu[$key];
				$ct['lotnguyenlieu'] = $arr_lotnguyenlieu[$key];
				$ct['makho'] = $arr_makho[$key];
				$ct['donvi'] = $this->document->getNguyenLieu($ct['nguyenlieuid'],'madonvi');
				$ct['chungtu'] = $arr_chungtu[$key];
				$ct['thucnhap'] = $arr_thucnhap[$key];
				$ct['dongia'] = $arr_dongia[$key];
				$ct['thanhtien'] = $this->string->toNumber($ct['thucnhap'])*$this->string->toNumber($ct['dongia']);
				
				$this->model_quanlykho_phieunhapvattuhanghoa->savePhieuNhanVatTuHangHoaChiTiet($ct);
				$sum +=$this->string->toNumber($ct['thanhtien']);
			}
			
			$this->model_quanlykho_phieunhapvattuhanghoa->updateCol($data['phieunhapvattuhanghoaid'],'tongsotien',$sum);
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