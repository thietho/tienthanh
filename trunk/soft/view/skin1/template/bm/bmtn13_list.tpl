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
            <th>Các phiếu liên quan</th>
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
            	<?php if($item['bmvt17id']){ ?>
            	<label>Phiếu cân hàng:</label>
            	<a onclick="fromPhieuCanHang('<?php echo $item['id']?>','<?php echo $item['bmvt17id']?>')"><?php echo $item['bmvt17code']?></a>
                <?php } ?>
                <?php if(count($item['data_bmvt16'])){ ?>
                <label>Phiếu nhập vật tư hàng hóa:</label>
                <?php foreach($item['data_bmvt16'] as $key => $bmvt16){ ?>
                	<?php if($key > 0) echo ","?>
                	<a onclick="fromPhieuNhanVTHH('<?php echo $item['id']?>','<?php echo $bmvt16['id']?>')"><?php echo $bmvt16['sophieu']?></a>
                <?php }?>
                <?php }?>
                </td>
            <td>
            	
                <?php if($item['bmvt17code'] == ""){ ?>
                <input type="button" class="button" value="Chỉnh sửa" onclick="loadData('?route=bm/bmtn13/edit&id=<?php echo $item['id']?>');">
     			<input type="button" class="button" value="Xuất phiếu cân hàng" onclick="fromPhieuCanHang('<?php echo $item['id']?>','')">
                <?php }else{ ?>
                <?php if(count($item['data_bmvt16'])== 0){ ?>
                <input type="button" class="button" value="Lập phiếu nhập vật tư hàng hóa" onclick="fromPhieuNhanVTHH('<?php echo $item['id']?>','')"/>
                <?php }?>
                <?php } ?>
                
            </td>
        </tr>
        <?php } ?>
    </tbody>
</table>
</form>
<script language="javascript">

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
								loadData('?route=bm/bmtn13/getList');
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
								loadData('?route=bm/bmtn13/getList');
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