<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content padding1">
    
    	<form id="frm_tieuchikiemtra" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	<input type="button" value="Lưu" class="button" onClick="save()"/>
     	        <input type="button" value="Bỏ qua" class="button" onclick="linkto('?route=quanlykho/tieuchikiemtra#page='+control.getParam('page'))"/>   
     	        
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
                            <th>Đơn vị kiểm tra</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody id="listtieuchi">
                    	
                    </tbody>
                </table>
                <input type="button" class="button" value="Thêm dòng" onclick="tieuchi.addRow(0,'','')"/>
                <input type="hidden" id="deltieuchi" name="deltieuchi" />
            </div>
        </form>
    
    </div>
    
</div>
<script language="javascript">
$(document).ready(function(e) {
    if($('#itemid').val()!="")
	{
		$('#hanghoa').html("<?php echo $item['itemtypename']?>: "+$("#itemcode").val() +" - "+ $("#itemname").val());
		<?php 
		if(count($tieuchikt))
		foreach($tieuchikt as $kt){ ?>
		tieuchi.addRow("<?php echo $kt['id']?>","<?php echo $kt['tieuchikiemtra']?>","<?php echo $kt['madonvi']?>");
		<?php } ?>
	}
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
		var row = '<tr id=row-'+ this.index +'>';
		row += '<td><input type="hidden" id="id-'+ this.index +'" name="id['+ this.index +']" value="'+id+'"><input type="text" class="text" id="tieuchikiemtra-'+ this.index +'" name="tieuchikiemtra['+ this.index +']" value="'+tieuchikiemtra+'"></td>';
		row += '<td><input type="text" class="text" id="madonvi-'+ this.index +'" name="madonvi['+ this.index +']" value="'+madonvi+'"></td>';
		row += '<td><input type="button" class="button" value="Xóa" onclick="tieuchi.remove('+ this.index +')"></td>';
		row += '</tr>'
		$('#listtieuchi').append(row);
		$('#madonvi-'+ this.index).val(madonvi);
		this.index++;
	}
	this.remove = function(pos)
	{
		alert($('#id-'+pos).val());
		$('#deltieuchi').val($('#id-'+pos).val()+","+ $('#deltieuchi').val());
		$('#row-'+pos).remove();
	}
}
var tieuchi = new TieuChi();
function save()
{
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=quanlykho/tieuchikiemtra/save", $("#frm_tieuchikiemtra").serialize(),
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
