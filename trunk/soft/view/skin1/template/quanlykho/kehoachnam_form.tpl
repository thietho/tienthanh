
<div class="section" id="sitemaplist">

<div class="section-title"><?php echo $this->document->title?></div>

<div class="section-content padding1">

<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">

<div class="button right">
	<input type="button" id="btnSave" value="Save" class="button" />
    <input type="button" value="Cancel" class="button" onclick="linkto('?route=quanlykho/kehoachnam')" />
    <input type="hidden" name="id" value="<?php echo $item['id']?>">
</div>
<div class="clearer">^&nbsp;</div>
<div id="error" class="error" style="display: none"></div>
<div>
	<p>
    	<label>Năm</label><br />
		
        <select id="nam" name="nam">
        	<?php for($i=$this->date->now['year']-5;$i <= $this->date->now['year']+5;$i++){ ?>
            <option value="<?php echo $i?>"><?php echo $i?></option>
            <?php } ?>
        </select>
    </p>
<p><label>Ghi chú</label><br />
<textarea id="ghichu" name="ghichu"><?php echo $item['ghichu']?></textarea>
</p>



</div>

</form>

</div>

</div>
<script language="javascript">
$('#nam').val("<?php echo $this->date->now['year']?>");
$('#btnSave').click(function(e) {
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
});



</script>
