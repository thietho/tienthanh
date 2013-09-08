
<form id="frm_bmtn13_list">
<div>
    <p>
        <label>Số phiếu</label>
        <input type="text" class="text" id="txt_sophieu" value="<?php echo $_GET['sophieu']?>"/>
        <input type="button" class="button" id="btn_BMVT03Search" value="Tìm"/>
    </p>
</div>
<table>
	<thead>
    	<tr>
        	<th>Số phiếu</th>
            <th>Nhân viên lập</th>
            <th>Ngày lập</th>
            <th>Tình trạng</th>
           
            <th></th>
        </tr>
    </thead>
    <tbody>
    	<?php foreach($data_btvt03 as $item){ ?>
        <tr>
        	<td><?php echo $item['sophieu']?></td>
            <td><?php echo $this->document->getNhanVien($item['nhanvienlap'])?></td>
            <td><?php echo $this->date->formatMySQLDate($item['ngaylapphieu'])?></td>
            <td bgcolor="<?php echo $pheduyet_color[$item['tinhtrang']]?>" align="center"><?php echo $arr_pheduyet[$item['tinhtrang']]?></td>
            <td>
            	<input type="button" class="button" value="Xem" onclick="bm.view(<?php echo $item['id']?>,'')">
                <?php if($this->user->checkPermission("bm/bmvt03/pheduyet")==true){ ?>
                <input type="button" class="button" value="Phê duyệt" onclick="bm.pheduyet(<?php echo $item['id']?>)">
                <?php } ?>
                <?php if($this->user->checkPermission("bm/bmvt03/phanHoiThoiGianCungUng")==true){ ?>
                <input type="button" class="button" value="Phản hồi thời gian cung ứng" onclick="bm.phanHoiThoiGianCungUng(<?php echo $item['id']?>)">
                <?php } ?>
                <?php if($this->user->checkPermission("bm/bmvt03/dotGiaoHang")==true){ ?>
                <input type="button" class="button" value="Đợt giao hàng" onclick="bm.dotGiaoHang(<?php echo $item['id']?>)">
                <?php } ?>
                <?php if($item['tinhtrang'] =="") {?>
                <?php if($this->user->checkPermission("bm/bmvt03/edit")==true){ ?>
                <input type="button" class="button" value="Chỉnh sửa" onclick="bm.edit('<?php echo $item['id']?>')">
                <?php } ?>
                <?php if($this->user->checkPermission("bm/bmvt03/delete")==true){ ?>
                <input type="button" class="button" value="Xóa" onclick="bm.del(<?php echo $item['id']?>)">
                <?php } ?>
                <?php } ?>
            </td>
        </tr>
        <?php } ?>
    </tbody>
</table>
</form>
<script language="javascript">
$('#btn_BMVT03Search').click(function(e) {
    ktdv.loadData('?route=bm/bmvt03/getList&sophieu=' + encodeURI($('#txt_sophieu').val()));
});
function fromPhieuCanHang(bmtn13id,bmvt17id)
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
					//$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
					$.post("?route=bm/bmvt17/save", $("#frm_bmvt17").serialize(),
						function(data){
							
							var obj = $.parseJSON(data);
							
							if(obj.error == "")
							{
								alert("Lưu phiếu thành công");
								openDialog("?route=bm/bmvt17/view&id="+ obj.id +"&dialog=print",800,500);
								ktdv.loadData('?route=bm/bmtn13/getList');
								$("#popup").dialog( "close" );
								
							}
							else
							{
							
								$('#error').html(obj.error).show('slow');
								
								
							}
							
						}
					);
					
				},
			}
		});
		var para = "";
		if(bmvt17id != "")
		{
			para = "&bmvt17id="+ bmvt17id;
		}
		$("#popup-content").load("?route=bm/bmvt17&bmtn13id="+bmtn13id+para,function(){
			$("#popup").dialog("open");
			$('#popup-seletetion').html('');
		});
}
function fromPhieuNhanVTHH(bmtn13id,bmvt16id)
{
	 $("#popup").attr('title','Phiếu nhập vật tư hàng hóa');
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
					//$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
					$.post("?route=bm/bmvt16/save", $("#frm_bmvt16").serialize(),
						function(data){
							
							var obj = $.parseJSON(data);
							
							if(obj.error == "")
							{
								alert("Lưu phiếu thành công");
								openDialog("?route=bm/bmvt16/view&id="+ obj.id +"&dialog=print",800,500);
								ktdv.loadData('?route=bm/bmtn13/getList');
								$("#popup").dialog( "close" );
								
							}
							else
							{
							
								$('#error').html(obj.error).show('slow');
								
								
							}
							
						}
					);
					
				},
			}
		});
		var para = "";
		if(bmvt16id != "")
		{
			para = "&bmvt16id="+ bmvt16id;
		}
		$("#popup-content").load("?route=bm/bmvt16&bmtn13id="+bmtn13id+para,function(){
			$("#popup").dialog("open");
			$('#popup-seletetion').html('');
		});
}
</script>