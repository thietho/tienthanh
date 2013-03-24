<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	<input type="button" value="Lưu" class="button" onClick="save()"/>
     	        <input type="button" value="Bỏ qua" class="button" onclick="linkto('?route=quanlykho/kho')"/>   
     	        <input type="hidden" name="id" value="<?php echo $item['makho']?>" />
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
        	<div>
            	<p>
            		<label>Mã kho</label><br />
					<input type="text" name="makho" value="<?php echo $item['makho']?>" class="text" size=60 <?php echo $readonly?>/>
                    
            	</p>
                
                <p>
            		<label>Tên kho</label><br />
					<input type="text" name="tenkho" value="<?php echo $item['tenkho']?>" class="text" size=60 />
                    
            	</p>
               
                <p>
            		<label>Địa chỉ</label><br />
					<input type="text" name="diachi" value="<?php echo $item['diachi']?>" class="text" size=60 />
                    
            	</p>
               
                <p>
                    <label>Điện thoại</label><br />
                    <input type="text" name="dienthoai" value="<?php echo $item['dienthoai']?>" class="text" size=60 />
                    
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
	
	$.post("?route=quanlykho/kho/save", $("#frm").serialize(),
		function(data){
			if(data == "true")
			{
				window.location = "?route=quanlykho/kho";
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
