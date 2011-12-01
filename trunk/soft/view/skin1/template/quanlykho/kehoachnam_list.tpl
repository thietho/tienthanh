<div class="section">

<div class="section-title">Quản lý tài sản</div>

<div class="section-content">

<form action="" method="post" id="listitem" name="listitem">

<div class="button right"><input class="button" value="Add new"
	type="button" onclick="linkto('<?php echo $insert?>')"> <input
	class="button" type="button" name="delete_all" value="Delete"
	onclick="deleteitem()" /></div>
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


			<td class="link-control"><a class="button"
				href="<?php echo $item['link_edit']?>"
				title="<?php echo $item['text_edit']?>"><?php echo $item['text_edit']?></a>


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

function searchForm()
{
	var url =  "?route=quanlykho/taisan";
	if($("#mataisan").val() != "")
		url += "&mataisan=" + $("#mataisan").val();
	
	if($("#tentaisan").val() != "")
		url += "&tentaisan="+ $("#tentaisan").val();
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

$("#mataisan").val("<?php echo $_GET['mataisan']?>");
$("#tentaisan").val("<?php echo $_GET['tentaisan']?>");
$("#manhom").val("<?php echo $_GET['manhom']?>");
$("#loai").val("<?php echo $_GET['loai']?>");
$("#makho").val("<?php echo $_GET['makho']?>");

function selectTaiSan()
{
	window.opener.document.getElementById('selecttaisan').value = $("#selecttaisan").val();
	window.close();
}

<?php if($dialog==true){ ?>
	$(".inputchk").click(function(){
		$("#selecttaisan").val('');
		$(".inputchk").each(function(){
			if(this.checked == true)
			{
				$("#selecttaisan").val($("#selecttaisan").val()+","+$(this).val());
				
			}
			
			
		})
		
	})

<?php } ?>

</script>
