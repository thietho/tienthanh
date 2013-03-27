<?php
class ControllerQuanlykhoChiphi extends Controller
{
	private $error = array();
	 
	public function index()
	{
		$this->load->model("core/module");
		$moduleid = $_GET['route'];
		$this->document->title = $this->model_core_module->getBreadcrumbs($moduleid);
		if($this->user->checkPermission($moduleid)==false)
		{
			$this->response->redirect('?route=page/home');
		}
		$this->load->model("quanlykho/chiphi");
		$this->getList();
	}

	public function insert()
	{
		$this->getForm();
	}

	public function update()
	{				
		$this->load->model("quanlykho/chiphi");
		$this->data['haspass'] = false;
		$this->data['readonly'] = 'readonly="readonly"';
		$this->getForm();
	}


	public function delete()
	{
		$listmachiphi=$this->request->post['delete'];
		//$listmachiphi=$_POST['delete'];
		$this->load->model("quanlykho/chiphi");
		if(count($listmachiphi))
		{
			$this->model_quanlykho_nhom->deletedatas($listmachiphi);
			$this->data['output'] = "Xóa thành công";
		}
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
	}

	private function getList()
	{
		$this->data['insert'] = $this->url->http('quanlykho/chiphi/insert');
		$this->data['delete'] = $this->url->http('quanlykho/chiphi/delete');

		$this->data['datas'] = array();
		$rows = $this->model_quanlykho_chiphi->getChiphis();

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
		//for($i=0; $i <= count($this->data['datas'])-1 ; $i++)
		{
			$this->data['datas'][$i] = $rows[$i];
			$this->data['datas'][$i]['link_edit'] = $this->url->http('quanlykho/chiphi/update&machiphi='.$this->data['datas'][$i]['machiphi']);
			$this->data['datas'][$i]['text_edit'] = "Sửa";
			$this->data['datas'][$i]['link_active'] = $this->url->http('quanlykho/chiphi/active&machiphi='.$this->data['datas'][$i]['machiphi']);
				
		}
		$this->data['refres']=$_SERVER['QUERY_STRING'];
		$this->id='content';
		$this->template="quanlykho/chiphi_list.tpl";
		$this->layout="layout/center";
		if($this->request->get['opendialog']=='true')
		{
			$this->layout="layout/dialog";
			$this->data['dialog'] = true;
				
		}
		$this->render();
	}


	private function getForm()
	{
		$this->data['error'] = @$this->error;
		$this->load->model("quanlykho/chiphi");



		if ((isset($this->request->get['machiphi'])) )
		{
			$this->data['item'] = $this->model_quanlykho_chiphi->getChiphi($this->request->get['machiphi']);
				
		}

		$this->id='content';
		$this->template='quanlykho/chiphi_form.tpl';
		$this->layout="layout/center";

		$this->render();
	}

	public function save()
	{
		$data = $this->request->post;
		if($this->validateForm($data))
		{
			$this->load->model("quanlykho/chiphi");
			$this->model_quanlykho_chiphi->saveChiphi($data);
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
		if ($data['machiphi'] == "")
		{
			$this->error['machiphi'] = "Bạn chưa nhập mã chi phí";
		}
		else
		{
			if($data['id']=="")
			{
				$this->load->model("quanlykho/chiphi");
				$item = $this->model_quanlykho_chiphi->getChiphi($data['machiphi']);

				if(count($item))
				{
					$this->error['machiphi'] = "Mã chi phí đã được sử dụng";
				}
			}
		}

		if ((strlen($data['tenchiphi']) == 0))
		{
			$this->error['tenchiphi'] = "Bạn chưa nhập tên chi phí";
		}

		if (count($this->error)==0) {
			return TRUE;
		} else {
			return FALSE;
		}
	}
	//Cac ham xu ly tren form
	public function getChiPhi()
	{
		$machiphi = $this->request->get['machiphi'];
		$this->load->model("quanlykho/chiphi");
			
			
		$datas = $this->model_quanlykho_chiphi->getChiphi($machiphi);
		$this->data['output'] = json_encode(array('chiphi' => $datas));
		$this->id="linhkien";
		$this->template="common/output.tpl";
		$this->render();
	}

}
?>