<div class="section">

<div class="section-title"><?php echo $this->document->title?></div>

<div class="section-content">

<form action="" method="post" id="listitem" name="listitem">

<div class="button right">
	<?php if($this->user->checkPermission("quanlykho/kehoachnam/insert")==true){ ?>
	<input class="button" value="Thêm" type="button" onclick="themkehoachnam()">
    <?php } ?>
    <?php if($this->user->checkPermission("quanlykho/kehoachnam/delete")==true){ ?>
    <input class="button" type="button" name="delete_all" value="Delete" onclick="deleteitem()" />
    <?php } ?>
</div>
<div class="clearer">^&nbsp;</div>

<div class="sitemap treeindex">

<table class="example data-table" width="100%">
	<thead>
		<tr class="tr-head">


			<th>
				<input class="inputchk" type="checkbox"
				onclick="$('input[name*=\'delete\']').attr('checked', this.checked);">
			Kế hoạch</th>


			<th>Control</th>
		</tr>
	</thead>
	<tbody>

	<?php
	 
	foreach($datas as $item)
	{
		?>
		<tr id="<?php echo $item['eid']?>" class="<?php echo $item['class']?>">


			<td><?php echo $item['tab']?> <?php if($item['deep'] == 1){?> <input
				class="inputchk" type="checkbox"
				name="delete[<?php echo $item['id']?>]"
				value="<?php echo $item['id']?>"> <?php } ?> Kế hoạch <?php echo $item['nam']?>
				<?php if($item['quy'] > 0) { ?> quý <?php echo $item['quy']?> <?php } ?>
				<?php if($item['thang'] > 0) { ?> tháng <?php echo $item['thang']?>
				<?php } ?></td>


			<td class="link-control">
            	<?php if($this->user->checkPermission("quanlykho/kehoachnam/update")==true){ ?>
				<a class="button" href="<?php echo $item['link_edit']?>" title="<?php echo $item['text_edit']?>"><?php echo $item['text_edit']?></a>
                <?php } ?>
				<?php if($item['link_danhgia']!=''){ ?>
                <?php if($this->user->checkPermission("quanlykho/kehoachnam/danhgia")==true){ ?>
				<a class="button" href="<?php echo $item['link_danhgia']?>" title="<?php echo $item['text_danhgia']?>"><?php echo $item['text_danhgia']?></a>
                <?php } ?>
				<?php } ?>
			</td>
		</tr>
		<?php
	}
	?>


	</tbody>
</table>
</div>


</form>

</div>

</div>
<script language="javascript">

function deleteitem()
{
	var answer = confirm("Bạn có muốn xóa không?")
	if (answer)
	{
		$.post("?route=quanlykho/kehoachnam/delete", 
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

function themkehoachnam()
{
	$("#popup").attr('title','Kế hoạch năm');
		$( "#popup" ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: $(document).width()-100,
			height: window.innerHeight,
			modal: true,
			buttons: {
				
				
				'Lưu': function() 
				{
					$.post("?route=quanlykho/kehoachnam/save", $("#frm").serialize(),
						function(data){
							var arr = data.split('-');
							if(arr[0] == "true")
							{
								//Luu chi tiet ke hoach
								window.location = "?route=quanlykho/kehoachnam/update&id="+ arr[1];
								
							}
							else
							{
							
								$('#error').html(data).show('slow');
								
								
							}
							
						}
					);
					
				},
				
			}
		});
	
		
		$("#popup-content").load("?route=quanlykho/kehoachnam/insertForm&opendialog=true",function(){
			$("#popup").dialog("open");	
		});	
}


</script>
