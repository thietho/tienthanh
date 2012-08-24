<?php
class ControllerCommonDate extends Controller
{
	public function getMonthToDay()
	{
		$thang = $this->request->get['month'];
		$nam = $this->request->get['year'];
		$startdate = $nam."-".$this->date->numberFormate($thang)."-"."01";
		$m_thang = $thang;
		$enddate = "";
		$days = 1;
		do
		{
			$temp = $this->date->addday($startdate,$days);
			$m_thang = $this->date->getMonth($temp);
			if($m_thang == $thang)
				$enddate = $temp;
			$days++;
		}
		while($m_thang == $thang);
		$arr = array(
					'startdate' => $this->date->formatMySQLDate($startdate),
					'enddate' => $this->date->formatMySQLDate($enddate)
					);
		$this->data['output'] = json_encode($arr);
		$this->id="country";
		$this->template="common/output.tpl";
		$this->render();
	}

}
?>