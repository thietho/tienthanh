<?php
class ControllerQuanlykhoKho extends Controller
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
		$this->data['modules'] = array(
									'quanlykho/nguyenlieu',
									'quanlykho/vattu',
									'quanlykho/linhkien',
									'quanlykho/sanpham',
									'quanlykho/taisan'
										);
		
	}
	public function index()
	{
		
		

		$this->load->model("quanlykho/kho");
		$this->getList();
	}

	public function insert()
	{
		$this->getForm();
	}

	public function update()
	{				
		$this->load->model("quanlykho/kho");
		$this->data['haspass'] = false;
		$this->data['readonly'] = 'readonly="readonly"';
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validateForm()))
		{
			$this->request->post['makho'] = $this->request->get['makho'];
			$this->request->post['birthday'] = $this->date->formatViewDate($this->request->post['birthday']);
			$this->model_quanlykho_kho->updateitem($this->request->post);
			$this->session->data['success'] = $this->language->get('text_success');
			$this->redirect($this->url->http('quanlykho/kho'));
		}

		$this->getForm();
		
	}


	public function delete()
	{
		$listmakho=$this->request->post['delete'];
		//$listmakho=$_POST['delete'];
		$this->load->model("quanlykho/kho");
		if(count($listmakho))
		{
			$this->model_quanlykho_nhom->deletedatas($listmakho);
			$this->data['output'] = "Xóa thành công";
		}
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
	}

	private function getList()
	{
		$this->data['insert'] = $this->url->http('quanlykho/kho/insert');
		$this->data['delete'] = $this->url->http('quanlykho/kho/delete');

		$this->data['datas'] = array();
		$this->data['datas'] = $this->model_quanlykho_kho->getKhos();

		
		for($i=0; $i <= count($this->data['datas'])-1 ; $i++)
		{
			//$this->data['datas'][$i] = $rows[$i];
			$arr = $this->string->referSiteMapToArray($this->data['datas'][$i]['modules']);
			$arrname = array();
			foreach($arr as $moduleid)
			{
				$arrname[] = $this->document->getModuleId($moduleid);
			}
			$this->data['datas'][$i]['modules'] = implode(", ",$arrname);
			$this->data['datas'][$i]['link_edit'] = $this->url->http('quanlykho/kho/update&makho='.$this->data['datas'][$i]['makho']);
			$this->data['datas'][$i]['text_edit'] = "Sửa";
			$this->data['datas'][$i]['link_active'] = $this->url->http('quanlykho/kho/active&makho='.$this->data['datas'][$i]['makho']);
				
		}
		$this->data['refres']=$_SERVER['QUERY_STRING'];
		$this->id='content';
		$this->template="quanlykho/kho_list.tpl";
		$this->layout="layout/center";

		if($this->request->get['opendialog']=='true')
		{
			$this->layout="layout/dialog";
			$this->data['dialog'] = true;
			//$this->data['list'] = $this->url->http('quanlykho/nhacungung&opendialog=true');
		}

		$this->render();
	}


	private function getForm()
	{
		$this->data['error'] = @$this->error;
		$this->load->model("quanlykho/kho");



		if ((isset($this->request->get['makho'])) )
		{
			$this->data['item'] = $this->model_quanlykho_kho->getKho($this->request->get['makho']);
			$this->data['item']['modules'] =  $this->string->referSiteMapToArray($this->data['item']['modules']);
		}

		$this->id='content';
		$this->template='quanlykho/kho_form.tpl';
		$this->layout="layout/center";

		$this->render();
	}

	public function save()
	{
		$data = $this->request->post;
		$data['modules'] = $this->string->arrayToString($data['modules']);
		
		if($this->validateForm($data))
		{
			$this->load->model("quanlykho/kho");
			$this->model_quanlykho_kho->saveKho($data);
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
		if ($data['makho'] == "")
		{
			$this->error['makho'] = "Bạn chưa nhập mã kho";
		}
		else
		{
			if($data['id']=="")
			{
				$this->load->model("quanlykho/kho");
				$item = $this->model_quanlykho_kho->getKho($data['makho']);
				if(count($item))
				{
					$this->error['makho'] = "Mã kho đã được sử dụng";
				}
			}
		}

		if ((strlen($data['tenkho']) == 0))
		{
			$this->error['tenkho'] = "Bạn chưa nhập tên kho";
		}

		if (count($this->error)==0) {
			return TRUE;
		} else {
			return FALSE;
		}
	}

	public function viewTonKho()
	{
		$this->load->model("quanlykho/kho");
		$this->load->model("quanlykho/nguyenlieu");
		$this->load->model("quanlykho/phieunhapxuat");
		$makho = $this->request->get['id'];
		$where = "";
		if($makho!="")
		{
			$this->data['datas'][0] = $this->model_quanlykho_kho->getKho($makho);
		}
		else
		{
			$this->data['datas'] = $this->model_quanlykho_kho->getKhos($where);
		}

		foreach($this->data['datas'] as $key => $val)
		{
			$where = " AND maphieu in (SELECT id
										FROM `qlkphieunhapxuat`
										WHERE makho = '".$val['makho']."'
									)";
			$where .= " AND phieuxuat = 0 AND trangthai = 'completed'";
			$this->data['datas'][$key]['chitiets'] = $this->model_quanlykho_phieunhapxuat->getChiTietPhieuXuatNhap($where);
		}

		$this->id='content';
		$this->template="quanlykho/kho_tonkho.tpl";
		$this->layout="layout/dialog";
		$this->data['dialog'] = true;
		$this->render();
	}
	//Cac ham xu ly tren form
	public function getKho()
	{
		$col = $this->request->get['col'];
		$val = $this->request->get['val'];


		/*
		 $operator = $this->request->get['operator'];
		 if($operator == "")
			$operator = "equal";
			$this->load->model("quanlykho/kho");
			$where = "";
			switch($operator)
			{
			case "equal":
			$where = " AND ".$col." = '".$val."'";
			break;
			case "like":
			$where = " AND ".$col." = '%".$val."%'";
			break;
			case "other":
			$where = " AND ".$col." <> '".$val."'";
			break;
			case "in":
			$where = " AND ".$col." in  (".$val.")";
			break;
				
			}
			*/

		$this->load->model("quanlykho/kho");
		$datas =  array();
		$datas[0] = $this->model_quanlykho_kho->getKho($val);

		$this->data['output'] = json_encode(array('khos' => $datas));

		$this->id="kho";
		$this->template="common/output.tpl";
		$this->render();
	}


}
?>