<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	<input type="button" value="Lưu" class="button" onClick="save()"/>
     	        <input type="button" value="Bỏ qua" class="button" onclick="linkto('?route=quanlykho/phongban')"/>
     	        <input type="hidden" name="maphongban" value="<?php echo $item['maphongban']?>" />
                <input type="hidden" id="permission" name="permission" value="<?php echo $item['permission']?>"/>
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
        	<div>
                <p>
            		<label>Tên phòng ban</label>
					<?php echo $item['tenphongban']?>
            	</p>
               
                <p>
                    <input type="checkbox"  class="checkbox" onclick="$('input').attr('checked', this.checked);" value=""/> All
                    <div>
                        <h2>Modules quản lý tài liệu</h2>
                        <?php foreach($sitemaps as $item){ ?>
                        <p>
                            <label><?php echo $item['prefix']?><?php echo $item['sitemapname']?></label><br />
                            <?php $index = 1; ?>
                            <?php foreach($listPermission as $key => $val){ ?>
                                <?php 
                                if($index == 1)
                                {
                                ?>
                            <input type="checkbox" class="<?php echo $item['sitemapid']?> checkbox"  name="<?php echo $item['sitemapid']?>[<?php echo $key?>]" value="<?php echo $item['sitemapid']?>-<?php echo $key?>"/> <?php echo $val?>
                                <?php
                                }
                                else
                                {
                                ?>
                            <input type="checkbox" style="display:none" class="<?php echo $item['sitemapid']?> checkbox"  name="<?php echo $item['sitemapid']?>[<?php echo $key?>]" value="<?php echo $item['sitemapid']?>-<?php echo $key?>"/>    
                                <?php 
                                }
                                 $index += 1;
                                ?>
                            <?php } ?>
                        </p>
                        <?php } ?>
                        <h2>Modules quản lý kho</h2>
                        <?php foreach($modulesquanlykho as $k => $item)
                           { 
                                $cls = str_replace("/","",$k);
                        ?>
                        <p>
                            <label><?php echo $item?></label> <br />
                            <?php $index = 1; ?>
                            <?php foreach($listPermission as $key => $val)
                            { 
                                if($index == 1)
                                {
                            ?>
                                <input type="checkbox" class="module<?php echo $cls?> checkbox" name="<?php echo $k?>[<?php echo $key?>]" value="<?php echo $k?>-<?php echo $key?>"/> <?php echo $val?>
                            <?php
                                }
                                else
                                {
                            ?>
                                <input type="checkbox" style="display:none" class="module<?php echo $cls?> checkbox" name="<?php echo $k?>[<?php echo $key?>]" value="<?php echo $k?>-<?php echo $key?>"/>
                            <?php 
                                } 
                                
                                $index += 1;
                            ?>
                                
                            <?php 
                            } 
                            $index = 1;
                            ?>
                            
                        </p>
                        <?php } ?>
                    </div>
                    
                </p>
               
            </div>
            
        </form>
    
    </div>
    
</div>
<script language="javascript">


function save()
{
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=quanlykho/phongban/savePermission", $("#frm").serialize(),
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
$(document).ready(function() {
	$(".checkbox").each(function(){
		var myMatch = $("#permission").val().search($(this).val());
		if(myMatch > 0)
		{
			this.checked = true;	
		}
		else
		{
			this.checked = false;	
		}
	})
	
	$(".checkbox").click(function(){
		var access = $(this).attr("name");	
		
		
		var str = access.split('[')[0];
		$("input[name*='"+str+"']").attr('checked', this.checked);
		
		$("#permission").val('');
		$(".checkbox").each(function(){
			
			if(this.checked == true && $(this).val()!="")
			{
				var temp = $("#permission").val() + "["+$(this).val()+"]";
				$("#permission").val(temp);
			}
			
		})
	});
});

</script>
