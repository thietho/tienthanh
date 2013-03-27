
<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        	<input type="hidden" id="selecttaisan">
        	<div class="button right">
            	<input type="button" value="Save" class="button" onClick="save()"/>
     	        <input type="button" value="Cancel" class="button" onclick="linkto('?route=quanlykho/taisan/sotaisan')"/>   
     	        <input type="hidden" name="id" value="<?php echo $item['id']?>">
                
                <input type="hidden" id="manhanvien" name="manhanvien" />
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
        	<div>
            	<p>
            		<label>Tài sản</label> <?php echo $item['tentaisan']?><br />
					
                    
            	</p>
                <p>
            		<label>Phòng ban</label> <?php echo $item['tenphongbannhan']?><br />
					
            	</p>
                <p>
                    <label>Ngày cấp</label> <?php echo $this->date->formatMySQLDate($item['ngaynhan'])?><br />
                    
                </p>
                <p>
                    <label>Người đề xuất</label> <?php echo $item['tennguoidexuat']?><br />
                    
                    
                </p>
                <p>
                    <label>Người nhận</label> <?php echo $item['tennguoinhan']?><br />
                    
                   
                </p>
                
                <p>
            		<label>Ghi chú</label> <?php echo $item['ghichu']?><br />
            	</p>
               	<p>
                    <label>Ngày trả</label><br />
<script language="javascript">
$(function() {
    $("#ngaytra").datepicker({
            changeMonth: true,
            changeYear: true,
            dateFormat: 'dd-mm-yy'
            });
    });
</script>
                    <input type="text" id="ngaytra" name="ngaytra" value="<?php echo $this->date->formatMySQLDate($item['ngaytra'])?>" class="text" size=60 />
                </p>
              	<p>
                    <label>Người trả</label><br />
                    <input type="hidden" id="nguoitra" name="nguoitra" value="<?php echo $item['nguoitra']?>" />
                    <input type="text" id="tennguoitra" name="tennguoitra" value="" class="text" size=60 readonly="readonly" />
                    <input type="button" class="button" name="btnChonNguoiTra" value="Chọn người trả" onclick="selectNguoiTra()" />
                    <input type="button" class="button" name="btnChonNguoiTra" value="Bỏ chọn" onclick="unSelectNguoiTra()"/>
                </p>
               	<p>
            		<label>Ghi chú</label><br />
					<textarea id="ghichutra" name="ghichutra"><?php echo $item['ghichutra']?></textarea>
            	</p>
            </div>
            
        </form>
    
    </div>
    
</div>
<script language="javascript">
function save()
{
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=quanlykho/taisan/savetrataisan", $("#frm").serialize(),
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


getNguoiTra("id","<?php echo $item['nguoitra']?>",'');

function getNguoiTra(col,val,operator)
{
	$.getJSON("?route=quanlykho/nhanvien/getNhanVien&col="+col+"&val="+val+"&operator="+operator, 
			function(data) 
			{
				
				for( i in data.nhanviens)
				{
					$("#nguoitra").val(data.nhanviens[i].id);
					$("#tennguoitra").val(data.nhanviens[i].hoten);
				}
				
			});
}

function selectNguoiTra()
{
	openDialog("?route=quanlykho/nhanvien&opendialog=true",1000,800);
	
	list = trim($("#manhanvien").val(), ',');
	
	arr = list.split(",");
	manhanvien = arr[0];
	getNguoiTra("id",manhanvien,'');
}

function unSelectNguoiTra()
{
	$("#nguoitra").val("");
	$("#tennguoitra").val("");
}




</script>
