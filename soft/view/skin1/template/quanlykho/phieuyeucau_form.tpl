
<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	<input type="button" value="Save" class="button" onClick="save()"/>
     	        <input type="button" value="Cancel" class="button" onclick="linkto('?route=quanlykho/phieuyeucau')"/>   
     	        <input type="hidden" name="maphieu" value="<?php echo $item['maphieu']?>">
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
            <div id="container">
                <ul>
                    <li><a href="#fragment-thongtin"><span>Thông tin phiếu yêu cầu</span></a></li>
                </ul>
                <div id="fragment-thongtin">
                	<div id="panelyeucau" style="display:''">
                    <p>
                        <label>Mã khách hàng</label><br />
                        <input type="hidden" id="makhachhang" name="makhachhang" value="<?php echo $item['makhachhang']?>" class="text" size=60 />
                        <input type="text" readonly id="makh" name="makh" value="<?php echo $item['makh']?>" class="text" size=60 />
                       	<input type="button" class="button" name="btnChonKhachHang" value="Chọn khách hàng" onClick="selectKhachHang()">
                    	<input type="button" class="button" name="btnChonKhachHang" value="Bỏ chọn" onClick="unSelectKhachHang()"> 
                    </p>
                    <p>
                    	<label>Tên khách hàng</label><br />
                        <input type="text" id="tenkhachhang" name="tenkhachhang" value="<?php echo $item['tenkhachhang']?>" class="text" size=60 readonly="<?php if($item['makhachhang'] != '') echo true; else echo false; ?>" />
                    </p>
                    <p>
                    	<label>Điện thoại liên lạc</label><br />
                        <input type="text" id="dienthoai" name="dienthoai" value="<?php echo $item['dienthoai']?>" class="text" size=60 />
                    </p>
                     <p>
                        <label>Ngày lập</label><br />
						<script language="javascript">
                            $(function() {
                                $("#ngaylap").datepicker({
                                        changeMonth: true,
                                        changeYear: true,
                                        dateFormat: 'dd-mm-yy'
                                        });
                                });
                         </script>
                        <input type="text" id="ngaylap" name="ngaylap" value="<?php echo $this->date->formatMySQLDate($item['ngaylap'])?>" class="text" size=60 />
                    </p>
                   	<p>
                        <label>Nhân viên tiếp nhận</label><br />
                        <input type="hidden" readonly id="nhanvientiepnhan" name="nhanvientiepnhan" value="<?php echo $item['nhanvientiepnhan']?>" class="text" size=60 />
                        <input type="text" readonly id="hoten" name="hoten" value="<?php echo $item['hoten']?>" class="text" size=60 />
                    </p>
                    <p>
                    	<label>Nội dung yêu cầu</label><br />
                        <textarea id="noidungyeucau" name="noidungyeucau" cols="60"><?php echo $item['noidungyeucau'] ?></textarea>	
                    </p>
                   	<p>
                    	<label>Hình thức xử lý</label><br />
                        <input type="text" id="hinhthuc" name="hinhthuc" value="<?php echo $item['hinhthuc']?>" class="text" size=60 />
                    </p>
                     <p>
                        <label>Ngày hẹn phản hồi</label><br />
						<script language="javascript">
                            $(function() {
                                $("#ngayhen").datepicker({
                                        changeMonth: true,
                                        changeYear: true,
                                        dateFormat: 'dd-mm-yy'
                                        });
                                });
                         </script>
                        <input type="text" id="ngayhen" name="ngayhen" value="<?php echo $item['ngayhen'] ?>" class="text" size=60 />
                    </p>
                    </div>
                    <div id="panelphanhoi" style="display:''" >
                    <p>
                    	<label>Nhân viên xử lý</label><br/>
						<input type="hidden" id="nhanvienxuly" name="nhanvienxuly" value="<?php echo $item['nhanvienxuly']?>" class="text" size=60 />
                        <input type="text" id="nvxlhoten" name="nvxlhoten" readonly="readonly" value="<?php echo $item['nvxlhoten']?>" class="text" size=60 />
                    </p>
                    <p>
						<label>Nội dung phản hồi</label><br/>
						<textarea id="noidungphanhoi" name="noidungphanhoi" cols="60"><?php echo $item['noidungphanhoi'] ?></textarea>	
                    </p>
                    <p>
						<input type="hidden" id="trangthai" name="trangthai" value="<?php echo $item['trangthai']?>" class="text" size=60 />
                    </p>
                    </div>
                </div>
                
            </div>
                
            
        </form>
    
    </div>
    
</div>

<script language="javascript">
$(document).ready(function() { 
	
	$('#container').tabs({ fxSlide: true, fxFade: true, fxSpeed: 'slow' });
	
	var yeucau = "<?php echo $item['yeucau']; ?>";
	
	if(yeucau == 'yc')
	{
		$('#panelyeucau').attr('style', "display:''");
		$('#panelphanhoi').attr('style', 'display:none');
	}
	else
	{
		$('#panelyeucau').attr('style', 'display:none');
		$('#panelphanhoi').attr('style', "display:''");
	}
	
});
function save()
{
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=quanlykho/phieuyeucau/save", $("#frm").serialize(),
		function(data){
			if(data == "true")
			{
				window.location = "?route=quanlykho/phieuyeucau";
			}
			else
			{
			
				$('#error').html(data).show('slow');
				$.unblockUI();
				
			}
			
		}
	);
}

function getKhachHang(col,val,operator)
{
	$.getJSON("?route=quanlykho/khachhang/getKhachHang&col="+col+"&val="+val+"&operator="+operator, 
			function(data) 
			{
				//var str = '<option value=""></option>';
				for( i in data.khachhangs)
				{
					
					$("#makhachhang").val(data.khachhangs[i].id);
					$("#makh").val(data.khachhangs[i].makhachhang);
					$("#tenkhachhang").val(data.khachhangs[i].hoten);
					$("#dienthoai").val(data.khachhangs[i].dienthoai);
				}
				
			});
}

function selectKhachHang()
{
	openDialog("?route=quanlykho/khachhang&opendialog=true",1000,800);
	
	list = trim($("#makhachhang").val(), ',');
	arr = list.split(",");
	makhachhang = arr[0];
	getKhachHang("id",makhachhang,'');
	
	document.getElementById("tenkhachhang").readOnly = true;
}

function unSelectKhachHang()
{
	if($("#makh").val().length > 0)
	{
		$("#makhachhang").val("");
		$("#makh").val("");
		$("#tenkhachhang").val("");
		$("#dienthoai").val("");
		document.getElementById("tenkhachhang").readOnly = false;
	}
}
</script>
