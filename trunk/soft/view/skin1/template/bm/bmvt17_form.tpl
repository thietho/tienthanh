<h2>Phiếu cân hàng</h2>
<div id="error" class="error hidden"></div>
<form id="frm_bmvt17">
	
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
	
	bmvt17.id = 0;
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

numberReady();

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