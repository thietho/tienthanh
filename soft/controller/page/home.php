<?php
class ControllerPageHome extends Controller
{
	public function index()
	{
		$this->load->model("core/module");
		$this->user->getUserTypeId();
		//Lay cac module thuot usertype do
		$where = " AND permission like '%[".$this->user->getUserTypeId()."]%'";
		$allow_modules = $this->model_core_module->getList($where);
		$this->data['allow_modules'] = $this->string->matrixToArray($allow_modules,'id');
		
		$this->data['group'] = $this->model_core_module->getChild(0);
		
		foreach($this->data['group'] as $key => $item)
		{
			$this->data['group'][$key]['module'] = $this->model_core_module->getChild($item['id']);
		}
		
		$this->id="content";
		$this->template="page/home.tpl";
		$this->layout="layout/center";
		//$this->response->redirect('?route=core/message');
		$this->render();
	}
}
?>