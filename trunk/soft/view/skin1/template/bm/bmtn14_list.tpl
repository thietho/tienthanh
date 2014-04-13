<h2>Phiếu kết quả nghiệm thu</h2>
<form id="frm_bmtn13_list">
<table>
	<thead>
    	<tr>
        	<th>Số phiếu</th>
            <th>Nhân viên lập</th>
            <th>Ngày lập</th>
            <th>Loại</th>
            <th>Tên mẫu</th>
            <th>Tình trạng</th>
            <th></th>
        </tr>
    </thead>
    <tbody>
    	<?php foreach($data_bttn14 as $item){ ?>
        <tr>
        	<td><?php echo $item['sophieu']?></td>
            <td><?php echo $this->document->getNhanVien($item['nhanvienlap'])?></td>
            <td><?php echo $this->date->formatMySQLDate($item['ngaylapphieu'])?></td>
            <td><?php echo $this->document->dauvao[$item['itemtype']]?></td>
            <td><?php echo $item['itemname']?></td>
            <td><?php echo $item['tinhtrangmau']?></td>
            
            <td>
            	
                <input type="button" class="button" value="Chỉnh sửa" onclick="ktdv.loadData('?route=bm/bmtn14/edit&id=<?php echo $item['id']?>');">
     			
                
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
			height: window.innerHeight,
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
			height: window.innerHeight,
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