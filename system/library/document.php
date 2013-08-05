<?php
final class Document {
	public $title = "MUABANXE.US";
	public $description;
	public $base;	
	public $charset = 'utf-8';		
	public $language = 'vi';	
	public $direction = 'ltr';		
	public $links = array();		
	public $styles = array();
	public $scripts = array();
	public $breadcrumbs = array();
	public $sitemapid = '';
	public $media = array();
	public $meta_description = '';
	public $status = array(
						   'deleted' => "Xóa",
						   'empty' => "Hết hàng",
						   );
	
	public $xuly = array(
						 'pending' => "Chờ xử lý",
						 'completed' => "Đã xử lý",
						 'closed' => "Đóng",
						 'deleted' => "Xóa"
						 );
	
	public $danhgia = array(
						   
						   '5' => "Tốt",
						   '4' => "Khá",
						   '3' => "Trung bình",
						   '2' => "Yếu",
						   '1' => "Kém"
						   );
	public $chatluong = array(
							'A' => "A - Đạt",
							'B' => "B - Xem xét lại",
							'C' => "C - Loại"
							);
	public $nghiemthu = array(
							'' => "Chưa nghiệm thu",
							'nghieuthu' => "Nghiệm thu",
							'khongdongy' => 'Không đồng ý'
							);
	public $tinhtrangnghiemthu = array(
										''=>'',
										'toanbo' => 'Toàn bộ',
										'motphan' => 'Một phần'
										);
	
	public $gioitinh = array(
							'male' => "Nam",
							'female' => "Nữ"
							);
	
	
	public $loaiphieu = array(
							  "pkn" => "Phiếu khiếu nại",
							  "pyc" => "Phiếu yêu cầu"
							  );
	public $loainguonxuatnhap = array(
							"xuatvattucosan" => "Xuất vật tư có sản"
								);
	
	public $hienhanh = array(
							 "0" => "Chưa hiện hành",
							 "1" => "Hiện hành"
							 );
	public $thanhtoan = array(
							  "dathanhtoan" => "Đã thanh toán",
							  "chuathanhtoan" => "Chưa thanh toán"
							  );
	
	public $loainguonxuat = array(
								  "xuatdoinoi" => "Xuất đối nội",
								  "xuatdoingoia" => "Xuất đối ngoại",
								  "tamxuattainhap" => "Tạm xuất tái nhập"
								  );
	
	public $loainguon = array(
								  "nhapdoinoi" => "Nhập đối nội",
								  "nhapdoingoai" => "Nhập đối ngoại",
								  "tamnhaptaixuat" => "Tạm nhập tái xuất"
								  );
	public $dauvao = array(
							"nguyenlieu" => "Nguyên liệu",
							"vattu" => "Vật tư",
							"linhkien" => "Linh kiện"
							
						);
	
	public $text = array();
	public $setting = array();
	private $filepath;
	public function __construct() 
	{
		$this->db = Registry::get('db');
		
		$this->language = Registry::get('language');
		$this->text = $this->language->getData();
		
		$this->filepath = DIR_FILE."db/setting.json";
		$this->createDB();
		$this->getData();
	}
	
