<div class="section">

	<div class="section-title">Quản lý tài sản</div>
    
    <div class="section-content">
    	
        <form action="" method="post" id="listitem" name="listitem">
        	<div id="ben-search">
            	<label>Mã số</label>
                <input type="text" id="mataisan" name="mataisan" class="text" value="" />
                <label>Tên</label>
                <input type="text" id="tentaisan" name="tentaisan" class="text" value="" />
                <label>Nhóm</label>
					<select id="manhom" name="manhom">
                    	<option value=""></option>
                    	<?php foreach($nhomtaisan as $val){ ?>
                        <option value="<?php echo $val['manhom']?>"><?php echo $val['tennhom']?></option>
                        <?php } ?>
                    </select>
                <label>Loại</label>
                <select id="loai" name="loai">
                    <option value=""></option>
                    <?php foreach($loaitaisan as $val){ ?>
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
                <input type="button" class="button" name="btnSearch" value="Xem tất cả" onclick="window.location = '?route=quanlykho/taisan'"/>
            </div>
        	<div class="button right">
            	<?php if($dialog==true){ ?>
            	<input class="button" value="Select" type="button" onclick="selectTaiSan()">
                <input type="hidden" id="selecttaisan" name="selecttaisan" />
                <?php } ?>
                <?php if($dialog!=true){ ?>
            	<input class="button" value="Sổ tài sản" type="button" onclick="linkto('<?php echo $sotaisan?>')">
                <input class="button" value="Add new" type="button" onclick="linkto('<?php echo $insert?>')">
            	<input class="button" type="button" name="delete_all" value="Delete" onclick="deleteitem()"/>  
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
                        <th>Mã tài sản</th>
                        <th>Tên tài sản</th>
                        <th>Số sêri</th>
                        <th>Nhóm</th>
                        <th>Loại</th>
                        <th>Kho</th>
                        <th>Khấu hao</th>
                        <th>Đơn vị tính</th>
                        <th>Ngày mua</th>
                        <th>Phòng ban nhận</th>
                        <th>Người nhận</th>
                        <th>Đơn giá</th>
                        <th>Tinh trang</th>
                        <th>Mục đích sử dụng</th>
                        <th>Ghi chú</th>
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
                        <td class="check-column">
                        	
                            <input class="inputchk" type="checkbox" name="delete[<?php echo $item['id']?>]" value="<?php echo $item['id']?>" >		
                            
                        </td>
                        <td><?php echo $key+1 ?></td>
                        <td><?php echo $item['mataisan']?></td>
                        <td><?php echo $item['tentaisan']?></td>
                        <td><?php echo $item['soseri']?></td>
                        <td><?php echo $item['tennhom']?></td>
                        <td><?php echo $item['tenloai']?></td>
                        <td><?php echo $item['tenkho']?></td>
                        <td class="number"><?php echo $this->string->numberFormate($item['khauhao'],0)?> tháng</td>
                		<td><?php echo $item['madonvi']?></td>
                        <td><?php echo $this->date->formatMySQLDate($item['ngaymua'])?></td>
                        <td><?php echo $this->document->getNhom($item['phongbannhan'])?></td>
                        <td><?php echo $item['tennguoinhan']?></td>
                        <td class="number"><?php echo $this->string->numberFormate($item['dongia'],0)?></td>
                        <td><?php echo ($item["hienhanh"]==true)?"":"Đã cho mượn" ;?></td>
                        <td><?php echo $item['mucdichsudung']?></td>
                        <td><?php echo $item['ghichu']?></td>
                        <td><img src="<?php echo $item['imagethumbnail']?>" /></td>
                        <?php if($dialog!=true){ ?>
                        <td class="link-control">
                            
                            <input type="button" class="button" name="btnEdit" value="<?php echo $item['text_edit']?>" onclick="window.location='<?php echo $item['link_edit']?>'"/>
                           
                           	
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