<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	<input type="button" value="Lưu" class="button" onClick="save()"/>
     	        <input type="button" value="Bỏ qua" class="button" onclick="linkto('?route=quanlykho/tieuchikiemtra#page='+control.getParam('page'))"/>   
     	        <input type="hidden" name="id" value="<?php echo $item['id']?>">
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
        	<div>
            	<p>
            		<label>Hàng hóa</label><br />
					<input type="button" class="button" id="btnSelectNguyenLieu" value="Chọn nguyên liệu">
                    <input type="button" class="button" id="btnSelectVatTu" value="Chọn vật tư">
                    <input type="button" class="button" id="btnSelectLinhKien" value="Chọn linh kiện">
                    <input type="button" class="button" id="btnSelectTaiSan" value="Chọn tài sản">
                    <input type="hidden" id="itemtype" name="itemtype" value="<?php echo $item['itemtype']?>">
                    
                    <input type="hidden" id="itemid" name="itemid" value="<?php echo $item['itemid']?>">
                    <input type="hidden" id="itemcode" name="itemcode" value="<?php echo $item['itemcode']?>">
                     <input type="hidden" id="itemname" name="itemname" value="<?php echo $item['itemname']?>">
                      <div id="hanghoa"></div>
            	</p>
            </div>
            <div>
            	<h3>Các tiêu chí kiểm tra</h3>
                <table style="width:auto">
                	<thead>
                    	<tr>
                        	<th>Tiêu chí kiểm tra</th>
                            <th>Đơn vị</th>
                        </tr>
                    </thead>
                    <tbody id="listtieuchi">
                    	
                    </tbody>
                </table>
                <input type="button" class="button" value="Thêm dòng" onclick="tieuchi.addRow(0,'','')"/>
            </div>
        </form>
    
    </div>
    
</div>
<script language="javascript">
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
			
		});
});
function intSelectNguyenLieu()
{
	$('.item').click(function(e) {
		$('#itemtype').val('nguyenlieu');
		$("#itemid").val(this.id);
		$("#itemcode").val($(this).attr('manguyenlieu'));
		$("#itemname").val($(this).attr('tennguyenlieu'));
		$('#hanghoa').html("Nguyên liệu: "+$("#itemcode").val() +" - "+ $("#itemname").val());
		$("#popup").dialog( "close" );
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
			
		});
});
function intSelectVatTu()
{
	$('.item').click(function(e) {
		$('#itemtype').val('vattu');
		$("#itemid").val(this.id);
		$("#itemcode").val($(this).attr('manguyenlieu'));
		$("#itemname").val($(this).attr('tennguyenlieu'));
		$('#hanghoa').html("Vật tư: "+$("#itemcode").val() +" - "+ $("#itemname").val());
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
			
		});
});
function intSelectLinhKien()
{
	$('.item').click(function(e) {
		$('#itemtype').val('linhkien');
		$("#itemid").val(this.id);
		$("#itemcode").val($(this).attr('malinhkien'));
		$("#itemname").val($(this).attr('tenlinhkien'));
		$('#hanghoa').html("Linh kiện: "+$("#itemcode").val() +" - "+ $("#itemname").val());
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
			
		});
});
function intSelectTaiSan()
{
	$('.item').click(function(e) {
		$('#itemtype').val('taisan');
		$("#itemid").val(this.id);
		$("#itemcode").val($(this).attr('mataisan'));
		$("#itemname").val($(this).attr('tentaisan'));
		$('#hanghoa').html("Tài sản: "+$("#itemcode").val() +" - "+ $("#itemname").val());
		$("#popup").dialog( "close" );
	});	
}
function TieuChi()
{
	this.index = 0;
	this.addRow = function(id,tieuchikiemtra,madonvi)
	{
		var row = '<tr id=row'+ this.index +'>';
		row += '<td><input type="text" class="text" value="'+tieuchikiemtra+'"></td>';
		row += '<td></td>';
		row += '</tr>'
		$('#listtieuchi').append(row);
	}
}
var tieuchi = new TieuChi();
function save()
{
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=quanlykho/tieuchikiemtra/save", $("#frm").serialize(),
		function(data){
			if(data == "true")
			{
				window.location = "?route=quanlykho/tieuchikiemtra#page="+control.getParam('page');
			}
			else
			{
			
				$('#error').html(data).show('slow');
				$.unblockUI();
				
			}
			
		}
	);
}
</script>
