<h2>Phiếu yêu cầu kiểm kết quả nghiệm thu</h2>
<div id="error" class="error hidden"></div>
<form id="frm_bmtn13">
	<p>
    	<input type="button" class="button" id="btnSaveBMTN13" value="Lưu phiếu" />
        <input type="button" class="button" id="btnSavePrintBMTN13" value="Lưu & in phiếu" />
    </p>
    <p>
    	<input type="hidden" id="id" name="id" value="<?php echo $item['id']?>"/>
        Phòng kiểm nghiệm đo lường chất lượng đồng ý:
        <select id="nghiemthu" name="nghiemthu">
        	<?php foreach($this->document->nghiemthu as $key => $val){ ?>
            <option value="<?php echo $key?>"><?php echo $val?></option>
            <?php } ?>
            
        </select>
    </p>
	<p>
    	Lô hàng theo phiếu giao hàng số:
        <input type="text" class="text" id="sophieugiaohang" name="sophieugiaohang" value="<?php echo $item['sophieugiaohang']?>">
        Ngày:
        <input type="text" class="text date" id="ngayphieugiaohang" name="ngayphieugiaohang" value="<?php echo $this->date->formatMySQLDate($item['ngayphieugiaohang'])?>">
        
    </p>
    <p>
    	Công ty:
        <input type="button" class="button" id="btnSelectNhaCungCap" value="Chọn nhà cung cấp">
        <input type="hidden" id="nhacungungid" name="nhacungungid" value="<?php echo $item['nhacungungid']?>"/>
        <input type="hidden" id="manhacungung" name="manhacungung" value="<?php echo $item['manhacungung']?>"/>
        <input type="hidden" id="tennhacungung" name="tennhacungung" value="<?php echo $item['tennhacungung']?>"/>
        <span id="tennhacungcapview"><?php echo $item['tennhacungung']?></span>
        Theo kế hoạch đặt hàng số
        <input type="text" class="text" id="sokehoachdathang" name="sokehoachdathang" value="<?php echo $item['sokehoachdathang']?>">
        Ngày:
        <input type="text" class="text date" id="ngaykehoachdathang" name="ngaykehoachdathang" value="<?php echo $this->date->formatMySQLDate($item['ngaykehoachdathang'])?>">
    </p>
    <table>
    	<thead>
        	<tr>
            	<th>Mã số - qui cách</th>
                <th>Đơn vị</th>
                <th>Trọng lượng</th>
                <th>Số Lượng</th>
                <th>Chất lượng</th>
                <th>Lot hàng hóa</th>
            </tr>
        </thead>
        <tbody id="listhanghoa">
        	
        </tbody>
    </table>
    <input type="button" class="button" id="btnSelectNguyenLieu" value="Chọn nguyên liệu">
    <input type="button" class="button" id="btnSelectVatTu" value="Chọn vật tư">
    <input type="button" class="button" id="btnSelectLinhKien" value="Chọn linh kiện">
    <input type="button" class="button" id="btnSelectTaiSan" value="Chọn tài sản">
    <input type="hidden" id="delid" name="delid">
    
    
    
</form>

<script language="javascript">
numberReady();
$('#btnSaveBMTN13').click(function(e) {
    $.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=bm/bmtn13/save", $("#frm_bmtn13").serialize(),
		function(data){
			
			var obj = $.parseJSON(data);
			
			if(obj.error == "")
			{
				alert("Lưu phiếu thành công");
				loadData('?route=bm/bmtn13/getList');
			}
			else
			{
			
				$('#error').html(data).show('slow');
				
				
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
			}
			else
			{
			
				$('#error').html(data).show('slow');
				
				
			}
			$.unblockUI();
		}
	);
});

