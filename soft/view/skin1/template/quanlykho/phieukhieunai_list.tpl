<script src='<?php echo DIR_JS?>ui.datepicker.js' type='text/javascript' language='javascript'> </script>
<div class="section">

	<div class="section-title">Quản lý danh mục phiếu khiếu nại</div>
    
    <div class="section-content">
    	
        <form action="" method="post" id="listitem" name="listitem">
        	<div id="ben-search">
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
                 
                 <label>Tình trạng phiếu</label>
                 <select id="trangthai" name="trangthai">
                    <option value=""></option>
                    <option value="pending"><?php echo $this->document->xuly['pending']; ?></option>
                    <option value="completed"><?php echo $this->document->xuly['completed']; ?></option>
                </select>
                 
                <br />
                <input type="button" class="button" name="btnSearch" value="Tìm" onclick="searchForm()"/>
                <input type="button" class="button" name="btnSearch" value="Xem tất cả" onclick="window.location = '?route=quanlykho/phieukhieunai'"/>
            </div>
            <!-- end search -->
            
        	<div class="button right">
                <input class="button" value="Thêm" type="button" onclick="linkto('<?php echo $insert?>')">
            	<input class="button" type="button" name="delete_all" value="Xóa" onclick="deleteitem()"/>  
            </div>
            <div class="clearer">^&nbsp;</div>
            
            <div class="sitemap treeindex">
                <table class="data-table" cellpadding="0" cellspacing="0">
                <thead>
                    <tr class="tr-head">
                        <th width="1%"><input class="inputchk" type="checkbox" onclick="$('input[name*=\'delete\']').attr('checked', this.checked);"></th>
                        <th>STT</th>
                        <th>Số chứng từ</th>
                        <th>Ngày lập</th>
                        <th>Tên khách hàng</th>
                        <th>Nhân viên tiếp nhận</th>
                        <th>Hình thức</th>
                        <th>Ngày hẹn</th>
                        <th>Trạng thái</th>
                        <th>Control</th>                                  
                    </tr>
                </thead>
                <tbody>
        
        
        <?php
            foreach($datas as $key => $item)
            {
        ?>
                    <tr>
                        <td class="check-column"><input class="inputchk" type="checkbox" name="delete[<?php echo $item['id']?>]" value="<?php echo $item['maphieu']?>" ></td>
                        <td><?php echo $key+1 ?></td>
                        <td><?php echo $item['maphieu']?></td>
                        <td><?php echo $this->date->formatMySQLDate($item['ngaylap'])?></td>
                        <td><?php echo $item['tenkhachhang']?></td>
                        <td><?php echo $item['nvtn']?></td>
                        <td><?php echo $item['hinhthuc']?></td>
                        <td><?php echo $item['ngayhen'] ?></td>
                        <td><?php echo $this->document->xuly[$item['trangthai']]; ?></td>
                        <td class="link-control">
                            <input type="button" class="button" name="btnEdit" value="<?php echo $item['text_edit']?>" onclick="window.location='<?php echo $item['link_edit']?>'"/>
                            <input type="button" class="button" name="btnPhanHoi" value="<?php echo $item['text_phanhoi']?>" onclick="window.location='<?php echo $item['link_phanhoi']?>'"/>
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
		$.post("?route=quanlykho/phieukhieunai/delete", 
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

function searchForm()
{
	var url =  "?route=quanlykho/phieukhieunai";
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

$("#tungay").val("<?php echo $_GET['tungay']?>");
$("#denngay").val("<?php echo $_GET['denngay']?>");

</script>