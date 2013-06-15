<?php
class ControllerQuanlykhoTieuchikiemtra extends Controller
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
		
		$this->load->model("quanlykho/tieuchikiemtra");
		$this->load->model("quanlykho/nguyenlieu");
		$this->load->model("quanlykho/linhkien");
		$this->load->model("quanlykho/taisan");
		$this->load->model("quanlykho/donvitinh");
		$this->data['donvitinh'] = $this->model_quanlykho_donvitinh->getList();
		$this->data['cbdonvitinh'] = "";
		foreach($this->data['donvitinh'] as $donvi)
		{
			$this->data['cbdonvitinh'].='<option value="'.$donvi['madonvi'].'">'.$donvi['tendonvitinh'].'</option>';
		}
		
   	}
	public function index()
	{
		
		$this->data['insert'] = $this->url->http('quanlykho/tieuchikiemtra/insert');
		$this->data['delete'] = $this->url->http('quanlykho/tieuchikiemtra/delete');
		
		$this->id='content';
		$this->template="quanlykho/tieuchikiemtra_list.tpl";
		$this->layout="layout/center";
		
		if($this->request->get['opendialog']=='true')
		{
			$this->layout="";
			$this->data['dialog'] = true;
			
		}
		$this->render();
	}
	
	public function insert()
	{
    	$this->getForm();
	}
	public function insertlist()
	{		
    	$this->id='content';
		$this->template='quanlykho/tieuchikiemtra_form_list.tpl';
		$this->layout="layout/center";
		$this->render();
	}
	
	public function update()
	{
		$this->data['haspass'] = false;
		$this->data['readonly'] = 'readonly="readonly"';
		$this->getForm();		
  	}

	public function delete() 
	{
		$listid=$this->request->post['delete'];
		//$listmadonvi=$_POST['delete'];
		
		if(count($listid))
		{
			foreach($listid as $id)
			{
				$item = $this->model_quanlykho_tieuchikiemtra->getItem($id);
				$where = " AND itemid = '".$item['itemid']."'";
				$data_tieuchi = $this->model_quanlykho_tieuchikiemtra->getList($where);
				foreach($data_tieuchi as $tieuchi)
					$this->model_quanlykho_tieuchikiemtra->delete($tieuchi['id']);
			}
			
			$this->data['output'] = "Xóa thành công";
		}
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
  	}
	
	public function getList() 
	{
		
		$this->data['bangbaogia'] = $this->url->http('quanlykho/tieuchikiemtra/bangbaogia');
		$this->data['insertlist'] = $this->url->http('quanlykho/tieuchikiemtra/insertlist');
		$this->data['insert'] = $this->url->http('quanlykho/tieuchikiemtra/insert');
		$this->data['delete'] = $this->url->http('quanlykho/tieuchikiemtra/delete');
		
		
		
		$this->data['datas'] = array();
		$where = "";
		
		$datasearchlike['itemcode'] = urldecode($this->request->get['itemcode']);
		$datasearchlike['itemname'] = urldecode($this->request->get['itemname']);
		$datasearch['itemtype'] = $this->request->get['itemtype'];
		
		$arr = array();
		foreach($datasearchlike as $key => $item)
		{
			if($item !="")
				$arr[] = " AND " . $key ." like '".$item."%'";
		}
		
		foreach($datasearch as $key => $item)
		{
			if($item !="")
				$arr[] = " AND " . $key ." = '".$item."'";
		}
		
		
		
		
		$where = implode("",$arr);
		//$where .= " AND loai IN ('".implode("','",$arrnhom)."')";
		
		$rows = $this->model_quanlykho_tieuchikiemtra->getList($where." Group by itemid");
		//Page
		$page = $this->request->get['page'];		
		$x=$page;		
		$limit = 20;
		$total = count($rows); 
		// work out the pager values 
		$this->data['pager']  = $this->pager->pageLayoutAjax($total, $limit, $page,"#listnguyenlieu");
		
		$pager  = $this->pager->getPagerData($total, $limit, $page); 
		$offset = $pager->offset; 
		$limit  = $pager->limit; 
		$page   = $pager->page;
		for($i=$offset;$i < $offset + $limit && count($rows[$i])>0;$i++)
		//for($i=0; $i <= count($this->data['datas'])-1 ; $i++)
		{
			$this->data['datas'][$i] = $rows[$i];
			$this->data['datas'][$i]['link_edit'] = $this->url->http('quanlykho/tieuchikiemtra/update&id='.$this->data['datas'][$i]['id']);
			$this->data['datas'][$i]['text_edit'] = "Sửa";
			
			
			//
			
			
		}
		$this->data['refres']=$_SERVER['QUERY_STRING'];
		$this->id='content';
		$this->template="quanlykho/tieuchikiemtra_table.tpl";
		
		if($this->request->get['opendialog']=='true')
		{
			$this->layout="";
			$this->data['dialog'] = true;
			
		}
		$this->render();
	}
	
	
	private function getForm()
	{
		$this->data['DIR_UPLOADPHOTO'] = HTTP_SERVER."index.php?route=common/uploadpreview";
		
		if ((isset($this->request->get['id'])) ) 
		{
      		$this->data['item'] = $this->model_quanlykho_tieuchikiemtra->getItem($this->request->get['id']);
			$this->data['item']['itemtypename'] = $this->document->dauvao[$this->data['item']['itemtype']];
			$where = " AND itemid = '".$this->data['item']['itemid']."'";
			$this->data['tieuchikt'] = $this->model_quanlykho_tieuchikiemtra->getList($where);
			
    	}
		
		$this->id='content';
		$this->template='quanlykho/tieuchikiemtra_form.tpl';
		$this->layout="layout/center";
		
		$this->render();
	}
	
	public function save()
	{
		$data = $this->request->post;
		
		if($this->validateForm($data))
		{
			$arr_id = $data['id'];
			$arr_tieuchikiemtra = $data['tieuchikiemtra'];
			$arr_madonvi = $data['madonvi'];
			if($data['deltieuchi'])
			{
				$arr_delid = split(",",$data['deltieuchi']);
				foreach($arr_delid as $id)
				{
					$this->model_quanlykho_tieuchikiemtra->delete($id);	
				}
			}
			if($arr_tieuchikiemtra)
			foreach($arr_tieuchikiemtra as $key => $tieuchikiemtra)
			{
				$data_tieuchi['id']	= $arr_id[$key];
				$data_tieuchi['itemtype'] = $data['itemtype'];
				$data_tieuchi['itemid']	=  $data['itemid'];
				$data_tieuchi['itemcode'] = $data['itemcode'];
				$data_tieuchi['itemname'] = $data['itemname'];
				$data_tieuchi['tieuchikiemtra']	= $arr_tieuchikiemtra[$key];
				$data_tieuchi['madonvi'] = $arr_madonvi[$key];
				if((int)$data_tieuchi['id']==0)
				{
					$this->model_quanlykho_tieuchikiemtra->insert($data_tieuchi);
				}
				else
				{
					$this->model_quanlykho_tieuchikiemtra->update($data_tieuchi);
				}
				
			}
			
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
		
		
    	if($data['itemid'] == "")
		{
      		$this->error['itemid'] = "Bạn chưa chọn hàng hóa";
    	}
		

		if (count($this->error)==0) {
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
	
//Json
	public function getTieuChiKiemTra()
	{
		$itemtype = $this->request->get['itemtype'];
		$itemid = $this->request->get['itemid'];
		$where = " AND itemtype = '".$itemtype."' AND itemid = '".$itemid."'";
		$rows = $this->model_quanlykho_tieuchikiemtra->getList($where);
		$this->data['output'] = json_encode($rows);
		
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
}
?>