<div class="section">

	<div class="section-title">Quản lý tài sản</div>
    
    <div class="section-content">
    	
        <form action="" method="post" id="listitem" name="listitem">
        	
        	<div class="button right">
                <input class="button" value="Add new" type="button" onclick="linkto('<?php echo $insert?>')">
            	<input class="button" type="button" name="delete_all" value="Delete" onclick="deleteitem()"/>  
            </div>
            <div class="clearer">^&nbsp;</div>
            
            <div class="sitemap treeindex">
                <table class="data-table" cellpadding="0" cellspacing="0">
                <thead>
                    <tr class="tr-head">
                        <th width="1%">
                        	
                        	<input class="inputchk" type="checkbox" onclick="$('input[name*=\'delete\']').attr('checked', this.checked);">
                            
                        </th>
                        <th>STT</th>
                        <th>Năm</th>
                        <th>Ghi chú</th>
                        <th>Control</th>
                    </tr>
                </thead>
                <tbody>
        
        
        <?php
            foreach($datas as $key => $item)
            {
        ?>
                    <tr>
                        <td class="check-column">
                        	
                            <input class="inputchk" type="checkbox" name="delete[<?php echo $item['id']?>]" value="<?php echo $item['id']?>" >		
                            
                        </td>
                        <td><?php echo $key+1 ?></td>
                        <td><?php echo $item['nam']?></td>
                        <td><?php echo $item['ghichu']?></td>
                        
                        <td class="link-control">
                            
                            <input type="button" class="button" name="btnEdit" value="<?php echo $item['text_edit']?>" onclick="window.location='<?php echo $item['link_edit']?>'"/>
                           
                           	
                        </td>
                        
                    </tr>
        <?php
            }
        ?>
                        
                                                    
                </tbody>
                </table>
            </div>
        	<?php echo $pager?>
        
        </form>
        
    </div>
    
</div>
<script language="javascript">

function deleteitem()
{
	var answer = confirm("Bạn có muốn xóa không?")
	if (answer)
	{
		$.post("?route=quanlykho/taisan/delete", 
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