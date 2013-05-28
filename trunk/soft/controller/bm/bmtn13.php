<?php
class ControllerBmBMtn13 extends Controller
{
	private $error = array();
	
	
	public function create()
	{
		$this->id='content';
		$this->template='bm/bmtn13_form.tpl';
		$this->render();
	}
}
?>