<h2>Phiếu kết quả thử nghiệm</h2>
<div id="error" class="error hidden"></div>
<form id="frm_bmtn14">
	<p>
    	<input type="button" class="button" id="btnSaveBMTN14" value="Lưu phiếu" />
        <input type="button" class="button" id="btnSavePrintBMTN14" value="Lưu & in phiếu" />
    </p>
    <p>
    	PHÒNG: KIỂM NGHIỆM
    </p>
    <p>
    	<input type="hidden" id="id" name="id" value="<?php echo $item['id']?>"/>
        Tên mẫu: <span id="itemnameview"></span>
        <input type="hidden" id="itemtype" name="itemtype" value="<?php echo $item['itemtype']?>">
        <input type="hidden" id="itemid" name="itemid" value="<?php echo $item['itemid']?>">
        <input type="hidden" id="itemcode" name="itemcode" value="<?php echo $item['itemcode']?>">
        <input type="hidden" id="itemname" name="itemname" value="<?php echo $item['itemname']?>">
        <input type="button" class="button" id="btnSelectNguyenLieu" value="Chọn nguyên liệu">
        <input type="button" class="button" id="btnSelectVatTu" value="Chọn vật tư">
        <input type="button" class="button" id="btnSelectLinhKien" value="Chọn linh kiện">
        <input type="button" class="button" id="btnSelectTaiSan" value="Chọn tài sản">
        
        
        Ký hiệu:
        <input type="text" class="text" id="kyhieu" name="kyhieu" value="<?php echo $item['kyhieu']?>">
    </p>
	<p>
    	Tình trạng mẫu:
        <input type="text" class="text" id="tinhtrangmau" name="tinhtrangmau" value="<?php echo $item['tinhtrangmau']?>">
    </p>
    <p>
    	Môi trường thử nghiệm:
        <input type="text" class="text" id="moitruongthunghiem" name="moitruongthunghiem" value="<?php echo $item['moitruongthunghiem']?>">
    </p>
    <p>
        Ngày yêu cầu ra kết quả chép tay:
        <input type="text" class="text date" id="ngayycrakqcheptay" name="ngayycrakqcheptay" value="<?php echo $this->date->formatMySQLDate($item['ngayycrakqcheptay'])?>">
        
    </p>
    <p>
        Ngày yêu cầu giao kết quả chép tay:
        <input type="text" class="text date" id="ngayycgiaokqcheptay" name="ngayycgiaokqcheptay" value="<?php echo $this->date->formatMySQLDate($item['ngayycgiaokqcheptay'])?>">
        
    </p>
    <p>
    	Người thực hiện:
        <input type="hidden" id="nhanvienthuchien" name="nhanvienthuchien" value="<?php echo $item['nhanvienthuchien']?>"/>
        <span id="tennhanvien"></span>
    </p>
    <p>
        Ngày ngày thực:
        <input type="text" class="text date" id="ngaythuchien" name="ngaythuchien" value="<?php echo $this->date->formatMySQLDate($item['ngaythuchien'])?>">
        
    </p>
    <p>
    	Đánh giá kết quả:
        <textarea id="danhgiakq" name="danhgiakq"></textarea>
    </p>
    <table>
    	<thead>
        	<tr>
            	<th>Tiêu chí kiểm tra</th>
                <th>Đơn vị</th>
                <th>Kết quả</th>
                <th>Mức chất lượng</th>
                
            </tr>
        </thead>
        <tbody id="listtieuchikiemtra">
        	
        </tbody>
    </table>
    
    
    
    
</form>

<script language="javascript">
$('#nghiemthu').val("<?php echo $item['nghiemthu']?>");
$('#tinhtrang').val("<?php echo $item['tinhtrang']?>");
numberReady();
$('#btnSaveBMTN14').click(function(e) {
    $.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=bm/bmtn14/save", $("#frm_bmtn14").serialize(),
		function(data){
			
			var obj = $.parseJSON(data);
			
			if(obj.error == "")
			{
				alert("Lưu phiếu thành công");
				loadData('?route=bm/bmtn13/getList');
			}
			else
			{
			
				$('#error').html(obj.error).show('slow');
				
				
			}
			$.unblockUI();
		}
	);
});

$('#btnSavePrintBMTN13').click(function(e) {
    $.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=bm/bmtn13/save", $("#frm_bmtn13").serialize(),
		function(data){
			var obj = $.parseJSON(data);
			if(obj.error == "")
			{
				alert("Lưu phiếu thành công");
				
				openDialog("?route=bm/bmtn13/view&id="+ obj.id +"&dialog=print",800,500);
				loadData('?route=bm/bmtn13/getList');
			}
			else
			{
			
				$('#error').html(obj.error).show('slow');
				
				
			}
			$.unblockUI();
		}
	);
});


