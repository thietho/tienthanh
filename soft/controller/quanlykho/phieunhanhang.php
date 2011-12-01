<?php
class ControllerQuanlykhoPhieunhanhang extends Controller
{
	private $error = array();

	public function index()
	{
		/*
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
			*/

		//$this->load->language('quanlykho/nhacungung');
		//$this->data = array_merge($this->data, $this->language->getData());

		$this->document->title = $this->language->get('heading_title');

		$this->load->model("quanlykho/phieunhanhang");
		$this->getList();
	}

	public function insert()
	{
		/*
		 if(!$this->user->hasPermission($this->getRoute(), "add"))
		 {
			$this->response->redirect("?route=common/permission");
			}
			*/

		$this->getForm();
	}

	public function update()
	{
		//if(!$this->user->hasPermission($this->getRoute(), "edit"))
		//{
		//$this->response->redirect("?route=common/permission");
		//}
		//else
		//{
		$this->load->model("quanlykho/phieunhanhang");
		$this->data['haspass'] = false;
		$this->data['readonly'] = 'readonly="readonly"';
			
		$this->getForm();
		//}

	}

	public function delete()
	{
		$listid=$this->request->post['delete'];
		//$listmadonvi=$_POST['delete'];
		$this->load->model("quanlykho/phieunhanhang");
		if(count($listid))
		{
			$this->model_quanlykho_phieunhanhang->deletedatas($listid);
			$this->data['output'] = "Xóa thành công";
		}
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
	}

	private function getList()
	{
		$this->load->model("quanlykho/phieunhanhang");
		$this->load->model("quanlykho/nhanvien");
		$this->load->model("quanlykho/nhacungung");

		$manhacungung= $this->request->get['id'];
		$nhacungung = $this->model_quanlykho_nhacungung->getItem($manhacungung);
		$this->data['manhacungung'] = $manhacungung;

		$this->data['nhacungungs'] = $this->model_quanlykho_nhacungung->getList();

		$this->data['insert'] = $this->url->http('quanlykho/phieunhanhang/insert&manhacungung='.$manhacungung);
		$this->data['delete'] = $this->url->http('quanlykho/phieunhanhang/delete');

		$this->data['datas'] = array();
		$where = "";


		$datasearch = array();
		$datasearch['tinhtrangthanhtoan'] = $this->request->get['tinhtrangthanhtoan'];
		$datasearch['manhacungung'] = $this->request->get['manhacungung'];
		$datasearch['trangthai'] = $this->request->get['trangthai'];


		$arr = array();
		foreach($datasearch as $key => $item)
		{
			if($item !="")
			$arr[] = " AND " . $key ." = '".$item."'";
		}

		if($this->request->get['tungay'] != "")
		$datasearch['tungay'] = $this->date->formatViewDate($this->request->get['tungay']);

		if($this->request->get['denngay'] != "")
		$datasearch['denngay'] = $this->date->formatViewDate($this->request->get['denngay']);

		if($datasearch['tungay'] != "")
		$arr[] = " AND ngaylap>= '".$datasearch['tungay']."'";

		if($datasearch['denngay'] != "")
		$arr[] = " AND ngaylap <= '".$datasearch['denngay']."'";

		$where = implode("",$arr);

		$rows = $this->model_quanlykho_phieunhanhang->getList($where);
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
			$this->data['datas'][$i]['tennhacungung'] = $nhacungung['tennhacungung'];
				
			$nhanviennhanhang = $this->model_quanlykho_nhanvien->getItem($rows[$i]['manhanviennhanhang']);
			$this->data['datas'][$i]['nhanviennhanhang'] = $nhanviennhanhang['hoten'];
				
			$this->data['datas'][$i]['link_edit'] = $this->url->http('quanlykho/phieunhanhang/update&id='.$this->data['datas'][$i]['id']);
			$this->data['datas'][$i]['text_edit'] = "Sửa";
				
		}

		$this->data['refres']=$_SERVER['QUERY_STRING'];
		$this->id='content';
		$this->template="quanlykho/phieunhanhang_list.tpl";
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
		$this->load->model("quanlykho/phieunhanhang");
		$this->load->model("quanlykho/nhacungung");
		$this->load->model("quanlykho/nhanvien");

		$manhacungung = $this->request->get['manhacungung'];
		$username = $this->user->getId();
		$nhanvien = $this->model_quanlykho_nhanvien->getItemByUsername($username);

		$this->data['item'] = array();
		$this->data['item']['manhacungung'] = $manhacungung;


		if ((isset($this->request->get['id'])) )
		{
			$this->data['item'] = $this->model_quanlykho_phieunhanhang->getItem($this->request->get['id']);
			//get chi tiet phieu nhan hang
			$this->data['chitiet'] = $this->model_quanlykho_phieunhanhang->getChiTietPhieuNhanHangs(" AND maphieunhanhang=" .$this->request->get['id']);

			$manhacungung = $this->data['item']['manhacungung'];
			$manhanviennhanhang = $this->data['item']['manhanviennhanhang'];
			$nhanvien = $this->model_quanlykho_nhanvien->getItem($manhanviennhanhang);
		}

