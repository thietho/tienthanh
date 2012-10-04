<script src='<?php echo DIR_JS?>ui.datepicker.js' type='text/javascript' language='javascript'> </script>
<div class="section" id="sitemaplist">

	<div class="section-title">Tài sản</div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        	<input type="hidden" id="selecttaisan">
        	<div class="button right">
            	<input type="button" value="Save" class="button" onClick="save()"/>
     	        <input type="button" value="Cancel" class="button" onclick="linkto('?route=quanlykho/taisan/sotaisan')"/>   
     	        <input type="hidden" name="id" value="<?php echo $item['id']?>">
                
                <input type="hidden" id="manhanvien" name="manhanvien" />
                <input type="hidden" id="nguoitra" name="nguoitra" value="<?php echo $item['nguoitra']?>" />
               	<input type="hidden" id="ngaytra" name="ngaytra" value="<?php echo $item['ngaytra']?>" />
                <textarea name="ghichutra" style="display:none"><?php echo $item['ghichutra']?></textarea>
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
        	<div>
            	<p>
            		<label>Tài sản</label><br />
					<input type="hidden" id="mataisan" name="mataisan" value="<?php echo $item['mataisan']?>" class="text" size=60 <?php echo $readonly?>/>
                    <span id="tentaisan"></span>
                    <input type="button" class="button" name="btnChonTaiSan" value="Chọn tài sản" onClick="selcetTaiSan()">
                    <input type="button" class="button" name="btnChonTaiSan" value="Bỏ chọn" onClick="unSelcetTaiSan()">
            	</p>
                <p>
            		<label>Phòng ban</label><br />
					<select id="phongbannhan" name="phongbannhan">
                    	<option value=""></option>
                    	<?php foreach($phongban as $val){ ?>
                        <option value="<?php echo $val['maphongban']?>"><?php echo $val['tenphongban']?></option>
                        <?php } ?>
                    </select>
            	</p>
                <p>
                    <label>Ngày cấp</label><br />
<script language="javascript">
$(function() {
    $("#ngaynhan").datepicker({
            changeMonth: true,
            changeYear: true,
            dateFormat: 'dd-mm-yy'
            });
    });
</script>
                    <input type="text" id="ngaynhan" name="ngaynhan" value="<?php echo $this->date->formatMySQLDate($item['ngaynhan'])?>" class="text" size=60 />
                </p>
                <p>
                    <label>Người đề xuất</label><br />
                    <input type="hidden" id="nguoidexuat" name="nguoidexuat" value="<?php echo $item['nguoidexuat']?>" />
                    <input type="text" id="tennguoidexuat" name="tennguoidexuat" value="" class="text" size=60 readonly="readonly" />
                    <input type="button" class="button" name="btnChonNguoiDeXuat" value="Chọn người đề xuất" onclick="selectNguoiDeXuat()" />
                    <input type="button" class="button" name="btnChonNguoiDeXuat" value="Bỏ chọn" onclick="unSelectNguoiDeXuat()"/>
                </p>
                <p>
                    <label>Người nhận</label><br />
                    <input type="hidden" id="nguoinhan" name="nguoinhan"  value="<?php echo $item['nguoinhan']?>"/>
                    <input type="text" id="tennguoinhan" name="tennguoinhan" class="text" size=60 readonly="readonly" />
                    <input type="button" class="button" name="btnChonNguoiNhan" value="Chọn người nhận" onclick="selectNguoiNhan()" />
                    <input type="button" class="button" name="btnChonNguoiMhan" value="Bỏ chọn" onclick="unSelectNguoiNhan()"/>
                </p>
                
                <p>
            		<label>Ghi chú</label><br />
					<textarea id="ghichu" name="ghichu"><?php echo $item['ghichu']?></textarea>
            	</p>
               
               
               
            </div>
            
        </form>
    
    </div>
    
</div>
<script language="javascript">
function save()
{
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=quanlykho/taisan/savecaptaisan", $("#frm").serialize(),
		function(data){
			if(data == "true")
			{
				window.location = "?route=quanlykho/taisan/sotaisan";
			}
			else
			{
			
				$('#error').html(data).show('slow');
				$.unblockUI();
				
			}
			
		}
	);
}

$("#phongbannhan").val("<?php echo $item['phongbannhan']?>");
getTaiSan("id","<?php echo $item['mataisan']?>",'');
getNguoiDeXuat("id","<?php echo $item['nguoidexuat']?>",'');
getNguoiNhan("id","<?php echo $item['nguoinhan']?>",'');

function getTaiSan(col,val,operator)
{
	$.getJSON("?route=quanlykho/taisan/getTaiSan&col="+col+"&val="+val+"&operator="+operator, 
			function(data) 
			{
				
				for( i in data.taisans)
				{
					$("#mataisan").val(data.taisans[i].id);
					$("#tentaisan").html(data.taisans[i].tentaisan);
				}
				
			});
}

function selcetTaiSan()
{
	openDialog("?route=quanlykho/taisan&opendialog=true",1000,800);
	
	list = trim($("#selecttaisan").val(), ',');
	
	arr = list.split(",");
	mataisan = arr[0];
	getTaiSan("id",mataisan,'');
}

function unSelcetTaiSan()
{
	$("#mataisan").val("");
	$("#tentaisan").html("");
}

function getNguoiDeXuat(col,val,operator)
{
	$.getJSON("?route=quanlykho/nhanvien/getNhanVien&col="+col+"&val="+val+"&operator="+operator, 
			function(data) 
			{
				
				for( i in data.nhanviens)
				{
					$("#nguoidexuat").val(data.nhanviens[i].id);
					$("#tennguoidexuat").val(data.nhanviens[i].hoten);
				}
				
			});
}

function selectNguoiDeXuat()
{
	openDialog("?route=quanlykho/nhanvien&opendialog=true",1000,800);
	
	list = trim($("#manhanvien").val(), ',');
	
	arr = list.split(",");
	mataisan = arr[0];
	getNguoiDeXuat("id",mataisan,'');
}

function unSelectNguoiDeXuat()
{
	$("#nguoidexuat").val("");
	$("#tennguoidexuat").val("");
}

function getNguoiNhan(col,val,operator)
{
	$.getJSON("?route=quanlykho/nhanvien/getNhanVien&col="+col+"&val="+val+"&operator="+operator, 
			function(data) 
			{
				
				for( i in data.nhanviens)
				{
					$("#nguoinhan").val(data.nhanviens[i].id);
					$("#tennguoinhan").val(data.nhanviens[i].hoten);
				}
				
			});
}

function selectNguoiNhan()
{
	openDialog("?route=quanlykho/nhanvien&opendialog=true",1000,800);
	
	list = trim($("#manhanvien").val(), ',');
	
	arr = list.split(",");
	mataisan = arr[0];
	getNguoiNhan("id",mataisan,'');
}

function unSelectNguoiNhan()
{
	$("#nguoinhan").val("");
	$("#tennguoinhan").val("");
}
</script>
