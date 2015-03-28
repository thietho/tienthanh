<?php
class ControllerCommonLogin extends Controller
{
	public $validSecure;
	private $error = array();
	function index()
	{
		$this->load->language('common/login');
		
		
		
		$this->data = array_merge($this->data, $this->language->getData());
		
		$img = new Securimage();
		$this->validSecure = $img->check($this->request->post['code']);
		
		if ($this->user->isLogged()) {
			$this->redirect($this->url->https('page/home'));
		}

		if (($this->request->post) && ($this->validate())) {
	  		$this->redirect($this->url->https('page/home'));
			return;
		}
		
		$this->load->model('core/site');
		$this->data['sites'] = $this->model_core_site->getList();
		
		$this->data['error'] = @$this->error;
		$this->data['username'] = $this->request->post['username'];
		$this->data['security'] = DIR_COMPONENT."securimage/securimage_show.php?sid=".md5(uniqid(time()));
		$this->id='content';
		$this->template='common/login.tpl';
		$this->layout='layout/login';
		$this->render();
	}
	
	private function validate() {
		//Kiem tra secure image
		if($this->validSecure == false)
		{
			$this->error['error_warning'] = $this->language->get('error_warning');
		}
		
		//Kiem tra dang nhap
		if($this->request->post['username']=="")
			$this->error['error_warning'] = $this->language->get('error_warning');
		else
			if (!$this->login(@$this->request->post['username'], @$this->request->post['password'])) {
				$this->error['error_warning'] = $this->language->get('error_warning');
			}
		
		if (!$this->error) {
			return TRUE;
		} else {
			return FALSE;
		}
	}	
	
	public function login($username,$pwd)
	{
		$this->load->model("core/user");
		$this->load->model("quanlykho/nhanvien");
		$user = $this->model_core_user->getItemByUserName($username);
		if(md5($pwd) == $user['password'])
		{
			//Login thanh cong
			$nhanvien = $this->model_quanlykho_nhanvien->getItemByUsername($username);
			$this->session->set('usertypeid',$user['usertypeid']);
			$this->session->set('userid',$user['userid']);
			$this->session->set('username',$user['username']);	
			$this->session->set('siteid',SITEID);
			//Thong tin nhan vien
			$this->session->set('nhanvien',$nhanvien);
			return true;
			
		}
		else
			return false;
	}
	public function checkLogin() {
		if (!$this->user->isLogged()) {
			$route = $this->getRoute();
			$part = explode('/', $route);
			$ignore = array(
				'common/forgotpassword'
			);
			
			if (!in_array(@$part[0] . '/' . @$part[1], $ignore)) {
				return $this->forward('common/login', 'index');
			}
			
		}
	}
	
	
}


?>