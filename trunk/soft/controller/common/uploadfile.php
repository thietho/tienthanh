<?php
class ControllerCommonUploadfile extends Controller
{
	function index()
	{	
		
		$folder = urldecode($this->request->get['folder']);
		if($folder == "")
			$filepath = DIR_FILE."upload/";
		else
			$filepath = DIR_FILE."upload/".$folder."/";
		foreach($_FILES['files']['name'] as $key => $item)
		{
			if($_FILES['files']['name'][$key] != "")
			{
				$ftemp['name'] = $_FILES['files']['name'][$key];
				$ftemp['type'] = $_FILES['files']['type'][$key];
				$ftemp['tmp_name'] = $_FILES['files']['tmp_name'][$key];
				$ftemp['error'] = $_FILES['files']['error'][$key];
				$ftemp['size'] = $_FILES['files']['size'][$key];
				
				
				move_uploaded_file($ftemp['tmp_name'],$filepath.$ftemp['name']);
				
			}

		}
		$this->data['output'] = json_encode(array('files' => $_FILES['files']['name']));
		$this->id="uploadpreview";
		$this->template="common/output.tpl";
		$this->render();
	}
	
}
?>