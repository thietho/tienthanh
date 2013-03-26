<script type="text/javascript">
$(document).ready(function(e) {
	var CLASSES = ($.treeview.classes = {
		open: "open",
		//closed: "closed",
		expandable: "expandable",
		expandableHitarea: "expandable-hitarea",
		lastExpandableHitarea: "lastExpandable-hitarea",
		collapsable: "collapsable",
		collapsableHitarea: "collapsable-hitarea",
		lastCollapsableHitarea: "lastCollapsable-hitarea",
		lastCollapsable: "lastCollapsable",
		lastExpandable: "lastExpandable",
		last: "last",
		hitarea: "hitarea"
	});
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
	
	$('.permission').click(function(e) {
        var flag = this.checked;
		if(flag == true)
		{
			var obj = $(this);
			while(obj.attr('parent')!=0)
			{
				var objparent = document.getElementById('per'+obj.attr('parent'));
				objparent.checked = flag;
				obj = $('#per'+obj.attr('parent'));
			}			
		}
		else
		{
			//Bo check tat ca module con
			var obj = $(this);
			unchecked(obj);
		}
    });
});

function unchecked(obj)
{
	var id = obj.attr('id').replace('per','');
	$('.permission').each(function(index, element) {
        if($(this).attr('parent') == id)
		{
			this.checked = false;
			unchecked($(this));
		}
    });
}

function save()
{
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=quanlykho/nhanvien/savePermission", $("#frmphanquyen").serialize(),
		function(data){
			if(data == "true")
			{
				alert('Cập nhật phân quyền thành công');
				window.location = '?route=quanlykho/nhanvien';
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
                <a class="button cancel" href="?route=quanlykho/nhanvien">Trở về</a>
                <input type="hidden" name="nhanvienid" value="<?php echo $nhanvien['id']?>">
                
            </div>
            <div class="clearer">^&nbsp;</div>
            
            <div>
            	<p>
                	<label>Tên nhân viên</label> <?php echo $nhanvien['hoten']?>
                </p>
                <p>
                	<label>Loại tài khoản</label> <?php echo $this->document->getUserType($this->document->getUser($nhanvien['username'],'usertypeid'))?>
                </p>
                
				
                <ul id="group0" class="filetree">
                	<?php echo $treemodule?>
                </ul>
            </div>
        	
        
        </form>
        
    </div>
    
</div>