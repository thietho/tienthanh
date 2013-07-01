<h2>Đợt giao hàng</h2>
<div id="error" class="error hidden"></div>
<form id="frm_dotgiaohangfrm">
	<p>
    	<input type="button" class="button" id="btnCreateDotGiaoHang" value="Tạo đợt giao hàng" />
        
    </p>
	<input type="hidden" name="bmvt03id" value="<?php echo $item['id']?>">
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
        <span id="tennhacungcapview"><strong><?php echo $item['tennhacungung']?></strong></span>
        Theo kế hoạch đặt hàng số
        <input type="text" class="text" id="sokehoachdathang" name="sokehoachdathang" value="<?php echo $item['sokehoachdathang']?>">
        Ngày:
        <input type="text" class="text date" id="ngaykehoachdathang" name="ngaykehoachdathang" value="<?php echo $this->date->formatMySQLDate($item['ngaykehoachdathang'])?>">
    </p>
    <table class="table-data">
	<thead>
        <tr>
            <th>STT</th>
            <th>Tên hàng và qui cách</th>
            <th>ĐVT</th>
            <th>Phê duyệt</th>
            <th>Số lượng giao</th>
            <th>Đã giao</th>
            <th>Còn lại</th>
            
        </tr>
       
        
    </thead>
    <tbody>
    	<?php if(count($data_ct)){ ?>
			<?php foreach($data_ct as $key => $ct){ ?>
    	<tr>
        	<td><?php echo $key + 1 ?></td>
            <td>
            	<input type="hidden" name="itemtype[<?php echo $ct['id']?>]" value="<?php echo $ct['itemtype']?>" />
                <input type="hidden" name="itemid[<?php echo $ct['id']?>]" value="<?php echo $ct['itemid']?>" />
                <input type="hidden" name="itemcode[<?php echo $ct['id']?>]" value="<?php echo $ct['itemcode']?>" />
                <input type="hidden" name="itemname[<?php echo $ct['id']?>]" value="<?php echo $ct['itemname']?>" />
                <input type="hidden" name="madonvi[<?php echo $ct['id']?>]" value="<?php echo $ct['madonvi']?>" />
            	<?php echo $ct['itemname']?>
            </td>
            <td><?php echo $this->document->getDonViTinh($ct['madonvi'])?></td>
            <td class="number"><?php echo $this->string->numberFormate($ct['pheduyet'])?></td>
            <td class="number"><input type="text" class="text number" name="soluong[<?php echo $ct['id']?>]"></td>
            <td class="number"></td>
            <td class="number"></td>
            
        </tr>
        	<?php } ?>
        <?php } ?>
    </tbody>
   
</table>
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
		$("#tennhacungung").val($(this).attr('tennhacungung'));
		$('#tennhacungcapview').html("<strong>"+$(this).attr('tennhacungung')+"</strong>");
		$("#popup").dialog( "close" );
    });
}
$('#btnCreateDotGiaoHang').click(function(e) {
    bm.createDotGiaoHang("<?php echo $item['id']?>");
});
</script>