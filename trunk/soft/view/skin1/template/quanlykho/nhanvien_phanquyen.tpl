<script type="text/javascript">
$(document).ready(function(e) {
    $("#group0").treeview();

	arr = new Array();
	
	<?php 
	foreach($permission as $val)
		echo "arr.push('".$val."');";
	?>	
	
	$('.permission').each(function(index, element) {
        if(arr.indexOf(this.value)!=-1)
			this.checked = true;
    });
});

function save()
{
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=quanlykho/nhanvien/savePermission", $("#frmphanquyen").serialize(),
		function(data){
			if(data == "true")
			{
				
				
			}
			else
			{
			
				
				
			}
			
		}
	);
}
</script>
<div class="section">

	<div class="section-title">Quản lý module</div>
    
    <div class="section-content">
    	<!--<div id="idcur"></div>
    	<div id="drag"></div>
        <div id="drop"></div>-->
        <form action="" method="post" id="frmphanquyen" name="frmphanquyen">
        
        	<div class="button right">
            	
                <a class="button save" onclick="save()">Lưu</a>
                <input type="hidden" name="nhanvienid" value="<?php echo $nhanvien['id']?>">
                
            </div>
            <div class="clearer">^&nbsp;</div>
            
            <div>
                <ul id="group0" class="filetree">
                	<?php echo $treemodule?>
                </ul>
            </div>
        	
        
        </form>
        
    </div>
    
</div>