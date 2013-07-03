<h2>Phiếu cân hàng</h2>
<div id="error" class="error hidden"></div>
<form id="frm_bmvt17">
	<p>
    	<input type="button" class="button" id="btnSaveBMVT17" value="Lưu phiếu" />
        <input type="button" class="button" id="btnSavePrintBMVT17" value="Lưu & in phiếu" />
    </p>
    <p>
    	<input type="hidden" id="id" name="id" value="<?php echo $item['id']?>"/>
        
        <input type="hidden" id="dotgiaohangid" name="dotgiaohangid" value="<?php echo $dotgiaohangid?>"/>
        Đơn vị giao hàng: <?php echo $item['tennhacungung']?>
        <input type="hidden" id="nhacungungid" name="nhacungungid" value="<?php echo $item['nhacungungid']?>"/>
        <input type="hidden" id="manhacungung" name="manhacungung" value="<?php echo $item['manhacungung']?>"/>
        <input type="hidden" id="tennhacungung" name="tennhacungung" value="<?php echo $item['tennhacungung']?>"/>
        
    </p>
    <?php if(count($data_ct)){ ?>
    <?php foreach($data_ct as $key => $ct){ ?>
    <h3><?php echo $ct['itemname']?> số lượng giao <?php echo $ct['soluong']?> <?php echo $this->document->getDonViTinh($ct['madonvi'])?></h3>
    <input type="button" class="button btnAddCan" ref="<?php echo $ct['itemid']?>" value="Thêm lần cân"/>
    <table>
    	<thead>
        	<tr>
                <th>Bao bì</th>
                <th>Loại bao</th>
                <th>Số lượng</th>
                
                <th>Ghi chú</th>
            </tr>
        </thead>
        <tbody id="listcan<?php echo $ct['itemid']?>"></tbody>
    </table>
    <?php } ?>        
    <?php }?>
    
</form>
<script language="javascript">
$('.btnAddCan').click(function(e) {
	alert($(this).attr('ref'));
    //bmvt17.addRow($(this).attr('ref'));
});
$('#btnSaveBMVT17').click(function(e) {
    $.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=bm/bmvt17/save", $("#frm_bmvt17").serialize(),
		function(data){
			
			var obj = $.parseJSON(data);
			
			if(obj.error == "")
			{
				alert("Lưu phiếu thành công");
				ktdv.loadData("?route=bm/bmvt03/dotGiaoHang&id=<?php echo $dotgiaohangid?>");
			}
			else
			{
			
				$('#error').html(obj.error).show('slow');
				
				
			}
			$.unblockUI();
		}
	);
});

$('#btnSavePrintBMVT17').click(function(e) {
    $.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=bm/bmvt17/save", $("#frm_bmvt17").serialize(),
		function(data){
			var obj = $.parseJSON(data);
			if(obj.error == "")
			{
				alert("Lưu phiếu thành công");
				$("#popup").attr('title','Phiếu cân hàng');
							$( "#popup" ).dialog({
								autoOpen: false,
								show: "blind",
								hide: "explode",
								width: 1000,
								height: 500,
								modal: true,
								close: function(event, ui) {
									ktdv.loadData("?route=bm/bmvt03/dotGiaoHang&id=<?php echo $dotgiaohangid?>");
									
									
								},
								buttons: {
									
									'In': function(){
										openDialog("?route=bm/bmtn13/view&id="+ obj.id +"&dialog=print",800,500);
										ktdv.loadData("?route=bm/bmvt03/dotGiaoHang&id=<?php echo $dotgiaohangid?>");
										
										$( this ).dialog( "close" );
									},
								}
							});
						
							
				$("#popup-content").load("?route=bm/bmtn13/view&id="+obj.id,function(){
					$("#popup").dialog("open");
				});
				
				
			}
			else
			{
			
				$('#error').html(obj.error).show('slow');
				
				
			}
			$.unblockUI();
		}
	);
});
numberReady();
function BMVT17()
{
	this.index = 0;
	this.id = 0;
	this.itemtype = "";
	this.itemid = "";
	this.itemcode = "";
	this.itemname = "";
	this.madonvi = "";
	this.tendonvi = "";
	this.baobi = "";
	this.loaibao = "";
	this.soluongcan = 0;
	
	this.ghichu = "";
	this.addRow = function(itemid)
	{
		var row = '<tr>';
		//Bao bi
		row += '<td><input type="hidden" id="itemtype-'+ this.index +'" name="itemtype['+ this.index +']" value="'+ this.itemtype +'"><input type="hidden" id="itemid-'+ this.index +'" name="itemid['+ this.index +']" value="'+ this.itemid +'"><input type="hidden" id="itemcode-'+ this.index +'" name="itemcode['+ this.index +']" value="'+ this.itemcode +'"><input type="hidden" id="itemname-'+ this.index +'" name="itemname['+ this.index +']" value="'+ this.itemname +'"><input type="text" class="text" id="baobi-'+ this.index +'" name="baobi['+ itemid +']['+ this.index +']" value="'+ this.baobi +'"></td>';
		//Loai bao
		row += '<td><input type="text" class="text " id="loaibao-'+ this.index +'" name="loaibao['+ itemid +']['+ this.index +']" value="'+ this.loaibao +'"></td>';
		//So luong can
		row += '<td><input type="text" class="text number" id="soluongcan-'+ this.index +'" name="soluongcan['+ itemid +']['+ this.index +']" value="'+ this.soluongcan +'"></td>';
		//Ghi chu
		row += '<td><input type="text" class="text" id="ghichu-'+ this.index +'" name="ghichu['+ itemid +']['+ this.index +']" value="'+ this.ghichu +'"></td>';
		row += '</tr>';
		$('#listcan'+itemid).append(row);
		numberReady();
	}
		
}
var bmvt17 = new BMVT17();

</script>