$('#btnSelectNhaCungCap').click(function(e) {
    $("#popup").attr('title','Chọn nhà cung cấp');
		$( "#popup" ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 800,
			height: 600,
			modal: true,
			
		});
	
		
		$("#popup-content").load("?route=quanlykho/nhacungung&opendialog=true",function(){
			$("#popup").dialog("open");	
		});
});
function intSelectNhaCungCap()
{
	$('.item').click(function(e) {
		$("#nhacungungid").val($(this).attr('id'));
        $("#manhacungung").val($(this).attr('manhacungung'));
		$("#tennhacungung").val($(this).attr('tennhacungung'));
		$('#tennhacungcapview').html("<strong>"+$(this).attr('tennhacungung')+"</strong>");
		$("#popup").dialog( "close" );
    });
}
$('#btnSelectNguyenLieu').click(function(e) {
    $("#popup").attr('title','Chọn nguyên liệu');
		$( "#popup" ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 900,
			height: 600,
			modal: true,
			buttons: {
				
				'Xem danh sach':function()
				{
					$( "#popup-selete" ).show('fast',function(){
						$( "#popup-selete" ).position({
							my: "center",
							at: "center",
							of: "#popup"
						});
						$( "#popup-selete" ).draggable();
					});
					$('.closeselect').click(function(e) {
                        $( "#popup-selete" ).hide('fast');
                    });
				},
				'Chọn': function() 
				{
					$('.selectitem').each(function(index, element) {
						bm.id = 0;
						bm.itemtype = "nguyenlieu";
						bm.itemid = $(this).attr('id');
						bm.itemcode = $(this).attr('manguyenlieu');
						bm.itemname = $(this).attr('tennguyenlieu');
						bm.madonvi = $(this).attr('madonvi');
						bm.tendonvi = $(this).attr('tendonvi');
						bm.trongluong = 0;
						bm.soluong = 0;
						bm.chatluong = "";
						bm.lothang = "";
						bm.createRow();
						
						
                    });
					$( this ).dialog( "close" );
				},
			}
		});
		
		
		$("#popup-content").load("?route=quanlykho/nguyenlieu&opendialog=true",function(){
			$("#popup").dialog("open");
			$('#popup-seletetion').html('');
		});
});
function intSelectNguyenLieu()
{
	$('.item').click(function(e) {
	
		if($('#popup-seletetion #'+this.id).html() == undefined)
		{
			var html = "<div><div class='selectitem left' id='"+ this.id +"' manguyenlieu='"+$(this).attr('manguyenlieu')+"' tennguyenlieu='"+$(this).attr('tennguyenlieu')+"' madonvi='"+$(this).attr('madonvi')+"' tendonvi='"+$(this).attr('tendonvi')+"'>"+$(this).attr('manguyenlieu')+":"+ $(this).attr('tennguyenlieu') +"   </div><a class='removeitem button right'>X</a><div class='clearer'>^&nbsp;</div></div>";
			$('#popup-seletetion').append(html);
			
			$('.removeitem').click(function(e) {
				$(this).parent().remove();
			});
		}
		
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
			buttons: {
				
				'Xem danh sach':function()
				{
					$( "#popup-selete" ).show('fast',function(){
						$( "#popup-selete" ).position({
							my: "center",
							at: "center",
							of: "#popup"
						});
						$( "#popup-selete" ).draggable();
					});
					$('.closeselect').click(function(e) {
                        $( "#popup-selete" ).hide('fast');
                    });
				},
				'Chọn': function() 
				{
					$('.selectitem').each(function(index, element) {
						bm.id = 0;
						bm.itemtype = "vattu";
						bm.itemid = $(this).attr('id');
						bm.itemcode = $(this).attr('manguyenlieu');
						bm.itemname = $(this).attr('tennguyenlieu');
						bm.madonvi = $(this).attr('madonvi');
						bm.tendonvi = $(this).attr('tendonvi');
						bm.trongluong = 0;
						bm.soluong = 0;
						bm.chatluong = "";
						bm.lothang = "";
						
						bm.createRow();
						
                    });
					$( this ).dialog( "close" );
				},
			}
		});
	
		
		$("#popup-content").load("?route=quanlykho/vattu&opendialog=true",function(){
			$("#popup").dialog("open");
			$('#popup-seletetion').html('');
			
		});
});
function intSelectVatTu()
{
	$('.item').click(function(e) {
	
		if($('#popup-seletetion #'+this.id).html() == undefined)
		{
			var html = "<div><div class='selectitem left' id='"+ this.id +"' manguyenlieu='"+$(this).attr('manguyenlieu')+"' tennguyenlieu='"+$(this).attr('tennguyenlieu')+"' madonvi='"+$(this).attr('madonvi')+"' tendonvi='"+$(this).attr('tendonvi')+"'>"+$(this).attr('manguyenlieu')+":"+ $(this).attr('tennguyenlieu') +"   </div><a class='removeitem button right'>X</a><div class='clearer'>^&nbsp;</div></div>";
			$('#popup-seletetion').append(html);
			
			$('.removeitem').click(function(e) {
				$(this).parent().remove();
			});
		}
		
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
			buttons: {
				
				'Xem danh sach':function()
				{
					$( "#popup-selete" ).show('fast',function(){
						$( "#popup-selete" ).position({
							my: "center",
							at: "center",
							of: "#popup"
						});
						$( "#popup-selete" ).draggable();
					});
					$('.closeselect').click(function(e) {
                        $( "#popup-selete" ).hide('fast');
                    });
				},
				'Chọn': function() 
				{
					$('.selectitem').each(function(index, element) {
						bm.id = 0;
						bm.itemtype = "linhkien";
						bm.itemid = $(this).attr('id');
						bm.itemcode = $(this).attr('malinhkien');
						bm.itemname = $(this).attr('tenlinhkien');
						bm.madonvi = $(this).attr('madonvi');
						bm.tendonvi = $(this).attr('tendonvi');
						bm.trongluong = 0;
						bm.soluong = 0;
						bm.chatluong = "";
						bm.lothang = "";
						
						bm.createRow();
						
						
                    });
					$( this ).dialog( "close" );
				},
			}
		});
	
		
		$("#popup-content").load("?route=quanlykho/linhkien&opendialog=true",function(){
			$("#popup").dialog("open");
			$('#popup-seletetion').html('');
		});
});
function intSelectLinhKien()
{
	$('.item').click(function(e) {
	
		if($('#popup-seletetion #'+this.id).html() == undefined)
		{
			var html = "<div><div class='selectitem left' id='"+ this.id +"' malinhkien='"+$(this).attr('malinhkien')+"' tenlinhkien='"+$(this).attr('tenlinhkien')+"' madonvi='"+$(this).attr('madonvi')+"' tendonvi='"+$(this).attr('tendonvi')+"'>"+$(this).attr('malinhkien')+":"+ $(this).attr('tenlinhkien') +"   </div><a class='removeitem button right'>X</a><div class='clearer'>^&nbsp;</div></div>";
			$('#popup-seletetion').append(html);
			
			$('.removeitem').click(function(e) {
				$(this).parent().remove();
			});
		}
		
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
			buttons: {
				
				'Xem danh sach':function()
				{
					$( "#popup-selete" ).show('fast',function(){
						$( "#popup-selete" ).position({
							my: "center",
							at: "center",
							of: "#popup"
						});
						$( "#popup-selete" ).draggable();
					});
					$('.closeselect').click(function(e) {
                        $( "#popup-selete" ).hide('fast');
                    });
				},
				'Chọn': function() 
				{
					$('.selectitem').each(function(index, element) {
						bm.id = 0;
						bm.itemtype = "taisan";
						bm.itemid = $(this).attr('id');
						bm.itemcode = $(this).attr('mataisan');
						bm.itemname = $(this).attr('tentaisan');
						bm.madonvi = $(this).attr('madonvi');
						bm.tendonvi = $(this).attr('tendonvi');
						bm.trongluong = 0;
						bm.soluong = 0;
						bm.chatluong = "";
						bm.lothang = "";
						
						bm.createRow();
						
						
                    });
					$( this ).dialog( "close" );
				},
			}
		});
	
		
		$("#popup-content").load("?route=quanlykho/taisan&opendialog=true",function(){
			$("#popup").dialog("open");
			$('#popup-seletetion').html('');
		});
});
function intSelectTaiSan()
{
	$('.item').click(function(e) {
	
		if($('#popup-seletetion #'+this.id).html() == undefined)
		{
			var html = "<div><div class='selectitem left' id='"+ this.id +"' mataisan='"+$(this).attr('mataisan')+"' tentaisan='"+$(this).attr('tentaisan')+"' madonvi='"+$(this).attr('madonvi')+"' tendonvi='"+$(this).attr('tendonvi')+"'>"+$(this).attr('mataisan')+":"+ $(this).attr('tentaisan') +"   </div><a class='removeitem button right'>X</a><div class='clearer'>^&nbsp;</div></div>";
			$('#popup-seletetion').append(html);
			
			$('.removeitem').click(function(e) {
				$(this).parent().remove();
			});
		}
		
	});	
}
function BMTN13()
{
	this.index = 0;
	this.id = 0;
	this.itemtype = "";
	this.itemid = "";
	this.itemcode = "";
	this.itemname = "";
	this.madonvi = "";
	this.tendonvi = "";
	this.trongluong = 0;
	this.soluong = 0;
	this.chatluong = "";
	this.lothang = "";
	this.cbChatLuong = '<?php echo $cbChatLuong?>';
	
	this.createRow = function()
	{
		var row = '<tr id="row'+ this.index +'">';
		//Ma so - Qui cach
		row += '<td><input type="hidden" id="ctid-'+ this.index +'" name="ctid['+ this.index +']" value="'+ this.id +'"><input type="hidden" id="itemtype-'+ this.index +'" name="itemtype['+ this.index +']" value="'+ this.itemtype +'"><input type="hidden" id="itemid-'+ this.index +'" name="itemid['+ this.index +']" value="'+ this.itemid +'"><input type="hidden" id="itemcode-'+ this.index +'" name="itemcode['+ this.index +']" value="'+ this.itemcode +'"><input type="hidden" id="itemname-'+ this.index +'" name="itemname['+ this.index +']" value="'+ this.itemname +'">'+ this.itemname +'</td>';
		//Don vi
		row += '<td><select id="madonvi-'+ this.index +'" name="madonvi['+ this.index +']"><?php echo $cbDonViTinh?></select></td>';
		//Trong luong
		row += '<td><input type="text" name="trongluong['+this.index+']" value="'+ this.trongluong +'" class="text number"/></td>';
		//So luong
		row += '<td><input type="text" name="soluong['+this.index+']" value="'+ this.soluong +'" class="text number"/></td>';
		//Chat luong
		row += '<td><select id="chatluong-'+ this.index +'" name="chatluong['+this.index+']">'+ this.cbChatLuong +'</select></td>';
		//Lot hang hoa
		row += '<td><input type="text" name="lothang['+this.index+']" value="'+ this.lothang +'" class="text"/></td>';
		//Control
		row += '<td><input type="button" class="button" value="Xóa" onclick="bm.remove('+this.index+')"></td>';
		row += '</tr>';
		$('#listhanghoa').append(row);
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
var bm = new BMTN13();
</script>
<?php if(count($data_ct)){ ?>
	<?php foreach($data_ct as $ct){ ?>
<script language="javascript">
$(document).ready(function(e) {
	bm.id = "<?php echo $ct[id]?>";
	bm.itemtype = "<?php echo $ct['itemtype']?>";
	bm.itemid = "<?php echo $ct['itemid']?>";
	bm.itemcode = "<?php echo $ct['itemcode']?>";
	bm.itemname = "<?php echo $ct['itemname']?>";
	bm.madonvi = "<?php echo $ct['madonvi']?>";
	bm.trongluong = "<?php echo $ct['trongluong']?>";
	bm.soluong = "<?php echo $ct['soluong']?>";
	bm.chatluong = "<?php echo $ct['chatluong']?>";
	bm.lothang = "<?php echo $ct['lothang']?>";
	
    bm.createRow();
});
</script>
	<?php } ?>
<?php } ?>