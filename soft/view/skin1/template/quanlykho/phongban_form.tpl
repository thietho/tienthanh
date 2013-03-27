<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	<input type="button" value="Lưu" class="button" onClick="save()"/>
     	        <input type="button" value="Bỏ qua" class="button" onclick="linkto('?route=quanlykho/phongban')"/>
     	        <input type="hidden" name="id" value="<?php echo $item['maphongban']?>" />
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
        	<div>
            	<p>
            		<label>Mã phòng ban</label><br />
					<input type="text" name="maphongban" value="<?php echo $item['maphongban']?>" class="text" size=60 <?php echo $readonly?>/>
            	</p>
                <p>
            		<label>Tên phòng ban</label><br />
					<input type="text" name="tenphongban" value="<?php echo $item['tenphongban']?>" class="text" size=60 />
            	</p>
               
                <p>
                    <label>Ghi chú</label><br />
                    <textarea name="ghichu"><?php echo $item['ghichu']?></textarea>
                    
                </p>
               
            </div>
            
        </form>
    
    </div>
    
</div>
<script language="javascript">
function save()
{
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=quanlykho/phongban/save", $("#frm").serialize(),
		function(data){
			if(data == "true")
			{
				window.location = "?route=quanlykho/phongban";
			}
			else
			{
			
				$('#error').html(data).show('slow');
				$.unblockUI();
				
			}
			
		}
	);
}


</script>
