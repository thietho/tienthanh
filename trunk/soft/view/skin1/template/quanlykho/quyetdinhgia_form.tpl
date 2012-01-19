<script src='<?php echo DIR_JS?>ui.datepicker.js' type='text/javascript' language='javascript'> </script>
<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $heading_title?>Quyết định giá</div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	<input type="button" value="Save" class="button" onClick="save()"/>
     	        <input type="button" value="Cancel" class="button" onclick="linkto('?route=quanlykho/quyetdinhgia')"/>   
     	        <input type="hidden" name="id" value="<?php echo $item['id']?>">
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
            <div id="container">
                <ul class="tabs-nav">
                	<li class="tabs-selected"><a href="#fragment-thongtin"><span>Thông tin</span></a></li>
                    <li class="tabs"><a href="#fragment-linhkien"><span>Linh kiện</span></a></li>
                </ul>
    
                <div id="fragment-thongtin" class="tabs-container">
                    <p>
                        <label>Mã quyết định giá</label><br />
                        <input type="text" id="maquyetdinhgia" name="maquyetdinhgia" value="<?php echo $item['maquyetdinhgia']?>" class="text" size=60 <?php echo $readonly?>/>
                        
                    </p>
                    
                    
                    <p>
                        <label>Ngày ra quyết định</label><br />
                        <script language="javascript">
                            $(function() {
                                $("#ngayraquyetdinh").datepicker({
                                        changeMonth: true,
                                        changeYear: true,
                                        dateFormat: 'dd-mm-yy'
                                        });
                                });
                         </script>
                        <input type="text" id="ngayraquyetdinh" name="ngayraquyetdinh" value="<?php echo $item['ngayraquyetdinh']?>" class="text" size=60 />
                        
                    </p>
                   
                    <p>
                        <label>Người ra quyết định</label><br />
                        <input type="text" id="nguoiraquyetdinh" name="nguoiraquyetdinh" value="<?php echo $item['nguoiraquyetdinh']?>" class="text" size=60 />
                        
                    </p>
                    <p>
                        <label>Ghi chú</label><br />
                        <textarea id="ghichu" name="ghichu"><?php echo $item['ghichu']?></textarea>
                    </p>
                    
					
                </div>
                <div id="fragment-linhkien" class="tabs-container">
                	
                	
                
                </div>
			</div>
        	
            
        </form>
    
    </div>
    
</div>
<script src="<?php echo DIR_JS?>jquery.tabs.pack.js" type="text/javascript"></script>
<script language="javascript">
$(document).ready(function() {
	$('#container').tabs({ fxSlide: true, fxFade: true, fxSpeed: 'slow' });
});
function save()
{
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=quanlykho/quyetdinhgia/save", $("#frm").serialize(),
		function(data){
			if(data == "true")
			{
				window.location = "?route=quanlykho/quyetdinhgia";
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