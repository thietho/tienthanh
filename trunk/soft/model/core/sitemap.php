<?php
class ModelCoreSitemap extends Model 
{
	private $module = array(
							'group' => 'None',
							'homepage' => "Homepage",
							'module/information' => 'Information Page',
							'module/news'=>'News',
							'module/banner'=>'Banner',
							'module/video'=>'Video',
							'module/product'=>'Product',
							'module/download'=>'Download',
							'module/contact'=>'Contact',
							'module/link'=>'Web URL',
							'addon/cart'=>'Shopping cart',
							'group/domain'=>'Domain page',
							);
	private $moduleaddon = array(
								 /*"core/changeskin" => "Change skin",*/
								 "core/user" => "User management"
								 );
	private $modulequanlykho = array(
								 "1-title" => "Quản lý phiếu",
								 "quanlykho/phieuyeucau" => "Danh mục phiếu yêu cầu", 
								 "quanlykho/phieukhieunai" => "Danh mục phiếu khiếu nại", 
								 "quanlykho/phieuthuthap" => "Danh mục phiếu thu thập", 
								 "quanlykho/phieuxuatnguyenlieu" => "Danh mục phiếu xuất nguyên liệu", 
								 "quanlykho/phieunhapnguyenlieu" => "Danh mục phiếu nhập nguyên liệu", 
								 "2-title" => "Báo cáo thông kê nguyên liệu",
								 "quanlykho/baocaonguyenlieunhapxuat" => "Báo cáo nhập xuất nguyên liệu phát sinh", 
								 "quanlykho/baocaonguyenlieutinhhinhtonkho" => "Báo cáo tình hình tồn kho nguyên", 
								  "quanlykho/baocaonguyenlieuvuotmucton" => "Báo cáo nguyên liệu vượt quá mức tồn kho", 
								 "3-title" => "Quản lý danh mục",
								 "quanlykho/donvitinh" => "Đơn vị tính",
								 "quanlykho/kho" => "Kho",
								 "quanlykho/phongban" => "Phòng ban",
								 "quanlykho/chiphi" => "Danh muc chi phí",
								 "quanlykho/nhom" => "Danh muc phân loại",
								 "quanlykho/khachhang" => "Danh mục khách hàng",
								 "quanlykho/nhacungung" => "Danh mục nhà cung ứng",
								 "quanlykho/nhanvien" => "Danh mục nhân viên",
								 "quanlykho/nguyenlieu" => "Danh mục nguyên liệu",
								 "quanlykho/taisan" => "Quản lý tài sản",
								 "quanlykho/linhkien" => "Quản lý linh kiện",
								 "quanlykho/quyetdinhgia" => "Quản lý quyết định giá",
								 "quanlykho/sanpham" => "Quản lý sản phẩm",
								 "4-title" => "Quản lý kế khoạch",
								 "quanlykho/kehoachnam" => "Kế hoạch năm",
								 "quanlykho/kehoach" => "Kế hoạch"
								 
								 );
	public function getModules()
	{
		return $this->module;
	}
	public function getModuleAddons()
	{
		return $this->moduleaddon;
	}
	public function getModuleQuanLyKho()
	{
		return $this->modulequanlykho;
	}
	public function getItem($sitemapid, $siteid, $where="")
	{
		$query = $this->db->query("Select `sitemap`.* 
									from `sitemap`
									where  siteid='".$siteid."' AND sitemapid='".$sitemapid."'
									");
		return $query->row;
	}
	
	public function getList($siteid, $where = "")
	{
		$query = $this->db->query("Select `sitemap`.* 
									from `sitemap`
									where `sitemap`.status not like 'Delete' AND siteid = '".$siteid."' ".$where.
									" ORDER BY position, siteid, id"
									);
		return $query->rows;
	}
	
	public function nextID()
	{
		return $this->db->getNextIdVarChar("sitemap","sitemapid","site");
	}
	
	public function nextPosition($parentid)
	{
		$sql = "Select max(position) as max From sitemap where sitemapparent='".$parentid."' AND siteid='".$this->user->getSiteId()."' Order By position";
		$query = $this->db->query($sql);
		return $query->rows[0]['max'] +1 ;
	}
	
	public function listStatus()
	{
		return array(
				"Active"=>"Active",
				"Addon"=>"Addon",
				"Hide"=>"Hide"
				);
	}
	
	
	//Cac dang lat list khac nhau
	public function getListByParent($parentid, $siteid, $status = "")
	{
		$where = " AND sitemapparent = '".$parentid."' ";
		if($status != "")
		{
			$where .= " AND `sitemap`.status = '".$status."' ";
		}
		return $this->getList($siteid, $where);
	}
	
	public function getListByModule($moduleid, $siteid)
	{
		$where = " AND `sitemap`.moduleid = '".$moduleid."'";
		return $this->getList($siteid, $where);
	}
	
	
/*	public function getListChild($parentid)
	{
		$query = $this->db->query("Select * From sitemap where sitemapparent='".$parentid."' and siteid='".$siteid."' Order By position");
		return $query->rows;
	}*/

	/*public function getListSitemapIDbyMediaID($id)
	{
		$query = $this->db->query("Select * from `sitemap_media` where mediaid='".$id."'");
		return $query->rows;
	}*/
	
	
	function getTreeSitemapEdit($id, $hidenid, &$data, $siteid)
	{
		if($id!=$hidenid)
		{
			$arr=$this->getItem($id, $siteid);
			if($id!="")
				array_push($data,$arr);
				
			$rows = $this->getListByParent($id, $siteid);
			
			if(count($rows))
				foreach($rows as $row)
				{
					$this->getTreeSitemapEdit($row['sitemapid'],$hidenid,$data, $siteid);
				}			
		}
	}
	
	
	function getDeep($id, $siteid)
	{
		$deep=0;
		$row=$this->getItem($id, $siteid);
		while($row['sitemapparent']!="")
		{
			$deep++;
			$row=$this->getItem($row['sitemapparent'], $siteid);
		}
		return $deep;
	}
	
	public function getPath($id, $siteid)
	{
		$arr=array();
		$row=$this->getItem($id, $siteid);
		array_push($arr,$row);
		while($row['sitemapparent']!="")
		{
			$row=$this->getItem($row['sitemapparent'], $siteid);
			array_push($arr,$row);
		}
		return $arr;
	}
	
	public function getBreadcrumb($id, $siteid, $end=0)
	{
		$data = $this->getPath($id, $siteid);
		$strBreadcrumb = "<a href='index.php'>Home</a>";
		for($i=count($data)-1;$i>$end;$i--)
		{
			$link = "".$data[$i]['sitemapname']."";
			if($data[$i]['modulepath'] != "")
				$link='<a target="_blank" href="'.$data[$i]['modulepath']."&sitemapid=".$data[$i]['sitemapid'].'" title="[Detail]">'.$data[$i]['sitemapname'].'</a>';
			$strBreadcrumb .= " >> ".$link; 
		}
		return $strBreadcrumb;
	}
	
	/*public function pathOfPosition($id)
	{
		$arr=array();
		$row=$this->getItem($id);
		array_push($arr,$row['sitemapid']);
		while($row['sitemapparent']!="")
		{
			$row=$this->getSitemap($row['sitemapparent']);
			array_push($arr,$row['sitemapid']);
		}
		$path="";
		while(count($arr))
		{
			$position=array_pop($arr);
			if($position!="")
				$path.="-".$position;
		}
		//echo $path."<br>";
		return $path;
	}*/
	
	public function insertSiteMap($data)
	{
		$sitemapid=$this->db->escape(@$data['sitemapid']);
		$siteid=$this->db->escape(@$data['siteid']);
		$sitemapparent = $this->db->escape(@$data['sitemapparent']);
		$sitemapname = $this->db->escape(@$data['sitemapname']);
		$othername = $this->db->escape(@$data['othername']);
		$position=(int)@$data['position'];
		$moduleid=$this->db->escape(@$data['moduleid']);
		$imageid=(int)@$data['imageid'];
		$imagepath = $this->db->escape(@$data['imagepath']);
		$status=$this->db->escape(@$data['status']);
		$field=array(
						"sitemapid",
						"siteid",
						"sitemapparent",
						"sitemapname",
						"othername",
						"position",
						"moduleid",
						"imageid",
						"imagepath",
						"status"
					);
		$value=array(
						$sitemapid,
						$siteid,
						$sitemapparent,
						$sitemapname,
						$othername,
						$position,
						$moduleid,
						$imageid,
						$imagepath,
						$status
					);
		$this->db->insertData("sitemap",$field,$value);
	}
	
	public function updateSiteMap($data)
	{
		$sitemapid=$this->db->escape(@$data['sitemapid']);
		$siteid=$this->db->escape(@$data['siteid']);
		$sitemapparent = $this->db->escape(@$data['sitemapparent']);
		$sitemapname = $this->db->escape(@$data['sitemapname']);
		$othername = $this->db->escape(@$data['othername']);
		$position=(int)@$data['position'];
		$moduleid=$this->db->escape(@$data['moduleid']);
		$imageid=(int)@$data['imageid'];
		$imagepath = $this->db->escape(@$data['imagepath']);
		$status=$this->db->escape(@$data['status']);
		$field=array(
						"siteid",
						"sitemapparent",
						"sitemapname",
						"othername",
						"position",
						"moduleid",
						"imageid",
						"imagepath",
						"status"
					);
		$value=array(
						$siteid,
						$sitemapparent,
						$sitemapname,
						$othername,
						$position,
						$moduleid,
						$imageid,
						$imagepath,
						$status
					);
		$where="sitemapid = '".$sitemapid."' AND siteid = '".$siteid."'";
		$this->db->updateData('sitemap',$field,$value,$where);
	}
	
	public function updateSiteMapPosition($sitmapid,$position, $siteid)
	{
		$field=array(
						"position"
					);
		$value=array(
						$position
					);
		$where="sitemapid = '".$sitmapid."' AND siteid = '".$siteid."'";
		$this->db->updateData('sitemap',$field,$value,$where);
	}
	
	public function deleteSiteMap($id, $siteid)
	{
		if(count($this->getListByParent($id, $siteid))==0)
		{
			$sitemapid=$id;
			$where="sitemapid = '".$sitemapid."' AND siteid = '".$siteid."'";
			$this->db->deleteData('sitemap',$where);
			return true;
		}
		else return false;			
	}
	



	//Cac ham duyet cay sitemap//////////////////////////////////////////////////////////////
	
	
	function getTreeSitemap($id, &$data, $siteid, $level=-1, $path="", $parentpath="")
	{
		$arr=$this->getItem($id, $siteid);
		
		$rows = $this->getListByParent($id, $siteid);
		
		$arr['countchild'] = count(rows);
		
		if($arr['sitemapparent'] != "") $parentpath .= "-".$arr['sitemapparent'];
		
		if($id!="")
		{
			$level += 1;
			$path .= "-".$id;
			
			$arr['level'] = $level;
			$arr['path'] = $path;
			$arr['parentpath'] = $parentpath;
			
			array_push($data,$arr);
		}
		
		
		if(count($rows))
			foreach($rows as $row)
			{
				$this->getTreeSitemap($row['sitemapid'], $data, $siteid, $level, $path, $parentpath);
			}
	}
	
	public function getTreeAll($id,&$data,$status="")
	{
		$where = "";
		if($status != "")
			$where = " AND sitemap.status = '".$status."'";
		$arr=$this->getItem($id, $this->user->getSiteId(),$where);
		
			
		if(count($arr))
		{
			$deep = $this->getDeep($arr['sitemapid'],$this->user->getSiteId());
			$arr['prefix'] = $this->string->getPrefix("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;",$deep-1);
			$data[]=$arr;
		}
		$rows = $this->getListByParent($id, $this->user->getSiteId());
		if(count($rows))
			foreach($rows as $item)
			{
				$this->getTreeAll($item['sitemapid'],$data,$status);		
			}
	
	}
	
	public function getListSiteMapCheckBox()
	{
		
		$list = array();
		$this->getTreeAll("",$list );
		$html = "";
		foreach($list as $item)
		{
			$html .= '<tr>';
			$html .= '<td>';
			$deep = $this->model_core_sitemap->getDeep($item['sitemapid'], $this->user->getSiteId());
			$preFix = $this->string->getPrefix("&nbsp;&nbsp;&nbsp;&nbsp;",$deep);
			$sitemapid = "[".$item['sitemapid']."]";
			
			
			if($item['moduleid']=="group" || $item['moduleid']=="homepage")
				$name ='<label><input name="listrefersitemap['.$item['sitemapid'].']" type="checkbox" value="'.$item['sitemapid'].'" '.$checked.' disabled="disabled" /> '.$item['sitemapname'].'</label>';
			else
				$name ='<label> <input class="checkbox" name="listrefersitemap['.$item['sitemapid'].']" type="checkbox" value="'.$item['sitemapid'].'" '.$checked.' />'.$item['sitemapname'].'</label>';
			$html .= $preFix.$name;
			$html .= '</td></tr>';
		}
		
		return "<table>".$html."</table>";
	}
	//end cac ham duyet cay sitemap///////////////////////////////////////////////////////
}
?>