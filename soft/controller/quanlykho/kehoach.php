<?php
class ControllerQuanlykhoKehoach extends Controller
{
	private $error = array();
	private $loaikehoach = '';
	
	function __construct()
	{
		$this->load->model("core/module");
		$moduleid = $_GET['route'];
		$this->document->title = $this->model_core_module->getBreadcrumbs($moduleid);
		if($this->user->checkPermission($moduleid)==false)
		{
			$this->response->redirect('?route=page/home');
		}
		
		$this->load->model("quanlykho/kehoach");
		$this->load->helper('image');
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
		$this->load->model("quanlykho/taisan");
		$this->data['haspass'] = false;
		$this->data['readonly'] = 'readonly="readonly"';
		$this->getForm();
	}
	
	public function setting()
	{
		$this->load->model("quanlykho/taisan");
		$this->data['haspass'] = false;
		$this->data['readonly'] = 'readonly="readonly"';
			

		$this->setup();
		

	}

	public function  danhgia()
	{
		$this->data['item'] = $this->model_quanlykho_kehoach->getItem($this->request->get['id']);

		$this->id='content';
		$this->template='quanlykho/kehoach_danhgia.tpl';
		$this->layout="layout/center";
		$this->render();
	}
	
	public function delete()
	{
		$listid=$this->request->post['delete'];
		//$listmadonvi=$_POST['delete'];
		$this->load->model("quanlykho/taisan");
		if(count($listid))
		{
			$this->model_quanlykho_kehoach->deletedatas($listid);
			$this->data['output'] = "Xóa thành công";
		}
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
	}

	private function getList()
	{

		$this->data['insert'] = $this->url->http('quanlykho/kehoach/insert');
		$this->data['delete'] = $this->url->http('quanlykho/kehoach/delete');
		$this->data['list'] = $this->url->http('quanlykho/kehoach');
			

		$this->data['datas'] = array();
		$rows = array();
		$this->model_quanlykho_kehoach->getTree(0,$rows);
		$eid="ex0-node";
		$eclass="child-of-ex0-node";
		foreach($rows as $item)
		{
				
			$deep = $item['level'];
			$link_edit = $this->url->http('quanlykho/kehoach/update&id='.$item['id']);
			$text_edit = "Edit";
			
			$makehoach = $item['id'];
			$where = "AND makehoach = '".$makehoach."'";
			$khsp = array();
			$khsp = $this->model_quanlykho_kehoach->getKeKhoachSanPhams($where);
			
			if(count($khsp)>0)
			{
				$link_danhgia = $this->url->http('quanlykho/kehoach/danhgia&id='.$item['id']);
				$text_danhgia = "Đánh giá kế quả";
			}
			else
			{
				$link_danhgia = '';
				$text_danhgia = '';
			}
			$tab="";
			if(count($item['countchild'])==0)
			$tab="<span class='tab'></span>";

			$class="";
			if($item['parentpath']!="")
			$class=$eclass.$item['parentpath'];

			$this->data["datas"][]=array(
										'id'=>$item['id'],
										'tenkehoach'=>$item['tenkehoach'],
										
										'prefix'=>$this->string->getPrefix("--",$deep),
										'deep'=>$deep + 1,
										'eid' =>$eid . $item['path'] ,
										'class' =>$class,
										
										'tab'=>$tab,
										'link_edit'=>$link_edit,
										'text_edit' =>$text_edit,
										'link_danhgia'=>$link_danhgia,
										'text_danhgia' =>$text_danhgia,
										'link_addchild' => $link_addchild,
										'text_addchild' => $text_addchild
			);
				
				
		}

		$this->id='content';
		$this->template="quanlykho/kehoach_list.tpl";
		$this->layout="layout/center";
		$this->render();
	}

	private function getForm()
	{
		if ((isset($this->request->get['id'])) )
		{
			$this->data['item'] = $this->model_quanlykho_kehoach->getItem($this->request->get['id']);
				
		}
		$this->id='content';
		$this->template='quanlykho/kehoach_form.tpl';
		$this->layout="layout/center";

		$this->render();
	}

	private function setup()
	{
		$this->data['item'] = $this->model_quanlykho_kehoach->getItem($this->request->get['id']);

		$this->id='content';
		$this->template='quanlykho/kehoach_setup.tpl';
		$this->layout="layout/center";
		$this->render();
	}