$('#btnSelectNguyenLieu').click(function(e) {
    $("#popup").attr('title','Chọn nguyên liệu');
		$( "#popup" ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 900,
			height: 600,
			modal: true,
			
		});
		
		
		$("#popup-content").load("?route=quanlykho/nguyenlieu&opendialog=true",function(){
			$("#popup").dialog("open");
			$('#popup-seletetion').html('');
		});
});
function intSelectNguyenLieu()
{
	$('.item').click(function(e) {
		$('#itemtype').val('nguyenlieu');
		$('#itemid').val($(this).attr('id'));
		$('#itemcode').val($(this).attr('manguyenlieu'));
		$('#itemname').val($(this).attr('tennguyenlieu'));
		$('#itemnameview').html($(this).attr('tennguyenlieu'));
		$("#popup").dialog( "close" );
		
		getTieuChiKiemTra($('#itemtype').val(),$('#itemid').val());
	});	
}
$('#btnSelectVatTu').click(function(e) {
    $("#popup").attr('title','Chọn vật tư');
		$( "#popup" ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 900,
			height: 600,
			modal: true,
			
		});
	
		
		$("#popup-content").load("?route=quanlykho/vattu&opendialog=true",function(){
			$("#popup").dialog("open");
			$('#popup-seletetion').html('');
			
		});
});
function intSelectVatTu()
{
	$('.item').click(function(e) {
		$('#itemtype').val('vattu');
		$('#itemid').val($(this).attr('id'));
		$('#itemcode').val($(this).attr('manguyenlieu'));
		$('#itemname').val($(this).attr('tennguyenlieu'));
		$('#itemnameview').html($(this).attr('tennguyenlieu'));
		$("#popup").dialog( "close" );
	});	
}
$('#btnSelectLinhKien').click(function(e) {
    $("#popup").attr('title','Chọn linh kiện');
		$( "#popup" ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 900,
			height: 600,
			modal: true,
			
		});
	
		
		$("#popup-content").load("?route=quanlykho/linhkien&opendialog=true",function(){
			$("#popup").dialog("open");
			$('#popup-seletetion').html('');
		});
});
function intSelectLinhKien()
{
	$('.item').click(function(e) {
		$('#itemtype').val('linhkien');
		$('#itemid').val($(this).attr('id'));
		$('#itemcode').val($(this).attr('malinhkien'));
		$('#itemname').val($(this).attr('tenlinhkien'));
		$('#itemnameview').html($(this).attr('tenlinhkien'));
		$("#popup").dialog( "close" );
	});	
}
$('#btnSelectTaiSan').click(function(e) {
    $("#popup").attr('title','Chọn tài sản');
		$( "#popup" ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 900,
			height: 600,
			modal: true,
			
		});
	
		
		$("#popup-content").load("?route=quanlykho/taisan&opendialog=true",function(){
			$("#popup").dialog("open");
			$('#popup-seletetion').html('');
		});
});
function intSelectTaiSan()
{
	$('.item').click(function(e) {
		$('#itemtype').val('taisan');
		$('#itemid').val($(this).attr('id'));
		$('#itemcode').val($(this).attr('mataisan'));
		$('#itemname').val($(this).attr('tentaisan'));
		$('#itemnameview').html($(this).attr('tentaisan'));
		$("#popup").dialog( "close" );
	});	
	
}
function getTieuChiKiemTra(itemtype,itemid)
{
	$.getJSON("?route=quanlykho/tieuchikiemtra/getTieuChiKiemTra",
		{
			itemtype:itemtype,
			itemid:itemid
		},
		function(data)
		{
			for(i in data)
			{
				alert(data[i].tieuchikiemtra)	
			}
		}
	);
}
function BMTN14()
{
	this.index = 0;
	this.id = 0;
	this.tieuchikiemtraid = "";
	this.tieuchikiemtra = "";
	this.madonvi = "";
	this.ketqua = "";
	this.mucchatluong = "";
	
	
	
	this.createRow = function()
	{
		var row = '<tr id="row'+ this.index +'">';
		//Tieu chi kiem tra
		row += '<td><input type="hidden" id="ctid-'+ this.index +'" name="ctid['+ this.index +']" value="'+ this.id +'"><input type="hidden" id="tieuchikiemtraid-'+ this.index +'" name="tieuchikiemtraid['+ this.index +']" value="'+ this.tieuchikiemtraid +'">'+ this.tieuchikiemtra +'</td>';
		//Don vi
		row += '<td><select id="madonvi-'+ this.index +'" name="madonvi['+ this.index +']"><?php echo $cbDonViTinh?></select></td>';
		//Ket qua
		row += '<td><input type="text" name="trongluong['+this.index+']" value="'+ this.trongluong +'" class="text number"/></td>';
		//Muc chat luong
		row += '<td><input type="text" name="soluong['+this.index+']" value="'+ this.soluong +'" class="text number"/></td>';
		
		row += '</tr>';
		$('#listtieuchikiemtra').append(row);
		$('#madonvi-'+ this.index).val(this.madonvi);
		$('#chatluong-'+ this.index).val(this.chatluong);
		this.index++;
		numberReady();
	}
	
	this.remove = function(pos)
	{
		$("#delid").val($("#delid").val()+","+ $('#ctid-'+pos).val());
		$("#row"+pos).remove();
	}
}
</script>
