<script src='<?php echo DIR_JS?>ui.datepicker.js' type='text/javascript' language='javascript'> </script>
<div class="section">

	<div class="section-title">Lịch sử giao dịch của nhà cung ứng <?php echo $nhacungung['tennhacungung']?></div>
    
    <div class="section-content">
    	
        <form action="" method="post" id="listitem" name="listitem">
        	<div id="ben-search">
            	<label>Nhà cung ứng</label>
                <select id="id" name="id">
                    <option value=""></option>
                    <?php foreach($nhacungungs as $val){ ?>
                    <option value="<?php echo $val['id']?>"><?php echo $val['tennhacungung']?></option>
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
                 
                 <label>Tình trạng thanh toán</label>
                 <select id="tinhtrangthanhtoan" name="tinhtrangthanhtoan">
                    <option value=""></option>
                    <?php foreach($this->document->thanhtoan as $key => $val){ ?>
                    <option value="<?php echo $key?>"><?php echo $val?></option>
                    <?php } ?>
                </select>
                 
                <br />
                <input type="button" class="button" name="btnSearch" value="Tìm" onclick="searchForm()"/>
                <input type="button" class="button" name="btnSearch" value="Xem tất cả" onclick="window.location = '?route=quanlykho/phieunhanhang&id=<?php echo $manhacungung; ?>'"/>
            </div>
            <!-- end search -->
            
        	<div class="button right">
            	<?php if($dialog==true){ ?>
            	<input class="button" value="Select" type="button" onclick="selectPhieuNhanHang()">
                <input type="hidden" id="selectphieunhanhang" name="selectphieunhanhang" />
                <?php }else{ ?>
                <input class="button" value="Thêm" type="button" onclick="linkto('<?php echo $insert?>')">
            	<input class="button" type="button" name="delete_all" value="Xóa" onclick="deleteitem()"/>  
				<input class="button" type="button" name="cancel" value="Trở lại" onclick="window.location = '?route=quanlykho/nhacungung'"/>
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
                        <th>Số chứng từ</th>
                        <th>Nhà cung ứng</th>
                        <th>Mã hợp đồng</th>
                        <th>Lần giao</th>
                        <th>Nhân viên tiếp nhận</th>
                        <th>Ngày lập</th>
                        <th>Ngày nhận hàng</th>
                        <th>Đánh giá số lượng</th>
                        <th>Đánh giá chất lượng</th>
                        <th>Đành giá thời gian</th>
                        <th>Đánh giá thanh toán</th>
                        <th>Tình trạng thanh toán</th>
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
                        <td><?php echo $item['maphieunhanhang']?></td>
                        <td><?php echo $item['tennhacungung']?></td>
                        <td><?php echo $item['mahopdong']?></td>
                        <td><?php echo $item['langiao']?></td>
                        <td><?php echo $item['nhanviennhanhang']?></td>
                        <td><?php echo $this->date->formatMySQLDate($item['ngaylap']) ?></td>
                        <td><?php echo $this->date->formatMySQLDate($item['ngaygiao']) ?></td>
                        <td><?php echo $this->document->danhgia[$item['danhgiasoluong']] ?></td>
                        <td><?php echo $this->document->danhgia[$item['danhgiachatluong']] ?></td>
                        <td><?php echo $this->document->danhgia[$item['danhgiathoigian']] ?></td>
                        <td><?php echo $this->document->danhgia[$item['danhgiathanhtoan']] ?></td>
                        <td><?php echo $this->document->thanhtoan[$item['tinhtrangthanhtoan']]; ?></td>
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
		$.post("?route=quanlykho/phieunhanhang/delete", 
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
	var url =  "?route=quanlykho/phieunhanhang";
	//url += "&id=" + "<?php echo $manhacungung; ?>";
	if($("#id").val() != "")
		url += "&id=" + $("#id").val();
	if($("#tungay").val() != "")
		url += "&tungay=" + $("#tungay").val();
	if($("#denngay").val() != "")
		url += "&denngay="+ $("#denngay").val();
	if($("#tinhtrangthanhtoan").val() != "")
		url += "&tinhtrangthanhtoan="+ $("#tinhtrangthanhtoan").val();
	if("<?php echo $_GET['opendialog']?>" == "true")
	{
		url += "&opendialog=true";
	}
	
	window.location = url;
}
$("#id").val("<?php echo $_GET['id']?>");
$("#tungay").val("<?php echo $_GET['tungay']?>");
$("#denngay").val("<?php echo $_GET['denngay']?>");
$("#tinhtrangthanhtoan").val("<?php echo $_GET['tinhtrangthanhtoan']?>");

function selectPhieuNhanHang()
{
	window.opener.document.getElementById('selectmaphieunhanhang').value = $("#selectphieunhanhang").val();
	window.close();
}

<?php if($dialog==true){ ?>
	$(".inputchk").click(function()
	{
		$("#selectphieunhanhang").val('');
		$(".inputchk").each(function(){
			if(this.checked == true)
			{
				$("#selectphieunhanhang").val($("#selectphieunhanhang").val()+","+$(this).val());
				
			}
		})
		
		
	});
<?php } ?>
</script>