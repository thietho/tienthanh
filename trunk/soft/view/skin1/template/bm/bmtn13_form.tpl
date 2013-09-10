<h2>Phiếu yêu cầu kiểm kết quả nghiệm thu</h2>
<div id="error" class="error hidden"></div>
<form id="frm_bmtn13">
	
    <p>
    	<input type="hidden" id="id" name="id" value="<?php echo $item['id']?>"/>
        <input type="hidden" id="dotgiaohangid" name="dotgiaohangid" value="<?php echo $dotgiaohangid?>"/>
        Phòng kiểm nghiệm đo lường chất lượng đồng ý:
        <select id="nghiemthu" name="nghiemthu">
        	<?php foreach($this->document->nghiemthu as $key => $val){ ?>
            <option value="<?php echo $key?>"><?php echo $val?></option>
            <?php } ?>
            
        </select>
    </p>
	<p>
    	Lô hàng theo phiếu giao hàng số:
        <input type="text" class="text" id="sophieugiaohang" name="sophieugiaohang" value="<?php echo $item['sophieugiaohang']?>">
        Ngày:
        <input type="text" class="text date" id="ngayphieugiaohang" name="ngayphieugiaohang" value="<?php echo $this->date->formatMySQLDate($item['ngayphieugiaohang'])?>">
        
    </p>
    <p>
    	Công ty:
       
        <input type="hidden" id="nhacungungid" name="nhacungungid" value="<?php echo $item['nhacungungid']?>"/>
        <input type="hidden" id="manhacungung" name="manhacungung" value="<?php echo $item['manhacungung']?>"/>
        <input type="hidden" id="tennhacungung" name="tennhacungung" value="<?php echo $item['tennhacungung']?>"/>
        <span id="tennhacungcapview"><strong><?php echo $item['tennhacungung']?></strong></span>
        Theo kế hoạch đặt hàng số
        <input type="text" class="text" id="sokehoachdathang" name="sokehoachdathang" value="<?php echo $item['sokehoachdathang']?>">
        Ngày:
        <input type="text" class="text date" id="ngaykehoachdathang" name="ngaykehoachdathang" value="<?php echo $this->date->formatMySQLDate($item['ngaykehoachdathang'])?>">
    </p>
    <p>
    	Tình trạng:
        <select id="tinhtrang" name="tinhtrang">
        	<?php foreach($this->document->tinhtrangnghiemthu as $key => $val){ ?>
            <option value="<?php echo $key?>"><?php echo $val?></option>
            <?php } ?>
        </select>
    </p>
    <table>
    	<thead>
        	<tr>
            	<th>Mã số - qui cách</th>
                <th>Đơn vị</th>
                <th>Trọng lượng</th>
                <th>Số Lượng</th>
                <th>Chất lượng</th>
                <th>Lot hàng hóa</th>
            </tr>
        </thead>
        <tbody id="listhanghoa">
        	
        </tbody>
    </table>
    
    
    
    
</form>

<script language="javascript">
$('#nghiemthu').val("<?php echo $item['nghiemthu']?>");
$('#tinhtrang').val("<?php echo $item['tinhtrang']?>");
numberReady();

</script>
<?php if(count($data_ct)){ ?>
	<?php foreach($data_ct as $ct){ ?>
<script language="javascript">
$(document).ready(function(e) {
	bmtn13.id = "<?php echo $ct[id]?>";
	bmtn13.itemtype = "<?php echo $ct['itemtype']?>";
	bmtn13.itemid = "<?php echo $ct['itemid']?>";
	bmtn13.itemcode = "<?php echo $ct['itemcode']?>";
	bmtn13.itemname = "<?php echo $ct['itemname']?>";
	bmtn13.madonvi = "<?php echo $ct['madonvi']?>";
	bmtn13.trongluong = "<?php echo $ct['trongluong']?>";
	bmtn13.soluong = "<?php echo $ct['soluong']?>";
	bmtn13.chatluong = "<?php echo $ct['chatluong']?>";
	bmtn13.lothang = "<?php echo $ct['lothang']?>";
	
    bmtn13.createRow();
});
</script>
	<?php } ?>
<?php } ?>