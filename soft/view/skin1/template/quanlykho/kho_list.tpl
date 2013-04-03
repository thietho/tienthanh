<div class="section">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content">
    	
        <form action="" method="post" id="listitem" name="listitem">
            
            <div class="button right">
                <?php if($dialog==true){ ?>
            	<input class="button" value="Select" type="button" onclick="selectKho()">
                <input type="hidden" id="selectkho" name="selectkho" />
                <?php } ?>
                <?php if($dialog!=true){ ?>
                <?php if($this->user->checkPermission("quanlykho/kho/viewTonKho")==true){ ?>
                <input class="button" value="Xem tồn kho" type="button" onclick="viewTonKho('')">
                <?php } ?>
                <?php if($this->user->checkPermission("quanlykho/kho/insert")==true){ ?>
                <input class="button" value="Thêm" type="button" onclick="linkto('<?php echo $insert?>')">
                <?php } ?>
                <?php if($this->user->checkPermission("quanlykho/kho/delete")==true){ ?>
            	<input class="button" type="button" name="delete_all" value="Xóa" onclick="deleteitem()"/>
                <?php } ?>
                <?php } ?>  
            </div>
            
            <div class="clearer">^&nbsp;</div>
            
            <div class="sitemap treeindex">
                <table class="data-table" cellpadding="0" cellspacing="0">
                <tbody>
                    <tr class="tr-head">
                        <th width="1%"><input class="inputchk" type="checkbox" onclick="$('input[name*=\'delete\']').attr('checked', this.checked);"></th>
                        
                        <th>Mã kho</th>
                        <th>Tên kho</th>
                        <th>Địa chỉ</th>
                        <th>Điện thoại</th>
                        <th>Chức năng sử dụng</th>
                        <th>Ghi chú</th>                    
                        <th width="10%">Control</th>                                  
                    </tr>
        
        
        <?php
            foreach($datas as $item)
            {
        ?>
                    <tr>
                        <td class="check-column"><input class="inputchk" type="checkbox" name="delete[<?php echo $item['makho']?>]" value="<?php echo $item['makho']?>" ></td>
                        
                        <td><?php echo $item['makho']?></td>
                        <td><?php echo $item['tenkho']?></td>
                        <td><?php echo $item['diachi']?></td>
                        <td><?php echo $item['dienthoai']?></td>
                        <td><?php echo $item['modules']?></td>
                		<td><?php echo $item['ghichu']?></td>
                        <td class="link-control">
                        	<?php if($this->user->checkPermission("quanlykho/kho/viewTonKho")==true){ ?>
                            <input type="button" class="button" name="btnView" value="Xem tồn kho" onclick="viewTonKho('<?php echo $item['makho']?>')"/>
                            <?php } ?>
                            <?php if($this->user->checkPermission("quanlykho/kho/update")==true){ ?>
                           	<input type="button" class="button" name="btnEdit" value="<?php echo $item['text_edit']?>" onclick="window.location='<?php echo $item['link_edit']?>'"/>
                            <?php } ?>
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

function selectKho()
{
	window.opener.document.getElementById('makho').value = $("#selectkho").val();
	window.close();
}

function deleteitem()
{
	var answer = confirm("Bạn có muốn xóa không?")
	if (answer)
	{
		$.post("?route=quanlykho/kho/delete", 
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

<?php if($dialog==true){ ?>
	$(".inputchk").click(function()
	{
		$("#selectkho").val('');
		$(".inputchk").each(function(){
			if(this.checked == true)
			{
				$("#selectkho").val($("#selectkho").val()+","+$(this).val());
			}
		})
		
	});
<?php } ?>

function viewTonKho(id)
{
	openDialog("?route=quanlykho/kho/viewTonKho&id="+id,1000,800);
}
</script>