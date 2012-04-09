<?php
class ControllerLayoutPrint extends Controller
{
	public function index()
	{
		$this->template="layout/print.tpl";
		$this->children=array(
				'common/header',
				'common/footer'
				
				);	
		$this->render();
	}
}
?>