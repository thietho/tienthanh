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
        <input type="hidden" id="delid" name="delid"/>
    </p>
    <?php if(count($data_ct)){ ?>
    <?php foreach($data_ct as $key => $ct){ ?>
    <h3><?php echo $ct['itemname']?> số lượng giao <?php echo $ct['soluong']?> <?php echo $this->document->getDonViTinh($ct['madonvi'])?></h3>
    <input type="button" class="button btnAddCan" itemtype="<?php echo $ct['itemtype']?>" itemid="<?php echo $ct['itemid']?>" itemcode="<?php echo $ct['itemcode']?>" itemname="<?php echo $ct['itemname']?>" madonvi="<?php echo $ct['madonvi']?>" tendonvi="<?php echo $this->document->getDonViTinh($ct['madonvi'])?>" value="Thêm lần cân"/>
    <table>
    	<thead>
        	<tr>
                <th>Bao bì</th>
                <th>Loại bao</th>
                <th>Số lượng</th>
                <th>ĐVT</th>
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
	//alert($(this).attr('ref'));
    bmvt17.itemtype = $(this).attr('itemtype');
	bmvt17.itemid = $(this).attr('itemid');
	bmvt17.itemcode = $(this).attr('itemcode');
	bmvt17.itemname = $(this).attr('itemname');
	bmvt17.madonvi = $(this).attr('madonvi');
	bmvt17.tendonvi = $(this).attr('tendonvi');
	bmvt17.baobi = "";
	bmvt17.loaibao = "";
	bmvt17.soluongcan = 0;
	bmvt17.ghichu = "";
	bmvt17.addRow($(this).attr('itemid'));
});
$('#btnSaveBMVT17').click(function(e) {
    //$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
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
				ktdv.loadData("?route=bm/bmvt03/dotGiaoHang&id=<?php echo $dotgiaohangid?>");
				bm.viewBMVT17(obj.id);
							
				$("#popup-content").load("?route=bm/bmvt17/view&id="+obj.id,function(){
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
		var row = '<tr id="row-'+ this.index +'">';
		//Bao bi
		row += '<td><input type="hidden" id="ctid-'+ this.index +'" name="ctid['+ this.index +']" value="'+ this.id +'"><input type="hidden" id="itemtype-'+ this.index +'" name="itemtype['+ this.index +']" value="'+ this.itemtype +'"><input type="hidden" id="itemid-'+ this.index +'" name="itemid['+ this.index +']" value="'+ this.itemid +'"><input type="hidden" id="itemcode-'+ this.index +'" name="itemcode['+ this.index +']" value="'+ this.itemcode +'"><input type="hidden" id="itemname-'+ this.index +'" name="itemname['+ this.index +']" value="'+ this.itemname +'"><input type="text" class="text" id="baobi-'+ this.index +'" name="baobi['+ this.index +']" value="'+ this.baobi +'"></td>';
		//Loai bao
		row += '<td><input type="text" class="text " id="loaibao-'+ this.index +'" name="loaibao['+ this.index +']" value="'+ this.loaibao +'"></td>';
		//So luong can
		row += '<td><input type="text" class="text number" id="soluongcan-'+ this.index +'" name="soluongcan['+ this.index +']" value="'+ this.soluongcan +'"></td>';
		//DVT
		row += '<td><input type="hidden" id="madonvi-'+ this.index +'" name="madonvi['+ this.index +']" value="'+ this.madonvi +'">'+ this.tendonvi +'</td>';
		//Ghi chu
		row += '<td><input type="text" class="text" id="ghichu-'+ this.index +'" name="ghichu['+ this.index +']" value="'+ this.ghichu +'"></td>';
		row += '<td><input type="button" class="button" value="Xóa" onclick="bmvt17.remove('+ this.index +')"></td>';
		row += '</tr>';
		$('#listcan'+itemid).append(row);
		this.index++;
		numberReady();
	}
	this.remove = function(pos)
	{
		$("#delid").val($("#delid").val()+","+ $('#ctid-'+pos).val());
		$('#row-'+pos).remove();	
	}
}
var bmvt17 = new BMVT17();
</script>
<?php if(count($data_ctcan)){ ?>
<?php foreach($data_ctcan as $key =>$can){ ?>
<script language="javascript">
	bmvt17.id = "<?php echo $can['id']?>";
	bmvt17.itemtype = "<?php echo $can['itemtype']?>";
	bmvt17.itemid = "<?php echo $can['itemid']?>";
	bmvt17.itemcode = "<?php echo $can['itemcode']?>";
	bmvt17.itemname = "<?php echo $can['itemname']?>";
	bmvt17.madonvi = "<?php echo $can['madonvi']?>";
	bmvt17.tendonvi = "<?php echo $this->document->getDonViTinh($can['madonvi'])?>";
	bmvt17.baobi = "<?php echo $can['baobi']?>";
	bmvt17.loaibao = "<?php echo $can['loaibao']?>";
	bmvt17.soluongcan = "<?php echo $can['soluongcan']?>";
	bmvt17.ghichu = "<?php echo $can['ghichu']?>";
	bmvt17.addRow("<?php echo $can['itemid']?>");
</script>
<?php } ?>
<?php } ?>