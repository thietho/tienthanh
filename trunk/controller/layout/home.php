<?php
class ControllerLayoutHome extends Controller
{
	public function index()
	{
		$this->template="layout/home.tpl";
		$this->children=array(
				'common/header',
				'common/footer'
				);
				$this->render();
	}
}
?>