<div class="section">

	<div class="section-title">Quản lý danh mục linh kiện</div>
    
    <div class="section-content">
    	
        <form action="" method="post" id="listitem" name="listitem">
        	<div id="ben-search">
            	<label>Mã số</label>
                <input type="text" id="malinhkien" name="malinhkien" class="text" value="" />
                <label>Tên</label>
                <input type="text" id="tenlinhkien" name="tenlinhkien" class="text" value="" />
                <label>Nhóm</label>
					<select id="manhom" name="manhom">
                    	<option value=""></option>
                    	<?php foreach($nhomlinhkien as $val){ ?>
                        <option value="<?php echo $val['manhom']?>"><?php echo $val['tennhom']?></option>
                        <?php } ?>
                    </select>
                
                <label>Kho</label>
                <select id="makho" name="makho">
                    <option value=""></option>
                    <?php foreach($kho as $val){ ?>
                    <option value="<?php echo $val['makho']?>"><?php echo $val['tenkho']?></option>
                    <?php } ?>
                </select>
                <br />
                <input type="button" class="button" name="btnSearch" value="Tìm" onclick="searchForm()"/>
                <input type="button" class="button" name="btnSearch" value="Xem tất cả" onclick="window.location = '?route=quanlykho/linhkien'"/>
            </div>
        	<div class="button right">
            	<?php if($dialog==true){ ?>
            	<input class="button" value="Select" type="button" onclick="selectLinhKien()">
                <input type="hidden" id="selectlinhkien" name="selectlinhkien" />
                <?php }else{ ?>
                <input class="button" value="Thêm" type="button" onclick="linkto('<?php echo $insert?>')">
            	<input class="button" type="button" name="delete_all" value="Xóa" onclick="deleteitem()"/>  
                <?php } ?>
            </div>
            <div class="clearer">^&nbsp;</div>
            
            <div class="sitemap treeindex">
                <table class="data-table" cellpadding="0" cellspacing="0">
                <thead>
                    <tr class="tr-head">
                        <th width="1%">
                        	<?php if($dialog!=true){ ?>
                        	<input class="inputchk" type="checkbox" onclick="$('input[name*=\'delete\']').attr('checked', this.checked);">
                            <?php } ?>
                            </th>
                        <th>STT</th>
                        <th>Mã linh kiện</th>
                        <th>Tên linh kiện</th>
                        <th>Linh kiện /Lot</th>
                        <th>Số lượng tồn</th>
                        <th>Đơn vị tính</th>
                        <th>Tiền công</th>
                        <th>Kho</th>
                        <th>Định mức</th>
                        <th>Hình</th>
                        <?php if($dialog!=true){ ?>
                        <th>Control</th>     
                        <?php } ?>
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
                        <td><?php echo $item['malinhkien']?></td>
                        <td><?php echo $item['tenlinhkien']?></td>
                        <td class="number"><?php echo $item['solinhkientrenlot']?></td>
                        <td class="number"><?php echo $item['soluongton']?></td>
                        <td><?php echo $item['madonvi']?></td>
                        <td class="number"><?php echo $this->string->numberFormate($item['tiencong'])?></td>
                		<td><?php echo $item['tenkho']?></td>
                        <td class="number"><?php echo $this->string->numberFormate($item['dinhmuc'])?></td>
                        <td><img src="<?php echo $item['imagethumbnail']?>" /></td>
                        <?php if($dialog!=true){ ?>
                        <td class="link-control">
                            
                            <input type="button" class="button" name="btnEdit" value="<?php echo $item['text_edit']?>" onclick="window.location='<?php echo $item['link_edit']?>'"/>
                            <input type="button" class="button" name="btnDinhLuong" value="<?php echo $item['text_dinhluong']?>" onclick="window.location='<?php echo $item['link_dinhluong']?>'"/>
                            <input type="button" class="button" name="btnCapNhatGia" value="<?php echo $item['text_caidatcongdoan']?>" onclick="window.location='<?php echo $item['link_caidatcongdoan']?>'"/>
                           	
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
		$.post("?route=quanlykho/linhkien/delete", 
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
	var url =  "?route=quanlykho/linhkien";
	if($("#malinhkien").val() != "")
		url += "&malinhkien=" + $("#malinhkien").val();
	
	if($("#tenlinhkien").val() != "")
		url += "&tenlinhkien="+ $("#tenlinhkien").val();
	if($("#manhom").val() != "")
		url += "&manhom=" + $("#manhom").val();
	
	if($("#makho").val() != "")
		url += "&makho=" + $("#makho").val();
	
	if("<?php echo $_GET['opendialog']?>" == "true")
	{
		url += "&opendialog=true";
	}
	
	window.location = url;
}

$("#malinhkien").val("<?php echo $_GET['malinhkien']?>");
$("#tenlinhkien").val("<?php echo $_GET['tenlinhkien']?>");
$("#manhom").val("<?php echo $_GET['manhom']?>");

$("#makho").val("<?php echo $_GET['makho']?>");

function selectLinhKien()
{
	window.opener.document.getElementById('selectmalinhkien').value = $("#selectlinhkien").val();
	window.close();
}

<?php if($dialog==true){ ?>
	$(".inputchk").click(function()
	{
		$("#selectlinhkien").val('');
		$(".inputchk").each(function(){
			if(this.checked == true)
			{
				$("#selectlinhkien").val($("#selectlinhkien").val()+","+$(this).val());
			}
		})
		
	});
<?php } ?>
</script>