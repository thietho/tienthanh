<div class="section">

<div class="section-title"><?php echo $this->document->title?></div>

<div class="section-content">

<form action="" method="post" id="listitem" name="listitem">

<div class="button right">
	<?php if($this->user->checkPermission("quanlykho/phongban/insert")==true){ ?>
	<input class="button" value="Thêm" type="button" onclick="linkto('<?php echo $insert?>')">
    <?php } ?>
    <?php if($this->user->checkPermission("quanlykho/phongban/delete")==true){ ?>
    <input class="button" type="button" name="delete_all" value="Xóa" onclick="deleteitem()" />
    <?php } ?>
</div>
<div class="clearer">^&nbsp;</div>

<div class="sitemap treeindex">
<table class="data-table" cellpadding="0" cellspacing="0">
	<tbody>
		<tr class="tr-head">
			<th width="1%"><input class="inputchk" type="checkbox"
				onclick="$('input[name*=\'delete\']').attr('checked', this.checked);"></th>

			<th>Mã phòng ban</th>
			<th>Tên phòng ban</th>
			<th>Ghi chú</th>
			<th>Control</th>
		</tr>


		<?php
		foreach($datas as $item)
		{
			?>
		<tr>
			<td class="check-column"><input class="inputchk" type="checkbox"
				name="delete[<?php echo $item['maphongban']?>]"
				value="<?php echo $item['maphongban']?>"></td>
			<td><?php echo $item['maphongban']?></td>
			<td><?php echo $item['tenphongban']?></td>
			<td><?php echo $item['ghichu']?></td>
			<td class="link-control">
            	<?php if($this->user->checkPermission("quanlykho/phongban/update")==true){ ?>
            	<input type="button" class="button" name="btnPhanQuyen" value="<?php echo $item['text_edit']?>" onclick="window.location = '<?php echo $item['link_edit']?>'" />
                <?php } ?>
                <!--<input
				type="button" class="button" name="btnPhanQuyen"
				value="<?php echo $item['text_phanquyen']?>"
				onclick="window.location = '<?php echo $item['link_phanquyen']?>'" />-->
			</td>
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
		$.post("?route=quanlykho/phongban/delete", 
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


</script>
