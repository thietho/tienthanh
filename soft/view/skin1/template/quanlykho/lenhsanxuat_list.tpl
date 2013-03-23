
<div class="section">

	<div class="section-title">Lệnh sản xuất</div>
    
    <div class="section-content">
    	
        <form action="" method="post" id="listitem" name="listitem">
        	<div id="ben-search">
            	<label>Số phiếu</label>
                <input type="text" id="solenhsanxuat" name="solenhsanxuat" class="text"/>
                <label>Ngày lập</label>
                từ
                <input type="text" id="tungay" name="tungay" class="text ben-datepicker" />
                đến
                <input type="text" id="denngay" name="denngay" class="text ben-datepicker" />
                
                <br />
                
                <label>Số tiền</label>
                từ
                <input type="text" id="sotientu" name="sotientu" class="text number" />
                đến
                <input type="text" id="sotienden" name="sotienden" class="text number" />
                
                
           
                <label>Tình trạng</label>
                <select id="tinhtrang" name="tinhtrang">
                	<option value=""></option>
                    <?php foreach($this->document->thuchien as $key => $val){ ?>
                    <option value="<?php echo $key?>"><?php echo $val?></option>
                    <?php } ?>
                </select>
                
                <br />
                <input type="button" class="button" name="btnSearch" value="Tìm" onclick="searchForm()"/>
                <input type="button" class="button" name="btnSearch" value="Xem tất cả" onclick="window.location = '?route=quanlykho/phieunhapvattuhanghoa'"/>
            </div>
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
                        
                        <th>Số</th>
                        <th>Ngày lập</th>
                        <th>Nhân viên nhân lệnh</th>
                        <th>KTV phụ trách</th>
                        <th>Sản phẩm</th>
                        <th>Lot sản phẩm</th>
                        <th>T/lượng SX</th>
                        <th>BM-SX-07 số</th>
                        <th>Nhóm sản xuất</th>
                        <th>Ngày SX</th>
                        <th>Ngày hoàn thành</th>
                        <th>Tình trạng</th>
                        <th width="10%"></th>                                  
                    </tr>
        
        
        <?php
            foreach($datas as $item)
            {
        ?>
                    <tr>
                        <td class="check-column"><input class="inputchk" type="checkbox" name="delete[<?php echo $item['lenhsanxuatid']?>]" value="<?php echo $item['lenhsanxuatid']?>" ></td>
                        <td><?php echo $item['solenhsanxuat']?></td>
                        <td><?php echo $this->date->formatMySQLDate($item['ngayphatlenh'])?></td>
                        <td><?php echo $this->document->getNhanVien($item['nhanvien'])?></td>
                        <td><?php echo $this->document->getNhanVien($item['ktvien'])?></td>
                        <td><?php echo $item['tensanpham']?>(<?php echo $item['masanpham']?>)</td>
                        <td><?php echo $item['lotsp']?></td>
                        <td class="number"><?php echo $this->string->numberFormate($item['trongluongsx'])?></td>
                        <td><?php echo $item['bmsx07']?></td>
                        <td><?php echo $item['nhomsx']?></td>
                        <td><?php echo $this->date->formatMySQLDate($item['ngaysx'])?></td>
                        <td><?php echo $this->date->formatMySQLDate($item['ngayhoanthanh'])?></td>
                        <td><?php echo $this->document->thuchien[$item['tinhtrang']]?></td>
                        <td class="link-control">
                            <input type="button" class="button" name="btnEdit" value="Sửa" onClick="window.location='<?php echo $item['link_edit']?>'">
                            <input type="button" class="button" value="In" onclick="view('<?php echo $item['lenhsanxuatid']?>')"/>
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
function view(lenhsanxuatid)
{
	
	openDialog("?route=quanlykho/phieunhapvattuhanghoa/view&lenhsanxuatid="+lenhsanxuatid+"&dialog=print",800,500);
}

function searchForm()
{
	var url =  "?route=quanlykho/phieunhapvattuhanghoa";
	if($("#solenhsanxuat").val() != "")
		url += "&solenhsanxuat=" + $("#solenhsanxuat").val();
	if($("#tungay").val() != "")
		url += "&tungay="+ $("#tungay").val();
	if($("#denngay").val() != "")
		url += "&denngay="+ $("#denngay").val();
	if($("#kehoachngay").val() != "")
		url += "&kehoachngay="+ $("#kehoachngay").val();
	if(parseFloat($("#sotientu").val()) != 0)
		url += "&sotientu=" + $("#sotientu").val();
	if(parseFloat($("#sotienden").val()) != 0)
		url += "&sotienden=" + $("#sotienden").val();
	if($("#nhacungungid").val() != "")
		url += "&nhacungungid=" + $("#nhacungungid").val();
	if($("#tinhtrang").val() != "")
		url += "&tinhtrang=" + $("#tinhtrang").val();
	window.location = url;
}

$("#solenhsanxuat").val("<?php echo $_GET['solenhsanxuat']?>");
$("#tungay").val("<?php echo $_GET['tungay']?>");
$("#denngay").val("<?php echo $_GET['denngay']?>");
$("#kehoachngay").val("<?php echo $_GET['kehoachngay']?>");
$("#sotientu").val("<?php echo $_GET['sotientu']?>");
$("#sotienden").val("<?php echo $_GET['sotienden']?>");
$("#nhacungungid").val("<?php echo $_GET['nhacungungid']?>");
$("#tinhtrang").val("<?php echo $_GET['tinhtrang']?>");

</script>