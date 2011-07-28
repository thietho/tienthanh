<div class="section">

	<div class="section-title">Quản lý danh mục chi phí</div>
    
    <div class="section-content">
    	
        <form action="" method="post" id="listitem" name="listitem">
        
        	<div class="button right">
            	<?php if($dialog==true){ ?>
            	<input class="button" value="Select" type="button" onclick="selectChiPhi()">
                <input type="hidden" id="selectchiphi" name="selectchiphi" />
                <?php }else{ ?>
                <input class="button" value="Thêm" type="button" onclick="linkto('<?php echo $insert?>')">
            	<input class="button" type="button" name="delete_all" value="Xóa" onclick="deleteitem()"/>  
                <?php } ?>
            </div>
            <div class="clearer">^&nbsp;</div>
            
            <div class="sitemap treeindex">
                <table class="data-table" cellpadding="0" cellspacing="0">
                <tbody>
                    <tr class="tr-head">
                        <th width="1%">
                        	<?php if($dialog!=true){ ?>
                        	<input class="inputchk" type="checkbox" onclick="$('input[name*=\'delete\']').attr('checked', this.checked);">
                            <?php } ?>
                        </th>
                        
                        <th>Mã chi phí</th>
                        <th>Tên chi phí</th>
                        <?php if($dialog!=true){ ?>              
                        <th width="10%">Control</th>                                  
                        <?php } ?>
                    </tr>
        
        
        <?php
            foreach($datas as $item)
            {
        ?>
                    <tr>
                        <td class="check-column"><input class="inputchk" type="checkbox" name="delete[<?php echo $item['machiphi']?>]" value="<?php echo $item['machiphi']?>" ></td>
                        
                        <td><?php echo $item['machiphi']?></td>
                        <td><?php echo $item['tenchiphi']?></td>
                        <?php if($dialog!=true){ ?>
                        <td class="link-control">
                            <a class="button" href="<?php echo $item['link_edit']?>" title="<?php echo $item['text_edit']?>"><?php echo $item['text_edit']?></a>
                           
                        </td>
                        <?php } ?>
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
		$.post("?route=quanlykho/donvitinh/delete", 
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

function selectChiPhi()
{
	window.opener.document.getElementById('selectmachiphi').value = $("#selectchiphi").val();
	window.close();
}

<?php if($dialog==true){ ?>
	$(".inputchk").click(function()
	{
		$("#selectchiphi").val('');
		$(".inputchk").each(function(){
			if(this.checked == true)
			{
				$("#selectchiphi").val($("#selectchiphi").val()+","+$(this).val());
			}
		})
		
	});
<?php } ?>
</script>