<?php
class ControllerBmBMtn13 extends Controller
{
	private $error = array();
	function __construct() 
	{
		$this->data['cbChatLuong'] = '<option value=""></option>';
		foreach($this->document->chatluong as $key => $val)
		{
			$this->data['cbChatLuong'] .= '<option value="'.$key.'">'.$val.'</option>';
		}
		//echo $this->data['cbChatLuong'];
	}
	public function create()
	{
		$this->id='content';
		$this->template='bm/bmtn13_form.tpl';
		$this->render();
	}
}
?>