<h2>Phiếu đề xuất mua vật tư, nguyên liệu</h2>
<div id="error" class="error hidden"></div>
<form id="frm_bmv03">
  <p>
    	<input type="button" class="button" id="btnSaveBMVT03" value="Lưu phiếu" />
        <input type="button" class="button" id="btnSavePrintBMVT03" value="Lưu & in phiếu" />
        
        <input type="hidden" id="id" name="id" value="<?php echo $item['id']?>"/>
    </p>
    <table>
    	<thead>
        	<tr>
            	<th rowspan="2">Tên hàng và qui cách</th>
                <th rowspan="2">Đơn vị</th>
                <th rowspan="2">Tồn hiện tại</th>
                <th colspan="2">Quy định</th>
                
                <th rowspan="2">T/G yêu cầu cung ứng</th>
                
                
                <th rowspan="2">Mục đích sử dụng</th>
            </tr>
        	<tr>
        	  <th>Tồn T/thiểu</th>
        	  <th>Mua T/thiểu</th>
          </tr>
        </thead>
        <tbody id="listhanghoa">
        	
        </tbody>
    </table>
    <input type="button" class="button" id="btnSelectNguyenLieu" value="Chọn nguyên liệu">
    <input type="button" class="button" id="btnSelectVatTu" value="Chọn vật tư">
    <input type="button" class="button" id="btnSelectLinhKien" value="Chọn linh kiện">
    
    <input type="hidden" id="delid" name="delid">
    
    
    
</form>

<script language="javascript">
$('#nghiemthu').val("<?php echo $item['nghiemthu']?>");
$('#tinhtrang').val("<?php echo $item['tinhtrang']?>");
numberReady();
$('#btnSaveBMVT03').click(function(e) {
    $.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=bm/bmvt03/save", $("#frm_bmv03").serialize(),
		function(data){
			$.unblockUI();
			var obj = $.parseJSON(data);
			
			if(obj.error == "")
			{
				alert("Lưu phiếu thành công");
				ktdv.loadData('?route=bm/bmvt03/getList');
			}
			else
			{
			
				$('#error').html(obj.error).show('slow');
				
				
			}
			
		}
	);
});

$('#btnSavePrintBMVT03').click(function(e) {
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=bm/bmvt03/save", $("#frm_bmv03").serialize(),
		function(data){
			$.unblockUI();
			var obj = $.parseJSON(data);
			
			if(obj.error == "")
			{
				alert("Lưu phiếu thành công");
				openDialog("?route=bm/bmvt03/view&id="+ obj.id +"&dialog=print",800,500);
				ktdv.loadData('?route=bm/bmvt03/getList');
			}
			else
			{
			
				$('#error').html(obj.error).show('slow');
				
				
			}
			
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
			alert($(this).attr('madonvi'));
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

function BMVT03()
{
	this.index = 0;
	this.id = 0;
	this.itemtype = "";
	this.itemid = "";
	this.itemcode = "";
	this.itemname = "";
	this.madonvi = "";
	this.tendonvi = "";
	this.tonhientai = 0;
	this.tontonthieu = 0;
	this.muatoithieu = 0;
	this.thoigiayeucau = "";
	this.mucdichsudung = "";
	
	
	this.createRow = function()
	{
		var row = '<tr id="row'+ this.index +'">';
		//Ten hang hoa va qui cach
		row += '<td><input type="hidden" id="ctid-'+ this.index +'" name="ctid['+ this.index +']" value="'+ this.id +'"><input type="hidden" id="itemtype-'+ this.index +'" name="itemtype['+ this.index +']" value="'+ this.itemtype +'"><input type="hidden" id="itemid-'+ this.index +'" name="itemid['+ this.index +']" value="'+ this.itemid +'"><input type="hidden" id="itemcode-'+ this.index +'" name="itemcode['+ this.index +']" value="'+ this.itemcode +'"><input type="hidden" id="itemname-'+ this.index +'" name="itemname['+ this.index +']" value="'+ this.itemname +'">'+ this.itemname +'</td>';
		//Don vi
		row += '<td><select id="madonvi-'+ this.index +'" name="madonvi['+ this.index +']"><?php echo $cbDonViTinh?></select></td>';
		//Ton hien tai
		row += '<td><input type="hidden" id="tonhientai-'+ this.index +'" name="tonhientai['+ this.index +']" value="'+ this.tonhientai +'"><span id="tonhientai_text-'+ this.index +'"></span></td>';
		
		//Ton T/thieu
		row += '<td><input type="hidden" id="tontonthieu-'+ this.index +'" name="tontonthieu['+ this.index +']" value="'+ this.tontonthieu +'"><span id="tontonthieu_text-'+ this.index +'"></span></td>';
		//Mua T/thieu
		row += '<td><input type="text" name="muatoithieu['+this.index+']" value="'+ this.muatoithieu +'" class="text number"/></td>';
		
		//T/G yeu cau cung ung
		row += '<td><input type="text" name="thoigiayeucau['+this.index+']" value="'+ this.thoigiayeucau +'" class="text date"/></td>';
		//Muc dich su dung
		row += '<td><input type="text" name="mucdichsudung['+this.index+']" value="'+ this.mucdichsudung +'" class="text"/></td>';
		//Control
		row += '<td><input type="button" class="button" value="Xóa" onclick="bm.remove('+this.index+')"></td>';
		row += '</tr>';
		$('#listhanghoa').append(row);
		$('#madonvi-'+ this.index).val(this.madonvi);
		$('#chatluong-'+ this.index).val(this.chatluong);
		//Get ton hien tai
		//Get ton toi thieu
		this.index++;
		numberReady();
	}
	
	this.remove = function(pos)
	{
		$("#delid").val($("#delid").val()+","+ $('#ctid-'+pos).val());
		$("#row"+pos).remove();
	}
}
var bm = new BMVT03();
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
	bm.tonhientai = "<?php echo $ct['tonhientai']?>";
	bm.tontonthieu = "<?php echo $ct['tontonthieu']?>";
	bm.muatoithieu = "<?php echo $ct['muatoithieu']?>";
	bm.thoigiayeucau = "<?php echo $this->date->formatMySQLDate($ct['thoigiayeucau'])?>";
	bm.ketquathuchien = "<?php echo $ct['ketquathuchien']?>";
	bm.mucdichsudung = "<?php echo $ct['mucdichsudung']?>";
	
    bm.createRow();
});
</script>
	<?php } ?>
<?php } ?>