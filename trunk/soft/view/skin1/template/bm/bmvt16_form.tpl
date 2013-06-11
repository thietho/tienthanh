<h2>Phiếu nhập vật tư hàng hóa</h2>
<div id="error" class="error hidden"></div>
<form id="frm_bmvt16">
	
    <p>
    	<input type="hidden" id="id" name="id" value="<?php echo $item['id']?>"/>
        <input type="hidden" id="bmtn13id" name="bmtn13id" value="<?php echo $item['bmtn13id']?>"/>
        Theo kế hoạch đặt hàng: <?php echo $item['sokehoachdathang']?>
        Ngày: <?php echo $this->date->formatMySQLDate($item['ngaykehoachdathang'])?>
        <input type="hidden" id="sokehoachdathang" name="sokehoachdathang" value="<?php echo $item['sokehoachdathang']?>"/>
        <input type="hidden" id="ngaykehoachdathang" name="ngaykehoachdathang" value="<?php echo $item['ngaykehoachdathang']?>"/>
        
        
    </p>
    <table class="table-data">
        <thead>
            <tr>
                <th rowspan="2">STT</th>
                <th rowspan="2">Tên hàng - qui cách</th>
                <th rowspan="2">Lot hàng</th>
                <th rowspan="2">Đ/V<br />tính</th>
                <th colspan="2">Số lượng</th>
                <th rowspan="2">Đơn giá</th>
                
            </tr>
            <tr>
                <th>Chứng từ</th>
                <th>Thực nhập</th>
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
                <td><input type="text" class="text short" id="lothang-<?php echo $key?>" name="lothang[<?php echo $key?>]" value="<?php echo $ct['lothang']?>"></td>
                <td><?php echo $this->document->getDonViTinh($ct['madonvi'])?></td>
                <td><input type="text" class="text number short" id="chungtu-<?php echo $key?>" name="chungtu[<?php echo $key?>]" value="<?php echo $ct['chungtu']?>"></td>
                <td><input type="text" class="text number short" id="thucnhap-<?php echo $key?>" name="thucnhap[<?php echo $key?>]" value="<?php echo $ct['thucnhap']?>"></td>
                <td><input type="text" class="text number short" id="dongia-<?php echo $key?>" name="dongia[<?php echo $key?>]" value="<?php echo $ct['dongia']?>"></td>
                
            </tr>
            <?php } ?>
        <?php } ?>
        </tbody>
    </table>
</form>
<script language="javascript">
numberReady();

</script>