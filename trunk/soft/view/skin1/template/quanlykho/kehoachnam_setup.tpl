<script src='<?php echo DIR_JS?>ui.datepicker.js' type='text/javascript' language='javascript'> </script>
<div class="section" id="sitemaplist">

	<div class="section-title">Kê hoạch năm</div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	<input type="button" value="Save" class="button" onClick="save()"/>
     	        <input type="button" value="Cancel" class="button" onclick="linkto('?route=quanlykho/kehoachnam')"/>   
     	        <input type="hidden" name="id" value="<?php echo $item['id']?>">
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
        	<div>
            	<p>
            		<label>Năm:</label><?php echo $item['nam']?>
					
                    
            	</p>
                <p>
            		<label>Ghi chú</label><br />
					<?php echo $item['ghichu']?>
            	</p>
               	<div id="listkehoachsanpham">
                </div>
                	
               
               
            </div>
            
        </form>
    
    </div>
    
</div>
<script language="javascript">
$('#listkehoachsanpham').load("?route=quanlykho/kehoachnam/loadKehoachSanPham&id=<?php echo $item['id']?>");
function save()
{
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=quanlykho/kehoachnam/save", $("#frm").serialize(),
		function(data){
			var arr = data.split('-');
			if(arr[0] == "true")
			{
				window.location = "?route=quanlykho/kehoachnam/update&id="+ arr[1];
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
