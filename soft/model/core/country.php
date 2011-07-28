<?php
class ModelCoreCountry extends Model 
{
	public function getCountrys()
	{
		$query = $this->db->query("Select * from `country`");
		return $query->rows;
	}
	
	public function getCountry($countryid)
	{
		$query = $this->db->query("Select * from `country` where countryid = '".$countryid."'");
		return $query->row;
	}
	
	public function getCountryByCode2($code)
	{
		$sql = "Select * from `country` where iso_code_2 = '".$code."'";
		$query = $this->db->query($sql);
		return $query->row;
	}
	
	public function getZones($code)
	{
		$sql = "Select * from `zone` 
							Where countryid = (Select countryid from `country` Where iso_code_2='".$code."')";
		$query = $this->db->query($sql);
		return $query->rows;
	}
	
	public function getZone($zoneid)
	{
		$query = $this->db->query("Select * from `zone` where zoneid = '".$countryid."'");
		return $query->row;
	}	
}

?>