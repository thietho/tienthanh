<ul>
<div class="section" id="sitemaplist">

<div class="section-title"><?php echo $this->document->title?></div>

<div class="section-content padding1">

<form name="frm" id="frm" action="<?php echo $action?>" method="post"
	enctype="multipart/form-data">

<div class="button right"><input type="button" value="Save"
	class="button" onClick="save()" /> <input type="button" value="Cancel"
	class="button" onclick="linkto('?route=quanlykho/kehoachnam')" /> <input
	type="hidden" name="makehoach" value="<?php echo $item['id']?>"></div>
<div class="clearer">^&nbsp;</div>
<div id="error" class="error" style="display: none"></div>
<div>
<p><label>Năm:</label><?php echo $item['nam']?></p>
<?php if($item['quy']>0){ ?>
<p><label>Quý:</label><?php echo $item['quy']?></p>
<?php } ?>
<?php if($item['thang']>0){ ?>
<p><label>Tháng:</label><?php echo $item['thang']?></p>
<?php } ?>
<p><label>Ghi chú</label><br />
<?php echo $item['ghichu']?></p>
<div id="listkehoachsanpham"></div>



</div>

</form>

</div>

</div>
<script language="javascript">
$.blockUI({ message: "<h1>Please wait...</h1>" }); 
$('#listkehoachsanpham').load("?route=quanlykho/kehoachnam/loadKehoachSanPham&id=<?php echo $item['id']?>",function(){
		
		$.unblockUI();
		numberReady();
	});
function save()
{
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=quanlykho/kehoachnam/savechitietkehoach", $("#frm").serialize(),
		function(data){
			var arr = data.split('-');
			if(arr[0] == "true")
			{
				window.location = "?route=quanlykho/kehoachnam";
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
</ul>