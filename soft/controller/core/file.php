<?php
class ControllerCoreFile extends Controller
{
	private $error = array();
	public function index()
	{
		$this->load->model("core/module");
		$moduleid = $_GET['route'];
		$this->document->title = $this->model_core_module->getBreadcrumbs($moduleid);
		if($this->user->checkPermission($moduleid)==false)
		{
			$this->response->redirect('?route=page/home');
		}
		$files = glob(DIR_CACHE . '*13*');
		
		$this->load->model("core/media");
		$this->load->model("core/sitemap");
		
		
		//$this->data['sitemap'] = $this->model_core_sitemap->getListSiteMapCheckBox($media);
		//$this->getList();
		$this->data['DIR_UPLOADPHOTO'] = HTTP_SERVER."index.php?route=common/uploadpreview";
		$this->data['DIR_UPLOADATTACHMENT'] = HTTP_SERVER."index.php?route=common/uploadattachment";
		$this->id='content';
		$this->template="core/file.tpl";
		if($_GET['dialog'] == '')
		{
			//$this->template="core/file_list.tpl";
			$this->layout="layout/center";
		}
		$this->render();
	}

	public function getList()
	{
		$this->load->model("core/media");
		$this->load->helper('image');
		//HTTP_IMAGE . 'upload/*'; 
		
		$this->data['folderchild'] = array();
		$this->data['files'] = array();
		$folder = urldecode($this->request->get['folder']);
		if($folder=="")
			$files = glob(DIR_FILE.'upload/*');
		else
		{
			$files = glob(DIR_FILE.'upload/'.$folder.'/*');
			$this->data['folderchild'][-1]['foldername'] = $this->string->getFileName("..");
			$this->data['folderchild'][-1]['folderpath'] = $file;
		}
		
		$keyword = urldecode($this->request->get['keyword']);
		
		
		//print_r($this->data['files']);
		//echo substr_count('New folder4444','a'); 
		
		if(count($files)>0)
		{
			
			foreach($files as $i => $file) 
			{
				$info = pathinfo($file);
				
				if(@substr_count(strtolower($info['basename']), strtolower($keyword))>0 || $keyword == "")
				{
					
					if(is_dir($file))
					{
						
						$this->data['folderchild'][$i]['foldername'] = $this->string->getFileName($file);
						$this->data['folderchild'][$i]['folderpath'] = $file;
					}
					else
					{
						$ext = $this->string->getFileExt($file);
						if($this->string->isImage($ext))
							$this->data['files'][$i]['imagethumbnail'] = HelperImage::resizePNG(str_replace(DIR_FILE,"",$file), 130, 130);
						else
						{
							$urlext = HTTP_IMAGE."icon/48px/".$ext.".png";
							if(!@fopen($urlext,"r"))
								$urlext = HTTP_IMAGE."icon/48px/_blank.png";
							$this->data['files'][$i]['imagethumbnail'] = $urlext;	
						}
						$this->data['files'][$i]['filename'] = $this->string->getFileName($file);
						$this->data['files'][$i]['filepath'] = $file;
					}	
				}
				
			}	
		}
		/*$list = "";
		
		//
		$path = $this->model_core_file->getPath($folderid);
		$arr = array();
		$arr[] = '<a class="folderpath" folderid="0">Root</a>';	
		foreach($path as $f)
		{
			$arr[] = '<a class="folderpath" folderid="'.$f['folderid'].'">'.$f['foldername'].'</a>';	
		}
		$this->data['path'] = implode(" >> ",$arr);
		//
		$this->data['folderchild'] = $this->model_core_file->getFolderChild($folderid);
		$this->load->model("core/sitemap");
		$this->load->helper('image');
		$where="";
		if($list!="")
			$where.=" AND fileid in (".$list.")";
		if($keyword!="")
		{
			$where .= " AND filename like '%".$keyword."%'";	
		}
		if($folderid!="")
			$where .= " AND folderid = ".$folderid;
		$rows = $this->model_core_media->getFiles($where." ORDER BY `file`.`fileid` DESC");
		//Page
		$page = $this->request->get['page'];		
		$x=$page;		
		$limit = 28;
		$total = count($rows); 
		// work out the pager values 
		for($i=0;$i <  count($rows);$i++)
		{
			
			$this->data['files'][$i] = $rows[$i];
			$this->model_core_file->updateFileTemp($this->data['files'][$i]['fileid']);
			$this->data['files'][$i]['imagethumbnail'] = HelperImage::resizePNG($this->data['files'][$i]['filepath'], 130, 130);
			if(!$this->string->isImage($this->data['files'][$i]['extension']))
			{
				$urlext = HTTP_IMAGE."icon/48px/".$this->data['files'][$i]['extension'].".png";
				
				if(!@fopen($urlext,"r"))
					$urlext = HTTP_IMAGE."icon/48px/_blank.png";
				$this->data['files'][$i]['imagethumbnail'] = $urlext;
			}
		}*/
		
		
		$this->id='content';
		$this->template="core/file_grid.tpl";
		$this->render();
	}
	