	public function getTenNhom($manhom)
	{
		$query = $this->db->query("Select `qlknhom`.* 
									from `qlknhom` 
									where manhom ='".$manhom."' ");
		return $query->row['tennhom'];	
	}
	
	public function getNhom($manhom,$name = 'tennhom')
	{
		$query = $this->db->query("Select `qlknhom`.* 
									from `qlknhom` 
									where manhom ='".$manhom."' ");
		return $query->row[$name];	
	}
	
	public function getModule($id,$name = 'modulename')
	{
		$query = $this->db->query("Select `module`.* 
									from `module` 
									where id ='".$id."' ");
		return $query->row[$name];	
	}
	public function getModuleId($moduleid,$name = 'modulename')
	{
		$query = $this->db->query("Select `module`.* 
									from `module` 
									where moduleid ='".$moduleid."' ");
		return $query->row[$name];	
	}
	public function getTenDonVi($madonvi)
	{
		$query = $this->db->query("Select `qlkdonvitinh`.* 
									from `qlkdonvitinh` 
									where madonvi ='".$madonvi."' ");
		return $query->row['tendonvitinh'];	
	}
	
	public function getDonViTinh($madonvi,$name="tendonvitinh")
	{
		$query = $this->db->query("Select `qlkdonvitinh`.* 
									from `qlkdonvitinh` 
									where madonvi ='".$madonvi."' ");
		return $query->row[$name];	
	}
	
	public function getSanPham($id,$name = 'tensanpham')
	{
		$sql = "Select `qlksanpham`.* 
									from `qlksanpham` 
									where id ='".$id."' ";
		$query = $this->db->query($sql);
		return $query->row[$name];
	}
	
	public function getLinhKien($id,$name = 'tenlinhkien')
	{
		$sql = "Select `qlklinhkien`.* 
									from `qlklinhkien` 
									where id ='".$id."' ";
		$query = $this->db->query($sql);
		return $query->row[$name];
	}
	
	public function getNguyenLieu($id,$name = 'tennguyenlieu')
	{
		$sql = "Select `qlknguyenlieu`.* 
									from `qlknguyenlieu` 
									where id ='".$id."' ";
		$query = $this->db->query($sql);
		return $query->row[$name];
	}
	
	public function getCongDoan($id,$name = 'tencongdoan')
	{
		$sql = "Select `qlkcongdoan`.* 
									from `qlkcongdoan` 
									where id ='".$id."' ";
		$query = $this->db->query($sql);
		return $query->row[$name];
	}
	
	public function getNhaCungUng($id,$name = 'tennhacungung')
	{
		$sql = "Select `qlknhacungung`.* 
									from `qlknhacungung` 
									where id ='".$id."' ";
		$query = $this->db->query($sql);
		return $query->row[$name];
	}
	
	public function getNhanVien($id,$name = 'hoten')
	{
		$sql = "Select `qlknhanvien`.* 
									from `qlknhanvien` 
									where id ='".$id."' ";
		$query = $this->db->query($sql);
		return $query->row[$name];
	}
	
	
	public function getUserType($usertypeid,$name = 'usertypename')
	{
		$sql = "Select `usertype`.* 
									from `usertype` 
									where usertypeid ='".$usertypeid."' ";
		$query = $this->db->query($sql);
		return $query->row[$name];
	}
	
	public function getUser($userid,$name = 'fullname')
	{
		$sql = "Select `user`.* 
									from `user` 
									where userid ='".$userid."' ";
		$query = $this->db->query($sql);
		return $query->row[$name];
	}
	public function getPhieuNhapXuat($id,$name = 'maphieu')
	{
		$sql = "Select `qlkphieunhapxuat`.* 
									from `qlkphieunhapxuat` 
									where id ='".$id."' ";
		$query = $this->db->query($sql);
		return $query->row[$name];
	}
	
	private function createDB()
	{
		$arr = array();
		if(!is_dir(DIR_FILE."db"))
			mkdir(DIR_FILE."db");
		
		if(!is_file($this->filepath))
		{
			
			$fp = fopen($this->filepath, 'w');
			fwrite($fp, '');
			fclose($fp);	
		}
	}
	
	private function getData()
	{
		$filename = $this->filepath;
		$handle = fopen($filename, "r");
		@$contents = fread($handle, filesize($filename));
		fclose($handle);
		$this->setting = json_decode($contents);
		
	}
	
	public function setValue($key,$value)
	{
		$this->setting->$key = $value;
		$this->saveData();
	}
	
	private function saveData()
	{
		$str = json_encode($this->setting);
		$fp = fopen($this->filepath, 'w');
		fwrite($fp, $str);
		fclose($fp);
	}
	
}
?>