<h2>Phiếu cân hàng</h2>
<div id="error" class="error hidden"></div>
<form id="frm_bmvt17">
	
    <p>
    	<input type="hidden" id="id" name="id" value="<?php echo $item['id']?>"/>
        <input type="hidden" id="bmtn13id" name="bmtn13id" value="<?php echo $item['bmtn13id']?>"/>
        Đơn vị giao hàng: <?php echo $item['tennhacungung']?>
        <input type="hidden" id="nhacungungid" name="nhacungungid" value="<?php echo $item['nhacungungid']?>"/>
        <input type="hidden" id="manhacungung" name="manhacungung" value="<?php echo $item['manhacungung']?>"/>
        <input type="hidden" id="tennhacungung" name="tennhacungung" value="<?php echo $item['tennhacungung']?>"/>
        
    </p>
    <table>
    	<thead>
        	<tr>
            	<th>STT</th>
                <th>Tên hàng</th>
                <th>Bao bì</th>
                <th>Loại bao</th>
                <th>Số lượng</th>
                <th>Đơn vị tính</th>
                <th>Ghi chú</th>
            </tr>
        </thead>
        <tbody>
        <?php if(count($data_ct)){ ?>
        	<?php foreach($data_ct as $key => $ct){ ?>
            <tr>
            	<td><?php echo $key + 1 ?></td>
                <td>
                	<input type="hidden" name="ctid[<?php echo $key?>]" value="<?php echo $ct['id']?>">
                	<input type="hidden" name="itemtype[<?php echo $key?>]" value="<?php echo $ct['itemtype']?>">
                    <input type="hidden" name="itemid[<?php echo $key?>]" value="<?php echo $ct['itemid']?>">
                    <input type="hidden" name="itemcode[<?php echo $key?>]" value="<?php echo $ct['itemcode']?>">
                    <input type="hidden" name="itemname[<?php echo $key?>]" value="<?php echo $ct['itemname']?>">
                    <input type="hidden" name="madonvi[<?php echo $key?>]" value="<?php echo $ct['madonvi']?>">
                	<?php echo $ct['itemname']?>
                </td>
                <td><input type="text" class="text" id="baobi-<?php echo $key?>" name="baobi[<?php echo $key?>]" value="<?php echo $ct['baobi']?>"></td>
                <td><input type="text" class="text" id="loaibao-<?php echo $key?>" name="loaibao[<?php echo $key?>]" value="<?php echo $ct['loaibao']?>"></td>
                <td><input type="text" class="text number" id="soluongcan-<?php echo $key?>" name="soluongcan[<?php echo $key?>]" value="<?php echo $ct['soluongcan']?>"></td>
                <td><?php echo $this->document->getDonViTinh($ct['madonvi'])?></td>
                <td><input type="text" class="text" id="ghichu-<?php echo $key?>" name="ghichu[<?php echo $key?>]" value="<?php echo $ct['ghichu']?>"></td>
            </tr>
            <?php } ?>
        <?php } ?>
        </tbody>
    </table>
</form>
<script language="javascript">
numberReady();

</script>