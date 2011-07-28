<?php
class ControllerAddonOrder extends Controller
{
	private $error = array();
	
	public function index()
	{
		$this->load->language('addon/order');
		$this->data = array_merge($this->data, $this->language->getData());
		
		$this->document->title = $this->language->get('heading_title');
		
		$this->load->model("addon/order");
		$this->getList();
	}
	
	public function view()
	{
		$this->load->language('addon/order');
		$this->data = array_merge($this->data, $this->language->getData());
		
		$orderid = $this->request->get['orderid'];
		$this->load->model("addon/order");
		$this->load->helper('image');
		$this->data = $this->model_addon_order->getItem($orderid);
		if($this->data['order']['status']=='')
			$this->data['order']['text_active'] = "New";
		else
			$this->data['order']['text_active'] = "Checked";
		foreach($this->data['detail'] as $key => $item)
		{
			$imagepreview = "<img width=100 src='".HelperImage::resizePNG($item['imagepath'], 180, 180)."' >";
			$this->data['detail'][$key]['imagepreview'] = $imagepreview;
		}
		
		$this->id='content';
		$this->template="addon/order_form.tpl";
		$this->layout="layout/center";
		$this->render();
	}
	
	private function getList() 
	{
		$this->data['insert'] = $this->url->http('core/user/insert');
		$this->data['delete'] = $this->url->http('core/user/delete');		

		$this->data['orders'] = array();
		$where = " ORDER BY  `order`.`orderdate` DESC ";
		$this->data['orders'] = $this->model_addon_order->getList($where);
		
		for($i=0; $i <= count($this->data['orders'])-1 ; $i++)
		{
			$this->data['orders'][$i]['link_active'] = $this->url->http('addon/order/check&orderid='.$this->data['orders'][$i]['orderid']);
			if($this->data['orders'][$i]['status']=='')
				$this->data['orders'][$i]['text_active'] = "New";
			else
				$this->data['orders'][$i]['text_active'] = "Checked";
		}
		$this->data['refres']=$_SERVER['QUERY_STRING'];
		$this->id='content';
		$this->template="addon/order_list.tpl";
		$this->layout="layout/center";
		$this->render();
	}
	
	public function updatestatus()
	{
		$this->load->model("addon/order");
		$orderid = $this->request->get['orderid'];
		//$this->data = $this->model_addon_order->getItem($orderid);
		$data['orderid'] = $orderid;
		$data['status'] = "checked";
		$this->model_addon_order->updateStatus($data);
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
	}
}
?>