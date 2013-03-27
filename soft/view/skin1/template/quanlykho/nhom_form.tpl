<div class="section" id="sitemaplist">

<div class="section-title"><?php echo $this->document->title?></div>

<div class="section-content padding1">

<form name="frm" id="frm" action="<?php echo $action?>" method="post"
	enctype="multipart/form-data">

<div class="button right"><input type="button" value="Save"
	class="button" onClick="save()" /> <input type="button" value="Cancel"
	class="button" onclick="linkto('?route=quanlykho/nhom')" /> <input
	type="hidden" name="curmanhom" value="<?php echo $item['manhom']?>"></div>
<div class="clearer">^&nbsp;</div>
<div id="error" class="error" style="display: none"></div>
<div>
<p><label>Mã danh mục</label><br />
<input type="text" name="manhom" value="<?php echo $item['manhom']?>"
	class="text" size=60
	<?php if($item['manhom']!="") echo 'readonly="readonly"'?> /></p>
<p><label>Tên danh mục</label><br />
<input type="text" name="tennhom" value="<?php echo $item['tennhom']?>"
	class="text" size=60 /></p>
<p><label>Danh mục cha</label><br />
<select id="nhomcha" name="nhomcha">
<?php foreach($datas as $it){ ?>
	<option value="<?php echo $it['manhom']?>"><?php echo $this->string->getPrefix("&nbsp;&nbsp;&nbsp;&nbsp;",$it['level']) ?><?php echo $it['tennhom']?></option>
	<?php } ?>
</select></p>
<p><label>Ghi chú</label><br />
<textarea name="ghichu"><?php echo $item['ghichu']?></textarea></p>
</div>

</form>

</div>

</div>
	<?php
	$nhomcha =$item['nhomcha'];
	if($_GET['nhomcha'] !="")
	$nhomcha = $_GET['nhomcha'];

	?>
<script language="javascript">
function save()
{
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=quanlykho/nhom/save", $("#frm").serialize(),
		function(data){
			if(data == "true")
			{
				window.location = "?route=quanlykho/nhom";
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
	
	$("#nhomcha").val("<?php echo $nhomcha?>");
	
	
});

</script>
