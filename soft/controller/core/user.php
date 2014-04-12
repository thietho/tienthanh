<?php
class ControllerCoreUser extends Controller
{
	private $error = array();
	
	public function index()
	{
		if(!$this->user->hasPermission($this->getRoute(), "access"))
		{
			$this->response->redirect("?route=common/permission");
		}
		$this->data['permissionAdd'] = true;
		$this->data['permissionEdit'] = true;
		$this->data['permissionDelete'] = true;
		if(!$this->user->hasPermission($this->getRoute(), "add"))
		{
			$this->data['permissionAdd'] = false;
		}
		if(!$this->user->hasPermission($this->getRoute(), "edit"))
		{
			$this->data['permissionEdit'] = false;
		}
		if(!$this->user->hasPermission($this->getRoute(), "delete"))
		{
			$this->data['permissionDelete'] = false;
		}
		//$this->load->language('core/user');
		//$this->data = array_merge($this->data, $this->language->getData());
		
		$this->document->title = $this->language->get('heading_title');
		
		$this->load->model("core/user");
		$this->getList();
	}
	
	public function insert()
	{
		if(!$this->user->hasPermission($this->getRoute(), "add"))
		{
			$this->response->redirect("?route=common/permission");
		}
		//$this->load->language('core/user');
		//$this->data = array_merge($this->data, $this->language->getData());
		
		$this->document->title = $this->language->get('heading_title');
		$this->load->model("core/user");
		$this->data['haspass'] = true;
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validateForm())) 
		{
			$this->request->post['birthday'] = $this->date->formatViewDate($this->request->post['birthday']);
			$this->model_core_user->insertuser($this->request->post);
			$this->session->data['success'] = $this->language->get('text_success');
			$this->redirect($this->url->http('core/user'));
		}
    
    	$this->getForm();
	}
	
	public function update()
	{
		if(!$this->user->hasPermission($this->getRoute(), "edit"))
		{
			$this->response->redirect("?route=common/permission");
		}
		else
		{
			//$this->load->language('core/user');
			//$this->data = array_merge($this->data, $this->language->getData());
			
			$this->document->title = $this->language->get('heading_title');
			$this->load->model("core/user");
			$this->data['haspass'] = false;
			$this->data['usernamereadonly'] = 'readonly="readonly"';
			if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validateForm())) 
			{
				$this->request->post['userid'] = $this->request->get['userid'];
				$this->request->post['birthday'] = $this->date->formatViewDate($this->request->post['birthday']);
				$this->model_core_user->updateuser($this->request->post);
				$this->session->data['success'] = $this->language->get('text_success');
				$this->redirect($this->url->http('core/user'));
			}
		
			$this->getForm();
		}
		
  	}
	
	public function active()
	{
		$userid = $this->request->get['userid'];
		$this->load->model("core/user");
		
		$data['userid'] = $userid;
		$user=$this->model_core_user->getItem($userid);
		if($user['status'] == "lock")
			$data['status'] = "active";
		else
			$data['status'] = "lock";
		$this->model_core_user->updatestatus($data);
		if($data['status'] == "active")
			$this->data['output']= $this->data['announ_active'];
		if($data['status'] == "lock")
			$this->data['output']= $this->data['announ_lock'];
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
	}
	
	public function delete() 
	{
		$listuserid=$this->request->post['delete'];
		//$listuserid=$_POST['delete'];
		$this->load->model("core/user");
		if(count($listuserid))
		{
			$this->model_core_user->deleteusers($listuserid);
			$this->data['output'] = $this->data['announ_del'];
		}
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
  	}
	
	private function getList() 
	{
		$this->data['insert'] = $this->url->http('core/user/insert');
		$this->data['delete'] = $this->url->http('core/user/delete');		
		
		$this->data['users'] = array();
		$where = "AND usertypeid <> 'member'";
		$rows = $this->model_core_user->getList($where);
		//Page
		$page = $this->request->get['page'];		
		$x=$page;		
		$limit = 20;
		$total = count($rows); 
		// work out the pager values 
		$this->data['pager']  = $this->pager->pageLayout($total, $limit, $page); 
		
		$pager  = $this->pager->getPagerData($total, $limit, $page); 
		$offset = $pager->offset; 
		$limit  = $pager->limit; 
		$page   = $pager->page;
		for($i=$offset;$i < $offset + $limit && count($rows[$i])>0;$i++)
		//for($i=0; $i <= count($this->data['users'])-1 ; $i++)
		{
			$this->data['users'][$i] = $rows[$i];
			$this->data['users'][$i]['link_edit'] = $this->url->http('core/user/update&userid='.$this->data['users'][$i]['userid']);
			$this->data['users'][$i]['text_edit'] = $this->data['button_edit'];
			$this->data['users'][$i]['link_active'] = $this->url->http('core/user/active&userid='.$this->data['users'][$i]['userid']);
			if($this->data['users'][$i]['status']=='lock')
				$this->data['users'][$i]['text_active'] = $this->data['button_active'];
			else
				$this->data['users'][$i]['text_active'] = $this->data['button_lock'];
				
			if($this->data['users'][$i]['status']=='active')
				$this->data['users'][$i]['text_st'] = $this->data['button_active'];
			else
				$this->data['users'][$i]['text_st'] = $this->data['button_lock'];
		}
		$this->data['refres']=$_SERVER['QUERY_STRING'];
		$this->id='content';
		$this->template="core/user_list.tpl";
		$this->layout="layout/center";
		
		$this->render();
	}
	
	
	private function getForm()
	{
		$this->data['error'] = @$this->error;
		$this->load->model("core/usertype");
		$this->load->model("core/country");
		$this->load->helper('image');
		//$xml = simplexml_load_file(DIR_COMPONENT.'xml/countries.xml');
		//$this->data['countries'] = $this->string->xmltoArray($xml);
		$this->data['countries'] = $this->model_core_country->getCountrys();
		
		$this->data['usertype'] = $this->model_core_usertype->getAllUsertype();
		
		if (!isset($this->request->get['userid'])) {
			$this->data['action'] = $this->url->http('core/user/insert');
		} else {
			$this->data['action'] = $this->url->http('core/user/update&userid=' . $this->request->get['userid']);
		}
		$this->data['DIR_UPLOADPHOTO'] = HTTP_SERVER."index.php?route=common/uploadpreview";
		$this->data['cancel'] = $this->url->https('core/user');
		
		if ((isset($this->request->get['userid'])) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
      		$this->data['user'] = $this->model_core_user->getItem($this->request->get['userid']);
			$this->data['user']['imagethumbnail']=HelperImage::resizePNG($this->data['user']['imagepath'], 200, 200);
    	}
		else
		{
			$this->data['user'] = $this->request->post;
			$this->data['selectcountry'] = $this->data['user']['country'];
			
		}
		
		if(!$this->data['selectcountry'])
		{
			$this->data['selectcountry'] = "VN";	
		}
		
		$this->id='content';
		$this->template='core/user_form.tpl';
		$this->layout="layout/center";
		
		$this->render();
	}
	
	private function validateForm()
	{
    	if ((strlen($this->request->post['username']) == 0) || (strlen($this->request->post['username']) > 30)) 
		{
      		$this->error['username'] = $this->data['war_username'];
    	}
		else
		{
			
			if($this->validation->_isId(trim($this->request->post['username'])) == false)
				$this->error['username'] = $this->data['war_invalid_username'];
			else
			{
				$user = $this->model_core_user->getItemByUserName($this->request->post['username']);
				if(count($user)>0 && $this->request->post['userid'] == '')
					$this->error['username'] = $this->data['war_existed_username'];			
			}
		}
		if($this->request->get['userid']=="")
		{
			if (strlen($this->request->post['password']) == 0) 
			{
				$this->error['password'] = $this->data['war_password'];
			}
			
			if ($this->request->post['confrimpassword'] != $this->request->post['password']) 
			{
				$this->error['confrimpassword'] = $this->data['war_confirmpass'];
			}		
		}
		
		if ($this->validation->_checkEmail($this->request->post['email']) == false ) 
		{
      		$this->error['email'] = $this->data['war_invalid_email'];
    	}

		if (!$this->error) {
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
}
?>