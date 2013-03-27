<?php
class ControllerQuanlykhoNhom extends Controller
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

		$this->load->model("quanlykho/nhom");
		$this->getList();
	}

	public function insert()
	{
		$this->getForm();
	}

	public function update()
	{
		$this->load->model("quanlykho/nhom");
		$this->data['haspass'] = false;
		$this->data['readonly'] = 'readonly="readonly"';
		$this->getForm();
	}


	public function delete()
	{
		$listmanhom=$this->request->post['delete'];
		//$listmanhom=$_POST['delete'];
		$this->load->model("quanlykho/nhom");
		if(count($listmanhom))
		{
			$this->model_quanlykho_nhom->deletedatas($listmanhom);
			$this->data['output'] = "Xóa thành công";
		}
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
	}

	public function updatethutu()
	{
		$listthutu=$this->request->post['thutu'];
		//$listmanhom=$_POST['delete'];
		$this->load->model("quanlykho/nhom");
		if(count($listthutu))
		{
			foreach($listthutu as $key => $item)
			{
				$data['manhom'] = $key;
				$data['thutu'] = $item;
				$this->model_quanlykho_nhom->updatethutu($data);
			}
				
			$this->data['output'] = "Cập nhật thành công";
		}
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();

	}

	private function getList()
	{
		$this->data['insert'] = $this->url->http('quanlykho/nhom/insert');
		$this->data['delete'] = $this->url->http('quanlykho/nhom/delete');

		$this->data['datas'] = array();
		$rows = $this->model_quanlykho_nhom->getDanhMucPhanLoai();
		unset($rows[0]);
		$this->data['nhoms'] = array();

		$eid="ex0-node";
		$eclass="child-of-ex0-node";
		foreach($rows as $item)
		{
				
			$deep = $item['level'];
			$link_edit = $this->url->http('quanlykho/nhom/update&manhom='.$item['manhom']);
			$text_edit = "Edit";
				
			$link_addchild = $this->url->http('quanlykho/nhom/update&nhomcha='.$item['manhom']);
			$text_addchild = "Add child";
				
			$tab="";
			if(count($item['countchild'])==0)
			$tab="<span class='tab'></span>";

			$class="";
			if($item['parentpath']!="")
			$class=$eclass.$item['parentpath'];

			$this->data["nhoms"][]=array(
										'manhom'=>$item['manhom'],
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
										'link_addchild' => $link_addchild,
										'text_addchild' => $text_addchild
			);
				
				
		}

		$this->data['refres']=$_SERVER['QUERY_STRING'];
		$this->id='content';
		$this->template="quanlykho/nhom_list.tpl";
		$this->layout="layout/center";

		$this->render();
	}


	private function getForm()
	{
		$this->data['error'] = @$this->error;
		$this->load->model("quanlykho/nhom");

		$this->data['datas'] = array();
		$this->data['datas'] = $this->model_quanlykho_nhom->getDanhMucPhanLoai();

		if ((isset($this->request->get['manhom'])) )
		{
			$this->data['item'] = $this->model_quanlykho_nhom->getItem($this->request->get['manhom']);
		}

		$this->id='content';
		$this->template='quanlykho/nhom_form.tpl';
		$this->layout="layout/center";

		$this->render();
	}

	public function save()
	{
		$data = $this->request->post;
		if($this->validateForm($data))
		{
			$this->load->model("quanlykho/nhom");
			$this->model_quanlykho_nhom->saveNhom($data);
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
		if($data['curmanhom'] == "")
		{
			$this->load->model("quanlykho/nhom");
			$item = $this->model_quanlykho_nhom->getItem($data['manhom']);
			if(count($item)>0)
			$this->error['manhom'] = "Mã nhóm đã được sử dụng";
		}

		if ((strlen($data['tennhom']) == 0))
		{
			$this->error['tennhom'] = "Bạn chưa nhập tên nhóm";
		}

		if (count($this->error)==0) {
			return TRUE;
		} else {
			return FALSE;
		}
	}
	//Cac ham xu ly tren form

}
?>