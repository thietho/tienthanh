<script src='<?php echo DIR_JS?>ui.datepicker.js' type='text/javascript'
	language='javascript'> </script>
<div class="section" id="sitemaplist">

<div class="section-title">Kê hoạch</div>

<div class="section-content padding1">

<form name="frm" id="frm" action="<?php echo $action?>" method="post"
	enctype="multipart/form-data">

<div class="button right"><input type="button" value="Save"
	class="button" onClick="save()" /> <input type="button" value="Cancel"
	class="button" onclick="linkto('?route=quanlykho/kehoachnam')" /> <input
	type="hidden" name="id" value="<?php echo $item['id']?>"></div>
<div class="clearer">^&nbsp;</div>
<div id="error" class="error" style="display: none"></div>
<div>
<p><label>Tên kế hoạch</label><br />
<input type="text" id="tenkehoach" name="tenkehoach" value="<?php echo $item['tenkehoach']?>"
	class="text" /></p>
	<p>
		<label>Ngày bắt đầu</label><br />
		<script language="javascript">
		 	$(function() {
				$("#ngaybatdau").datepicker({
						changeMonth: true,
						changeYear: true,
						dateFormat: 'dd-mm-yy'
						});
				});
		 </script>
		<input type="text" id="ngaybatdau" name="ngaybatdau" value="<?php echo $this->date->formatMySQLDate($item['ngaybatdau'])?>"
	class="text" />
	</p>
	<p>
		<label>Ngày kết thúc</label><br />
		<script language="javascript">
		 	$(function() {
				$("#ngayketthuc").datepicker({
						changeMonth: true,
						changeYear: true,
						dateFormat: 'dd-mm-yy'
						});
				});
		</script>
		<input type="text" id="ngayketthuc" name="ngayketthuc" value="<?php echo $this->date->formatMySQLDate($item['ngayketthuc'])?>"
	class="text" />
	</p>
<p><label>Ghi chú</label><br />
<textarea id="ghichu" name="ghichu"><?php echo $item['ghichu']?></textarea>
</p>



</div>

</form>

</div>

</div>
<script language="javascript">
function save()
{
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=quanlykho/kehoach/save", $("#frm").serialize(),
		function(data){
			var arr = data.split('-');
			if(arr[0] == "true")
			{
				window.location = "?route=quanlykho/kehoach/setting&id="+ arr[1];
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
