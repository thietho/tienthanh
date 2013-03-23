
<div class="section" id="sitemaplist">

	<div class="section-title">Khách hàng</div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	<input type="button" value="Lưu" class="button" onClick="save()"/>
     	        <input type="button" value="Bỏ qua" class="button" onclick="linkto('?route=quanlykho/khachhang')"/>   
     	        <input type="hidden" name="id" value="<?php echo $item['id']?>">
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
            <div id="container">
        	
                <ul>
                    <li><a href="#fragment-thongtin"><span>Thông tin khách hàng</span></a></li>
                </ul>
                <div id="fragment-thongtin">
                    <p>
                        <label>Mã khách hàng</label><br />
                        <input type="text" id="makhachhang" name="makhachhang" value="<?php echo $item['makhachhang']?>" class="text" size=60 <?php echo $readonly?>/>
                        
                    </p>                    
                    <p>
                        <label>Họ tên</label><br />
                        <input type="text" id="hoten" name="hoten" value="<?php echo $item['hoten']?>" class="text" size=60 />
                    </p>
                    <p>
                        <label>Địa chỉ</label><br />
                        <input type="text" id="diachi" name="diachi" value="<?php echo $item['diachi']?>" class="text" size=60 />
                    </p>
                     <p>
                        <input type="hidden" id="nhom" name="nhom" value="" class="text" size=60 />
                    </p>
                   <p>
                        <label>Khu vực</label><br />
                        <select id="khuvuc" name="khuvuc">
                            <option value=""></option>
                            <?php foreach($khuvuc as $val){ ?>
                            <option value="<?php echo $val['manhom']?>"><?php echo $this->string->getPrefix("&nbsp;&nbsp;&nbsp;&nbsp;",$val['level']-1)?><?php echo $val['tennhom']?></option>
                            <?php } ?>
                        </select>
                    </p>
                    <p>
                        <label>Điện thoại</label><br />
                        <input type="text" id="dienthoai" name="dienthoai" value="<?php echo $item['dienthoai']?>" class="text" size=60 />
                    </p>
                    
                    <p>
                        <label>Fax</label><br />
                        <input type="text" id="fax" name="fax" value="<?php echo $item['fax']?>" class="text" size=60 />
                    </p>
                    
                      <p>
                        <label>Người đại diện</label><br />
                        <input type="text" id="nguoidaidien" name="nguoidaidien" value="<?php echo $item['nguoidaidien']?>" class="text" size=60 />
                    </p>
                    <p>
                    	<label>Loại khách hàng</label>
                        <select id="loaikhachhang" name="loaikhachhang">
                            <option value=""></option>
                            <?php foreach($loaikhachhang as $val){ ?>
                            <option value="<?php echo $val['manhom']?>"><?php echo $this->string->getPrefix("&nbsp;&nbsp;&nbsp;&nbsp;",$val['level']-1)?><?php echo $val['tennhom']?></option>
                            <?php } ?>
                        </select>
                        
                    </p>
                    
                   
                </div>
                
            </div>
                
            
        </form>
    
    </div>
    
</div>

<script language="javascript">
$(document).ready(function() { 
	
	$('#container').tabs({ fxSlide: true, fxFade: true, fxSpeed: 'slow' });
	
});
function save()
{
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=quanlykho/khachhang/save", $("#frm").serialize(),
		function(data){
			if(data == "true")
			{
				window.location = "?route=quanlykho/khachhang";
			}
			else
			{
			
				$('#error').html(data).show('slow');
				$.unblockUI();
				
			}
			
		}
	);
}

$("#khuvuc").val("<?php echo $item['khuvuc']?>");
$("#loaikhachhang").val("<?php echo $item['loaikhachhang']?>");
</script>
