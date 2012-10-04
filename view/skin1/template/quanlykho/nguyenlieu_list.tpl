<div class="section">

	<div class="section-title">Quản lý danh muc nguyên vật liệu</div>
    
    <div class="section-content">
    	
        <form action="" method="post" id="listitem" name="listitem">
        	<div id="ben-search">
            	<label>Mã số</label>
                <input type="text" id="manguyenlieu" name="manguyenlieu" class="text" value="" />
                <label>Tên</label>
                <input type="text" id="tennguyenlieu" name="tennguyenlieu" class="text" value="" />
                
                <label>Loại</label>
                <select id="loai" name="loai">
                    <option value=""></option>
                    <?php foreach($loainguyenlieu as $val){ ?>
                    <option value="<?php echo $val['manhom']?>"><?php echo $this->string->getPrefix("&nbsp;&nbsp;&nbsp;",$val['level']-1)?><?php echo $val['tennhom']?></option>
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
                <input type="button" class="button" name="btnSearch" value="Xem tất cả" onclick="window.location = '?route=quanlykho/nguyenlieu'"/>
            </div>
        	<div class="button right">
            	<?php if($dialog==true){ ?>
            	<input class="button" value="Select" type="button" onclick="selectNguyenLieu()">
                <input type="hidden" id="selectnguyenlieu" name="selectnguyenlieu" />
                <?php }else{ ?>
                <input class="button" value="Chi tiết tồn kho" type="button" onclick="viewTonKho('')">
                <input class="button" value="Bảng báo giá" type="button" onclick="linkto('<?php echo $bangbaogia?>')">
                <input class="button" value="Thêm nhiều nguyên liệu" type="button" onclick="linkto('<?php echo $insertlist?>')">
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
                        <th>Mã nguyên vật liệu</th>
                        <th>Tên nguyên vật liệu</th>
                        
                        <th>Loại</th>
                        <th>Kho</th>
                        
                        <th>Số lượng tồn</th>
                        <th>Tồn tối thiểu</th>
                        <th>Tồn tối đa</th>
                        <th>Số lượng 1 lần đặt hàng</th>
                        <th>Đơn vị tính</th>
                        
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
                        <td class="check-column"><input class="inputchk" type="checkbox" name="delete[<?php echo $item['id']?>]" value="<?php echo $item['id']?>" ></td>
                        <td><?php echo $key+1 ?></td>
                        <td><?php echo $item['manguyenlieu']?></td>
                        <td><?php echo $item['tennguyenlieu']?></td>
                        
                        <td><?php echo $item['tenloai']?></td>
                        <td><?php echo $item['tenkho']?></td>
                        
                		<td class="number">
                        	<?php if($item['soluongton'] >0){?>
                            <a onclick="viewTonKho(<?php echo $item['id']?>)"><?php echo $this->string->numberFormate($item['soluongton'],0)?></a>
                            <?php }else{?>
                        	<?php echo $this->string->numberFormate($item['soluongton'],0)?>
                            <?php } ?>
                        </td>
                        <td class="number"><?php echo $this->string->numberFormate($item['tontoithieu'],0)?></td>
                        <td class="number"><?php echo $this->string->numberFormate($item['tontoida'],0)?></td>
                        <td class="number"><?php echo $this->string->numberFormate($item['soluongmoilandathang'],0)?></td>
                        <td><?php echo $item['madonvi']?></td>
                        
                        <td><?php echo $item['mucdichsudung']?></td>
                        <td><?php echo $item['ghichu']?></td>
                        <td><img src="<?php echo $item['imagethumbnail']?>" /></td>
                        <?php if($dialog!=true){ ?>
                        <td class="link-control">
                            
                            <input type="button" class="button" name="btnEdit" value="<?php echo $item['text_edit']?>" onclick="window.location='<?php echo $item['link_edit']?>'"/>
                            <input type="button" class="button" name="btnDinhLuong" value="<?php echo $item['text_dinhluong']?>" onclick="window.location='<?php echo $item['link_dinhluong']?>'"/>
                            <!--<input type="button" class="button" name="btnCapNhatGia" value="<?php echo $item['text_capnhatgia']?>" onclick="window.location='<?php echo $item['link_capnhatgia']?>'"/>-->
                           	<input type="button" class="button" name="btnXemGia" value="<?php echo $item['text_xemgia']?>" onclick="window.location='<?php echo $item['link_xemgia']?>'"/>
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
		$.post("?route=quanlykho/nguyenlieu/delete", 
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
	var url =  "?route=quanlykho/nguyenlieu";
	if($("#manguyenlieu").val() != "")
		url += "&manguyenlieu=" + $("#manguyenlieu").val();
	
	if($("#tennguyenlieu").val() != "")
		url += "&tennguyenlieu="+ $("#tennguyenlieu").val();
	
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

$("#manguyenlieu").val("<?php echo $_GET['manguyenlieu']?>");
$("#tennguyenlieu").val("<?php echo $_GET['tennguyenlieu']?>");
$("#manhom").val("<?php echo $_GET['manhom']?>");
$("#loai").val("<?php echo $_GET['loai']?>");
$("#makho").val("<?php echo $_GET['makho']?>");

function selectNguyenLieu()
{
	window.opener.document.getElementById('manguyenlieu').value = $("#selectnguyenlieu").val();
	window.close();
}

<?php if($dialog==true){ ?>
	$(".inputchk").click(function()
	{
		$("#selectnguyenlieu").val('');
		$(".inputchk").each(function(){
			if(this.checked == true)
			{
				$("#selectnguyenlieu").val($("#selectnguyenlieu").val()+","+$(this).val());
			}
		})
		
	});
<?php } ?>

function viewTonKho(id)
{
	$("#popup").attr('title','Tồn kho');
				$( "#popup" ).dialog({
					autoOpen: false,
					show: "blind",
					hide: "explode",
					width: 800,
					height: 500,
					modal: true,
					buttons: {
						
						
						'Đóng': function() {
							$( this ).dialog( "close" );
						},
						
						
					}
				});
			
				
	$("#popup-content").load("?route=quanlykho/nguyenlieu/viewTonKho&id="+id,function(){
		$("#popup").dialog("open");	
	});
	//openDialog("?route=quanlykho/nguyenlieu/viewTonKho&id="+id,1000,800);
}
</script>