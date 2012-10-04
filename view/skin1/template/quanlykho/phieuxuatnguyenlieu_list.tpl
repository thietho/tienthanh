<script src='<?php echo DIR_JS?>ui.datepicker.js' type='text/javascript' language='javascript'> </script>
<div class="section">

	<div class="section-title">Phiếu xuất nguyên vật liệu</div>
    
    <div class="section-content">
    	
        <form action="" method="post" id="listitem" name="listitem">
        	<div id="ben-search">
            	<label>Loại phiếu xuất</label>
                <select id="loaiphieu" name="loaiphieu" <?php if($dialog==true) echo 'disabled="disabled"' ?>>
                    <option value=""></option>
                    <?php foreach($this->document->loaiphieuxuat as $key => $val){ ?>
                    <option value="<?php echo $key?>"><?php echo $val?></option>
                    <?php } ?>
                </select>
            	<label>Ngày lập từ ngày</label>
				<script language="javascript">
                    $(function() {
                        $("#tungay").datepicker({
                                changeMonth: true,
                                changeYear: true,
                                dateFormat: 'dd-mm-yy'
                                });
                        });
                 </script>
                 <input type="text" id="tungay" name="tungay" value="" class="text" />
                 
                <label>đến ngày</label>
				<script language="javascript">
                $(function() {
                    $("#denngay").datepicker({
                            changeMonth: true,
                            changeYear: true,
                            dateFormat: 'dd-mm-yy'
                            });
                    });
                </script>
                 <input type="text" id="denngay" name="denngay" value="" class="text"/>
                 
                 <label>Trạng thái </label>
                 <select id="trangthai" name="trangthai" <?php if($dialog==true) echo 'disabled="disabled"' ?>>
                    <option value=""></option>
                    <option value="pending">Chờ xử lý</option>
                    <option value="completed">Đã xử lý</option>
                </select>
                 
                <br />
                <input type="button" class="button" name="btnSearch" value="Tìm" onclick="searchForm()"/>
                <input type="button" class="button" name="btnSearch" value="Xem tất cả" onclick="window.location = '?route=quanlykho/phieuxuatnguyenlieu'"/>
            </div>
            <!-- end search -->
            
        	<div class="button right">
            	<?php if($dialog==true){ ?>
            	<input class="button" value="Select" type="button" onclick="selectPhieuNhanHang()">
                <input type="hidden" id="selectphieuxuatnguyenlieu" name="selectphieuxuatnguyenlieu" />
                <?php }else{ ?>
                <input class="button" value="Thêm" type="button" onclick="linkto('<?php echo $insert?>')">
            	<input class="button" type="button" name="delete_all" value="Xóa" onclick="deleteitem()"/>  
				<input class="button" type="button" name="cancel" value="Trở lại" onclick="window.location = '?route=quanlykho/phieuxuatnguyenlieu'"/> 
                <?php } ?>
            </div>
            <div class="clearer">^&nbsp;</div>
            
            <div class="sitemap treeindex">
                <table class="data-table" cellpadding="0" cellspacing="0">
                <thead>
                    <tr class="tr-head">
                    	<?php if($this->user->getUserTypeId()=="admin"){?>
                        <th width="1%">
                        	
                            <?php if($dialog!=true){ ?>
                        	<input class="inputchk" type="checkbox" onclick="$('input[name*=\'delete\']').attr('checked', this.checked);">
                            <?php } ?>
                        </th>
                        <?php } ?>
                        <th>STT</th>
                        <th>Số chứng từ</th>
                        <th>Người nhận</th>
                        <th>Loại xuất</th>
                        
                        <th>Tình trạng</th>
                       	<th>Ngày xuất</th>
                        <th>Mã hợp đồng</th>
                        <th>Ngày lập phiếu</th>
                        <th>Người lập</th>
                        <th>Trạng thái</th>
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
                    	<?php if($this->user->getUserTypeId()=="admin"){?>
                        <td class="check-column"><input class="inputchk" type="checkbox" name="delete[<?php echo $item['id']?>]" value="<?php echo $item['id']?>" ></td>
                        <?php } ?>
                        <td><?php echo $key+1 ?></td>
                        <td><?php echo $item['maphieu']?></td>
                        <td><?php echo $item['nguoinhan']?></td>
                        <td><?php echo $this->document->loaiphieuxuat[$item['loainguon']] ?></td>
                        
                        <td><?php echo $this->document->thanhtoan[$item['tinhtrang']]?></td>
                        <td><?php echo $this->date->formatMySQLDate($item['ngayxuat']) ?></td>
                        <td><?php echo $item['mahopdong'] ?></td>
                        <td><?php echo $this->date->formatMySQLDate($item['ngaylapphieu']) ?></td>
                        <td><?php echo $item['nguoilap'] ?></td>
                        <td><?php echo $this->document->xuly[$item['trangthai']] ?></td>
                        <?php if($dialog!=true){ ?>
                        <td class="link-control">
                        	<input type="button" class="button" name="btnView" value="<?php echo $item['text_view']?>" onclick="window.location='<?php echo $item['link_view']?>'"/>
                        	<?php if($this->user->getUserTypeId()=="admin"){?>
                            <input type="button" class="button" name="btnEdit" value="<?php echo $item['text_edit']?>" onclick="window.location='<?php echo $item['link_edit']?>'"/>
                            <?php } ?>
                            <?php if($item['tinhtrang'] == "chuathanhtoan") { ?>
                            <input type="button" class="button" name="btnThanhToan" value="Thanh Toán" onclick="thanhtoan('<?php echo $item['id']?>')"/>
                            <?php }?>
                         	<?php if($item['trangthai'] == "pending") { ?>
                            <input type="button" class="button" name="btnXuatKho" value="<?php echo $item['text_xuatkho']?>" onclick="xuat('<?php echo $item['id']?>')"/>
                            <?php } ?>
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
		$.post("?route=quanlykho/phieuxuatnguyenlieu/delete", 
				$("#listitem").serialize(), 
				function(data)
				{
					if(data!="")
					{
						alert(data);
						window.location.reload();
					}
				}
		);
	}
}