	public function detail()
	{
		/*$this->load->model("core/file");
		$this->load->helper('image');
		$fileid = $this->request->get['fileid'];
		
		$this->data['item']=$this->model_core_file->getFile($fileid);
		
		if($this->string->isImage($this->data['item']['extension']))
			$this->data['item']['imagepreview'] = HelperImage::resizePNG($this->data['item']['filepath'], 800, 800);*/
		//print_r($this->data['file']);
		//$info = pathinfo(HTTP_IMAGE.$this->data['item']['filepath']);
		//print_r($info);
		$this->load->helper('image');
		$filepath = urldecode($this->request->get['filepath']);
		$this->data['item'] = pathinfo($filepath);
		if($this->string->isImage($this->data['item']['extension']))
			$this->data['item']['imagepreview'] = HelperImage::resizePNG(str_replace(DIR_FILE,"",$filepath), 800, 800);
		$this->data['item']['filepath'] = str_replace(DIR_FILE,"",$filepath);
		$this->data['item']['filesize'] = filesize(DIR_FILE.$filepath)/1024;
		
		$this->id='file';
		$this->template = "core/file_detail.tpl";
		$this->render();
	}
	
	
	
	function getFile()
	{
		$width = (int)$this->request->get['width'];
		$height = (int)$this->request->get['height'];
		$this->load->model("core/file");
		$this->load->helper('image');
		$fileid = $this->request->get['fileid'];
		$file=$this->model_core_file->getFile($fileid);
		if($this->string->isImage($file['extension']))
			$file['imagepreview'] = HelperImage::resizePNG($file['filepath'], $width, $height);
		else
		{
			
			
			$urlext = HTTP_IMAGE."icon/48px/".$file['extension'].".png";
			
			if(!@fopen($urlext,"r"))
				$urlext = HTTP_IMAGE."icon/48px/_blank.png";
			$file['imagepreview'] = $urlext;
			
		}
		$this->data['output'] = json_encode(array('file' => $file));
		$this->id='post';
		$this->template="common/output.tpl";
		$this->render();
	}
	public function delFile()
	{
		/*$this->load->model("core/file");
		$fileid = $this->request->get['fileid'];
		$this->model_core_file->deleteFile($fileid);*/
		$filepath = urldecode($this->request->get['filepath']);
		unlink($filepath);
		$this->data['output'] = "true";
		$this->id='post';
		$this->template="common/output.tpl";
		$this->render();
	}
	public function copy()
	{
		$data = $this->request->post;
		
		$arrfilepath = $data['source'];
		$desdir = DIR_FILE."upload/".$data['desdir']."/";
		foreach($arrfilepath as $filepath)
		{
			if(is_file($filepath))
			{
				$file = pathinfo($filepath);
				copy($filepath,$desdir.$file['basename']);
			}
			if(is_dir($filepath))
			{
				
				$this->smartCopy($filepath,$desdir);
			}
		}
		$this->data['output'] = "true";
		$this->id='post';
		$this->template="common/output.tpl";
		$this->render();
	}
	
