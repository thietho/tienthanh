<?php
class ControllerModuleInformation extends Controller
{
	public function index()
	{
		$this->load->model("core/media");

		$sitemapid = $this->document->sitemapid;

		$this->data['post'] = $this->model_core_media->getItem($this->member->getSiteId().$sitemapid);

		if(count($this->data['post']) == 0)
		{
			$this->data['post']['description'] = "Updating...";
		}

		$this->data['post']['description'] = html_entity_decode($this->data['post']['description']);

		$this->id="information";
		$this->template="module/information.tpl";
		$this->render();
	}
}
?>