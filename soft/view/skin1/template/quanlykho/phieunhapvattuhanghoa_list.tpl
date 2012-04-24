<script src='<?php echo DIR_JS?>ui.datepicker.js' type='text/javascript' language='javascript'> </script>
<div class="section">

	<div class="section-title">Phiếu nhập vật tư hàng hóa</div>
    
    <div class="section-content">
    	
        <form action="" method="post" id="listitem" name="listitem">
        	
        	<div class="button right">
            	
                <input class="button" type="button" name="btnAdd" value="Thêm" onclick="window.location='<?php echo $insert?>'"/>  
            	<input class="button" type="button" name="delete_all" value="Xóa" onclick="deleteList()"/>  
            </div>
            <div class="clearer">&nbsp;</div>
            
            <div class="sitemap treeindex">
                <table class="data-table" cellpadding="0" cellspacing="0">
                <tbody>
                    <tr class="tr-head">
                        <th width="1%"><input class="inputchk" type="checkbox" onclick="$('input[name*=\'delete\']').attr('checked', this.checked);"></th>
                        
                        <th>Số phiếu</th>
                        <th>Ngày lập</th>
                        <th>Số kế hoạch đăt hàng</th>
                        <th>Tổng tiền</th>
                        <th>Tình trạng</th>
                        <th width="10%"></th>                                  
                    </tr>
        
        
        <?php
            foreach($datas as $item)
            {
        ?>
                    <tr>
                        <td class="check-column"><input class="inputchk" type="checkbox" name="delete[<?php echo $item['phieunhapvattuhanghoaid']?>]" value="<?php echo $item['phieunhapvattuhanghoaid']?>" ></td>
                        <td><?php echo $item['sophieu']?></td>
                        <td><?php echo  $this->date->formatMySQLDate($item['ngaylap'])?></td>
                        <td><?php echo $item['kehoachdathang']?></td>
                        <td class="number"><?php echo $this->string->numberFormate($item['tongsotien'])?></td>
                        <td><?php echo $this->document->thanhtoan[$item['tinhtrang']]?></td>
                        <td class="link-control">
                            <input type="button" class="button" name="btnEdit" value="Sửa" onClick="window.location='<?php echo $item['link_edit']?>'">
                            <input type="button" class="button" value="In" onclick="view('<?php echo $item['phieunhapvattuhanghoaid']?>')"/>
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
function deleteList()
{
	var answer = confirm("Bạn có muốn xóa?")
	if (answer)
	{
		$.post("?route=quanlykho/phieunhapvattuhanghoa/delete", 
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
function view(phieunhapvattuhanghoaid)
{
	
	openDialog("?route=quanlykho/phieunhapvattuhanghoa/view&phieunhapvattuhanghoaid="+phieunhapvattuhanghoaid+"&dialog=print",800,500);
}
</script>