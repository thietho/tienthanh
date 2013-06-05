<h2>Phiếu yêu cầu kiểm kết quả nghiệm thu</h2>
<form id="frm_bmtn13">
	<p>
    	<input type="button" class="button" id="btnCreateBMTN13" value="Tạo phiếu" />
    </p>
    <p>
        Phòng kiểm nghiệm đo lường chất lượng đồng ý:
        <select id="nghiemthu" name="nghiemthu">
            <option value=""></option>
            <option value="nghieuthu">Nghiệm thu</option>
            <option value="khongdongy">Không đồng ý</option>
        </select>
    </p>
	<p>
    	Lô hàng theo phiếu giao hàng số:
        <input type="text" class="text" name="sophieugiaohang">
        Ngày:
        <input type="text" class="text date" id="ngayphieugiaohang" name="ngayphieugiaohang">
        
    </p>
    <p>
    	Công ty:
        <input type="button" class="button" id="btnSelectNhaCungCap" value="Chọn nhà cung cấp">
        <input type="hidden" id="nhacungungid" name="nhacungungid"/>
        <input type="hidden" id="manhacungung" name="manhacungung"/>
        <input type="hidden" id="tennhacungcung" name="tennhacungcung"/>
        <span id="tennhacungcapview"></span>
        Theo kế hoạch đặt hàng số
        <input type="text" class="text date" id="ngaykehoachdathang" name="ngaykehoachdathang">
    </p>
    <table>
    	<thead>
        	<tr>
            	<th>Mã số - qui cách</th>
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
		$("#tennhacungcap").val($(this).attr('tennhacungung'));
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
			
		});
});
function intSelectNguyenLieu()
{
	$('.item').click(function(e) {
	
		if($('#popup-seletetion #'+this.id).html() == undefined)
		{
			var html = "<div><div class='selectitem left' id='"+ this.id +"' manguyenlieu='"+$(this).attr('manguyenlieu')+"' tennguyenlieu='"+$(this).attr('tennguyenlieu')+"'>"+$(this).attr('manguyenlieu')+":"+ $(this).attr('tennguyenlieu') +"   </div><a class='removeitem button right'>X</a><div class='clearer'>^&nbsp;</div></div>";
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
						bm.itemtype = "nguyenlieu";
						bm.itemid = $(this).attr('id');
						bm.itemcode = $(this).attr('manguyenlieu');
						bm.itemname = $(this).attr('tennguyenlieu');
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
			
		});
});
function intSelectVatTu()
{
	$('.item').click(function(e) {
	
		if($('#popup-seletetion #'+this.id).html() == undefined)
		{
			var html = "<div><div class='selectitem left' id='"+ this.id +"' manguyenlieu='"+$(this).attr('manguyenlieu')+"' tennguyenlieu='"+$(this).attr('tennguyenlieu')+"'>"+$(this).attr('manguyenlieu')+":"+ $(this).attr('tennguyenlieu') +"   </div><a class='removeitem button right'>X</a><div class='clearer'>^&nbsp;</div></div>";
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
						alert($(this).html())
						
						
                    });
					$( this ).dialog( "close" );
				},
			}
		});
	
		
		$("#popup-content").load("?route=quanlykho/linhkien&opendialog=true",function(){
			$("#popup").dialog("open");
			
		});
});
function intSelectLinhKien()
{
	$('.item').click(function(e) {
	
		if($('#popup-seletetion #'+this.id).html() == undefined)
		{
			var html = "<div><div class='selectitem left' id='"+ this.id +"' malinhkien='"+$(this).attr('malinhkien')+"' tenlinhkien='"+$(this).attr('tenlinhkien')+"'>"+$(this).attr('malinhkien')+":"+ $(this).attr('tenlinhkien') +"   </div><a class='removeitem button right'>X</a><div class='clearer'>^&nbsp;</div></div>";
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
						alert($(this).html())
						
						
                    });
					$( this ).dialog( "close" );
				},
			}
		});
	
		
		$("#popup-content").load("?route=quanlykho/taisan&opendialog=true",function(){
			$("#popup").dialog("open");
			
		});
});
function intSelectTaiSan()
{
	$('.item').click(function(e) {
	
		if($('#popup-seletetion #'+this.id).html() == undefined)
		{
			var html = "<div><div class='selectitem left' id='"+ this.id +"' mataisan='"+$(this).attr('mataisan')+"' tentaisan='"+$(this).attr('tentaisan')+"'>"+$(this).attr('mataisan')+":"+ $(this).attr('tentaisan') +"   </div><a class='removeitem button right'>X</a><div class='clearer'>^&nbsp;</div></div>";
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
	this.trongluong = 0;
	this.soluong = 0;
	this.chatluong = "";
	this.lothang = "";
	this.cbChatLuong = '<?php echo $cbChatLuong?>';
	
	this.createRow = function()
	{
		var row = '<tr id="row'+ this.index +'">';
		//Ma so - Qui cach
		row += '<td><input type="hidden" id="bmtn13id-'+ this.index +'" name="bmtn13id['+ this.index +']" value="'+ this.id +'"><input type="hidden" id="itemtype-'+ this.index +'" name="itemtype['+ this.index +']" value="'+ this.itemtype +'"><input type="hidden" id="itemid-'+ this.index +'" name="itemid['+ this.index +']" value="'+ this.itemid +'"><input type="hidden" id="itemcode-'+ this.index +'" name="itemcode['+ this.index +']" value="'+ this.itemcode +'"><input type="hidden" id="itemname-'+ this.index +'" name="itemname['+ this.index +']" value="'+ this.itemname +'">'+ this.itemname +'</td>';
		//Trong luong
		row += '<td><input type="text" name="trongluong['+this.index+']" value="'+ this.trongluong +'" class="text number"/></td>';
		//So luong
		row += '<td><input type="text" name="soluong['+this.index+']" value="'+ this.soluong +'" class="text number"/></td>';
		//Chat luong
		row += '<td><select id="chatluong-'+ this.index +'" name="chatluong['+this.index+']">'+ this.cbChatLuong +'</select></td>';
		//Lot hang hoa
		row += '<td><input type="text" name="lothang['+this.index+']" value="'+ this.lothang +'" class="text"/></td>';
		row += '</tr>';
		this.index++;
		$('#listhanghoa').append(row);
		
		numberReady();
	}
	
	this.remove = function(pos)
	{
		$("#delid").val($("#delid").val()+","+dlid);
		$("#row"+pos).remove();
	}
}
var bm = new BMTN13();
</script>