		$nhacungung = $this->model_quanlykho_nhacungung->getItem($manhacungung);
		$this->data['item']['tennhacungung'] = $nhacungung['tennhacungung'];

		$this->data['item']['tennhanviennhanhang'] = $nhanvien['hoten'];
		$this->data['item']['manhanviennhanhang'] = $nhanvien['id'];

		$this->id='content';
		$this->template='quanlykho/phieunhanhang_form.tpl';
		$this->layout="layout/center";

		$this->render();
	}

	public function save()
	{
		$data = $this->request->post;

		if($this->validateForm($data))
		{
			$this->load->model("quanlykho/phieunhanhang");
			$item = $this->model_quanlykho_phieunhanhang->getItem($data['id']);
				
			$data['ngaylap'] = $this->date->formatViewDate($data['ngaylap']);
			$data['ngaygiao'] = $this->date->formatViewDate($data['ngaygiao']);
				
			if(count($item)==0)
			{
				$data['id']=$this->model_quanlykho_phieunhanhang->insert($data);
			}
			else
			{
				$this->model_quanlykho_phieunhanhang->update($data);
			}
				
			$arrchitietid = $data['chitiet'];
			$arrmanguyenlieu = $data['manguyenlieu'];
			$arrtennguyenlieu = $data['tennguyenlieu'];
			$arrsoluong = $data['soluong'];
			$arrdongia = $data['dongia'];
				
			$arrdanhgiachatluong = $data['danhgiachatluongct'];
				
			$arrsoluongnhan =  $data['soluongnhan'];
			$arrsoluongtralai =  $data['soluongtralai'];
				
			$this->load->model("quanlykho/phieunhanhang");
			$list = trim( $data['delchitiet'],",");
			$arrdel = split(",", $list);
				
			foreach($arrdel as $val)
			{
				$this->model_quanlykho_phieunhanhang->deletechitiet($val);
			}
				
			$datachitiet = array();
			if(count($arrchitietid)>0)
			{

				foreach($arrchitietid as $key => $val)
				{
					$datachitiet['id'] = $arrchitietid[$key];
					$datachitiet['maphieunhanhang'] = $data['id'];
					$datachitiet['manguyenlieu'] = $arrmanguyenlieu[$key];
					$datachitiet['tennguyenlieu'] = $arrtennguyenlieu[$key];
					$datachitiet['soluong'] = $arrsoluong[$key];
					$datachitiet['dongia'] = $arrdongia[$key];
					$datachitiet['danhgiachatluong'] = $arrdanhgiachatluong[$key];
					$datachitiet['soluongnhan'] = $arrsoluongnhan[$key];
					$datachitiet['soluongtralai'] = $arrsoluongtralai[$key];
						
					$this->model_quanlykho_phieunhanhang->saveChiTiet($datachitiet);
				}

			}
				
				
			$this->data['output'] = "true";
			$this->id='content';
			$this->template='common/output.tpl';
			$this->render();
				
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
		if($data['maphieunhanhang'] == "")
		{
			$this->error['maphieunhanhang'] = "Mã phiếu nhận hàng không được rỗng";
		}

		if(strlen($data['maphieunhanhang']) > 50)
		{
			$this->error['maphieunhanhang'] = "Mã phiếu nhận hàng không được vượt quá 50 ký tự";
		}

		if ($data['mahopdong'] == "")
		{
			$this->error['mahopdong'] = "Bạn chưa nhập hợp đồng";
		}

		if ($data['langiao'] == "")
		{
			$this->error['langiao'] = "Bạn chưa nhập lần giao";
		}

		if ($data['ngaylap'] == "")
		{
			$this->error['ngaylap'] = "Bạn chưa nhập ngày lập";
		}

		if ($data['ngaygiao'] == "")
		{
			$this->error['ngaygiao'] = "Bạn chưa nhập ngày giao";
		}

		if (count($this->error)==0)
		{
			return TRUE;
		} else {
			return FALSE;
		}
	}

	//chi tiet phieu nhan hang

	//Cac ham xu ly tren form
	public function getPhieuNhanHang()
	{
		$col = $this->request->get['col'];
		$val = $this->request->get['val'];
		$operator = $this->request->get['operator'];
		if($operator == "")
		$operator = "equal";
		$this->load->model("quanlykho/phieunhanhang");
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
			
			
		$datas = $this->model_quanlykho_phieunhanhang->getList($where);
		$this->data['output'] = json_encode(array('phieunhanhangs' => $datas));
		$this->id="phieunhanhang";
		$this->template="common/output.tpl";
		$this->render();
	}

	public function getChiTietPhieuNhanHang()
	{
		$maphieunhanhang = $this->request->get['maphieunhanhang'];
		$this->load->model("quanlykho/phieunhanhang");
		$where = " AND maphieunhanhang = '".$maphieunhanhang."'";
		$datas = $this->model_quanlykho_phieunhanhang->getChiTietPhieuNhanHangs($where);
		$this->data['output'] = json_encode(array('chitietphieunhanhangs' => $datas));
		$this->id="chitietphieunhanhang";
		$this->template="common/output.tpl";
		$this->render();
	}
}
?>