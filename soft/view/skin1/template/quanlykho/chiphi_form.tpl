<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $heading_title?>Danh mục chi phi</div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	<input type="button" value="Lưu" class="button" onClick="save()"/>
     	        <input type="button" value="Bỏ qua" class="button" onclick="linkto('?route=quanlykho/chiphi')"/>   
     	        
                <input type="hidden" name="id" value="<?php echo $item['machiphi']?>" />
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
        	<div>     
            	<p>
            		<label>Mã chi phí</label><br />
					<input type="text" name="machiphi" value="<?php echo $item['machiphi']?>" class="text" size=60 <?php echo $readonly?>/>
                    
            	</p>   
                <p>
            		<label>Tên chi phí</label><br />
					<input type="text" name="tenchiphi" value="<?php echo $item['tenchiphi']?>" class="text" size=60 />
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
	
	$.post("?route=quanlykho/chiphi/save", $("#frm").serialize(),
		function(data){
			if(data == "true")
			{
				window.location = "?route=quanlykho/chiphi";
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
