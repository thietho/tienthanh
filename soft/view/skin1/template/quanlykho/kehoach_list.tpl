<div class="section">

<div class="section-title"><?php echo $this->document->title?></div>

<div class="section-content">

<form action="" method="post" id="listitem" name="listitem">

<div class="button right">
	<?php if($this->user->checkPermission("quanlykho/kehoach/insert")==true){ ?>
	<input class="button" value="Thêm" type="button" onclick="linkto('<?php echo $insert?>')"> 
    <?php } ?>
    <?php if($this->user->checkPermission("quanlykho/kehoach/delete")==true){ ?>
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
			Tên kế hoạch</th>


			<th>Control</th>
		</tr>
	</thead>
	<tbody>

	<?php
	 
	foreach($datas as $item)
	{
		?>
		<tr id="<?php echo $item['eid']?>" class="<?php echo $item['class']?>">


			<td><?php echo $item['tab']?> 
				<input
				class="inputchk" type="checkbox"
				name="delete[<?php echo $item['id']?>]"
				value="<?php echo $item['id']?>"> 
				<?php echo $item['tenkehoach']?>
				</td>


			<td class="link-control">
            	<?php if($this->user->checkPermission("quanlykho/kehoach/update")==true){ ?>
				<a class="button" href="<?php echo $item['link_edit']?>" title="<?php echo $item['text_edit']?>"><?php echo $item['text_edit']?></a>
                <?php } ?>
				<?php if($item['link_danhgia']!=''){ ?>
                <?php if($this->user->checkPermission("quanlykho/kehoach/danhgia")==true){ ?>
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
		$.post("?route=quanlykho/kehoach/delete", 
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
