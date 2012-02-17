<?php
class ControllerQuanlykhoNhanVien extends Controller
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
		//$this->load->language('quanlykho/nhacungung');
		//$this->data = array_merge($this->data, $this->language->getData());
		
		$this->document->title = $this->language->get('heading_title');
		
		$this->load->model("quanlykho/nhanvien");
		$this->getList();
	}
	
	public function insert()
	{
		if(!$this->user->hasPermission($this->getRoute(), "add"))
		{
			$this->response->redirect("?route=common/permission");
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
			//$this->load->language('quanlykho/nhanvien');
			//$this->data = array_merge($this->data, $this->language->getData());
			
			$this->load->model("quanlykho/nhanvien");
			$this->data['haspass'] = false;
			$this->data['readonly'] = 'readonly="readonly"';
			
			$this->getForm();
		}
		
  	}
	
	public function delete() 
	{
		$listid=$this->request->post['delete'];
		//$listmadonvi=$_POST['delete'];
		$this->load->model("quanlykho/nhanvien");
		if(count($listid))
		{
			$this->model_quanlykho_nhanvien->deletedatas($listid);
			$this->data['output'] = "Xóa thành công";
		}
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
  	}
	
	private function getList() 
	{
		$this->load->model("quanlykho/phongban");
		$this->load->model("core/user");
		
		$this->data['phongban'] = array();
		$this->data['phongban']=$this->model_quanlykho_phongban->getTreePhongBan($this->model_quanlykho_phongban->root);
		unset($this->data['phongban'][0]);
		
		$this->data['chucvu'] = $this->document->chucvu;
		
		$this->data['insert'] = $this->url->http('quanlykho/nhanvien/insert');
		$this->data['delete'] = $this->url->http('quanlykho/nhanvien/delete');		
		
		$this->data['datas'] = array();
		$where = "";
		
		$datasearchlike['manhanvien'] = $this->request->get['manhanvien'];
		$datasearchlike['hoten'] = $this->request->get['hoten'];
		$datasearch['chucvu'] = $this->request->get['machucvu'];
		$datasearch['maphongban'] = $this->request->get['maphongban'];
		
		$arr = array();
		foreach($datasearchlike as $key => $item)
		{
			if($item !="")
				$arr[] = " AND " . $key ." like '%".$item."%'";
		}
		
		foreach($datasearch as $key => $item)
		{
			if($item !="")
				$arr[] = " AND " . $key ." = '".$item."'";
		}
		
		$where = implode("",$arr);
		
		$rows = $this->model_quanlykho_nhanvien->getList($where);
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
		{
			$this->data['datas'][$i] = $rows[$i];
			
			$phongban = $this->model_quanlykho_phongban->getPhongBan($rows[$i]['maphongban']);
			$this->data['datas'][$i]['tenphongban'] = $phongban['tenphongban'];
			
			
			
			$this->data['datas'][$i]['link_edit'] = $this->url->http('quanlykho/nhanvien/update&id='.$this->data['datas'][$i]['id']);
			$this->data['datas'][$i]['text_edit'] = "Sửa";
			
			
			
			$user = $this->model_core_user->getItem($this->data['datas'][$i]['username']);
			if($this->data['datas'][$i]['username'] == "")
			{
				$this->data['datas'][$i]['link_taikhoan'] = $this->url->http("quanlykho/nhanvien/taotaikhoan&id=".$this->data['datas'][$i]['id']);
				$this->data['datas'][$i]['text_taikhoan'] = "Tạo tài khoản";
			}
			else
			{
				
				$this->data['datas'][$i]['link_phanquyen'] = $this->url->http('quanlykho/nhanvien/phanquyen&id='.$this->data['datas'][$i]['id']);
				$this->data['datas'][$i]['text_phanquyen'] = "Phân quyền";
			
				if($user['status'] == "lock")	
				{
					$this->data['datas'][$i]['link_taikhoan'] = $this->url->http("quanlykho/nhanvien/motaikhoan&username=".$this->data['datas'][$i]['username']);
					$this->data['datas'][$i]['text_taikhoan'] = "Mở tài khoản";
				}
				
				if($user['status'] == "active")	
				{
					$this->data['datas'][$i]['link_taikhoan'] = $this->url->http("quanlykho/nhanvien/khoataikhoan&username=".$this->data['datas'][$i]['username']);
				$this->data['datas'][$i]['text_taikhoan'] = "Khóa tài khoản";
				}
				
				
			}
			
		}
		$this->data['refres']=$_SERVER['QUERY_STRING'];
		$this->id='content';
		$this->template="quanlykho/nhanvien_list.tpl";
		$this->layout="layout/center";
		
		
		if($this->request->get['opendialog']=='true')
		{
			$this->layout="layout/dialog";
			$this->data['dialog'] = true;
			//$this->data['list'] = $this->url->http('quanlykho/nhacungung&opendialog=true');
		}
		$this->render();
	}
	
	private function getForm()
	{
		
		$this->load->model("quanlykho/phongban");
		$this->load->helper('image');
		$this->data['phongbans'] = $this->model_quanlykho_phongban->getTreePhongBan($this->model_quanlykho_phongban->root);
		unset($this->data['phongbans'][0]);
		//$this->data['chucvus'] = $this->document->chucvu;
		$this->data['chucvus'] = array();
		$this->model_quanlykho_nhom->getTree("chucvu",$this->data['chucvus']);
		unset($this->data['chucvus'][0]);
		
		$this->data['nhomnhanvien'] = $this->model_quanlykho_nhom->getChild("nhomnhanvien");
		$this->data['loainhanvien'] = $this->model_quanlykho_nhom->getChild("loainhanvien");
		if ((isset($this->request->get['id'])) ) 
		{
      		$this->data['item'] = $this->model_quanlykho_nhanvien->getItem($this->request->get['id']);
			$this->data['item']['arrnhom'] = array();
			$this->data['item']['arrnhom'] = $this->string->referSiteMapToArray($this->data['item']['nhom']);
			$this->data['item']['imagethumbnail'] = HelperImage::resizePNG($this->data['item']['imagepath'], 200, 200);
    	}
		$this->data['DIR_UPLOADPHOTO'] = HTTP_SERVER."index.php?route=common/uploadpreview";
		$this->id='content';
		$this->template='quanlykho/nhanvien_form.tpl';
		$this->layout="layout/center";
		
		$this->render();
	}
	
	public function save()
	{
		$data = $this->request->post;
		
		if($this->validateForm($data))
		{
			$this->load->model("quanlykho/nhanvien");
			$item = $this->model_quanlykho_nhanvien->getItem($data['id']);
			$data['ngaysinh'] = $this->date->formatViewDate($data['ngaysinh']);
			$data['ngayvaolam'] = $this->date->formatViewDate($data['ngayvaolam']);
			$data['ngaykyhopdong'] = $this->date->formatViewDate($data['ngaykyhopdong']);
			$data['nhom'] = $this->string->arrayToString($data['nhom']);
			if(count($item)==0)
			{
				$data['id']=$this->model_quanlykho_nhanvien->insert($data);
			}
			else
			{
				$this->model_quanlykho_nhanvien->update($data);
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
    	if($data['manhanvien'] == "")
		{
      		$this->error['manhanvien'] = "Mã nhân viên không được rỗng";
    	}
		else
		{
			if($data['id'] == "")
			{
				$this->load->model("quanlykho/nhanvien");
				$where = " AND manhanvien ='".$data['manhanvien']."'" ;
				$item = $this->model_quanlykho_nhanvien->getList($where);
				if(count($item)>0)
					$this->error['manhanvien'] = "Mã nhân viên đã được sử dụng";
			}
		}
		if(strlen($data['manhanvien']) > 50)
		{
      		$this->error['manhanvien'] = "Mã nhà nhân viên không được vượt quá 50 ký tự";
    	}
		
		if ($data['hoten'] == "") 
		{
      		$this->error['hoten'] = "Bạn chưa nhập tên nhân viên";
    	}
		
		if ($data['ngaysinh'] == "") 
		{
      		$this->error['ngaysinh'] = "Bạn chưa nhập ngày sinh";
    	}
		
		if ($data['cmnd'] == "") 
		{
      		$this->error['cmnd'] = "Bạn chưa nhập số CMND";
    	}
		
		if ($data['gioitinh'] == "") 
		{
      		$this->error['gioitinh'] = "Bạn chưa chọn giới tính";
    	}
		
		if ($data['maphongban'] == "") 
		{
      		$this->error['maphongban'] = "Bạn chưa chọn phòng ban";
    	}
		
		if ($data['loai'] == "") 
		{
      		$this->error['loai'] = "Bạn chưa chọn loại";
    	}
		
		if ($data['nhom'] == "") 
		{
      		$this->error['nhom'] = "Bạn chưa chọn nhóm";
    	}
		
		if ($data['chucvu'] == "") 
		{
      		$this->error['chucvu'] = "Bạn chưa chọn chức vụ";
    	}
		
		if (count($this->error)==0) 
		{
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
	
	//Các hàm xủ lý trên form
	public function getNhanVien()
	{
		$col = $this->request->get['col'];
		$val = $this->request->get['val'];
		$operator = $this->request->get['operator'];
		if($operator == "")
			$operator = "equal";
		$this->load->model("quanlykho/nhanvien");
		$where = "";
		switch($operator)
		{
			case "equal":
				$where = " AND ".$col." = '".$val."'";
				break;
			case "like":
				$where = " AND ".$col." = '%".$val."%'";
				break;
			case "other":
				$where = " AND ".$col." <> '".$val."'";
				break;
			case "in":
				$where = " AND ".$col." in  (".$val.")";
				break;
			
		}
			
		
		$datas = $this->model_quanlykho_nhanvien->getList($where);
		
		$this->data['output'] = json_encode(array('nhanviens' => $datas));
		$this->id="nhanvien";
		$this->template="common/output.tpl";
		$this->render();
	}
	
	public function taotaikhoan()
	{
		if(!$this->user->hasPermission($this->getRoute(), "add"))
		{
			$this->response->redirect("?route=common/permission");
		}
		$this->document->title = $this->language->get('heading_title');
		$this->load->model("core/user");
		$this->load->model("quanlykho/nhanvien");
		$this->data['haspass'] = true;
		
		$this->data['error'] = @$this->error;
		$this->load->model("core/usertype");
		
		$this->data['nhanvien'] = $this->model_quanlykho_nhanvien->getItem($this->request->get['id']);
		$this->data['usertype'] = $this->model_core_usertype->getList(" AND usertypeid <> 'admin'");
		$this->data['cancel'] = $this->url->https('quanlykho/nhanvien');
		
		$this->id='content';
		$this->template='quanlykho/user_form.tpl';
		$this->layout="layout/center";
		
		$this->render();
	}
	
	public function phanquyen()
	{
		
		$this->load->model("core/usertype");
		$this->load->model("core/user");
		$this->load->model("quanlykho/nhanvien");
		$this->load->model("quanlykho/phongban");
		$this->load->model("core/module");
		$this->load->model("core/sitemap");
		$this->load->model("common/control");
		
		/*$this->data['usertype'] = $this->model_quanlykho_nhanvien->getItem($this->request->get['id']);
		$this->data['permission'] = $this->string->referSiteMapToArray($this->data['usertype']['permission']);*/
		$this->data['nhanvien'] = $this->model_quanlykho_nhanvien->getItem($this->request->get['id']);
		
		$this->data['permission'] = $this->string->referSiteMapToArray($this->data['nhanvien']['permission']);
		
		if(count($this->data['permission']) == 0)
		{
			$phongban = $this->model_quanlykho_phongban->getPhongBan($this->data['nhanvien']['maphongban']);
			$this->data['nhanvien']['permission'] = $phongban['permission'];
			$this->data['permission'] = $this->string->referSiteMapToArray($phongban['permission']);
			//print_r($this->data['permission']);
		}
		$this->data['sitemaps'] = array();
		$this->data['listPermission'] = $this->model_core_usertype->listPermission;
		$this->model_core_sitemap->getTreeSitemap("",$this->data['sitemaps'],$this->user->getSiteId());
		$this->data['modules'] = $this->model_core_sitemap->getModuleAddons();
		$this->data['modulesquanlykho'] = $this->model_core_sitemap->getModuleQuanLyKho();
		
		$this->data['cancel'] = $this->url->https('quanlykho/nhanvien');
		
		$this->id='content';
		$this->template = 'quanlykho/usertype_form.tpl';
		$this->layout="layout/center";
		$this->render();
	}
	
	public function motaikhoan()
	{
		$this->load->model("core/user");
		
		$data = array();
		$data['userid'] = $this->request->get['username'];
		$data['status'] = "active";
		
		$this->model_core_user->updatestatus($data);
		$this->response->redirect("index.php?route=quanlykho/nhanvien");
		
	}
	
	public function khoataikhoan()
	{
		$this->load->model("core/user");
		
		$data = array();
		$data['userid'] = $this->request->get['username'];
		$data['status'] = "lock";
		$this->model_core_user->updatestatus($data);
		
		$this->response->redirect("index.php?route=quanlykho/nhanvien");
	}
	
	public function saveuser()
	{
		$data = $this->request->post;
		
		if($this->validateFormUser($data))
		{
			$this->load->model("quanlykho/nhanvien");
			$userid = $this->model_quanlykho_nhanvien->saveuser($data);
			$this->model_quanlykho_nhanvien->updateusername($data['nhanvienid'], $userid);
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
	
	public function savePermission()
	{
		$this->load->model("quanlykho/nhanvien");
		$data['nhanvienid'] = $this->request->post['id'];
		$data['permission'] = $this->request->post['permission'];
		$this->model_quanlykho_nhanvien->updatePermission($data);
		$this->data['output'] = "true";
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
	}
	
	private function validateFormUser($data)
	{
    	if ((strlen($data['username']) == 0) || (strlen($data['username']) > 30)) 
		{
      		$this->error['username'] = "Bạn chưa nhập tên tài khoản";
    	}
		else
		{
			
			if($this->validation->_isId(trim($data['username'])) == false)
				$this->error['username'] ="tên tài khoản không hợp lệ";
			else
			{
				$this->load->model("core/user");
				$user = $this->model_core_user->getItemByUserName($data['username']);
				if(count($user)>0 && $this->request->post['userid'] == '')
					$this->error['username'] = "Tên tài khoản đã được sử dụng";			
			}
		}
		if($this->request->get['userid']=="")
		{
			if (strlen($data['password']) == 0) 
			{
				$this->error['password'] = "Bạn chưa nhập mật khẩu";
			}
			
			if ($this->request->post['confrimpassword'] != $data['password']) 
			{
				$this->error['confrimpassworfd'] = "Mật khẩu mới không trùng khớp";
			}		
		}
		
		if (count($this->error)==0) {
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
	
}
?>