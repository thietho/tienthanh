<?php
class ControllerQuytrinhKtdauvao extends Controller
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
		
		$this->load->model("quanlykho/nguyenlieu");
		$this->load->model("quanlykho/linhkien");
		$this->load->model("quanlykho/taisan");
		$this->load->helper('image');
		$this->load->model("quanlykho/nhom");
		$this->load->model("quanlykho/kho");
		$this->load->model("quanlykho/donvitinh");
		
		$this->data['loainguyenlieu'] = array();
		$this->model_quanlykho_nhom->getTree("NL",$this->data['loainguyenlieu']);
		//unset($this->data['loainguyenlieu'][0]);
		
		$this->data['donvitinh'] = $this->model_quanlykho_donvitinh->getList();
		
   	}
	public function index()
	{
		
		
		$this->id='content';
		$this->template="quytrinh/ktdauvao.tpl";
		$this->layout="layout/center";
		
		if($this->request->get['opendialog']=='true')
		{
			$this->layout="";
			$this->data['dialog'] = true;
			
		}
		$this->render();
	}
	
	public function lapBMTN13()
	{
		$this->id='content';
		$this->template='quanlykho/nguyenlieu_dinhluong.tpl';
		$this->render();
	}
}
?>