	public function loadKehoachSanPham()
	{
		$makehoach = $this->request->get['id'];
		$where = "AND makehoach = '".$makehoach."'";
		$this->data['khsp'] = $this->model_quanlykho_kehoach->getKeKhoachSanPhams($where);
		if(count($this->data['khsp'])==0)
		{
			$data = array();
			$this->load->model('quanlykho/sanpham');
			$rows = $this->model_quanlykho_sanpham->getList();
			foreach($rows as $item)
			{
				$data['makehoach'] = $makehoach;
				$data['masanpham'] = $item['id'];
				$data['tensanpham'] = $item['tensanpham'];
				$data['soluongtonhientai'] = $item['soluongton'];
				$data['sosanphamtrenlot'] = $item['sosanphamtrenlot'];
				$data['dongia'] = $item['dongiaban'];
				$this->data['khsp'][] = $data;
			}
		}
		
		$this->id='content';
		$this->template='quanlykho/kehoach_sanpham.tpl';
		$this->render();
	}
	public function loadKehoachSanPhamDanhGia()
	{
		$makehoach = $this->request->get['id'];
		$where = "AND makehoach = '".$makehoach."'";
		$this->data['khsp'] = $this->model_quanlykho_kehoach->getKeKhoachSanPhams($where);
		
		$this->id='content';
		$this->template='quanlykho/kehoach_sanpham_danhgia.tpl';
		$this->render();
	}
	public function save()
	{
		$data = $this->request->post;
		if($this->validateForm($data))
		{
			$data['loai'] = $this->loaikehoach;
			$data['ngaybatdau'] = $this->date->formatViewDate($data['ngaybatdau']);
			$data['ngayketthuc'] = $this->date->formatViewDate($data['ngayketthuc']);
			if($data['id']=="")
			{
				$data['id'] = $this->model_quanlykho_kehoach->insert($data);
				
			}
			else
			{
				$this->model_quanlykho_kehoach->update($data);
			}
			$this->data['output'] = "true-".$data['id'];
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

	public function savechitietkehoach()
	{
		$data = $this->request->post;
		$makehoach = $data['makehoach'];
		foreach($data['soluong'] as $key => $val)
		{
			$khsp['id'] = $data['id'][$key];
			$khsp['makehoach'] = $makehoach;
			$khsp['masanpham'] = $data['masanpham'][$key];
			$khsp['tensanpham'] = $data['tensanpham'][$key];
			$khsp['soluongtonhientai'] = $data['soluongtonhientai'][$key];
			$khsp['sosanphamtrenlot'] = $data['sosanphamtrenlot'][$key];
			$khsp['soluong'] = $data['soluong'][$key];
			$khsp['solot'] = $data['solot'][$key];
			$khsp['dongia'] = $data['dongia'][$key];
				
			$khsp['pheduyet'] = $data['pheduyet'][$key];
			$khsp['phuchu'] = $data['phuchu'][$key];
			$this->model_quanlykho_kehoach->saveKeHoachSanPham($khsp);
		}
		$this->data['output'] = "true";
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}

	public function savedanhgiakehoach()
	{
		$data = $this->request->post;
		$makehoach = $data['makehoach'];
		foreach($data['masanpham'] as $key => $val)
		{
			$id = $data['id'][$key];
			$ketquathuchien = $data['ketquathuchien'][$key];
			$ketquakinhdoanh = $data['ketquakinhdoanh'][$key];
			$this->model_quanlykho_kehoach->updateKeHoachSanPham($id,'ketquathuchien',$ketquathuchien);
			$this->model_quanlykho_kehoach->updateKeHoachSanPham($id,'ketquakinhdoanh',$ketquakinhdoanh);
		}
		$this->data['output'] = "true";
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	private function validateForm($data)
	{
		if($data['tenkehoach'] == "")
		{
			$this->error['tenkehoach'] = "Bạn chưa nhập tên kê hoạch";
		}
		
		if($data['ngaybatdau'] == "")
		{
			$this->error['ngaybatdau'] = "Bạn chưa nhập ngày bắt đầu";
		}
		if($data['ngayketthuc'] == "")
		{
			$this->error['ngayketthuc'] = "Bạn chưa nhập ngày kết thúc";
		}

		if (count($this->error)==0) {
			return TRUE;
		} else {
			return FALSE;
		}
	}

	//Cac ham xu ly tren form
	public function getKeHoach()
	{
		$col = $this->request->get['col'];
		$val = $this->request->get['val'];
		$operator = $this->request->get['operator'];
		if($operator == "")
		$operator = "equal";
		$this->load->model("quanlykho/taisan");
		$where = "";
		switch($operator)
		{
			case "equal":
				$where = " AND ".$col." = '".$val."'";
				break;
			case "like":
				$where = " AND ".$col." like '%".$val."%'";
				break;
			case "other":
				$where = " AND ".$col." <> '".$val."'";
				break;
			case "in":
				$where = " AND ".$col." in  (".$val.")";
				break;
					
		}

			
		$datas = $this->model_quanlykho_kehoach->getList($where);
		$this->data['output'] = json_encode(array('taisans' => $datas));
		$this->id="taisan";
		$this->template="common/output.tpl";
		$this->render();
	}

}
?>