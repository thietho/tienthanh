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
		
		$this->load->model("quanlykho/kehoachnam");
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
		
		$this->getForm();
	}

	public function  danhgia()
	{
		$this->data['item'] = $this->model_quanlykho_kehoachnam->getItem($this->request->get['id']);

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
			$this->model_quanlykho_kehoachnam->deletedatas($listid);
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
		$where = "";
		$rows = $this->model_quanlykho_kehoachnam->getList($where);
		
		
		foreach($rows as $item)
		{
				
			
			$link_edit = $this->url->http('quanlykho/kehoachnam/update&nam='.$item['nam']);
			$text_edit = "Edit";
			
			
			
			
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
		if ((isset($this->request->get['nam'])) )
		{
			$this->data['item'] = $this->model_quanlykho_kehoachnam->getItem($this->request->get['nam']);
				
		}
		else
		{
			$this->data['item']['nam'] = $this->date->now['year'];
		}
		$this->id='content';
		$this->template='quanlykho/kehoachnam_form.tpl';
		$this->layout="layout/center";

		$this->render();
	}
	
	public function loadKehoachSanPham()
	{
		$this->load->model("quanlykho/nhom");
		$this->data['nhomsanpham'] = array();
		$this->model_quanlykho_nhom->getTree("nhomsanpham",$this->data['nhomsanpham']);
		unset($this->data['nhomsanpham'][0]);
		
		$nam = $this->request->get['nam'];
		$where = "AND nam = '".$nam."'";
		$this->data['khsp'] = $this->model_quanlykho_kehoachnam->getHeHoachNamSanPhams($where);
		$this->data['kehoach'] = $this->model_quanlykho_kehoachnam->getItem($nam);
		
		if(count($this->data['khsp'])==0)
		{
			//Chua lam ke hoach
			$data = array();
			$this->load->model('quanlykho/sanpham');
			$rows = $this->model_quanlykho_sanpham->getList();
			foreach($rows as $item)
			{
				$data['nam'] = $nam;
				$data['sanphamid'] = $item['id'];
				$data['masanpham'] = $item['masanpham'];
				$data['tensanpham'] = $item['tensanpham'];
				$data['manhom'] = $item['manhom'];
				$data['giacodinh'] = $item['giacodinh'];
				$data['sosanphamtrenlot'] = $item['sosanphamtrenlot'];
				$data['qui1'] = 0;
				$data['qui2'] = 0;
				$data['qui3'] = 0;
				$data['qui4'] = 0;
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
		$where = "AND nam = '".$makehoach."'";
		$this->data['khsp'] = $this->model_quanlykho_kehoachnam->getHeHoachNamSanPhams($where);
		
		$this->id='content';
		$this->template='quanlykho/kehoach_sanpham_danhgia.tpl';
		$this->render();
	}
	public function save()
	{
		$data = $this->request->post;
		if($this->validateForm($data))
		{
			$item = $this->model_quanlykho_kehoachnam->getItem($data['nam']);
			
			if(count($item)==0)
			{
				$this->model_quanlykho_kehoachnam->insert($data);
			}
			else
			{
				$this->model_quanlykho_kehoachnam->update($data);
			}
			$this->data['output'] = "true-".$data['nam'];
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
		$this->data['output'] = "false";
		if((int)$data['sanphamid']!=0)
		{
			$this->model_quanlykho_kehoachnam->saveKeHoachNamSanPham($data);
			$this->data['output'] = "true";
		}
		
		
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

			
		$datas = $this->model_quanlykho_kehoachnam->getList($where);
		$this->data['output'] = json_encode(array('taisans' => $datas));
		$this->id="taisan";
		$this->template="common/output.tpl";
		$this->render();
	}

}
?>