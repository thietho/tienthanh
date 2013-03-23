
<div class="section">

	<div class="section-title">Phiếu nhập vật tư hàng hóa</div>
    
    <div class="section-content">
    	
        <form action="" method="post" id="listitem" name="listitem">
        	<div id="ben-search">
            	<label>Số phiếu</label>
                <input type="text" id="sophieu" name="sophieu" class="text"/>
                <label>Ngày lập</label>
                từ
                <input type="text" id="tungay" name="tungay" class="text ben-datepicker" />
                đến
                <input type="text" id="denngay" name="denngay" class="text ben-datepicker" />
                <label>Số kế hoạch đặt hàng</label>
                <input type="text" id="kehoachngay" name="kehoachngay" class="text"/>
                <br />
                
                <label>Số tiền</label>
                từ
                <input type="text" id="sotientu" name="sotientu" class="text number" />
                đến
                <input type="text" id="sotienden" name="sotienden" class="text number" />
                
                <label>Nhà cung cấp</label>
                <select id="nhacungungid" name="nhacungungid">
                	<option value=""></option>
                    <?php foreach($data_nhacungung as $key => $val){ ?>
                    <option value="<?php echo $val['id']?>"><?php echo $val['tennhacungung']?> (<?php echo $val['manhacungung']?>)</option>
                    <?php } ?>
                </select>
           
                <label>Tình trạng</label>
                <select id="tinhtrang" name="tinhtrang">
                	<option value=""></option>
                    <?php foreach($this->document->thanhtoan as $key => $val){ ?>
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
                        
                        <th>Số phiếu</th>
                        <th>Ngày lập</th>
                        <th>Số kế hoạch đăt hàng</th>
                        <th>Cung cấp bởi</th>
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
                        <td><?php echo $this->date->formatMySQLDate($item['ngaylap'])?></td>
                        <td><?php echo $item['kehoachngay']?></td>
                        <td><?php echo $this->document->getNhaCungUng($item['nhacungungid'])?></td>
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

function searchForm()
{
	var url =  "?route=quanlykho/phieunhapvattuhanghoa";
	if($("#sophieu").val() != "")
		url += "&sophieu=" + $("#sophieu").val();
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

$("#sophieu").val("<?php echo $_GET['sophieu']?>");
$("#tungay").val("<?php echo $_GET['tungay']?>");
$("#denngay").val("<?php echo $_GET['denngay']?>");
$("#kehoachngay").val("<?php echo $_GET['kehoachngay']?>");
$("#sotientu").val("<?php echo $_GET['sotientu']?>");
$("#sotienden").val("<?php echo $_GET['sotienden']?>");
$("#nhacungungid").val("<?php echo $_GET['nhacungungid']?>");
$("#tinhtrang").val("<?php echo $_GET['tinhtrang']?>");

</script>