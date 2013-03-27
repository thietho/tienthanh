<div class="section">

<div class="section-title"><?php echo $this->document->title?></div>

<div class="section-content">

<form action="" method="post" id="listitem" name="listitem">

<div class="button right">
	<?php if($this->user->checkPermission("quanlykho/nhom/update")==true){ ?>
	<input class="button" type="button" name="btnUpdate" value="Update" onclick="updatethutu()" />
    <?php } ?>
    <?php if($this->user->checkPermission("quanlykho/nhom/insert")==true){ ?>
    <input class="button" value="Add new" type="button" onclick="linkto('<?php echo $insert?>')">
    <?php } ?>
    <?php if($this->user->checkPermission("quanlykho/nhom/delete")==true){ ?>
    <input class="button" type="button" name="delete_all" value="Delete" onclick="deleteitem()" />
    <?php } ?>
</div>
<div class="clearer">^&nbsp;</div>

<div class="sitemap treeindex">
<link href="<?php echo DIR_VIEW?>css/jquery.treeTable.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="<?php echo DIR_VIEW?>js/jquery.treeTable.js"></script> <script
	type="text/javascript">
                  $(document).ready(function() {
                    // TODO Fix issue with multiple treeTables on one page, each with different options
                    // Moving the #example3 treeeTable call down will break other treeTables that are expandable...
                    $(".example").treeTable();
                  });
                  
                  </script>
<table class="example data-table" width="100%">
	<thead>
		<tr class="tr-head">


			<th><input class="inputchk" type="checkbox"
				onclick="$('input[name*=\'delete\']').attr('checked', this.checked);">
			Mã nhóm</th>
			<th>Tên nhóm</th>
			<th>Thứ tự</th>
			<th>Ghi chú</th>
			<th>Control</th>
		</tr>
	</thead>
	<tbody>

	<?php
	 
	foreach($nhoms as $item)
	{
		?>
		<tr id="<?php echo $item['eid']?>" class="<?php echo $item['class']?>">


			<td><?php echo $item['tab']?><input class="inputchk" type="checkbox"
				name="delete[<?php echo $item['manhom']?>]"
				value="<?php echo $item['manhom']?>"> <?php echo $item['manhom']?></td>
			<td><?php echo $item['tennhom']?></td>
			<td><input type="text" name="thutu[<?php echo $item['manhom']?>]"
				value="<?php echo $item['thutu']?>" size=3 class="text number" /></td>
			<td><?php echo $item['ghichu']?></td>
			<td class="link-control">
            	<?php if($this->user->checkPermission("quanlykho/nhom/update")==true){ ?>
            	<a class="button" href="<?php echo $item['link_edit']?>" title="<?php echo $item['text_edit']?>"><?php echo $item['text_edit']?></a>
                <?php }?>
                <?php if($this->user->checkPermission("quanlykho/nhom/insert")==true){ ?>
				<a class="button" href="<?php echo $item['link_addchild']?>" title="<?php echo $item['text_edit']?>"><?php echo $item['text_addchild']?></a>
                <?php } ?>

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
		$.post("?route=quanlykho/nhom/delete", 
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

function updatethutu()
{
	$.post("?route=quanlykho/nhom/updatethutu", 
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

</script>