function xuat(maphieu)
{
	$.ajax({
		url: "?route=quanlykho/phieuxuatnguyenlieu/xuatkho&id=" + maphieu,
		cache: false,
		success: function(html){
			alert(html);
			window.location.reload();
		}
	});
}

function thanhtoan(maphieu)
{
	$.ajax({
		url: "?route=quanlykho/phieunhapxuat/thanhtoan&id=" + maphieu,
		cache: false,
		success: function(html){
			alert(html);
			window.location.reload();
		}
	});
}

function searchForm()
{
	var url =  "?route=quanlykho/phieuxuatnguyenlieu";
	if($("#loaiphieu").val() != "")
		url += "&loaiphieu=" + $("#loaiphieu").val();
	if($("#tungay").val() != "")
		url += "&tungay=" + $("#tungay").val();
	if($("#denngay").val() != "")
		url += "&denngay="+ $("#denngay").val();
	if($("#trangthai").val() != "")
		url += "&trangthai="+ $("#trangthai").val();
	if("<?php echo $_GET['opendialog']?>" == "true")
	{
		url += "&opendialog=true";
	}
	
	window.location = url;
}
$("#loaiphieu").val("<?php echo $_GET['loaiphieu']?>");
$("#tungay").val("<?php echo $_GET['tungay']?>");
$("#denngay").val("<?php echo $_GET['denngay']?>");
$("#trangthai").val("<?php echo $_GET['trangthai']?>");

function selectPhieuNhanHang()
{
	window.opener.document.getElementById('selectmaphieuxuatnhap').value = $("#selectphieuxuatnguyenlieu").val();
	window.close();
}

<?php if($dialog==true){ ?>
	$(".inputchk").click(function()
	{
		$("#selectphieuxuatnguyenlieu").val('');
		$(".inputchk").each(function(){
			if(this.checked == true)
			{
				$("#selectphieuxuatnguyenlieu").val($("#selectphieuxuatnguyenlieu").val()+","+$(this).val());
				
			}
		})
		
		
	});
<?php } ?>

</script>