	function smartCopy($source, $dest, $options=array('folderPermission'=>0755,'filePermission'=>0755)) 
    { 
        $result=false; 
        
        if (is_file($source)) { 
            if ($dest[strlen($dest)-1]=='/') { 
                if (!file_exists($dest)) { 
                    cmfcDirectory::makeAll($dest,$options['folderPermission'],true); 
                } 
                $__dest=$dest."/".basename($source); 
            } else { 
                $__dest=$dest; 
            } 
            $result=copy($source, $__dest); 
            chmod($__dest,$options['filePermission']); 
            
        } elseif(is_dir($source)) { 
            if ($dest[strlen($dest)-1]=='/') { 
                if ($source[strlen($source)-1]=='/') { 
                    //Copy only contents 
                } else { 
                    //Change parent itself and its contents 
                    $dest=$dest.basename($source); 
                    @mkdir($dest); 
                    chmod($dest,$options['filePermission']); 
                } 
            } else { 
                if ($source[strlen($source)-1]=='/') { 
                    //Copy parent directory with new name and all its content 
                    @mkdir($dest,$options['folderPermission']); 
                    chmod($dest,$options['filePermission']); 
                } else { 
                    //Copy parent directory with new name and all its content 
                    @mkdir($dest,$options['folderPermission']); 
                    chmod($dest,$options['filePermission']); 
                } 
            } 

            $dirHandle=opendir($source); 
            while($file=readdir($dirHandle)) 
            { 
                if($file!="." && $file!="..") 
                { 
                     if(!is_dir($source."/".$file)) { 
                        $__dest=$dest."/".$file; 
                    } else { 
                        $__dest=$dest."/".$file; 
                    } 
                    //echo "$source/$file ||| $__dest<br />"; 
                    $result=$this->smartCopy($source."/".$file, $__dest, $options); 
                } 
            } 
            closedir($dirHandle); 
            
        } else { 
            $result=false; 
        } 
        return $result; 
    }
	public function delListFile()
	{
		$this->load->model("core/file");
		$listpath = $this->request->post['chkfile'];
		/*foreach($listfileid as $fileid)
			$this->model_core_file->deleteFile($fileid);*/
		foreach($listpath as $path)
		{	
			if(is_file($path))
				unlink($path);
			if(is_dir($path))
				$this->rrmdir($path);
		}
		$this->data['output'] = "true";
		$this->id='post';
		$this->template="common/output.tpl";
		$this->render();
	}
	function rrmdir($dir) 
	{ 
		if (is_dir($dir)) 
		{ 
			$objects = scandir($dir); 
			foreach ($objects as $object) 
			{ 
				if ($object != "." && $object != "..") 
				{ 
					if (filetype($dir."/".$object) == "dir") 
						$this->rrmdir($dir."/".$object); 
					else 
					unlink($dir."/".$object); 
				} 
			} 
			reset($objects); 
			rmdir($dir); 
		} 
	}
	public function newFolder()
	{
		$data = $this->request->post;
		$foldername = $data['foldername'];
		$desdir = DIR_FILE."upload/".$data['desdir']."/";
		mkdir($desdir.$foldername);
		
		$this->data['output'] = "true";
		$this->id='post';
		$this->template="common/output.tpl";
		$this->render();
	}
	public function rename()
	{
		$data = $this->request->post;
		$oldname = $data['oldname'];
		$newname = $data['newname'];
		$fileinfo = pathinfo($oldname);
		rename($oldname,$fileinfo['dirname']."/".$newname);
		
		$this->data['output'] = "true";
		$this->id='post';
		$this->template="common/output.tpl";
		$this->render();
	}
	public function showFolderMoveForm()
	{
		$this->load->model("core/file");
		$this->data['treefolder'] = array();
		$this->model_core_file->getTreeFolder(0, $this->data['treefolder']);
		
		$this->id='post';
		$this->template="core/folder_move_form.tpl";
		$this->render();	
	}
	public function showFolderForm()
	{
		$this->load->model("core/file");
		
		$folderid = $this->request->get['folderid'];
		if($folderid =="")
			$folderid = -1;
		$folderparent = $this->request->get['folderparent'];
		if($folderid!= -1)
			$this->data['item'] = $this->model_core_file->getFolder($folderid);
		else
		{
			$this->data['item']['folderparent'] = $folderparent;
		}
		$this->data['treefolder'] = array();
		$this->model_core_file->getTreeFolder(0, $this->data['treefolder'],$folderid);
		
		$this->id='post';
		$this->template="core/folder_form.tpl";
		$this->render();
	}
	
	public function saveFolder()
	{
		$data = $this->request->post;
		$this->load->model("core/file");
		if($this->validateFolderForm($data))
		{
			$this->model_core_file->saveFolder($data);
			
			$data['error'] = "";
		}
		else
		{
			foreach($this->error as $item)
			{
				$data['error'] .= $item."<br>";
			}
		}
		$this->data['output'] = json_encode($data);
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	
	private function validateFolderForm($data)
	{
		if ($data['foldername'] == "") 
		{
      		$this->error['foldername'] = "Bạn chưa nhập tên thư mục";
    	}
		
		if (count($this->error)==0) 
		{
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
	
	public function getFolderTreeView()
	{
		
		$root = DIR_FILE.'upload/*';
		$this->data['output'] = '<ul id="group'.$root.'" class="filetree">'.$this->getFolderTree($root).'</ul>';
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	
	private function getFolderTree($path)
	{
		//$files = glob(DIR_FILE.'upload/*');
		$folders = glob($path);
		
		$str = "";
		foreach($folders as $item)
		{
			
			if(is_dir($item))
			{
				$str.='<li id="node'.$item.'" class="closed" ref="'.$path.'">';
				$type = 'folder';
				
				
				$str.='<span id="folder'.$item.'" class="'.$type.'"><b><span id="foldername'.$item.'" class="folderitem" folderid="'.$item.'">'.$item.'</span></b> </span>';
				$child = glob($item."/*");
				if(count($child))
				{
					$str .= "<ul id='group".$item."'>";
					$str .= $this->getFolderTree($item."/*");
					$str .= "</ul>";
				}
				$str.='</li>';

			}
			
		}
		return $str;
	}
	public function updateFolder()
	{
		$fileid = $this->request->get['fileid'];
		$folderid = $this->request->get['folderid'];
		$this->load->model("core/file");
		$this->model_core_file->updateFileCol($fileid,'folderid',$folderid);
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	
	public function delFolder()
	{
		$folderid = $this->request->get['folderid'];
		$this->load->model("core/file");
		//Kt co thu con khong
		$child = $this->model_core_file->getFolderChild($folderid);
		//Kt co ton tai file trong thi muc ko
		$where .= " AND folderid = ".$folderid;
		$data_file = $this->model_core_file->getFiles($where);
		if(count($child) == 0 && count($data_file) == 0)
		{
			$this->model_core_file->delFolder($folderid);
			$this->data['output'] = "true";
		}
		else
		{
			$this->data['output'] = "Thư mục đang chứa thông tin không xóa được";
		}
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	
}
?>