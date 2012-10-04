<div class="section">

	<div class="section-title">Sổ tài sản</div>
    
    <div class="section-content">
    	
        <form action="" method="post" id="listitem" name="listitem">
        	<div id="ben-search">
            	<label>Mã số</label>
                <input type="text" id="mataisan" name="mataisan" class="text" value="" />
                <label>Tên</label>
                <input type="text" id="tentaisan" name="tentaisan" class="text" value="" />
                <label>Phòng ban</label>
                <select id="phongbannhan" name="phongbannhan">
                    <option value=""></option>
                    <?php foreach($phongban as $val){ ?>
                    <option value="<?php echo $val['maphongban']?>"><?php echo $val['tenphongban']?></option>
                    <?php } ?>
                </select>
                
                <br />
                <input type="button" class="button" name="btnSearch" value="Tìm" onclick="searchForm()"/>
                <input type="button" class="button" name="btnSearch" value="Xem tất cả" onclick="window.location = '?route=quanlykho/taisan/sotaisan'"/>
            </div>
        	<div class="button right">
            	
                <input class="button" value="Cấp tài sản" type="button" onclick="linkto('<?php echo $insert?>')">
            	<input class="button" type="button" value="Cancel" onclick="window.location='?route=quanlykho/taisan'"/>  
            </div>
            <div class="clearer">^&nbsp;</div>
            
            <div class="sitemap treeindex">
                <table class="data-table" cellpadding="0" cellspacing="0">
                <thead>
                    <tr class="tr-head">
                        <th width="1%"><input class="inputchk" type="checkbox" onclick="$('input[name*=\'delete\']').attr('checked', this.checked);"></th>
                        <th>STT</th>
                        <th>Mã tài sản</th>
                        <th>Tên tài sản</th>
                        <th>Phong ban</th>
                        <th>Người nhận</th>
                        <th>Ngày cấp</th>
                        <th>Ngày trả</th>
                        
                        <th>Control</th>                                  
                    </tr>
                </thead>
                <tbody>
        
        
        <?php
            foreach($datas as $key => $item)
            {
        ?>
                    <tr>
                        <td class="check-column"><input class="inputchk" type="checkbox" name="delete[<?php echo $item['id']?>]" value="<?php echo $item['id']?>" ></td>
                        <td><?php echo $key+1 ?></td>
                        <td><?php echo $item['maso']?></td>
                        <td><?php echo $item['tentaisan']?></td>
                        <td><?php echo $item['tenphongban']?></td>
                        <td><?php echo $this->document->getNhanVien($item['nguoinhan'])?></td>
                        <td><?php echo $this->date->formatMySQLDate($item['ngaynhan'])?></td>
                        <td><?php echo $this->date->formatMySQLDate($item['ngaytra'])?></td>
                        
                        <td class="link-control">
                            
                            <input type="button" class="button" name="btnEdit" value="<?php echo $item['text_edit']?>" onclick="window.location='<?php echo $item['link_edit']?>'"/>
                           	<?php echo $item['btnTra']?>
                           	
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
	var url =  "?route=quanlykho/taisan/sotaisan";
	if($("#mataisan").val() != "")
		url += "&mataisan=" + $("#mataisan").val();
	
	if($("#tentaisan").val() != "")
		url += "&tentaisan="+ $("#tentaisan").val();
	if($("#phongbannhan").val() != "")
		url += "&phongbannhan=" + $("#phongbannhan").val();
	
	
	if("<?php echo $_GET['opendialog']?>" == "true")
	{
		url += "&opendialog=true";
	}
	
	window.location = url;
}

$("#mataisan").val("<?php echo $_GET['mataisan']?>");
$("#tentaisan").val("<?php echo $_GET['tentaisan']?>");
$("#phongbannhan").val("<?php echo $_GET['phongbannhan']?>");

</script>