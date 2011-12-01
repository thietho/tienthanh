<?php
class ControllerPageHome extends Controller
{
	public function index()
	{
		$this->id="content";
		$this->template="page/home.tpl";

		if($this->request->get['ajax'] != "true")
		$this->layout="layout/home";
		$template = array(
					  'template' => "sample/defaultlist.tpl",
					  'width' => 0,
					  'height' =>0
		);

		$arr = array("site1",5,"",$template);

		$this->data['sample_defaultlist'] = $this->loadModule('module/block','getList',$arr);
		$this->render();
	}
}
?>