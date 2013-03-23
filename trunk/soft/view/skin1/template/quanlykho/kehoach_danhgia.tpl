
<div class="section" id="sitemaplist">

<div class="section-title">Kê hoạch năm</div>

<div class="section-content padding1">

<form name="frm" id="frm" action="<?php echo $action?>" method="post"
	enctype="multipart/form-data">

<div class="button right"><input type="button" value="Save"
	class="button" onClick="save()" /> <input type="button" value="Cancel"
	class="button" onclick="linkto('?route=quanlykho/kehoach')" /> <input
	type="hidden" name="makehoach" value="<?php echo $item['id']?>"></div>
<div class="clearer">^&nbsp;</div>
<div id="error" class="error" style="display: none"></div>
<div>
<p><label>Tên kế hoạch:</label><?php echo $item['tenkehoach']?></p>
<p><label>Ngày bắt đầu:</label><?php echo $this->date->formatMySQLDate($item['ngaybatdau'])?></p>
<p><label>Ngày kết thúc:</label><?php echo $this->date->formatMySQLDate($item['ngayketthuc'])?></p>
<p><label>Ghi chú</label><br />
<?php echo $item['ghichu']?></p>
<div id="listkehoachsanpham"></div>



</div>

</form>

</div>

</div>
<script language="javascript">
$('#listkehoachsanpham').load("?route=quanlykho/kehoachnam/loadKehoachSanPhamDanhGia&id=<?php echo $item['id']?>",function(){
		numberReady();
	});
function save()
{
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=quanlykho/kehoach/savedanhgiakehoach", $("#frm").serialize(),
		function(data){
			var arr = data.split('-');
			if(arr[0] == "true")
			{
				window.location = "?route=quanlykho/kehoach";
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
