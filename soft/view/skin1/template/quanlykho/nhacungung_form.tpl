
<div class="section" id="sitemaplist">

	<div class="section-title">Nhà cung ứng</div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	<input type="button" value="Save" class="button" onClick="save()"/>
     	        <input type="button" value="Cancel" class="button" onclick="linkto('?route=quanlykho/nhacungung')"/>   
     	        <input type="hidden" name="id" value="<?php echo $item['id']?>">
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
            <div id="container">
        	
            
                <ul>
                    <li><a href="#fragment-thongtin"><span>Thông tin nhà cung ứng</span></a></li>
                    <li><a href="#fragment-danhgia"><span>Đánh giá</span></a></li>
                    
                    
                </ul>
                <div id="fragment-thongtin">
                    <p>
                        <label>Mã nhà cung ứng</label><br />
                        <input type="text" id="manhacungung" name="manhacungung" value="<?php echo $item['manhacungung']?>" class="text" size=60 <?php echo $readonly?>/>
                        
                    </p>
                    
                    
                    <p>
                        <label>Tên nhà cung ứng</label><br />
                        <input type="text" id="tennhacungung" name="tennhacungung" value="<?php echo $item['tennhacungung']?>" class="text" size=60 />
                    </p>
                   <p>
                        <label>Địa chỉ</label><br />
                        <input type="text" id="diachi" name="diachi" value="<?php echo $item['diachi']?>" class="text" size=60 />
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
                        <label>Nhóm</label><br />
                        <select id="manhom" name="manhom">
                            <option value=""></option>
                            <?php foreach($nhomnhacungung as $val){ ?>
                            <option value="<?php echo $val['manhom']?>"><?php echo $this->string->getPrefix("&nbsp;&nbsp;&nbsp;",$val['level']-1)?><?php echo $val['tennhom']?></option>
                            <?php } ?>
                        </select>
                    </p>
                    <p>
                        <label>Mặt hàng/dịch vụ</label><br />
                        <input type="text" id="nganhnghe" name="nganhnghe" value="<?php echo $item['nganhnghe']?>" class="text" size=60 />
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
                        <label>Tên người dại diện</label><br />
                        <input type="text" id="tennguoidungdau" name="tennguoidungdau" value="<?php echo $item['tennguoidungdau']?>" class="text" size=60 />
                    </p>
                    <p>
                        <label>Ngày bắt đầu giao dịch</label><br />
<script language="javascript">
 	$(function() {
		$("#ngaybatdaugiaodich").datepicker({
				changeMonth: true,
				changeYear: true,
				dateFormat: 'dd-mm-yy'
				});
		});
 </script>
                        <input type="text" id="ngaybatdaugiaodich" name="ngaybatdaugiaodich" value="<?php echo $this->date->formatMySQLDate($item['ngaybatdaugiaodich'])?>" class="text" size=60 />
                    </p>
                    <p>
                        <label>Hiệu lực đến ngày</label><br />
<script language="javascript">
 	$(function() {
		$("#hieulucdenngay").datepicker({
				changeMonth: true,
				changeYear: true,
				dateFormat: 'dd-mm-yy'
				});
		});
 </script>
                        <input type="text" id="hieulucdenngay" name="hieulucdenngay" value="<?php echo $this->date->formatMySQLDate($item['hieulucdenngay'])?>" class="text" size=60 />
                    </p>
                    
                    
                    <p>
                        <label>Ghi chú</label><br />
                        <textarea id="ghichu" name="ghichu"><?php echo $item['ghichu']?></textarea>
                    </p>
                   
                   
                   
                </div>
                <div id="fragment-danhgia">
                	<p>
                        <label>Ngày đánh giá lại</label><br />
<script language="javascript">
 	$(function() {
		$("#ngaydanhgialai").datepicker({
				changeMonth: true,
				changeYear: true,
				dateFormat: 'dd-mm-yy'
				});
		});
 </script>
                        <input type="text" id="ngaydanhgialai" name="ngaydanhgialai" value="<?php echo $this->date->formatMySQLDate($item['ngaydanhgialai'])?>" class="text" size=60 />
                    </p>
                    <p>
                        <label>Về số lượng</label><br />
                        
                        <select id="danhgiasoluong" name="danhgiasoluong">
                        	<option value=""></option>
                        	<?php foreach($this->document->danhgia as $key => $val){ ?>
                            <option value="<?php echo $key?>"><?php echo $val?></option>
                            <?php } ?>
                        </select>
                    </p>
                    <p>
                        <label>Về chất lượng</label><br />
                        
                        <select id="danhgiachatluong" name="danhgiachatluong">
                        	<option value=""></option>
                        	<?php foreach($this->document->danhgia as $key => $val){ ?>
                            <option value="<?php echo $key?>"><?php echo $val?></option>
                            <?php } ?>
                        </select>
                    </p>
                    <p>
                        <label>Về thời gian cung ứng</label><br />
                        
                        <select id="danhgiathoigian" name="danhgiathoigian">
                        	<option value=""></option>
                        	<?php foreach($this->document->danhgia as $key => $val){ ?>
                            <option value="<?php echo $key?>"><?php echo $val?></option>
                            <?php } ?>
                        </select>
                    </p>
                    <p>
                        <label>Về thanh toán</label><br />
                        
                        <select id="danhgiathanhtoan" name="danhgiathanhtoan">
                        	<option value=""></option>
                        	<?php foreach($this->document->danhgia as $key => $val){ ?>
                            <option value="<?php echo $key?>"><?php echo $val?></option>
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
	
	$.post("?route=quanlykho/nhacungung/save", $("#frm").serialize(),
		function(data){
			if(data == "true")
			{
				window.location = "?route=quanlykho/nhacungung";
			}
			else
			{
			
				$('#error').html(data).show('slow');
				$.unblockUI();
				
			}
			
		}
	);
}

$("#manhom").val("<?php echo $item['manhom']?>");
$("#khuvuc").val("<?php echo $item['khuvuc']?>");
$("#danhgiasoluong").val("<?php echo $item['danhgiasoluong']?>");
$("#danhgiachatluong").val("<?php echo $item['danhgiachatluong']?>");
$("#danhgiathoigian").val("<?php echo $item['danhgiathoigian']?>");
$("#danhgiathanhtoan").val("<?php echo $item['danhgiathanhtoan']?>");

</script>
