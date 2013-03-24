<div class="section">

<div class="section-title">Bảng báo giá</div>

<div class="section-content">

<form action="" method="post" id="listitem" name="listitem">

<div class="button right"><?php if($dialog==true){ ?> <input
	class="button" value="Select" type="button"
	onclick="selectNguyenLieu()"> <input type="hidden"
	id="selectnguyenlieu" name="selectnguyenlieu" /> <?php }else{ ?> <input
	class="button" value="Add new" type="button"
	onclick="linkto('<?php echo $insert?>')"> <input class="button"
	type="button" name="delete_all" value="Delete" onclick="deleteitem()" />
<?php } ?></div>
<div class="clearer">^&nbsp;</div>

<div class="sitemap treeindex">
<table class="data-table" cellpadding="0" cellspacing="0">
	<thead>
		<tr class="tr-head">
			<th width="1%"><?php if($dialog!=true){ ?> <input class="inputchk"
				type="checkbox"
				onclick="$('input[name*=\'delete\']').attr('checked', this.checked);">
				<?php } ?></th>
			<th>STT</th>
			<th>Ngày</th>
			<th>Nhà cung ứng</th>

			<?php if($dialog!=true){ ?>
			<th>Control</th>
			<?php } ?>
		</tr>
	</thead>
	<tbody>


	<?php
	foreach($datas as $key => $item)

	{
		?>
		<tr>
			<td class="check-column"><input class="inputchk" type="checkbox"
				name="delete[<?php echo $item['id']?>]"
				value="<?php echo $item['id']?>"></td>
			<td><?php echo $key+1 ?></td>
			<td><?php echo $this->date->formatMySQLDate($item['ngay'])?></td>
			<td><?php echo $this->document->getnhaCungUng($item['manhacungung'])?></td>

			<?php if($dialog!=true){ ?>
			<td class="link-control"><input type="button" class="button"
				name="btnEdit" value="<?php echo $item['text_edit']?>"
				onclick="window.location='<?php echo $item['link_edit']?>'" /></td>
				<?php } ?>
		</tr>
		<?php
	}
	?>


	</tbody>
</table>
</div>
	<?php echo $pager?></form>

</div>

</div>
<script language="javascript">

function deleteitem()
{
	var answer = confirm("Bạn có muốn xóa không?")
	if (answer)
	{
		$.post("?route=quanlykho/nguyenlieu/deletedBangBaoGia", 
				$("#listitem").serialize(), 
				function(data)
				{
					if(data!="")
					{
						alert(data)
						window.location.reload();
					}
				}
		);
	}
}

function searchForm()
{
	var url =  "?route=quanlykho/nguyenlieu";
	if($("#manguyenlieu").val() != "")
		url += "&manguyenlieu=" + $("#manguyenlieu").val();
	
	if($("#tennguyenlieu").val() != "")
		url += "&tennguyenlieu="+ $("#tennguyenlieu").val();
	if($("#manhom").val() != "")
		url += "&manhom=" + $("#manhom").val();
	if($("#loai").val() != "")
		url += "&loai="+ $("#loai").val();
	if($("#makho").val() != "")
		url += "&makho=" + $("#makho").val();
	
	if("<?php echo $_GET['opendialog']?>" == "true")
	{
		url += "&opendialog=true";
	}
	
	window.location = url;
}

$("#manguyenlieu").val("<?php echo $_GET['manguyenlieu']?>");
$("#tennguyenlieu").val("<?php echo $_GET['tennguyenlieu']?>");
$("#manhom").val("<?php echo $_GET['manhom']?>");
$("#loai").val("<?php echo $_GET['loai']?>");
$("#makho").val("<?php echo $_GET['makho']?>");

function selectNguyenLieu()
{
	window.opener.document.getElementById('manguyenlieu').value = $("#selectnguyenlieu").val();
	window.close();
}

<?php if($dialog==true){ ?>
	$(".inputchk").click(function()
	{
		$("#selectnguyenlieu").val('');
		$(".inputchk").each(function(){
			if(this.checked == true)
			{
				$("#selectnguyenlieu").val($("#selectnguyenlieu").val()+","+$(this).val());
			}
		})
		
	});
<?php } ?>
</script>
