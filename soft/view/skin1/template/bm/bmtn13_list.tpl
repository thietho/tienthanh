<h2>Phiếu yêu cầu kiểm kết quả nghiệm thu</h2>
<form id="frm_bmtn13_list">
<table>
	<thead>
    	<tr>
        	<th>Số phiếu</th>
            <th>Nhân viên lập</th>
            <th>Ngày lập</th>
            <th>Số phiếu giao hàng</th>
            <th>Số kế hoạch đạt hàng</th>
            <th>Nghiệm thu</th>
            <th></th>
        </tr>
    </thead>
    <tbody>
    	<?php foreach($data_bttn13 as $item){ ?>
        <tr>
        	<td><?php echo $item['sophieu']?></td>
            <td><?php echo $this->document->getNhanVien($item['nhanvienlap'])?></td>
            <td><?php echo $this->date->formatMySQLDate($item['ngaylapphieu'])?></td>
            <td><?php echo $item['sophieugiaohang']?></td>
            <td><?php echo $item['sokehoachdathang']?></td>
            <td><?php echo $this->document->nghiemthu[$item['nghiemthu']]?></td>
            <td>
            	<input type="button" class="button" value="Chỉnh sửa" onclick="loadData('?route=bm/bmtn13/edit&id=<?php echo $item['id']?>');">
     			<input type="button" class="button" value="Xuất phiếu cân hàng" onclick="createPhieuCanHang('<?php echo $item['id']?>')">           
                
            </td>
        </tr>
        <?php } ?>
    </tbody>
</table>
</form>
<script language="javascript">
function createPhieuCanHang(bmtn13id)
{
	 $("#popup").attr('title','Phiếu cân hàng');
		$( "#popup" ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 900,
			height: 600,
			modal: true,
			buttons: {
				
				
				'Lưu': function() 
				{
					
					$( this ).dialog( "close" );
				},
			}
		});
		
		
		$("#popup-content").load("?route=bm/bmvt17&bmtn13id="+bmtn13id,function(){
			$("#popup").dialog("open");
			$('#popup-seletetion').html('');
		});
}
</script>