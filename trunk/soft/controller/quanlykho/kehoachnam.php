<?php
class ControllerQuanlykhoKehoachnam extends Controller
{
	private $error = array();
	private $loaikehoach = 'kehoachnam';
	private $setup = array(
						'quy' => 4
						
						
	);
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
		$this->setup();
	}

	public function  danhgia()
	{
		$this->data['item'] = $this->model_quanlykho_kehoach->getItem($this->request->get['id']);

		$this->id='content';
		$this->template='quanlykho/kehoachnam_danhgia.tpl';
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

		$this->data['insert'] = $this->url->http('quanlykho/kehoachnam/insert');
		$this->data['delete'] = $this->url->http('quanlykho/kehoachnam/delete');
		$this->data['list'] = $this->url->http('quanlykho/kehoachnam');
			

		$this->data['datas'] = array();
		$rows = array();
		$where = " AND kehoachcha = 0 AND loai = '".$this->loaikehoach."'";
		$rows = $this->model_quanlykho_kehoach->getList($where);
		$eid="ex0-node";
		$eclass="child-of-ex0-node";
		
		foreach($rows as $item)
		{
				
			$deep = $item['level'];
			$link_edit = $this->url->http('quanlykho/kehoachnam/update&id='.$item['id']);
			$text_edit = "Edit";
			
			$makehoach = $item['id'];
			$where = "AND kehoachid = '".$kehoachid."'";
			$khsp = array();
			$khsp = $this->model_quanlykho_kehoach->getKeKhoachSanPhams($where);
			
			if(count($khsp)>0)
			{
				$link_danhgia = $this->url->http('quanlykho/kehoachnam/danhgia&id='.$item['id']);
				$text_danhgia = "Đánh giá kết quả";
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
										'nam'=>$item['nam'],
										'quy'=>$item['quy'],
										'thang'=>$item['thang'],

										'prefix'=>$this->string->getPrefix("--",$deep),
										'deep'=>$deep + 1,
										'eid' =>$eid . $item['path'] ,
										'class' =>$class,
										'tennhom'=>$item['tennhom'],
										'nhomcha'=>$item['nhomcha'],
										'thutu'=>$item['thutu'],
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
		$this->template="quanlykho/kehoachnam_list.tpl";
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
		$this->template='quanlykho/kehoachnam_form.tpl';
		$this->layout="layout/center";

		$this->render();
	}
	
	private function chonsanpham()
	{
		$this->data['item'] = $this->model_quanlykho_kehoach->getItem($this->request->get['id']);

		$this->id='content';
		$this->template='quanlykho/kehoachnam_chonsanpham.tpl';
		$this->layout="layout/center";
		$this->render();
	}
	
	private function setup()
	{
		$this->data['item'] = $this->model_quanlykho_kehoach->getItem($this->request->get['id']);
		
		
		$this->id='content';
		$this->template='quanlykho/kehoachnam_setup.tpl';
		$this->layout="layout/center";
		$this->render();
	}
	
	public function loadKehoachSanPham()
	{
		$this->load->model("quanlykho/nhom");
		$this->data['nhomsanpham'] = array();
		$this->model_quanlykho_nhom->getTree("nhomsanpham",$this->data['nhomsanpham']);
		unset($this->data['nhomsanpham'][0]);
		
		$kehoachid = $this->request->get['id'];
		$where = "AND kehoachid = '".$kehoachid."'";
		$this->data['khsp'] = $this->model_quanlykho_kehoach->getKeKhoachSanPhams($where);
		$this->data['kehoach'] = $this->model_quanlykho_kehoach->getItem($kehoachid);
		
		$this->data['data_kehoachquy'] = $this->model_quanlykho_kehoach->getChild($kehoachid);
		
		
		if(count($this->data['khsp'])==0)
		{
			//Chua lam ke hoach
			$data = array();
			$this->load->model('quanlykho/sanpham');
			$rows = $this->model_quanlykho_sanpham->getList();
			foreach($rows as $item)
			{
				$data['kehoachid'] = $kehoachid;
				$data['sanphamid'] = $item['id'];
				$data['masanpham'] = $item['masanpham'];
				$data['manhom'] = $item['manhom'];
				$data['tensanpham'] = $item['tensanpham'];
				$data['soluongtonhientai'] = $item['soluongton'];
				$data['sosanphamtrenlot'] = $item['sosanphamtrenlot'];
				$data['dongia'] = $item['dongiabancai'];//Chi phi de sản xuat san pham
				$this->data['khsp'][] = $data;
			}
		}
		else
		{
			
		}
		//
		
		
		$this->id='content';
		$this->template='quanlykho/kehoachnam_sanpham.tpl';
		$this->render();
	}
	public function loadKehoachSanPhamDanhGia()
	{
		$makehoach = $this->request->get['id'];
		$where = "AND kehoachid = '".$makehoach."'";
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
			if($data['id']=="")
			{
				$data['id'] = $this->model_quanlykho_kehoach->insert($data);
				$this->saveKeHoachNam($data);
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

	private function saveKeHoachNam($data)
	{

		for($i=1;$i<=$this->setup['quy'];$i++)
		{
			$data['quy'] = $i;
			$data['thang'] = 0;
			$data['kehoachcha'] = $data['id'];
			$id = $this->model_quanlykho_kehoach->insert($data);
		}

	}

	public function savechitietkehoach()
	{
		$data = $this->request->post;
		if(count($data))
		{
			$this->model_quanlykho_kehoach->saveKeHoachSanPham($data);
			$this->data['output'] = "true";
		}
		/*foreach($data['soluong'] as $key => $val)
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
		}*/
		
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
		if($data['nam'] == "")
		{
			$this->error['nam'] = "Bạn chưa nhập năm";
		}
		else
		{
			if($data['id'] == "")
			{
				$where = " AND nam ='".$data['nam']."'" ;
				$item = $this->model_quanlykho_kehoach->getList($where);
				if(count($item)>0)
				$this->error['nam'] = "Kế hoạch năm " . $data ." đã có rồi";
			}
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